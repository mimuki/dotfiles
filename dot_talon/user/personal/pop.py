from talon import actions, noise

def on_pop(active):
    actions.core.repeat_command(1)
    print("pop!")
noise.register("pop", on_pop)