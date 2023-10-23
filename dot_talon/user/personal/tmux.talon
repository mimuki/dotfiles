app.name: XTerm
-
mux: "tmux "

#session management
mux new (sesh|session): insert("tmux new ")
mux (sesh|sessions):
    key(ctrl-b)
    key(s)
mux name (sesh|sessions):
    key(ctrl-b)
    key($)
mux (kill|close) (sesh|session): insert("tmux kill-session -t ")
#window management
mux new window:
    key(ctrl-b)
    key(c)
mux window <number>:
    key(ctrl-b)
    key('{number}')
mux previous window:
    key(ctrl-b)
    key(p)
mux next window:
    key(ctrl-b)
    key(n)
mux rename window:
    key(ctrl-b)
    key(,)
mux close window:
    key(ctrl-b)
    key(&)
#pane management
mux split horizontal:
    key(ctrl-b)
    key(%)
mux split vertical:
    key(ctrl-b)
    key(")
mux next pane:
    key(ctrl-b)
    key(o)
mux move <user.arrow_key>:
    key(ctrl-b)
    key(arrow_key)
mux close pane:
    key(ctrl-b)
    key(x)
#Say a number right after this command, to switch to pane
mux pane numbers:
    key(ctrl-b)
    key(q)
