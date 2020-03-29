
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include <GUIConstantsEx.au3>
#include <Timers.au3>

AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("GUIOnEventMode", 1)
Opt("MouseClickDownDelay", 100)
; relativity?? AutoItSetOption ( "MouseCoordMode" , 1 )

Const $Title = 'Territory Idle' ; Th3 Naem Of Th3 Gaem.
Const $APPNAME = 'PP Clicker 1.6.23'
Const $dummy = ''
Const $SECS5 = 12000 ; timeout

Global $idTimerPP = -1

Global $hMainGUI
Global $mousePosition

Global $buttonPP = [118, 439]
Global $buttonHeal = [686, 587]
Global $buttonRepeat = [749, 613]
Global $buttonRepeat = [749, 613]
Global $defaultposition = [170, 439]

_Main()

Func _Main()
	InitWindow()
	While True ; busywait for interaction
	 	Sleep(400) ; Sleep to reduce CPU usage
	WEnd
	quit()
EndFunc

Func InitWindow()
$hMainGUI = GUICreate($APPNAME, 400, 150, 800, 800) ; popup
	GUICtrlCreateLabel("leftmouseclicks PP button, heals and repeats every 12 seconds.", 30, 10)
	GUICtrlCreateLabel("Window must be exact in top-left corner @ default window size!", 30, 30)
	GUICtrlCreateLabel("Exits if mouse has moved to top of screen.", 30, 50)

	GUISetOnEvent($GUI_EVENT_CLOSE, "clickedCloseButton") ; system X

	Local $btSTART = GUICtrlCreateButton("START", 70, 100, 140)
	GUICtrlSetOnEvent($btSTART, "clickedStartButton")

	GUISetState(@SW_SHOW, $hMainGUI)
EndFunc

Func clickedStartButton()
	GUICtrlSetState(@GUI_CtrlId, $GUI_HIDE)
	expiredPP($dummy, $dummy, $dummy, $dummy)
	$idTimerPP = _Timer_SetTimer($hMainGUI, $SECS5, "expiredPP", $idTimerPP) ; why Id?
EndFunc

Func clickButton(Const $butt)
	WinActivate($Title)
	MouseClick($MOUSE_CLICK_PRIMARY, $butt[0], $butt[1])
EndFunc

Func expiredPP($notUsed1, $notUsed2, $notUsed3, $notUsed4) ; dummies)
	Local $isRepeating = False
	If (isMouseAtQuitPosition()) Then
		quit()
	Else
	clickButton($buttonPP)
	clickButton($buttonHeal)
	clickButton($buttonRepeat)
	MouseMove($defaultposition[0], $defaultposition[1])
	Endif
EndFunc

; ========================================

Func clickedCloseButton() ; system
	quit()
EndFunc

Func isMouseAtQuitPosition()
	Local $nowPos = MouseGetPos()
	If 50 > $nowPos[1] Then
		return True
	Else
		return False
	EndIf
EndFunc

Func quit()
	_Timer_KillAllTimers($hMainGUI)
	GUIDelete($hMainGUI)
	Exit
EndFunc

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