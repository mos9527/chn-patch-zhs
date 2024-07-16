if ($args -notcontains '--no-update') {
    Write-Host "Updating dependencies"
    
    Remove-Item -Path ".bin" -Recurse -ErrorAction Ignore | Out-Null
    New-Item -ErrorAction Ignore -ItemType Directory -Path ".bin" | Out-Null
    # MgsScriptTools
    Invoke-WebRequest -Uri "https://github.com/mos9527/MgsScriptTools/releases/download/latest/MgsScriptTools.zip" -OutFile .\.bin\MgsScriptTools.zip
    Expand-Archive -Path .\.bin\MgsScriptTools.zip -DestinationPath .\.bin\MgsScriptTools    
    # cpk
    Invoke-WebRequest -Uri "https://github.com/mos9527/mages-tools/releases/download/latest/cpk.exe" -OutFile .\.bin\cpk.exe
    # LanguageBarrier
    Invoke-WebRequest -Uri "https://github.com/mos9527/LanguageBarrier/releases/download/latest/dinput8.dll" -OutFile .\.bin\dinput8.dll
}

Remove-Item -Path ".temp" -Recurse -ErrorAction Ignore | Out-Null
New-Item -ErrorAction Ignore -ItemType Directory -Path ".temp" | Out-Null

Write-Host "Compiling scripts"
Set-Location scripts
cmd /c invoke.cmd compile

Write-Host "Packing script CPKs"
Set-Location ..\.temp
..\.bin\cpk.exe -r mes00.cpk -o ..\.temp\mes00
..\.bin\cpk.exe -r mes01.cpk -o ..\.temp\mes01

Set-Location ..

