from talon import Module, Context, grammar, actions
# is this really how I'm supposed to do this? (todo: find out)
from ..community.core.vocabulary.vocabulary import vocabulary as talon_vocabulary

mod = Module()
mod.mode('toki_pona')
mod.list("nimi")

@mod.action_class
class Actions:
    def insert_phrase(strings: list[str], delimiter: str = "") -> None:
        """Insert a list of strings, sequentially."""
        actions.insert(delimiter.join(strings))
        
ctx_ale = Context()
ctx_ale.matches = 'mode: all'
wordPronounciation = {}
# nimi pu + tonsi, n, ku, kijetesantakalu (for fun)
words = 'a akesi ala alasa ale anpa ante anu awen e en esun ijo ike ilo insa jaki jan jelo jo kala kalama kama kasi ken kepeken kili kiwen ko kon kule kulupu kute la lape laso lawa len lete li lili linja lipu loje lon luka lukin lupa ma mama mani meli mi mije moku moli monsi mu mun musi mute nanpa nasa nasin nena ni nimi noka o olin ona open pakala pali palisa pan pana pi pilin pimeja pini pipi poka poki pona pu sama seli selo seme sewi sijelo sike sin sina sinpin sitelen sona soweli suli suno supa suwi tan taso tawa telo tenpo toki tomo tu unpa uta utala walo wan waso wawa weka wile namako kin oko tonsi kijetesantakalu n ku '
# proper nouns & names of my friends
words = words + 'Inli Lasina Deni Mimuki Nesen Pakapa Salinsen Siko Tepo'
for word in words.split():
    # the j sound is pronounced like y
    wordPronounciation[word.replace('j','y')] = word
ctx_ale.lists['user.nimi'] = wordPronounciation

ctx = Context()
ctx.matches = 'mode: user.toki_pona'
# add toki pona to vocabulary
# this lets us speak toki pona in "say"- but we can "toki <nimi>" all the time
ctx.lists['user.vocabulary'] = dict(talon_vocabulary, **wordPronounciation)
