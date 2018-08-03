# Personal-script

#### stardust.zsh-theme:

my zsh theme, fork from ys.zsh-theme

#### windows.ahk:

autohotkey script for windows to make hotkeys work like mac, include:

* alt+c/v/w/t/s/r/a work as ctrl+c/v/w/t/s/r/a
* alt+q works as alt+f4

#### ddns.sh

a dnspod ddns script

#### fuzzyssh.sh 

search in ssh config dir with given keyword, then choose one to connect

Usage: `fuzzyssh.sh [keyword]`

if the input keyword is exactly a IP address, the script will connect to it directly without asking, so you can just `alias ssh='/path/to/fuzzyssh.sh`

#### shutup.sh

to control fans of IBM System x rack server, using `ipmitool`
