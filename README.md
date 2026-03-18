
# Dell Democenter Powerscale lab automation

**By:** Thomas Bettems

#Iwork4Dell

---

This repo contains scripts & procedure to automate as much as possible preconfiguration of a Dell Democenter demo environment tailored to my needs

## 2. PS1 and PS2: enable license (must be done interactively)

```bash
isi license add --evaluation cloudpools --evaluation smartpools --evaluation snapshotiq --evaluation smartquotas
```

## 3. Configure cluster 1

1. Log in to cluster PS1 using Royal TS
2. Fetch & run configuration script:

```bash
curl https://raw.githubusercontent.com/bugmanch/democenter-powerscale-superna-lab/main/config_ps1.sh -o /var/tmp/config_ps1.sh
chmod u+x /var/tmp/config_ps1.sh
/var/tmp/config_ps1.sh
```

## 4. Configure cluster 2

1. Log in to cluster PS2 using Royal TS
2. Fetch & run configuration script:

```bash
curl https://raw.githubusercontent.com/bugmanch/democenter-powerscale-superna-lab/main/config_ps2.sh -o /var/tmp/config_ps2.sh
chmod u+x /var/tmp/config_ps2.sh
/var/tmp/config_ps2.sh
```

## 3. Create SyncIQ replications

1. Log in to cluster PS1 using Royal TS
2. Fetch & run configuration script:

```bash
curl https://raw.githubusercontent.com/bugmanch/democenter-powerscale-superna-lab/main/config_ps1_synciq.sh -o /var/tmp/config_ps1_synciq.sh
chmod u+x /var/tmp/config_ps1_synciq.sh
/var/tmp/config_ps1_synciq.sh
```

## 4. Configure DNS zone delegation using Powershell


## 5. Add AD permissions to computer objects

1. Open a Powershell prompt on the Windows machine

```powershell
Add-WindowsCapability -Online -Name "Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0"
Invoke-Webrequest https://raw.githubusercontent.com/bugmanch/powerscale-add-ad-spn-perm/main/script/pscale-add-ad-perm.ps1 -OutFile pscale-add-ad-perm.ps1

pscale-add-ad-perm.ps1 -PscaleClusterName PS1 -GranteeName PS2
pscale-add-ad-perm.ps1 -PscaleClusterName PS2 -GranteeName PS1
```

## 4. Start Ransomware cluster

1. Log in to the Superna appliance using Royal TS then type

```bash
ecactl cluster down
ecactl cluster up
ecactl cluster status
```

2. Tune RW Defender for demo:

- **Threshold :** Set **Enforce mode** and **Critical on Mode**
