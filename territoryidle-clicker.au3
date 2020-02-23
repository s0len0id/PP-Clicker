; Make available a library of constant values.
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include <GUIConstantsEx.au3>
#include <Timers.au3>

AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("GUIOnEventMode", 1)
; relativity?? AutoItSetOption ( "MouseCoordMode" , 1 )

Const $Title = 'Territory Idle' ; Th3 Naem Of Th3 Gaem.
Const $APPNAME = 'PP Clicker'
Const $dummy = ''

Global $idTimer = -1
Global $hMainGUI
Global $mousePosition
; 118, 439

_Main()

Func _Main()
	InitWindow()
	While True ; busywait for interaction
	 	Sleep(200) ; Sleep to reduce CPU usage
	WEnd
	quit()
EndFunc

Func InitWindow()
	$hMainGUI = GUICreate($APPNAME, 400, 150, 800, 800)
	GUICtrlCreateLabel("leftmouseclicks PP button every 5 seconds.", 30, 10)
	GUICtrlCreateLabel("Window must be in top-left corner @ default window size!", 30, 30)
	GUICtrlCreateLabel("Exits if mouse has moved.", 30, 50)

	GUISetOnEvent($GUI_EVENT_CLOSE, "clickedCloseButton")

	Local $btSTART = GUICtrlCreateButton("START", 70, 100, 140)
	GUICtrlSetOnEvent($btSTART, "clickedStartButton")

	GUISetState(@SW_SHOW, $hMainGUI)
EndFunc

Func clickedStartButton()
	GUICtrlSetState(@GUI_CtrlId, $GUI_HIDE)
	$mousePosition = clickPP()
	;MsgBox($MB_SYSTEMMODAL, "Mouse x, y:", $mousePosition[0] & ", " & $mousePosition[1])
	$idTimer = _Timer_SetTimer($hMainGUI, 5000, "expired", $idTimer) ; create timer
EndFunc   ;==>clickedStartButton

Func expired($notUsed1, $notUsed2, $notUsed3, $notUsed4) ; dummies)
	WinFlash($hMainGUI, "", 2)
	If (hasMouseMoved()) Then
		quit()
	Else
		clickPP()
	EndIf
EndFunc

Func clickPP()
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
	MouseClick($MOUSE_CLICK_PRIMARY, $iX, $iY, 2)
	;MouseClick($MOUSE_CLICK_PRIMARY, $iX, $iY)
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

Func clickedCloseButton()
	; $iCONTINUE = False
	quit()
EndFunc   ;==>clickedCloseButton

Func hasMouseMoved()
	Local $nowPos = MouseGetPos()
	If $mousePosition[0] = $nowPos[0] And $mousePosition[1] = $nowPos[1] Then
		return False
	Else
		return True
	EndIf
EndFunc

Func quit()
	_Timer_KillAllTimers($hMainGUI)
	GUIDelete($hMainGUI)
	Exit
EndFunc

; WinWaitActive ( "Territory Idle" , "" , 6 )

