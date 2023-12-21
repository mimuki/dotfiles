from talon import speech_system, actions, cron, noise
import subprocess, os

# TODO: this but good, maybe somehow getting it from the tmux config file
# the left part of the status bar
tmuxLeft = "tmux set -g status-format[0] '#[align=left]#{?client_prefix,#[fg=brightwhite]#[bg=black],#[fg=black]#[bg=brightyellow]} #(echo \"$USER\" | head -c 5) #{?client_prefix,#[fg=brightwhite]#[bg=black],#[fg=black]#[bg=white]} #W #(bash ~/.tmux/plugins/rat_scripts/cwd.sh) #[align=absolute-centre]#[fg=black]#[bg=default]"
# the right part of the status bar
tmuxRight = "#[align=right]#{?client_prefix,#[fg=brightwhite]#[bg=black],#[fg=black]#[bg=white]} #(bash ~/.tmux/plugins/rat_scripts/battery.sh)#(bash ~/.tmux/plugins/rat_scripts/watts.sh)%I:%M %P '"


def clear_subtitles():
    """Clear the subtitle bar"""
    global clear_subtitle
    global popCount
    global tmuxLeft
    global tmuxRight

    cron.cancel(clear_subtitle)
    os.system("awesome-client 'subtitles.markup = \"\"'")
    os.system(tmuxLeft + tmuxRight)
    clear_subtitle = None
    popCount = 1

def show_as_subtitle(phrase: dict):
    """Display text in the subtitle bar"""
    global lastPhrase 
    global clear_subtitle
    global popCount
    global tmuxLeft
    global tmuxRight
    words = phrase.get("phrase")

    if words and actions.speech.enabled():
        # awesome-client wants literally '\'' to escape a '
        # so this is that, escaped like how python wants
        escapedQuote = "\'\\\'\'"
        # what you said, joined into a sentence, with the quotes escaped
        escapedPhrase = " ".join(words).replace('\'',escapedQuote)
        lastPhrase = escapedPhrase
        cmd = "awesome-client 'subtitles.markup = \" " + escapedPhrase + "\"'"
        cmd2 = tmuxLeft + escapedPhrase + tmuxRight
        # Only sends a notification of the first word if I don't escape spaces
        # Also, the latency on the phone sucks, that's seemingly just an adb thing
        cmd3 = "adb shell cmd notification post -S inbox 'Talon' '" + escapedPhrase.replace(' ','\\ ') + "'"
        
        try:
            clear_subtitle
        except NameError:
            # There's nothing currently displayed as subtitles
            # so we can proceed as normal
            pass
        else:
            # There's already a subtitle on screen, so we cancel the clear for
            # the last one (so that this subtitle doesn't go away too soon)
            cron.cancel(clear_subtitle)

        clear_subtitle = cron.after(
            f"5000ms",
            clear_subtitles,
        )
        #this might be the wrong way to run things? idk look into this future me
        os.system(cmd)
        os.system(cmd2)
        os.system(cmd3)

        # we've said something new, and haven't popped for it
        popCount = 1
        # print("You said: "+ phrase)

speech_system.register("pre:phrase", show_as_subtitle)

# todo: all of this but good, i don't like cramming pop in here just because
# i don't understand how to have it in seperate files properly 
def on_pop(active):
    global popCount
    global clear_subtitle
    global lastPhrase
    global tmuxLeft
    global tmuxRight
    if actions.speech.enabled():
        try:
            popCount
        except NameError:
            popCount = 1
        actions.core.repeat_command(1)

        try:
            lastPhrase
        except NameError:
            os.system("awesome-client 'subtitles.markup = \" pop!\"'")
        else:
            os.system("awesome-client 'subtitles.markup = \" [" + str(popCount) + "] " + lastPhrase + "\"'")
            os.system(tmuxLeft + "#[fg=black]#[bg=brightcyan][" + str(popCount) + "]#[fg=black]#[bg=default] " + lastPhrase + tmuxRight)
            os.system("adb shell cmd notification post -S inbox 'Talon' '\[" + str(popCount) + "\]\ " + lastPhrase.replace(' ','\\ ') + "'")
            popCount = popCount + 1

        try:
            clear_subtitle
        except NameError:
            # There's nothing currently displayed as subtitles
            # so we can proceed as normal
            pass
        else:
            # There's already a subtitle on screen, so we cancel the clear for
            # the last one (so that this subtitle doesn't go away too soon)
            cron.cancel(clear_subtitle)
        clear_subtitle = cron.after(
            f"5000ms",
            clear_subtitles,
        )
    print("pop!")

noise.register("pop", on_pop)
