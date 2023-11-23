#!/bin/bash

# Is gammastep running? if not, start it ASAP
if ! pidof gammastep > /dev/null
then
  gammastep -r & > /dev/null
  echo "started gammastep"
fi

# Are we using the experimental backend?
# TODO: the experimental backend will be the default soon
# and I'll need to adjust this accordingly
if picom --help | grep legacy-backends > /dev/null
then
  use_experimental_backends=1;
  grep_string="window-shader-fg"
else
  use_experimental_backends=0;
  grep_string="glx-fshader-win"
fi

if pgrep -a -x picom | grep $grep_string  > /dev/null
then
  pkill -x picom
  sleep 0.02 # make sure it's actually stopped before restarting
  picom $* -b
  toggle_mode="colour"
else
  pkill -x picom
  sleep 0.02

  if (( $use_experimental_backends == 1 ))
  then
    tmpfile=$(mktemp)
    trap 'rm -f "${tmpfile}"' EXIT

    cat > ${tmpfile} <<EOF
#version 330
in vec2 texcoord;

uniform sampler2D tex;
uniform float opacity;

vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    vec4 c = default_post_processing(texelFetch(tex, ivec2(texcoord), 0));
    float y = dot(c.rgb, vec3(0.2126, 0.7152, 0.0722));
    c = opacity*vec4(y, y, y, c.a);
    return c;
  }
EOF

    picom $* -b --backend glx --window-shader-fg ${tmpfile} --invert-color-include "class_g = 'CoQ.x86_64'" 2> /dev/null

  else
    shader='
      uniform sampler2D tex; 
      uniform float opacity; 
      uniform bool invert_color;

      void main() { 
      vec4 display = texture2D(tex, gl_TexCoord[0].xy); 
      vec3 magicNumber = vec3(0.2126, 0.7152, 0.0722);
      vec3 tint = vec3(1.,0.447,0.);
      if (invert_color) {
        display.xyz = 1.0 - display.xyz;
      }
      float greyscale = dot(display.rgb, magicNumber); 
      gl_FragColor = opacity*vec4((greyscale), (greyscale), (greyscale), display.a); 
    }'
    # For tinted greyscale, use this and don't run gammastep later
    # caveats: appears in screenshots, affects OCR
    # gl_FragColor = opacity*vec4((greyscale*tint.r), (greyscale*tint.g), (greyscale*tint.b), display.a); 

    picom $* -b --backend glx --glx-fshader-win "${shader}" --invert-color-include "class_g = 'CoQ.x86_64' || class_g = 'steam'" 2> /dev/null
  fi
  toggle_mode="greyscale"
fi


if (( $? == 0 )); then
  echo "$toggle_mode mode activated"
else
  echo "toggle failed"
fi
