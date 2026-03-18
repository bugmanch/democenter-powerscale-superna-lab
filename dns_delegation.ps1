Add-DnsServerZoneDelegation -Name "demo.local" -ChildzoneName "nas1" -NameServer "sip.demo.local." -IpAddress "192.168.1.100"
Add-DnsServerZoneDelegation -Name "demo.local" -ChildzoneName "nas2" -NameServer "sip.demo.local." -IpAddress "192.168.1.100"

Add-DnsServerZoneDelegation -Name "demo.local" -ChildzoneName "nas1" -NameServer "sip2.demo.local." -IpAddress "192.168.1.200"
Add-DnsServerZoneDelegation -Name "demo.local" -ChildzoneName "nas2" -NameServer "sip2.demo.local." -IpAddress "192.168.1.200"