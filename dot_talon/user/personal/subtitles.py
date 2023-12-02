from talon import speech_system, actions, cron, noise
import subprocess, os

def clear_subtitles():
    """Clear the subtitle bar"""
    global clear_subtitle
    global popCount

    cron.cancel(clear_subtitle)
    os.system("awesome-client 'subtitles.markup = \"\"'")
    clear_subtitle = None
    popCount = 1

def show_as_subtitle(phrase: dict):
    """Display text in the subtitle bar"""
    global lastPhrase 
    global clear_subtitle
    global popCount
    words = phrase.get("phrase")

    if words and actions.speech.enabled():
        # awesome-client wants literally '\'' to escape a '
        # so this is that, escaped like how python wants
        escapedQuote = "\'\\\'\'"
        # what you said, joined into a sentence, with the quotes escaped
        escapedPhrase = " ".join(words).replace('\'',escapedQuote)
        lastPhrase = escapedPhrase
        cmd = "awesome-client 'subtitles.markup = \" " + escapedPhrase + "\"'"
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
