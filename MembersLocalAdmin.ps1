$ComputerName = Get-Content C:\temp\CompList.txt
$output = '\\server\share\comp.csv'
$Date = Get-Date -Format "dd-MM-yyyy HH:mm"
foreach ($CompName in $ComputerName) {
$Connect = Test-NetConnection  -ComputerName $CompName -InformationLevel Quiet
if ($Connect -eq 'True') 
{
$localgroup =[ADSI]"WinNT://$CompName/Администраторы"
$members = @($localgroup.Invoke("Members"));
foreach ($member in $members) {
$memberName = $member.GetType().Invokemember("Name","GetProperty",$null,$member,$null);
$outstring = $CompName + "," + $Date + "," +$membername >> $output
}
}
}