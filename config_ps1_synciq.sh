#!/bin/sh

isi sync policies create nas1 sync /ifs/data/nas1 ps2.demo.local /ifs/data/nas1 -S "every 1 days every 5 minutes between 12:00 AM and 11:59 PM"  --accelerated-failback true --rpo-alert "10m" -f
isi sync policies create nas2 sync /ifs/data/nas2 ps2.demo.local /ifs/data/nas2 -S "every 1 days every 5 minutes between 12:00 AM and 11:59 PM"  --accelerated-failback true --rpo-alert "10m" -f