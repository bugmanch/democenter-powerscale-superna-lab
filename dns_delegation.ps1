dsacls "CN=PS1,CN=Computers,DC=demo,DC=local" /G "SELF:RPWP;servicePrincipalName"
dsacls "CN=PS2,CN=Computers,DC=demo,DC=local" /G "SELF:RPWP;servicePrincipalName"

Add-DnsServerZoneDelegation -Name "demo.local" -ChildzoneName "nas1" -NameServer "sip.demo.local." -IpAddress "192.168.1.100"
Add-DnsServerZoneDelegation -Name "demo.local" -ChildzoneName "nas2" -NameServer "sip.demo.local." -IpAddress "192.168.1.100"

Add-DnsServerZoneDelegation -Name "demo.local" -ChildzoneName "nas1" -NameServer "sip2.demo.local." -IpAddress "192.168.1.200"
Add-DnsServerZoneDelegation -Name "demo.local" -ChildzoneName "nas2" -NameServer "sip2.demo.local." -IpAddress "192.168.1.200"

Import-Module ActiveDirectory

Get-ACL "AD:CN=PS1,CN=Computers,DC=demo,DC=local"

$PS1Object = Get-ADObject -Identity 'CN=PS1,CN=Computers,DC=demo,DC=local'
$PS2Object = Get-ADObject -Identity 'CN=PS2,CN=Computers,DC=demo,DC=local'