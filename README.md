# Personal-script

#### stardust.zsh-theme:

my zsh theme, fork from ys.zsh-theme

#### windows.ahk:

autohotkey script for windows to make hotkeys work like mac, include:

* win+c/v/w/t/s/r/a work as ctrl+c/v/w/t/s/r/a
* alt+q works as alt+f4
* alt+v works as win+v (for windows 10 clipboard history)
* exchange alt-tab menu and win-tab menu

#### fuzzyssh.sh 

search in ssh config dir with given keyword, then choose one to connect

Usage: `fuzzyssh.sh [SSH option] [keyword1] [keyword2]`

if the input keyword is exactly a IP address, the script will connect to it directly without asking, so you can just `alias ssh='/path/to/fuzzyssh.sh`

#### shutup.sh

to control fans of IBM System x rack server, using `ipmitool`
