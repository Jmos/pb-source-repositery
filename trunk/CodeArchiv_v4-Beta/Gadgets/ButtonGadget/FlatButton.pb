; English forum: http://www.purebasic.fr/english/viewtopic.php?t=6533&highlight=
; Author: GPI (updated for PB4.00 by blbltheworm)
; Date: 13. June 2003
; OS: Windows
; Demo: Yes


; Flat Button doesn't work with enabled WinXP skin !
; Flat Button funktioniert nicht mit eingeschaltetem WinXP Skin !

Declare Open_Window_0() 

;- Window Constants 
; 
#Window_0  = 0 
#BS_FLAT  = $8000 
#GWL_STYLE  =  - 16 
#WS_CHILD  = $40000000 
;- Gadget Constants 
; 
#Gadget_0  = 0 


Procedure Open_Window_0() 
  If OpenWindow(#Window_0, 251, 249, 191, 300, "Flat Button", #PB_Window_SystemMenu  | #PB_Window_SizeGadget  | #PB_Window_TitleBar ) 
    If CreateGadgetList(WindowID(#Window_0)) 
      ButtonGadget(#Gadget_0,  25, 100, 140, 40, "Flat Button", #BS_FLAT) 
    EndIf 
  EndIf 
EndProcedure 


Open_Window_0() 
Repeat 
  Event  = WaitWindowEvent() 
  
  
Until Event  = #PB_Event_CloseWindow

; IDE Options = PureBasic v4.00 (Windows - x86)
; Folding = -