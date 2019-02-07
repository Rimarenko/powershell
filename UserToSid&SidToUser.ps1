#Domain User to SID
$objUser = New-Object System.Security.Principal.NTAccount("DOMEN", "SAMACCOUNTNAME")
$strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier]) 
$strSID.Value

#SID to Domain User
$objSID = New-Object System.Security.Principal.SecurityIdentifier ("S-1-5-21-xxxxxxxxx-xxxxxxxxxx-xxxxxxxxxx-xxxxx") 
$objUser = $objSID.Translate( [System.Security.Principal.NTAccount]) 
$objUser.Value