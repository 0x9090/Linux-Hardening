# Puppet Debian Hardening
Masterless Puppet Environment For Debian Hardening

**!! Work-In-Progress !! - Not for production systems** (yet)

Works with Debian 9 and Puppet 4.8.2

## Hardening Features
* Disables IPv6
* Disables Desktop GUI (Gnome, KDE, etc.)
* Hardens SSH Server Configuration
* Enforces Stanford Password policy and Google TOTP 2FA
* Enables memory corruption exploit mitigations
* Applies security patches daily

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

## Prerequesites
* wget
* git
* sudo

## Bootstrap Command
Automatically downloads and installs the hardening controls on a stock Debian machine.
Ensure you have console access to the box if recovery is needed.

$(cd /opt/ && sudo git clone https://github.com/0x9090/Linux-Hardening.git && sudo Linux-Hardening/setup.sh -a)

## Code Layout
The top-level nodes are configured in the site.pp file. There are several different hardening domains

* OS - Locks down Debian and reduces attack surfaces (/modules/os_hardening_config/manifests/init.pp)
* SSH - Configures SSH (and Google 2FA) for secure access (/modules/ssh_hardening_config/init.pp)
* Firewall - Enforces the host firewall config to your rule set (/modules/firewall_config/init.pp)

Most of the code is in the /modules/ folder.
Every "*_config" named module is a hardening configuration module. Those modules only contain one init.pp file, which
contains the configuration for one hardening domain. Each hardening domain is a collection of related security 
controls.

## Security Considerations
