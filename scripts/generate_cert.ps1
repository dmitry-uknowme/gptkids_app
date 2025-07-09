# 1. Создание самоподписанного сертификата с нужными полями
$cert = New-SelfSignedCertificate `
  -Type CodeSigningCert `
  -Subject "CN=GptkidsAssistant, O=LLC Gptkids, OU=Dev, C=RU" `
  -CertStoreLocation "Cert:\CurrentUser\My"

# 2. Установка пароля
$password = ConvertTo-SecureString -String "123456" -Force -AsPlainText

# 3. Создание папки (если нет)
New-Item -ItemType Directory -Force -Path "..\msix" | Out-Null

# 4. Экспорт в .pfx
Export-PfxCertificate -Cert $cert -FilePath "..\msix\gptkids_cert.pfx" -Password $password

# 5. Экспорт в .cer
Export-Certificate -Cert $cert -FilePath "..\msix\gptkids_cert.cer"