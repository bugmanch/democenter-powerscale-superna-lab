#!/bin/sh

set -x # Display commands on screen

isi zone zones create --name nas1 --create-path --auth-providers lsa-activedirectory-provider:DEMO.LOCAL /ifs/data/nas1
isi zone zones create --name nas2 --create-path --auth-providers lsa-activedirectory-provider:DEMO.LOCAL /ifs/data/nas2

isi network pools modify groupnet0:subnet0:pool0 --sc-dns-zone ps1.demo.local --add-sc-dns-zone-aliases igls-pool0-nas1
isi network pools create groupnet0:subnet0:nas1 --access-zone nas1 --alloc-method  static --sc-dns-zone nas1.demo.local --sc-dns-zone-aliases igls-nas1-ps1.demo.local --ifaces 1-3:ext-1 --ranges 192.168.1.51-192.168.1.53
isi network pools create groupnet0:subnet0:nas2 --access-zone nas2 --alloc-method static --sc-dns-zone nas2.demo.local --sc-dns-zone-aliases igls-nas2-ps1.demo.local --ifaces 1-3:ext-1 --ranges 192.168.1.61-192.168.1.63

isi smb shares create c$ /ifs/data/nas1 --zone nas1 
isi smb shares permission delete c$ --wellknown Everyone --zone nas1 -f
isi smb shares permission create c$ --zone nas1 --group Administrators --run-as-root

isi smb shares create share1 /ifs/data/nas1/share1 --zone nas1 --create-path --create-permissions "default acl"
isi smb shares permission delete share1 --wellknown Everyone --zone nas1 -f
isi smb shares permission create share1 --group Administrators --zone nas1 --run-as-root
isi smb shares permission create share1 --group "DEMO\Domain Users" --zone nas1 -d allow -p full

isi smb shares create c$ /ifs/data/nas2 --zone nas2
isi smb shares permission delete c$ --wellknown Everyone --zone nas2 -f
isi smb shares permission create c$ --zone nas2 --group Administrators --run-as-root

isi quota quotas create /ifs/data/nas1 directory --advisory-threshold 100G
isi quota quotas create /ifs/data/nas2 directory --advisory-threshold 100G

isi sync settings modify --encryption-required=false
isi sync policies delete csi -f
isi sync policies delete quotas -f

mkdir -p "/ifs/data/nas1/share1/Pictures"
cp -r "/ifs/data/Demo_Data/Pictures/" "/ifs/data/nas1/share1/Pictures"