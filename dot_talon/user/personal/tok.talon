# used if you want to speak toki ponglish inside of "say" or similar
# "toki" works outside of toki pona mode
ilo o toki pona:
    mode.enable("user.toki_pona")
ilo o toki (ike|Inli):
    mode.disable("user.toki_pona")

toki {user.nimi}+: user.insert_phrase(user.nimi_list, " ")
nimi {user.nimi}: insert(user.nimi)

^ilo o lape [<phrase>]$: speech.disable()
# waking talon is in sleep.talon
