#t::Send ^{t}
#w::Send ^{w}
#r::Send ^{r}
#c::Send ^{c}

#v::Send ^{v}
#f::Send ^{f}
#x::Send ^{x}
#z::Send ^{z}
#s::Send ^{s}
#a::Send ^{a}

#q::
if WinActive("ahk_exe chrome.exe")
{
	return
}
else {
	Send !{F4}
	return
}

!s::Send #{s}
#+t::Send ^+{t}
LWin & Tab::AltTab

;!Tab::Send #{Tab}
