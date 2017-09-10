# Puppet Debian Hardening
### Masterless Puppet Environment For Debian Hardening
This repo contains a masterless Puppet environment which may be used to lock down a minimal Debian server even further
than stock. These controls utilize only open-source components, and can be deploy to any stock Debian 9 machine.

Works on **Debian 9** and **Puppet 4.8.2**

Only intented for a non-gui Debian install, starting with only the "Standard system utilites" and "SSH Server"  

## Hardening Features
* Disables IPv6 + unecessary network services
* Disables desktop GUI (Gnome, KDE, etc.)
* Hardens SSH server + brute force protection
* Enforces Stanford password policy and Google TOTP 2FA
* Enables memory corruption exploit mitigations
* Applies security patches daily
* Locks down firewall rule to minimal necessary
* Disables uncommon kernel modules (floppy, usb storage, etc)

## Uses Open-Source Modules
* puppetlabs/stdlib - https://forge.puppet.com/puppetlabs/stdlib
* puppetlabs/firewall - https://forge.puppet.com/puppetlabs/firewall
* hardening/os_hardening - https://forge.puppet.com/hardening/os_hardening
* hardening/ssh_hardening - https://forge.puppet.com/hardening/ssh_hardening
* saz/ssh - https://forge.puppet.com/saz/ssh
* dhoppe/fail2ban - https://forge.puppet.com/dhoppe/fail2ban
* camptocamp/googleauthenticator - https://forge.puppet.com/camptocamp/googleauthenticator
* thias/sysctl - https://forge.puppet.com/thias/sysctl
* puppet/unattended_upgrades - https://forge.puppet.com/puppet/unattended_upgrades
* puppetlabs/apt - https://forge.puppet.com/puppetlabs/apt
* voxpopuli/extlib - https://forge.puppet.com/puppet/extlib
* camptocamp/kmod - https://forge.puppet.com/camptocamp/kmod

## Prerequesites
* wget
* git
* sudo

## Bootstrap Command
Automatically downloads and installs the hardening controls on a stock Debian machine.  
Ensure you have console access to the box if recovery is needed.

**$(cd /opt/ && sudo git clone https://github.com/0x9090/Linux-Hardening.git && sudo Linux-Hardening/setup.sh -a)**

## Code Layout
**setup.sh** = Main installer script. Run this once, and the controls will be implemented and enforced  
**run.sh** = Performs a Puppet run to manually apply the security controls  
**site.pp** = Top-level node definitions  

There are several different hardening domains, and each domain is a collection of related security controls.

* OS - Locks down Debian and reduces attack surfaces ([os_hardening_config/manifests/init.pp](https://github.com/0x9090/Linux-Hardening/blob/master/modules/os_hardening_config/manifests/init.pp))
* SSH - Configures SSH (and Google 2FA) for secure access ([ssh_hardening_config/manifests/init.pp](https://github.com/0x9090/Linux-Hardening/blob/master/modules/ssh_hardening_config/manifests/init.pp))
* Firewall - Enforces the host firewall config to your rule set ([firewall_config/manifests/init.pp](https://github.com/0x9090/Linux-Hardening/blob/master/modules/firewall_config/manifests/init.pp))

Most of the code is in the /modules/ folder. Every "_config" postpended module, is a hardening domain configuration 
module. Those modules contain an init.pp file, which configures the hardening domain. Those init.pp files are what 
you'll work in to customize the hardening to your needs.

## Security Considerations
* Thoroughly test this in your own environment before using in production. Use at your own risk
* These controls are only to be used on a fresh, minimal Debian 9 install
* You need to configure Google 2FA in the os_hardening_config module
* Firewall is only configured for SSH inbound