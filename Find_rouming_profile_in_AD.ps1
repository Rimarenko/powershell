﻿Get-ADUser -Filter {ProfilePath -ne "$Null" -and userAccountControl -eq 512 -and description -notlike "*Support*"} -Property SamAccountName,DisplayName,ProfilePath | Select-Object SamAccountName,DisplayName,ProfilePath | export-csv -path c:\temp\rouming_profile.csv -NoTypeInformation
