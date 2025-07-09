$certPath = "gptkids_cert.cer"
$msixPath = "gptkids_installer.msix"

Write-Host "==> Установка сертификата: $certPath..."

try {
    Import-Certificate -FilePath $certPath -CertStoreLocation "Cert:\LocalMachine\Root" -Verbose
    Write-Host "✅ Сертификат установлен успешно."
} catch {
    Write-Error "❌ Не удалось установить сертификат: $($_.Exception.Message)"
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

Start-Sleep -Seconds 2

$installedCert = Get-ChildItem -Path Cert:\LocalMachine\Root | Where-Object { $_.Subject -like "*Gptkids*" }

if ($installedCert) {
    Write-Host "✅ Сертификат найден в доверенных центрах."
} else {
    Write-Error "❌ Сертификат не найден после установки."
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

Write-Host "==> Запуск установки: $msixPath..."

try {
    Add-AppxPackage -Path $msixPath -Verbose
    Write-Host "✅ Установка завершена!"
} catch {
    Write-Error "❌ Ошибка при установке: $($_.Exception.Message)"
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

Write-Host ""
Read-Host "Нажмите Enter для выхода"
