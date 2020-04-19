
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include <GUIConstantsEx.au3>
#include <Timers.au3>

AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("GUIOnEventMode", 1)
Opt("MouseClickDownDelay", 100)
; relativity?? AutoItSetOption ( "MouseCoordMode" , 1 )

Const $Title = 'Territory Idle' ; Th3 Naem Of Th3 Gaem.
Const $APPNAME = 'PP Clicker 1.7.12'
Const $dummy = ''
Const $SECS5 = 12000 ; timeout

Global $idTimerPP = -1

Global $hMainGUI

Global $mousePositionIndex
Global $mousePositionList[3][2]

_Main()

Func _Main()
	setHotKey(True, "storeMousePosition")
	InitWindow()
	While True ; busywait for interaction
	 	Sleep(400) ; Sleep to reduce CPU usage
	WEnd
	quit()
EndFunc

Func InitWindow()
	$hMainGUI = GUICreate($APPNAME, 450, 150, 400, 100) ; popup
	GUICtrlCreateLabel("Move mouse to desired location and press CTRL-SHIFT-q. Three times total.", 30, 10)
	GUICtrlCreateLabel("Automatically leftmouseclicks the 3 locations every 12 seconds.", 30, 30)
	GUICtrlCreateLabel("To exit press CTRL-SHIFT-q a fourth time", 30, 50)

	GUISetOnEvent($GUI_EVENT_CLOSE, "clickedCloseButton") ; system X

	GUISetState(@SW_SHOW, $hMainGUI)
EndFunc

Func hereWeGo()
	expiredPP($dummy, $dummy, $dummy, $dummy)
	$idTimerPP = _Timer_SetTimer($hMainGUI, $SECS5, "expiredPP", $idTimerPP) ; why Id?
EndFunc

Func expiredPP($notUsed1, $notUsed2, $notUsed3, $notUsed4) ; dummies)
		;WinActivate($Title)
		For $i = 0 to 2 Step 1
			MouseClick($MOUSE_CLICK_PRIMARY, $mousePositionList[$i][0], $mousePositionList[$i][1])
		Next
EndFunc

Func storeMousePosition()
	Local $nowPos = MouseGetPos()
	$mousePositionList[$mousePositionIndex][0]=$nowPos[0]
	$mousePositionList[$mousePositionIndex][1]=$nowPos[1]
	$mousePositionIndex += 1
	if ($mousePositionIndex==3) Then
			setHotKey(True, "quit")
			; why can't i call hereWeGo ?!
			hereWeGo()
	EndIf
EndFunc

Func setHotKey(Const $wantOn, Const $func)
	if ($wantOn) Then
		HotKeySet("^+{q}", $func)
	Else
		HotKeySet("^+{q}")
	EndIf
EndFunc

; ========================================

Func clickedCloseButton() ; system
	quit()
EndFunc

Func quit()
	_Timer_KillAllTimers($hMainGUI)
	GUIDelete($hMainGUI)
	Exit
EndFunc

; ========================================
; ========================================
; ========================================

; WinWaitActive ( "Territory Idle" , "" , 6 )
;MsgBox($MB_SYSTEMMODAL, "Mouse x, y:", $mousePosition[0] & ", " & $mousePosition[1])

Func XXclickPP()
; Local $FullGameName = WinGetTitle ($Title) ; Get The Full Title..
; Local $hWndGame = WinGetHandle ($FullGameName) ; Get The Handle
; Local $iButton = $MOUSE_CLICK_PRIMARY ; Button The Mouse Will Click I.E. "Left Or Right"
; Local $iClicks = '1' ; #clicks
	Local $iX = '118'
	Local $iY = '439'

;If IsHWnD ($hWndGame) And WinExists ($FullGameName) <> '0' Then ; Win Check
;	MsgBox($MB_SYSTEMMODAL, $APPNAME, "found window")
;EndIf
	WinActivate($Title)
	; ControlClick($hWndGame, '','', $iButton, 1, $iX, $iY) ; Clicking The Window While Its Minmized
	; ?? MouseClick($iButton, $iX, $iY, $iClicks)
	; Sleep(100)
	; MouseMove($iX, $iY)
	; Sleep(100)
	; MouseClick($MOUSE_CLICK_PRIMARY)
	; Sleep(100)
	MouseClick($MOUSE_CLICK_PRIMARY, $iX, $iY)
	MouseClick($MOUSE_CLICK_PRIMARY, $iX, $iY) ; ?? twice ??
	; Sleep(100)
	; MouseDown($MOUSE_CLICK_PRIMARY) ; Set the left mouse button state as down.
	; Sleep(100)
	; MouseUp($MOUSE_CLICK_PRIMARY) ; Set the left mouse button state as up.
	; Sleep(100)
; Else
; 	MsgBox($MB_SYSTEMMODAL, $APPNAME, "Couldn't find window, exiting.")
; EndIf
	Return MouseGetPos()
EndFunc