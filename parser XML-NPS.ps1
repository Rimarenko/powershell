#Script create file .csv with Client NPS (Name, IP, SharedSecret)
[xml]$xmlfile = Get-Content "C:\NPS\configNPS.xml"
$outputfile = "C:\NPS\configNPS.csv"
$string = $xmlfile | Select-Xml -Xpath "//Clients"  
$clients = $string -split "><" 
foreach ($client in $clients) {
$Arr += [Regex]::Matches($client.Where({$_ -match "name=*"}),'(?<=\").*?(?=\")')
$Arr += [Regex]::Matches($client.Where({$_ -like "IP_Address*"}),'(?<=\>).*?(?=\<)')
$Arr += [Regex]::Matches($client.Where({$_ -like "Shared_Secret*"}),'(?<=\>).*?(?=\<)')
}
for ($i = 0; $i -lt $Arr.Count; $i += 3)
{$j = $i+2
($Arr[$i..$j] -join ",") | Out-File -FilePath $outputfile -Append
}
