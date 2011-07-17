; FileReader
; JCV @ PureBasic Forum
; http://www.JCVsite.com

Global hMapFile.l, hFile.l, Size.l = 0
Global addr.l

Procedure FileReader_destroy()
  CloseHandle_(hMapFile)
  CloseHandle_(hFile)
EndProcedure

Procedure FileReader_getSize()
  ProcedureReturn Size
EndProcedure

Procedure FileReader_readInt(offset)
  Protected i
  i = PeekL(addr + offset)
  ProcedureReturn i
EndProcedure

Procedure.s FileReader_readStr(offset)
  Protected out.s
	out = PeekS(addr + offset)
  ProcedureReturn out
EndProcedure

Procedure FileReader(filename.s)
  Protected buf.OFSTRUCT

  buf\cBytes = SizeOf(OFSTRUCT);
  hFile = CreateFile_(filename, #GENERIC_READ, #FILE_SHARE_READ, #Null, #OPEN_EXISTING, 0, #Null)
  If (hFile = #INVALID_HANDLE_VALUE)
    ProcedureReturn 0
  EndIf
	Size = GetFileSize_(hFile, #Null)
	hMapFile = CreateFileMapping_(hFile, #Null, #PAGE_READONLY, 0, Size, #Null)
	If hMapFile = #Null
    CloseHandle_(hFile)
    ProcedureReturn 1
  EndIf
    
	addr = MapViewOfFile_(hMapFile, #FILE_MAP_READ, 0, 0, Size)
  If (addr = #Null)
    CloseHandle_(hMapFile);
    CloseHandle_(hFile);
    ProcedureReturn 2
  EndIf
EndProcedure
   
; jaPBe Version=3.7.2.627
; Build=0
; Language=0x0000 Language Neutral
; FirstLine=0
; CursorPosition=3
; EnableXP
; ExecutableFormat=Windows
; DontSaveDeclare
; EOF