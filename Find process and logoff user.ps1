$Process = 'XXXXX' #Name process
$ComputerName = "XXXXX" #Name computer
Invoke-Command $ComputerName -ErrorAction Stop -ScriptBlock { Get-Process $Using:Process -IncludeUserName } | ft -AutoSize #How many processes work
Invoke-Command $ComputerName -ErrorAction Stop -ScriptBlock { quser } | ft -AutoSize  #Who logged in on the remote computer
Invoke-Command $ComputerName -ErrorAction Stop -ScriptBlock { logoff "ID" }  #Logoff remote user by ID
