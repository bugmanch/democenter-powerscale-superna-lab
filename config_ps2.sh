#!/bin/sh

set -x # Display commands on screen

isi zone zones create --name nas1 --create-path --auth-providers lsa-activedirectory-provider:DEMO.LOCAL /ifs/data/nas1
isi zone zones create --name nas2 --create-path --auth-providers lsa-activedirectory-provider:DEMO.LOCAL /ifs/data/nas2

isi network subnets modify groupnet0:subnet0 --sc-service-addrs 192.168.1.200
isi network pools modify groupnet0:subnet0:pool0 --sc-dns-zone ps2.demo.local --add-sc-dns-zone-aliases igls-pool0-nas2
isi network pools modify groupnet0:subnet0:pool0 --sc-dns-zone-aliases ps2.demo.local

isi network pools create groupnet0:subnet0:nas1 --access-zone nas1 --alloc-method  static --sc-dns-zone igls-original-nas1.demo.local --sc-dns-zone-aliases igls-nas1-ps2.demo.local --ifaces 1-3:ext-1 --ranges 192.168.1.55-192.168.1.58
isi network pools create groupnet0:subnet0:nas2 --access-zone nas2 --alloc-method static --sc-dns-zone igls-original-nas2.demo.local --sc-dns-zone-aliases igls-nas2-ps2.demo.local --ifaces 1-3:ext-1 --ranges 192.168.1.65-192.168.1.68

isi sync settings modify --encryption-required=false