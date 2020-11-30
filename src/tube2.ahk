SetWorkingDir %A_ScriptDir%
#SingleInstance, force
SetTitleMatchMode, RegEx
SetTitleMatchMode, Slow
CoordMode Menu

/*
Код определения url браузера (GetActiveBrowserURL()) от atnbueno на основе Sean Acc library:
https://www.autohotkey.com/boards/viewtopic.php?f=6&t=3702
*/

EnvSet PATH, % PATH ";" A_ScriptDir "\youtube-dl"
EnvSet APPDATA, % A_ScriptDir
EnvSet HOME, % A_ScriptDir "\youtube-dl"

ini:=RegExReplace(A_ScriptName,"\.\w{3}$") ".ini"
If !FileExist(ini) {
	MsgBox, 16, , Отсутствует файл настроек!, 1
	ExitApp
}

IniRead browser, % ini, Main, browser
IniRead player, % ini, Main, player
IniRead downloads, % ini, Main, downloads
IniRead quiterss, % ini, Main, quiterss
IniRead color, % ini, Main, color
IniRead max, % ini, Main, max
IniRead font, % ini, Main, font
IniRead start, % ini, Main, start
IniRead sites, % ini, Main, sites
IniRead exclude, % ini, Main, exclude

If (downloads~="^-?\w:\\")
	downloads:=usb_path(downloads)
else
	downloads:=A_ScriptDir "\" downloads
FileCreateDir % downloads
FileCreateDir open_in

rss:=FileExist(usb_path(quiterss)) ? 1 : 0
tip:=RegExReplace(A_ScriptName,"\.\w{3}$") . (rss ? "-rss" : "")

If FileExist("0.qrp")
	_menu:=1
If FileExist("1.qrp")
	_browser:=1
FileDelete *.qrp

RegRead tablet, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Tablet PC, IsTabletPC
SysGet M, Monitor
menu_x:=tablet ? MRight//2-50 : "", menu_y:=tablet ? 50 : ""

If start && rss {
	Menu Tray, NoIcon
	SetTimer Exit, 200
}
else {
	Menu Tray, Tip, % tip
	Menu Tray, NoStandard
	If rss {
		Menu Tray, Add, QuiteRSS, QuiteRSS
		Menu Tray, Default, QuiteRSS
	}
	Menu Tray, Add, Плеер, Player_menu
	If !rss
		Menu Tray, Default, Плеер
	Menu Tray, Add
	Menu Tray, Add, Играть url из буфера, ^#vk55
	Menu Tray, Add, Меню url из буфера, Caption
	Menu Tray, Add
	Menu Tray, Add, Папка загрузок, Folder_d
	Menu Tray, Add, Папка программы, Folder
	Menu Tray, Add, Обновить youtube-dl, Update
	Menu Tray, Add, Настройки, Edit	
	Menu Tray, Add, Помощь, Help
	Menu Tray, Add
	Menu Tray, Add, Перезапуск, Reload
	Menu Tray, Add
	Menu Tray, Add, Выход, End
}

Menu Open, Add, Открыть в браузере, Browser
Menu Open, Add, Открыть в плеере, Player
Menu Open, Add
Loop Files, youtube-dl\*.*
	If (A_LoopFileName~="^.+\.(bat|cmd|ps1)$")
		Menu Open, Add, % RegExReplace(A_LoopFileName,"\.bat"), Download
Menu Open, Add
Loop Files, open_in\*.*
{
	If (A_LoopFileName~="^.+\.(bat|cmd|lnk|ahk|vbs|ps1)$")
	{
		Menu Open, Add, % RegExReplace(A_LoopFileName,"\.\w{3}"), Open
		open_list.=A_LoopFilePath "|"
	}
}
Menu Open, Add
Menu Open, Add, Отмена, Cancel

If (url:=A_Args[1]) {
	RegExMatch(url,"^.+//\K[^/]+(?=/)",dom)
	If _menu {
		If dom contains % sites
			Menu Open, Default, 2&
		else
			Menu Open, Default, 1&
		Menu Open, Show, % menu_x, % menu_y
		return
	}
	If dom contains % sites
	{
		If _browser
			goto Browser
		else
			goto Player
	}
	else
		goto Browser
}
else If start && rss
	Run % usb_path(quiterss)
return

^#MButton::
^#vk55::  ; Ctrl+Win+U
	KeyWait LWin, T1
	KeyWait Ctrl, T1
	If (Clipboard~="^(https?://|magnet:|acestream:)") {
		url:=Clipboard
		goto Player
	}
	ToolTip Неверный адрес!
	Sleep 1000
	ToolTip
	return
		
#If rss
^#vk51:: ; Ctrl+Win+Q
	KeyWait Ctrl, T1
	KeyWait LWin, T1
	If WinActive("ahk_exe QuiteRSS.exe")
		WinClose A
	else
		Run % usb_path(quiterss)
	return
		
#If WinActive("ahk_exe QuiteRSS.exe")
Enter up::
NumpadEnter up::
	FileDelete *.qrp
	Send ^{vk4F}
	return

^Enter up::
^NumpadEnter up::
^Mbutton up::
^+Enter up::
^+NumpadEnter up::
^+Mbutton up::
	KeyWait Ctrl, T1
	KeyWait Shift, T1
	FileDelete *.qrp
	FileAppend,, 0.qrp
	Send {LButton}
	Sleep 100
	Send ^{vk4F}
	return

+Enter up::
+NumpadEnter up::
+Mbutton up::
	KeyWait Shift, T1
	FileDelete *.qrp
	FileAppend,, 1.qrp
	Send ^{vk4F}
	return

#If (WinActive("ahk_class Chrome_WidgetWin_0|Chrome_WidgetWin_1|Slimjet_WidgetWin_1|MozillaWindowClass|ApplicationFrameWindow|IEFrame|OperaWindowClass") || WinActive("ahk_exe maxthon.exe")) && !WinActive(".*" exclude ".*")

+Enter up::
+NumpadEnter up::
+MButton::
	KeyWait Shift, T1
	Sleep 100
	gosub Link
	If url
		goto Player
	return

^+Enter up::
^+NumpadEnter up::
^+MButton::
	KeyWait Ctrl, T1
	KeyWait Shift, T1
	Sleep 100
	gosub Link
	If url {
		If link_url && color
			Menu Open, Color, C1D4EC
		else
			Menu Open, Color
		Menu Open, Show, % menu_x, % menu_y
	}
	link_url:=""
	return
#If
	
QuiteRSS:
	Run % usb_path(quiterss)
	return
	
End:
	ExitApp

Link:
	Clipboard:=url:=link_url:=""
	Send ^{vk43}
	ClipWait 0.5
	If (Clipboard~="^(https?://|magnet:|acestream:)") {
		If !WinActive("ahk_exe palemoon.exe|basilisk.exe|vivaldi.exe")
			link_url:=1
		url:=Clipboard
	}
	else
		url:=GetActiveBrowserURL()
	return
	
Download:
	batfile:="youtube-dl\" A_ThisMenuItem ".bat"	
	Run % batfile " """ url """ """ downloads """"
Cancel:
	return

Update:
	Run youtube-dl\Обновить youtube-dl.bat
	return
	
Open:
 Loop Parse, open_list, |
{
	If A_LoopField contains % A_ThisMenuItem
	{
		Run % A_LoopField " """ url """"
		break
	}
}
return
	
Browser:
	Run % (browser ? usb_path(browser) " " : "") """" url """"
	return
	
Player:
	Run % usb_path(player) " """ url """",,, pid
	SplitPath player, player_file
	If max {
		WinWaitActive ahk_pid %pid%
		Sleep 100
		WinMaximize
	}
	If !font
		return
	While WinExist("ahk_pid " pid)
	{
		WinGet pid_new, PID, A   
		WinGetActiveTitle title
		If WinActive("ahk_pid " pid) && !IsFullScreen()
		{
			If (title!=title_old || !WinExist("wintitle ahk_class AutoHotkeyGUI")) {
				show:=RegExReplace(title," - MPC-BE.+$")
				show:=RegExReplace(show,"\|+","-")
				show:=RegExReplace(show,"(_+| {2,})"," ")
				Gui Destroy
				Gui font, s%font% bold cf1f1f1
				Gui Margin, 4, 2
				Gui Color, 2f2f2f
				Gui +AlwaysOnTop -Caption -DPIScale +ToolWindow +LastFound
				Gui, Add, Text, +Center gCaption, % Trim(show)
				WinSet Transparent, 240
				Gui Show, x0 y0 NA, wintitle
				title_old:=title
			}
			else If WinExist("wintitle ahk_class AutoHotkeyGUI")
				WinSet Top,, wintitle ahk_class AutoHotkeyGUI	
		}
		else
			Gui Destroy	
		Sleep 300
	}
	Gui Destroy
	return

^#!MButton::
KeyWait Ctrl, T1
KeyWait LWin, T1
KeyWait Alt, T1
^#vk4D::
	If (Clipboard~="^(https?://|magnet:|acestream:)") {
		url:=Clipboard
		goto Caption
	}
	ToolTip Неверный адрес!
	Sleep 1000
	ToolTip
	return

Caption:
	Menu Open, Show
	return	
	
Help:
	Run ReadMe.html
	return

Player_menu:
	Run % usb_path(player)
	return
	
Edit:
	Run notepad.exe %ini%
	return
	
Folder:
	Run explorer.exe "%A_ScriptDir%"
	return
	
Folder_d:
	Run explorer.exe "%downloads%"
	return
	
Reload:
	Reload

Exit:
	Process Exist, QuiteRSS.exe
	exit:=ErrorLevel ? 0 : exit+1
	If exit>4
		ExitApp
	return
	
IsFullScreen(win="A")
{
	SysGet, M, Monitor
	WinGetPos,,, w, h, % win
	f:=0
	If (w>=MRight && h>=MBottom)
		f:=1
	return f
}
	
usb_path(p) {
	SplitPath % A_ScriptDir,,,,, drive
	p:=RegExReplace(p,"^-[a-zA-Z]:",drive)
	return p
}

;====================================
GetActiveBrowserURL() {
	ModernBrowsers := "ApplicationFrameWindow,Chrome_WidgetWin_0,Chrome_WidgetWin_1,Maxthon3Cls_MainFrm,MozillaWindowClass,Slimjet_WidgetWin_1"	
	LegacyBrowsers := "IEFrame,OperaWindowClass"	
	WinGetClass, sClass, A
	If sClass In % ModernBrowsers
		url:=GetBrowserURL_ACC(sClass)
	Else If sClass In % LegacyBrowsers
		url:=GetBrowserURL_DDE(sClass)
	If (sClass="Chrome_WidgetWin_1") && !WinActive("ahk_exe vivaldi.exe")
		return Trim(url)
	If !(url~="^https?://\S+$") 
	{
		Clipboard:=""
		Send ^{vk4C}
		Sleep 300
		Send ^{Ins}
		ClipWait 0.5
		If Clipboard
			url:=Clipboard
	}
	return Trim(url)
}

; "GetBrowserURL_DDE" adapted from DDE code by Sean, (AHK_L version by maraskan_user)
; Found at http://autohotkey.com/board/topic/17633-/?p=434518

GetBrowserURL_DDE(sClass) {
	WinGet, sServer, ProcessName, % "ahk_class " sClass
	StringTrimRight, sServer, sServer, 4
	iCodePage := A_IsUnicode ? 0x04B0 : 0x03EC ; 0x04B0 = CP_WINUNICODE, 0x03EC = CP_WINANSI
	DllCall("DdeInitialize", "UPtrP", idInst, "Uint", 0, "Uint", 0, "Uint", 0)
	hServer := DllCall("DdeCreateStringHandle", "UPtr", idInst, "Str", sServer, "int", iCodePage)
	hTopic := DllCall("DdeCreateStringHandle", "UPtr", idInst, "Str", "WWW_GetWindowInfo", "int", iCodePage)
	hItem := DllCall("DdeCreateStringHandle", "UPtr", idInst, "Str", "0xFFFFFFFF", "int", iCodePage)
	hConv := DllCall("DdeConnect", "UPtr", idInst, "UPtr", hServer, "UPtr", hTopic, "Uint", 0)
	hData := DllCall("DdeClientTransaction", "Uint", 0, "Uint", 0, "UPtr", hConv, "UPtr", hItem, "UInt", 1, "Uint", 0x20B0, "Uint", 10000, "UPtrP", nResult) ; 0x20B0 = XTYP_REQUEST, 10000 = 10s timeout
	sData := DllCall("DdeAccessData", "Uint", hData, "Uint", 0, "Str")
	DllCall("DdeFreeStringHandle", "UPtr", idInst, "UPtr", hServer)
	DllCall("DdeFreeStringHandle", "UPtr", idInst, "UPtr", hTopic)
	DllCall("DdeFreeStringHandle", "UPtr", idInst, "UPtr", hItem)
	DllCall("DdeUnaccessData", "UPtr", hData)
	DllCall("DdeFreeDataHandle", "UPtr", hData)
	DllCall("DdeDisconnect", "UPtr", hConv)
	DllCall("DdeUninitialize", "UPtr", idInst)
	csvWindowInfo := StrGet(&sData, "CP0")
	StringSplit, sWindowInfo, csvWindowInfo, `" ;"; comment to avoid a syntax highlighting issue in autohotkey.com/boards
	Return sWindowInfo2
}

GetBrowserURL_ACC(sClass) {
	global nWindow, accAddressBar
	If (nWindow != WinExist("ahk_class " sClass)) ; reuses accAddressBar if it's the same window
	{
		nWindow := WinExist("ahk_class " sClass)
		accAddressBar := GetAddressBar(Acc_ObjectFromWindow(nWindow))
	}
	Try sURL := accAddressBar.accValue(0)
	If (sURL == "") {
		WinGet, nWindows, List, % "ahk_class " sClass ; In case of a nested browser window as in the old CoolNovo (TO DO: check if still needed)
		If (nWindows > 1) {
			accAddressBar := GetAddressBar(Acc_ObjectFromWindow(nWindows2))
			Try sURL := accAddressBar.accValue(0)
		}
	}
	If ((sURL != "") and (SubStr(sURL, 1, 4) != "http")) ; Modern browsers omit "http://"
		sURL := "http://" sURL
	If (sURL == "")
		nWindow := -1 ; Don't remember the window if there is no URL
	Return sURL
}

; "GetAddressBar" based in code by uname
; Found at http://autohotkey.com/board/topic/103178-/?p=637687

GetAddressBar(accObj) {
	Try If ((accObj.accRole(0) == 42) and IsURL(accObj.accValue(0)))
		Return accObj
	Try If ((accObj.accRole(0) == 42) and IsURL("http://" accObj.accValue(0))) ; Modern browsers omit "http://"
		Return accObj
	For nChild, accChild in Acc_Children(accObj)
		If IsObject(accAddressBar := GetAddressBar(accChild))
			Return accAddressBar
}

IsURL(sURL) {
	Return RegExMatch(sURL, "^(?<Protocol>https?|ftp)://(?<Domain>(?:[\w-]+\.)+\w\w+)(?::(?<Port>\d+))?/?(?<Path>(?:[^:/?# ]*/?)+)(?:\?(?<Query>[^#]+)?)?(?:\#(?<Hash>.+)?)?$")
}

; The code below is part of the Acc.ahk Standard Library by Sean (updated by jethrow)
; Found at http://autohotkey.com/board/topic/77303-/?p=491516

Acc_Init()
{
	static h
	If Not h
		h:=DllCall("LoadLibrary","Str","oleacc","Ptr")
}
Acc_ObjectFromWindow(hWnd, idObject = 0)
{
	Acc_Init()
	If DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd, "UInt", idObject&=0xFFFFFFFF, "Ptr", -VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
	Return ComObjEnwrap(9,pacc,1)
}
Acc_Query(Acc) {
	Try Return ComObj(9, ComObjQuery(Acc,"{618736e0-3c3d-11cf-810c-00aa00389b71}"), 1)
}
Acc_Children(Acc) {
	If ComObjType(Acc,"Name") != "IAccessible"
		ErrorLevel := "Invalid IAccessible Object"
	Else {
		Acc_Init(), cChildren:=Acc.accChildCount, Children:=[]
		If DllCall("oleacc\AccessibleChildren", "Ptr",ComObjValue(Acc), "Int",0, "Int",cChildren, "Ptr",VarSetCapacity(varChildren,cChildren*(8+2*A_PtrSize),0)*0+&varChildren, "Int*",cChildren)=0 {
			Loop %cChildren%
				i:=(A_Index-1)*(A_PtrSize*2+8)+8, child:=NumGet(varChildren,i), Children.Insert(NumGet(varChildren,i-8)=9?Acc_Query(child):child), NumGet(varChildren,i-8)=9?ObjRelease(child):
			Return Children.MaxIndex()?Children:
		} Else
			ErrorLevel := "AccessibleChildren DllCall Failed"
	}
}


