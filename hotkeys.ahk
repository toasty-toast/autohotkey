#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

#Include hotkeys.include.ahk

; "CTRL + ALT + SCROLL" scrolls left and right
^!WheelUp::
	ControlGetFocus, fcontrol, A
	Loop 4
		SendMessage, 0x114, 0, 0, %fcontrol%, A
	Return
^!WheelDown::
	ControlGetFocus, fcontrol, A
	Loop 4
		SendMessage, 0x114, 1, 0, %fcontrol%, A
	Return
	
; "WIN + ALT + SCROLL" and "WIN + ALT PGUP/PGDN" control volume
#!WheelUp::Send {Volume_Up 1}
#!WheelDown::Send {Volume_Down 1}
#!PgUp::Send {Volume_Up 1}
#!PgDn::Send {Volume_Down 1}

; "WIN + ALT + P" removes newlines from pull request text in Bitbucket
#!P::
{
	Send {Down}
	Sleep 10
	Send {Home}
	Sleep 10
	Send {Backspace}
	Sleep 10
	Send {Space}
	Send {Down}
	Return
}

; "CTRL + SHIFT + \" sends username, tab, password
^+\::
{
	Send %Username%{Tab}%Password%{Enter}
	Return
}

; "CTRL + ALT + K" shows a GUI to create a markdown link and copy it to the clipboard
^!k::

SendInput ^c

markdownUrl = %Clipboard%
markdownText = %Clipboard%

Gui, +AlwaysOnTop +Owner
Gui, Add, Text,, Link text
Gui, Add, Edit, vmarkdownText w320 r1, %markdownText%
Gui, Add, Text,, URL
Gui, Add, Edit, vmarkdownUrl w320 r1, %markdownUrl%
Gui, Add, Button, Default, OK
Gui, Show, w350, MDLink

Return

ButtonOK:
    Gui, Submit
    Gui, Destroy
    Clipboard = [%markdownText%](%markdownUrl%)
    TrayTip, Markdown Link, Markdown-formatted link copied to clipboard
    SetTimer, RemoveTrayTip, 2000
    Return

GuiClose:
    Gui, Destroy
    SetTimer, RemoveTrayTip, 2000
    Return

RemoveTrayTip:
    SetTimer, RemoveTrayTip, Off 
    TrayTip 
	
Return

; "WIN + End" turns off monitors
#End::
; 0x112 = WM_SYSCOMMAND
; 0xF170 = SC_MONITORPOWER
; 2 = Turn monitor off (-1 turns on, 1 activates low power mode)
SendMessage, 0x112, 0xF170, 2,, Program Manager
Return