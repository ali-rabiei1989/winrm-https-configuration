# Author : Ali Rabiei
# Creation Date : 11/18/2020
# This script create a https listener for winrm service and add the firewall rule 
# --------------------------------------

# Locate WinRMSSL certificate
$templateName = "WinRMSSL"
$cert = Get-ChildItem 'Cert:\LocalMachine\My' | Where-Object{ $_.Extensions | Where-Object{ ($_.Oid.FriendlyName -eq 'Certificate Template Information') -and ($_.Format(0) -match $templateName) }}

# Create https listener
new-item WSMan:\localhost\Listener -Transport HTTPS -Address * -CertificateThumbprint $cert.Thumbprint -Force

# Add a new firewall rule
$port=5986
netsh advfirewall firewall add rule name="Windows Remote Management (HTTPS-In)" dir=in action=allow protocol=TCP localport=$port
