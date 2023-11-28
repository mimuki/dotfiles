app.name: Firefox-esr
-
tag(): browser

# solves occasionally jumbled keystrokes
settings():
    insert_wait = 10


# relies on Smart TOC extension
(tony | table of contents) (show | hide | toggle): key(ctrl-alt-t)
[tony] heading next: key(ctrl-alt-0)
[tony] heading (back|previous): key(ctrl-alt-9)
