title: /Discord/
-
focus <user.rango_hint>:
    key(escape)
    user.rango_command_with_target("focusElement", rango_hint)

edit <user.rango_hint>:
    key(escape)
    user.rango_command_with_target("focusElement", rango_hint)
    key(tab)
    key(up)
    key(e)

react [to] <user.rango_hint>:
    key(escape)
    user.rango_command_with_target("focusElement", rango_hint)
    key(tab)
    key(up)
    key(+)

reply [to] <user.rango_hint>:
    key(escape)
    user.rango_command_with_target("focusElement", rango_hint)
    key(tab)
    key(up)
    key(r)

( delete | chuck ) <user.rango_hint>:
    key(escape)
    user.rango_command_with_target("focusElement", rango_hint)
    key(tab)
    key(up)
    key(backspace)

( delete | chuck ) <user.rango_hint> please:
    key(escape)
    user.rango_command_with_target("focusElement", rango_hint)
    key(tab)
    key(up)
    key(backspace)
    key(enter)

pin <user.rango_hint>:
    key(escape)
    user.rango_command_with_target("focusElement", rango_hint)
    key(tab)
    key(up)
    key(p)

pin <user.rango_hint> please:
    key(escape)
    user.rango_command_with_target("focusElement", rango_hint)
    key(tab)
    key(up)
    key(p)
    key(enter)

save <user.rango_hint>:
    key(escape)
    user.rango_command_with_target("focusElement", rango_hint)
    key(tab)
    key(up)
    key(ctrl-c)

[show] menu <user.rango_hint>:
    user.rango_command_with_target("focusElement", rango_hint)
    sleep(200ms)
    user.rango_run_action_on_reference("clickElement", "more")

guild down: key(ctrl-alt-down)
guild up: key(ctrl-alt-up)

thread down: key(alt-down)
thread up: key(alt-up)

thread new down: key(alt-shift-down)
thread new up: key(alt-shift-up)

(thread ping down|next ping): key(ctrl-alt-shift-down)
(thread ping up|last ping): key(ctrl-alt-shift-up)

go back: key(alt-left)
go next: key(alt-right)

toggle DMs: key(ctrl-alt-right)

(current call|call current): key(ctrl-alt-shift-v)

quick switcher: key(ctrl-k)

# TODO: sometimes this gets mixed up with rango's "hints toggle", so maybe change this
((show|hide|toggle) pins|pins (show|hide|toggle)): key(ctrl-p)

((show|hide|toggle) emoji|emoji (show|hide|toggle)): key(ctrl-e)

((show|hide|toggle) inbox|inbox (show|hide|toggle)): key(ctrl-i)

inbox read: key(ctrl-shift-e)

jump [to] unread: key(shift-pageup)
