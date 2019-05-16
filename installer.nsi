!define VERSION "1.0"

; The name of the installer
Name "Open Cmd Here"

; The file to write
OutFile "OpenCmdHere-${VERSION}-win64.exe"

; The default installation directory
InstallDir "$PROGRAMFILES\Open Cmd Here"

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "SOFTWARE\Open Cmd Here" "Install_Dir"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

; The stuff to install
Section "Open Cmd Here(required)"

  SectionIn RO

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  File "Tools\ComRegTool.exe"
  File "OpenCmdHere\bin\OpenCmdHere.dll"
  File "OpenCmdHere\bin\SharpShell.dll"

  Exec '"$INSTDIR\ComRegTool.exe" install register "$INSTDIR\OpenCmdHere.dll"'

  ; Write the installation path into the registry
  WriteRegStr HKLM "SOFTWARE\Open Cmd Here" "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Open Cmd Here" "DisplayName" "Open Cmd Here"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Open Cmd Here" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Open Cmd Here" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Open Cmd Here" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
SectionEnd

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Open Cmd Here"
  DeleteRegKey HKLM "SOFTWARE\Open Cmd Here"

  ; Unregister COM server
  ExecWait '"$INSTDIR\ComRegTool.exe" uninstall unregister "$INSTDIR\OpenCmdHere.dll"'

  ; Remove directories used
  RMDir "$SMPROGRAMS\Open Cmd Here"
  RMDir /r "$INSTDIR"

SectionEnd