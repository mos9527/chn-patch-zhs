if ($args -notcontains '--no-update') {
    Write-Host "Updating dependencies"
    
    Remove-Item -Path ".bin" -Recurse -ErrorAction Ignore | Out-Null
    New-Item -ErrorAction Ignore -ItemType Directory -Path ".bin" | Out-Null
    # MgsFontGen-DX
    Invoke-WebRequest -Uri "https://github.com/mos9527/mgsfontgen-dx/releases/download/latest/mgsfontgen-dx.zip" -OutFile .\.bin\mgsfontgen-dx.zip
    Expand-Archive -Path .\.bin\mgsfontgen-dx.zip -DestinationPath .\.bin\mgsfontgen-dx
    # MgsScriptTools
    Invoke-WebRequest -Uri "https://github.com/mos9527/MgsScriptTools/releases/download/latest/net6.0.zip" -OutFile .\.bin\MgsScriptTools.zip
    Expand-Archive -Path .\.bin\MgsScriptTools.zip -DestinationPath .\.bin\MgsScriptTools    
    # cpk
    Invoke-WebRequest -Uri "https://github.com/mos9527/mages-tools/releases/download/latest/cpk.exe" -OutFile .\.bin\cpk.exe
    # LanguageBarrier
    Invoke-WebRequest -Uri "https://github.com/mos9527/LanguageBarrier/releases/download/latest/dinput8.dll" -OutFile .\.bin\dinput8.dll
}

Remove-Item -Path ".temp" -Recurse -ErrorAction Ignore | Out-Null
New-Item -ErrorAction Ignore -ItemType Directory -Path ".temp" | Out-Null

Remove-Item -Path ".dist" -Recurse -ErrorAction Ignore | Out-Null
New-Item -ErrorAction Ignore -ItemType Directory -Path ".dist" | Out-Null

Write-Host "Building Charset"
$CharsetPath = ".bin\MgsScriptTools\mgs-spec-bank\charset\chaos_head_noah-zhs.utf8"
python .\scripts\build_charset.py .\scripts\mes01 $CharsetPath

Write-Host "Compiling scripts"
.bin\MgsScriptTools\MgsScriptTools.exe compile --bank-directory .bin\MgsScriptTools\mgs-spec-bank --compiled-directory .temp\mes01 --decompiled-directory scripts\mes01 --string-syntax Sc3Tools --charset chaos_head_noah-zhs  --flag-set chaos_head_windows --instruction-sets base,chaos_head_noah

Write-Host "Packing script CPKs"
.bin\cpk.exe -r .temp\mes01.cpk -o .temp\mes01

Copy-Item -Path config\*.json -Destination dist\LanguageBarrier\  -Recurse -Force
Write-Host "Updating config"
python config\update_config.py $CharsetPath dist\LanguageBarrier\patchdef.json

Write-Host "Copying files"
Copy-Item -Path ".temp\mes01.cpk" -Destination dist\LanguageBarrier\cmes01.cpk -Recurse -Force
Copy-Item -Path "data\*" -Destination dist\LanguageBarrier\ -Recurse -Force
Copy-Item -Path ".bin\dinput8.dll" -Destination "dist\dinput8.dll" -Recurse -Force
$GamePath = "H:\Etc\SteamLibrary\steamapps\common\CHAOS;HEAD NOAH"
if (Test-Path $GamePath) {
    Write-Host "Copying to game directory"
    Copy-Item -Path "dist\*" -Destination "$GamePath" -Recurse -Force
}