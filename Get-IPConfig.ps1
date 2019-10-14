#IPCONFIG
$RemoteComputer="Z-TECH-01470"
$OnlyConnectedNetworkAdapters= $true
gwmi -Class Win32_NetworkAdapterConfiguration -ComputerName $RemoteComputer | Where { $_.IPEnabled -eq $OnlyConnectedNetworkAdapters } | Format-List @{ Label="Computer Name"; Expression= { $_.__SERVER }}, IPEnabled, Description, MACAddress, IPAddress, IPSubnet, DefaultIPGateway, DHCPEnabled, DHCPServer, DNSServerSearchOrder
