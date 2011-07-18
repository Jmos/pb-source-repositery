; English forum: http://www.purebasic.fr/english/viewtopic.php?t=43409#43409
; Author: Wayne Diamond
; Date: 01. January 2004
; OS: Windows
; Demo: Yes


; EnableAsm
Procedure XorWithKey (sText.l, LenText.l, sKey.l, LenKey.l)
  XOR ecx, ecx
  MOV esi, sText
  MOV edi, sKey
  MOV edx, LenText
  MOV ebp, LenKey
  ADD ebp, esi
  xornextbyte:
  MOV al, [esi]
  MOV bl, [edi]
  XOR al, bl
  MOV [esi], al
  INC ecx
  INC esi
  INC edi
  CMP esi, ebp
  JGE l_xorcomplete
  CMP ecx, edx
  JGE l_xornextround
  JMP l_xornextbyte
  xornextround:
  XOR ecx, ecx
  SUB edi, edx
  JMP l_xornextbyte
  xorcomplete:
EndProcedure

sText.s = "Text to encrypt"
sKey.s = "Wayne Diamond"
;// Encrypt
XorWithKey(@sText, Len(sText), @sKey, Len(sKey))
Debug sText
;// And again, which decrypts it
XorWithKey(@sText, Len(sText), @sKey, Len(sKey))
Debug sText

; IDE Options = PureBasic v4.00 (Windows - x86)
; Folding = -
; EnableAsm