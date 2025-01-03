if ($args -contains '--help') {
    Write-Host "Usage: build.ps1 [--no-update] [--game-path=<path>]"
    Write-Host "  --no-update: 不更新依赖文件；可选择在第一次运行后使用"
    Write-Host "  --game-path=<path>: 游戏目录（如C:\Program Files (x86)\Steam\steamapps\common\CHAOS;HEAD NOAH)；指定将自动安装补丁至此目录"
    Write-Host "  --eng-script: 使用英语脚本代替日语脚本作为第二语言"
    exit
}
if ($args -notcontains '--no-update') {
    Write-Host "Updating dependencies"
    
    Remove-Item -Path ".bin" -Recurse -ErrorAction Ignore | Out-Null
    New-Item -ErrorAction Ignore -ItemType Directory -Path ".bin" | Out-Null
    # MgsScriptTools
    Invoke-WebRequest -Uri "https://github.com/mos9527/MgsScriptTools/releases/download/latest/net6.0.zip" -OutFile .\.bin\MgsScriptTools.zip
    Expand-Archive -Path .\.bin\MgsScriptTools.zip -DestinationPath .\.bin\MgsScriptTools    
    # cpk
    Invoke-WebRequest -Uri "https://github.com/mos9527/mages-tools/releases/download/latest/cpk.exe" -OutFile .\.bin\cpk.exe
    # LanguageBarrier
    Invoke-WebRequest -Uri "https://github.com/mos9527/LanguageBarrier/releases/download/latest/dinput8_chn.dll" -OutFile .\.bin\dinput8.dll
}

Remove-Item -Path ".temp" -Recurse -ErrorAction Ignore | Out-Null
New-Item -ErrorAction Ignore -ItemType Directory -Path ".temp" | Out-Null

Remove-Item -Path "dist" -Recurse -ErrorAction Ignore | Out-Null
New-Item -ErrorAction Ignore -ItemType Directory -Path "dist" | Out-Null

Write-Host "Building Charset"
$CharsetPath = ".bin\MgsScriptTools\mgs-spec-bank\charset\chaos_head_noah-zhs.utf8"
# 包括英，日，中mes的所有字符
python .\scripts\build_charset.py .\scripts $CharsetPath
python .bin\MgsScriptTools\mgs-spec-bank\charset\generate_from_charset.py $CharsetPath .bin\MgsScriptTools\mgs-spec-bank\charset\chaos_head_noah-zhs.json

Write-Host "Compiling scripts"
New-Item -ErrorAction Ignore -ItemType Directory -Path ".temp\zhs_src" | Out-Null
python scripts\generate_mst.py .temp\zhs_src scripts\zhs
.bin\MgsScriptTools\MgsScriptTools.exe compile --bank-directory .bin\MgsScriptTools\mgs-spec-bank --compiled-directory .temp\ja --decompiled-directory scripts\reference\ja --string-syntax Sc3Tools --charset chaos_head_noah-zhs  --flag-set chaos_head_windows --instruction-sets base,chaos_head_noah
.bin\MgsScriptTools\MgsScriptTools.exe compile --bank-directory .bin\MgsScriptTools\mgs-spec-bank --compiled-directory .temp\eng --decompiled-directory scripts\reference\eng --string-syntax Sc3Tools --charset chaos_head_noah-zhs  --flag-set chaos_head_windows --instruction-sets base,chaos_head_noah
.bin\MgsScriptTools\MgsScriptTools.exe compile --bank-directory .bin\MgsScriptTools\mgs-spec-bank --compiled-directory .temp\zhs --decompiled-directory .temp\zhs_src --string-syntax Sc3Tools --charset chaos_head_noah-zhs  --flag-set chaos_head_windows --instruction-sets base,chaos_head_noah

Write-Host "Packing script CPKs"
.bin\cpk.exe -r .temp\ja.cpk -o .temp\ja
.bin\cpk.exe -r .temp\eng.cpk -o .temp\eng
.bin\cpk.exe -r .temp\zhs.cpk -o .temp\zhs

Write-Host "Packing c0data"
.bin\cpk.exe -r .temp\c0data.cpk -o data\c0data

Write-Host "Copying files"
New-Item -ErrorAction Ignore -ItemType Directory -Path "dist\LanguageBarrier" | Out-Null
New-Item -ErrorAction Ignore -ItemType Directory -Path "dist\LanguageBarrier\fonts" | Out-Null
New-Item -ErrorAction Ignore -ItemType Directory -Path "dist\LanguageBarrier\subs" | Out-Null
New-Item -ErrorAction Ignore -ItemType Directory -Path "dist\LanguageBarrier\subs\fonts" | Out-Null
New-Item -ErrorAction Ignore -ItemType Directory -Path "dist\HEAD NOAH" | Out-Null
Copy-Item -Path ".temp\c0data.cpk" -Destination dist\LanguageBarrier\c0data.cpk -Recurse -Force
if ($args -notcontains '--eng-script') {
    Write-Host "Using Japanese script as second language"
    Copy-Item -Path ".temp\ja.cpk" -Destination dist\LanguageBarrier\c0mes00.cpk -Recurse -Force
} else {
    Write-Host "Using English script as second language"
    Copy-Item -Path ".temp\eng.cpk" -Destination dist\LanguageBarrier\c0mes00.cpk -Recurse -Force
}
Copy-Item -Path ".temp\zhs.cpk" -Destination dist\LanguageBarrier\c0mes01.cpk -Recurse -Force
Copy-Item -Path "data\fonts\*" -Destination dist\LanguageBarrier\fonts\ -Recurse -Force
Copy-Item -Path "data\subs\*" -Destination dist\LanguageBarrier\subs\ -Recurse -Force
Copy-Item -Path "data\fonts\*" -Destination dist\LanguageBarrier\subs\fonts -Recurse -Force
Copy-Item -Path "data\dll\*" -Destination "dist\HEAD NOAH" -Recurse -Force
Copy-Item -Path ".bin\dinput8.dll" -Destination "dist\HEAD NOAH\dinput8.dll" -Recurse -Force

Copy-Item -Path config\*.json -Destination dist\LanguageBarrier\ -Recurse -Force
Copy-Item -Path config\*.bin -Destination dist\LanguageBarrier\ -Recurse -Force
Write-Host "Updating config"
python config\update_config.py $CharsetPath ".bin\MgsScriptTools\mgs-spec-bank\charset\chaos_head_noah-zhs.json" dist\LanguageBarrier\patchdef.json

$GamePath = $args | Where-Object {$_ -match "--game-path=(.+)"} | ForEach-Object { $Matches[1] }
if ($null -ne $GamePath -and (Test-Path $GamePath)) {
    Write-Host "Copying to game directory"
    Remove-Item -Path "$GamePath\LanguageBarrier" -Recurse -ErrorAction Ignore | Out-Null
    Remove-Item -Path "$GamePath\HEAD NOAH" -Recurse -ErrorAction Ignore | Out-Null
    Copy-Item -Path "dist\*" -Destination $GamePath -Recurse -Force
}

Write-Host "Packing distribution"
Remove-Item -Path "Release.zip" -ErrorAction Ignore | Out-Null
Compress-Archive -Path .\dist\* -Destination Release.zip

Write-Host "All done. Going home."
