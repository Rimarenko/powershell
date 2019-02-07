#Find on remote computers register key and delete

 
$ComputerName = Get-Content C:\flc\PowerShell\PendingReboot\CompList.txt
foreach ($CompName in $ComputerName) {
$Connect = Test-NetConnection  -Port 135 -ComputerName $CompName -InformationLevel Quiet
if ($Connect -eq 'True') 
{
$RegValuePFRO=0

## Making registry connection to the local/remote computer
$WMI_Reg = [WMIClass] "\\$CompName\root\default:StdRegProv"
$HKLM = [UInt32] "0x80000002"

## Query PendingFileRenameOperations from the registry
$RegSubKeySM = $WMI_Reg.GetMultiStringValue($HKLM,"SYSTEM\CurrentControlSet\Control\Session Manager\","PendingFileRenameOperations")
$RegValuePFRO = $RegSubKeySM.sValue

##Search string contains only 'Amcache' and delete key if true
$Amcache=0; $Prog=0
foreach ($Value in $RegValuePFRO) 
{
if ($Value.Length -ne 0 -and $Value -match 'Amcache') {$Amcache=$Amcache+1}
elseif ($Value.Length -ne 0 -and $Value -notmatch 'Amcache') {$Prog=$Prog+1}
}
if ($Prog -gt 0 -and $Connect -eq 'True') {}
else {$WMI_Reg.DeleteValue($HKLM,"SYSTEM\CurrentControlSet\Control\Session Manager\","PendingFileRenameOperations")}
}
}