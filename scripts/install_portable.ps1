# Настройки
$AppName = "Gptkids Assistant"
$Executable = "GptkidsAssistant.exe"
$ShortcutName = "$AppName.lnk"

$BuildSource = Join-Path $PSScriptRoot "build\windows\x64\runner\Release"
$TargetFolder = "$env:LOCALAPPDATA\$AppName"

$DesktopShortcutPath = "$env:USERPROFILE\Desktop\$ShortcutName"
$StartMenuFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\$AppName"
$StartMenuShortcutPath = "$StartMenuFolder\$ShortcutName"
$StartupShortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\$ShortcutName"

# Проверка сборки
if (-Not (Test-Path "$BuildSource\$Executable")) {
    Write-Error "❌ Не найден исполняемый файл по пути: $BuildSource\$Executable"
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

Write-Host "Установка $AppName..."

if (-Not (Test-Path $TargetFolder)) {
    New-Item -ItemType Directory -Force -Path $TargetFolder | Out-Null
}

Copy-Item -Path "$BuildSource\*" -Destination $TargetFolder -Recurse -Force

$WshShell = New-Object -ComObject WScript.Shell

function CreateShortcut($path) {
    $shortcut = $WshShell.CreateShortcut($path)
    $shortcut.TargetPath = "$TargetFolder\$Executable"
    $shortcut.WorkingDirectory = $TargetFolder
    $shortcut.IconLocation = "$TargetFolder\$Executable"
    $shortcut.Save()
    Write-Host "Создан ярлык: $path"
}

CreateShortcut $DesktopShortcutPath

if (-Not (Test-Path $StartMenuFolder)) {
    New-Item -ItemType Directory -Force -Path $StartMenuFolder | Out-Null
}

CreateShortcut $StartMenuShortcutPath
CreateShortcut $StartupShortcutPath

Write-Host "`nУстановка завершена!"
Read-Host "Нажмите Enter для выхода"


# # === НАСТРОЙКИ ===
# $AppName       = "Gptkids Assistant"
# $TargetFolder  = "$env:LOCALAPPDATA\$AppName"
# $Executable    = "GptkidsAssistant.exe"  # Имя EXE в папке скрипта
# $ShortcutName  = "$AppName.lnk"

# # === ЛОГИКА ===
# Write-Host "🔧 Установка $AppName..."

# # 1. Создание целевой папки
# if (-Not (Test-Path $TargetFolder)) {
#     New-Item -ItemType Directory -Force -Path $TargetFolder | Out-Null
#     Write-Host "📁 Создана папка: $TargetFolder"
# }

# # 2. Копирование всех файлов
# $ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
# Copy-Item -Path "$ScriptPath\*" -Destination $TargetFolder -Recurse -Force
# Write-Host "📄 Файлы скопированы в $TargetFolder"

# # 3. Создание ярлыка на рабочем столе
# $WshShell = New-Object -ComObject WScript.Shell
# $ShortcutPath = "$env:USERPROFILE\Desktop\$ShortcutName"
# $Shortcut = $WshShell.CreateShortcut($ShortcutPath)
# $Shortcut.TargetPath = "$TargetFolder\$Executable"
# $Shortcut.WorkingDirectory = $TargetFolder
# $Shortcut.IconLocation = "$TargetFolder\$Executable"
# $Shortcut.Save()
# Write-Host "📌 Ярлык создан: $ShortcutPath"

# # 4. Завершение
# Write-Host "`n✅ $AppName установлен как portable!"
# Read-Host "Нажмите Enter для выхода"


# Что должно быть в архиве
# GptkidsPortableInstaller\
# ├─ GptkidsAssistant.exe
# ├─ *.dll, *.dat, data\
# ├─ install_portable.ps1
# ├─ ReadMe.txt

# Установка Gptkids Assistant:

# 1. Кликни правой кнопкой мыши по install_portable.ps1 → "Запуск от имени администратора"
# 2. Будет создана папка:
#    C:\Users\ВашеИмя\AppData\Local\Gptkids Assistant
# 3. На рабочем столе появится ярлык
# 4. Программа готова к запуску

