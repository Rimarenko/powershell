$Exclusions = ("Administrator", "Default", "Public", "ADMINI~1")
$Profiles = Get-ChildItem -Path $env:SystemDrive"\Users" | Where-Object { $_ -notin $Exclusions }
$AllProfiles = @()
foreach ($Profile in $Profiles) {
	$object = New-Object -TypeName System.Management.Automation.PSObject
    $FolderSizes = "{0:N3} GB" -f ((Get-ChildItem $Profile.FullName -Recurse -File -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum ).Sum /1Gb)
    $object | Add-Member -MemberType NoteProperty -Name ComputerName -Value $env:COMPUTERNAME.ToUpper()
	$object | Add-Member -MemberType NoteProperty -Name Profile -Value $Profile
	$Object | Add-Member -MemberType NoteProperty -Name Size -Value $FolderSizes
	$AllProfiles += $object
 }
 $AllProfiles | ft -AutoSize