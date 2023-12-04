# Device naming convention

All fields are mandatory. When referencing this in scripts, it's probably wise to ensure it's 8 characters long, as all our name conventions since 2016 could never be 8 characters long.

## Examples

L23LDE12: A laptop, purchased in 2023, running Debian 12
D08WIN10: A desktop, purchased in 2008, running windows 10 (impressively!)

## Fields

### Device form factor/function
Valid/defined options:
- (S)erver
- (V)irtual machine
- (L)aptop
- Mobile (P)hone
- (D)esktop
- Gaming (C)onsole

### Device aquisition year
When you came to own it (last two digits of year).
e.g 20(23), 19(80)

### Device OS (general)
Valid options:
- (L)inux
- (B)SD
- (W)indows
- (A)ndroid

### Device OS (specific)
Prefer first 2 letters of name, unless:
- there's major name collision, causing this and the previous field to be identical
> FreeBSD and Frugalware Linux aren't a collision- as LFR / BFR are unique
> Kali Linux and Kanotix are- they'd both be LKA, and one of them needs to change. Prefer the one you use more or see as more popular, at your discretion.
- the first word in the name is the same as the general OS name, e.g. Linux Mint
- something else would look better at your discretion. 

If the OS doesn't really have "flavours" to choose from, pick something based on it's general name (e.g. IN causes "WIN" for all windows devices). Note that this is largely about human aesthetics/readability, as there are usually better ways of checking OS.

Valid options:

- (DE)bian
- Linux (MI)nt
- W(IN)dows
- A(ND)roid
- (LI)neageOS
- (MA)njaro
- (AR)ch Linux
- (OP)enBSD

### Device OS (major version)
Digit padded to 2 characters. If something is on version 128, use the last two characters and hope it's never important. If they use a word version, uh... good luck, I haven't decided yet

e.g. (10), (02), 1(28)
