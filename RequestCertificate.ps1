#Script request certificate by CA with CEP / CES UsernamePassword
# Run script as Administrator
#Set credentinals
$compname = Read-Host 'Input computer name'
$username = Read-Host 'Input user name (domain\username)'
$password = Read-Host 'Input password'

#Set work directory
$dir = "C:\tmp"

#Set CEP and CES service
$PolicyServer = "https://ca01.domain.name/ADPolicyProvider_CEP_UsernamePassword/service.svc/CEP"
$ConfigServer = "https://ca01.domain.name/Inner%20Issuing%20Certification%20authority_CES_UsernamePassword/service.svc/CES"

#Create SMTP 
$smtp = "smtp server" 
$smtpport = "587"
$to = "user" 
$from = "user" 
$subject = "Request new certificate for BYOD. Computer name $compname"

#Create .inf file for new request
(Get-Content $dir\policy.inf).replace([Regex]::Matches((Get-Content $dir\policy.inf).Where({$_ -match "CN="}),'(?<=\"CN=).*?(?=[\"])'), $compname) | Set-Content $dir\$compname.inf
(Get-Content $dir\$compname.inf).replace([Regex]::Matches((Get-Content $dir\$compname.inf).Where({$_ -match "UPN="}),'(?<=\"UPN=).*?(?=\$)'), $compname) | Set-Content $dir\$compname.inf

#Create request file
Certreq.exe -New $dir\$compname.inf $dir\$compname.req

#Send request to CA
$Req = certreq -submit -Username $username -p $password -PolicyServer $PolicyServer -config $ConfigServer -attrib "CertificateTemplate:BYOD802.1x" $dir\$compname.req $dir\$compname.cer

#Getting RequestId
$ReqID = [Regex]::Matches($Req.Where({$_ -match "RequestId"}),'(?<=\").*?(?=\")')

#Send Email with Computer name and RequestId
$body = "<br>Request Created successful RequestId: $ReqID<br>" 
send-MailMessage -SmtpServer $smtp -port $smtpport -To $to -From $from -Subject $subject -Body $body -BodyAsHtml -Priority Normal -Credential username@domain -UseSsl

#Getting certificate by RequestId (uncomment after issue on CA server and run only this string)
#certreq -retrieve -Username $username -p $password -PolicyServer $PolicyServer -config $ConfigServer $ReqID c:\tmp\$compname.cer