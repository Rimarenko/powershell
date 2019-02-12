$ComputerName = "testcomp"
$userSystem = Get-WmiObject win32_operatingsystem -ComputerName $ComputerName -ErrorAction SilentlyContinue
if ($userSystem.LastBootUpTime) {
$sysuptime= (Get-Date) - $userSystem.ConvertToDateTime($userSystem.LastBootUpTime)
Write-Output ("Last boot: " + $userSystem.ConvertToDateTime($userSystem.LastBootUpTime) )
Write-Output ("Uptime : " + $sysuptime.Days + " Days " + $sysuptime.Hours + " Hours " + $sysuptime.Minutes + " Minutes" )
}
else {
Write-Warning "Unable to connect to $computername"
}