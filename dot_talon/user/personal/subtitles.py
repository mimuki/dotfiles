from talon import speech_system, actions, cron
import subprocess, os

def clear_subtitles():
    """Clear the subtitle bar"""
    global clear_subtitle

    cron.cancel(clear_subtitle)
    os.system("awesome-client 'subtitles.markup = \"\"'")
    clear_subtitle = None

def show_as_subtitle(phrase: dict):
    """Display text in the subtitle bar"""
    global clear_subtitle
    words = phrase.get("phrase")

    if words and actions.speech.enabled():
        # awesome-client wants literally '\'' to escape a '
        # so this is that, escaped like how python wants
        escapedQuote = "\'\\\'\'"
        # what you said, joined into a sentence, with the quotes escaped
        phrase = " ".join(words).replace('\'',escapedQuote)
        cmd = "awesome-client 'subtitles.markup = \" " + phrase + "\"'"
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
        # print("You said: "+ phrase)

speech_system.register("pre:phrase", show_as_subtitle)
