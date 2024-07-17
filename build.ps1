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
# TODO: CoZ file hook
$GamePath = "H:\Etc\SteamLibrary\steamapps\common\CHAOS;HEAD NOAH"

Remove-Item -Path ".temp" -Recurse -ErrorAction Ignore | Out-Null
New-Item -ErrorAction Ignore -ItemType Directory -Path ".temp" | Out-Null

Write-Host "Building Charset"
$CharsetPath = ".bin\MgsScriptTools\mgs-spec-bank\charset\chaos_head_noah-zhs.utf8"
python .\scripts\build_charset.py .\scripts\mes01 $CharsetPath
python .bin\MgsScriptTools\mgs-spec-bank\charset\generate_from_charset.py $CharsetPath .bin\MgsScriptTools\mgs-spec-bank\charset\chaos_head_noah-zhs.json

Set-Location -Path .temp
..\.bin\mgsfontgen-dx\bin\Release\net461\mgsfontgen-dx.exe generate --charset ..\$CharsetPath --compound-characters ..\.bin\mgsfontgen-dx\chn\CompoundCharacters.tbl --font-family "VL PGothic" --image-format png

Set-Location -Path ..
Write-Host "Compiling scripts"
.bin\MgsScriptTools\MgsScriptTools.exe compile --bank-directory .bin\MgsScriptTools\mgs-spec-bank --compiled-directory .temp\mes01 --decompiled-directory scripts\mes01 --string-syntax Sc3Tools --charset chaos_head_noah-zhs  --flag-set chaos_head_windows --instruction-sets base,chaos_head_noah

Write-Host "Unpacking system.cpk"
.bin\cpk.exe -i $GamePath\Data\system.cpk -o .temp\system

Write-Host "Replacing font maps"
Copy-Item -Path ".temp\FONT_A.png" -Destination .temp\system\20 -Recurse -Force
Copy-Item -Path ".temp\FONT_A.png" -Destination .temp\system\21 -Recurse -Force
Copy-Item -Path ".temp\FONT_A.png" -Destination .temp\system\22 -Recurse -Force
Copy-Item -Path ".temp\FONT_A.png" -Destination .temp\system\23 -Recurse -Force

Write-Host "Repacking system.cpk"
.bin\cpk.exe -r .temp\system.cpk -o .temp\system

Write-Host "Packing script CPKs"
.bin\cpk.exe -r .temp\mes01.cpk -o .temp\mes01

Write-Host "Writing back CPKs"
Copy-Item -Path ".temp\system.cpk" -Destination $GamePath\Data\system.cpk -Recurse -Force
Copy-Item -Path ".temp\mes01.cpk" -Destination $GamePath\Data\mes01.cpk -Recurse -Force
