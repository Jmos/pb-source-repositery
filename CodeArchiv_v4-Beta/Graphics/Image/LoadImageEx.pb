﻿; German forum: http://www.purebasic.fr/german/viewtopic.php?t=12155
; Author: Stefan
; Date: 27. February 2007
; OS: Windows
; Demo: No

;LoadImageEx() can load bmp,jpg,png and gif files, so you don't need huge imageplugins to load these formats
;LoadImageEx() works only if Internet Explorer 4.x or later is installed
;              it can also use an URL as filename

Interface nIDXSurfaceFactory
  QueryInterface(a, b)
  AddRef()
  Release()
  CreateSurface(a, b, c, d, e, f, g, h)
  CreateFromDDSurface(a, b, c, d, e, f)
  LoadImage(a.p-bstr, b, c, d, e, f)
  LoadImageFromStream(a, b, c, d, e, f)
  CopySurfaceToNewFormat(a, b, c, d, e)
  CreateD3DRMTexture(a, b, c, d, e)
  BitBlt(a, b, c, d, e)
EndInterface

#DXLOCKF_READ=0
#CLSCTX_INPROC_SERVER=1

Procedure LoadImageEx(Image,FileName.s,Flags=0)
  result=CoInitialize_(0)
  If result=#S_FALSE Or result=#S_OK
   
    CoCreateInstance_(?CLSID_DXTransformFactory,0,#CLSCTX_INPROC_SERVER,?IID_IDXTransformFactory,@dxtf.IDXTransformFactory)
   
    If dxtf
      dxtf\QueryService(?IID_IDXSurfaceFactory,?IID_IDXSurfaceFactory,@dxsf.nIDXSurfaceFactory)
      If dxsf
        dxsf\LoadImage(FileName,0,0,0,?IID_IDXSurface,@surf.IDXSurface)
        If surf
         
          surf\LockSurfaceDC(0,#INFINITE,#DXLOCKF_READ,@lock.IDXDCLock)
          If lock
            DC=lock\GetDC()
           
            If DC
              GetClipBox_(DC,re.rect)
             
              If Image=#PB_Any
                result=CreateImage(#PB_Any,re\right,re\bottom,Flags)
                Image=result
              Else
                result=CreateImage(Image,re\right,re\bottom,Flags)
              EndIf
             
              If result
               
                DestDC=StartDrawing(ImageOutput(Image)) 
                If DestDC
                  Success=BitBlt_(DestDC,0,0,re\right,re\bottom,DC,0,0,#SRCCOPY)
                  StopDrawing()         
                EndIf
               
                If Success=#False:FreeImage(Image):EndIf
              EndIf
            EndIf
           
            Lock\Release()     
          EndIf
         
          surf\Release()
        EndIf
       
        dxsf\Release()
      EndIf
     
      dxtf\Release()
    EndIf
   
    ;CoUninitialize_() ; dosn't work with this ?!?
  EndIf
 
  If Success:ProcedureReturn result:EndIf
  ProcedureReturn #False
  DataSection
  CLSID_DXTransformFactory:
  Data.l $D1FE6762
  Data.w $FC48,$11D0
  Data.b $88,$3A,$3C,$8B,$00,$C1,$00,$00
 
  IID_IDXTransformFactory:
  Data.l $6A950B2B
  Data.w $A971,$11D1
  Data.b $81,$C8,$00,$00,$F8,$75,$57,$DB
 
  IID_IDXSurfaceFactory:
  Data.l $144946F5
  Data.w $C4D4,$11D1
  Data.b $81,$D1,$00,$00,$F8,$75,$57,$DB
 
  IID_IDXSurface:
  Data.l $B39FD73F
  Data.w $E139,$11D1
  Data.b $90,$65,$00,$C0,$4F,$D9,$18,$9D
  EndDataSection
EndProcedure




OpenWindow(1,0,0,640,480,"LoadImageEx test")

LoadImageEx(1,"..\Gfx\anim_surprize.gif",32)


Repeat

StartDrawing(WindowOutput(1))
DrawImage(ImageID(1),0,0)
StopDrawing()


Until WindowEvent()=#PB_Event_CloseWindow

; IDE Options = PureBasic v4.02 (Windows - x86)
; Folding = -
; EnableXP