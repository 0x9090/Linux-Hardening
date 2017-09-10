class os_hardening_config {
#========== OS Hardening ==========#
  file { "/usr/bin/X11": # fixes X11 bug
    ensure  => "absent",
  } ->
  class { "os_hardening":
    system_environment        => "default",
    desktop_enabled           => false,
    enable_ipv4_forwarding    => false,
    enable_ipv6_forwarding    => false,
    enable_ipv6               => false,
    arp_restricted            => true,
    extra_user_paths          => [],
    umask                     => "027",
    password_max_age          => 365,
    password_min_age          => 7,
    auth_retries              => 5,
    auth_lockout_time         => 300,
    login_timeout             => 60,
    allow_login_without_home  => true,
    passwdqc_enabled          => true,
    passwdqc_options          => "min=20,16,12,12,8", # https://uit.stanford.edu/service/accounts/passwords/quickguide
    allow_change_user         => true,
    enable_module_loading     => true,
    load_modules              => [],
    enable_sysrq              => false,
    enable_core_dump          => false,
    enable_stack_protection   => true,
    # cpu_vendor                => 'intel'
    root_ttys                 => ["console","tty1","tty2","tty3","tty4","tty5","tty6","ttyS0","ttyS1"],
    # whitelist                 => [], # suid / guid whitelist
    # blacklist                 => [], # suid / guid blacklist
    # remove_from_unknown       => false,
    # dry_run_on_unknown        => false,
  }

#======== Google Auth ========#
  #googleauthenticator::pam {
  #  'login': mode => 'root-only';
  #  'su':    mode => 'root-only';
  #  'sshd':  mode => 'all-users';
  #} ->
  #googleauthenticator::user {'root':
  #  secret_key => '#######',
  #  scratch_codes => ['###', '###', '###', '###', '###'],
  #}

#======== Auto Patching =========#
  class { 'unattended_upgrades':
    age   => { 'max' => 10 },
    mail  => { 'to'             => 'admin@domain.tld',
      'only_on_error'  => true},
    auto  => { 'reboot'               => false,
      'clean'                => 0,
      'remove'               => true
    },
    origins => ['${distro_id}:${distro_codename}',
      '${distro_id}:${distro_codename}-security',
      '${distro_id}ESM:${distro_codename}'],
    update  => 1,
    upgrade => 1,
    enable  => 1,
    package_ensure  => 'latest'
  }

#========= Surface Reduction =========#
  kmod::install { 'dccp': command => '/bin/false' }
  kmod::blacklist { 'dccp': }
  kmod::install { 'cdrom': command  => '/bin/false' }
  kmod::blacklist { 'cdrom': }
  kmod::install { 'sr_mod': command => '/bin/false' }
  kmod::blacklist { 'sr_mod': }
  kmod::install { 'sctp': command => '/bin/false' }
  kmod::blacklist { 'sctp': }
  kmod::install { 'floppy': command => '/bin/false' }
  kmod::blacklist { 'floppy': }
  kmod::install { 'tipc': command => '/bin/false' }
  kmod::blacklist { 'tipc': }
  kmod::install { 'rds': command  => '/bin/false' }
  kmod::blacklist { 'rds': }
  kmod::install { 'usb-storage': command  => '/bin/false' }
  kmod::blacklist { 'usb-storage': }
  kmod::install { 'joymod': command => '/bin/false' }
  kmod::blacklist { 'joymod': }
  kmod::install { 'pcspkr': command => '/bin/false' }
  kmod::blacklist { 'pcspkr': }

  if defined(Service['portmap']) {
    service { 'portmap':
      ensure  => 'stopped',
    }
  }
  if defined(Package['portmap']) {
    package { 'portmap':
      ensure  => 'absent',
    }
  }
  if defined(Service['rpcbind']) {
    service { 'rpcbind':
      ensure  => 'stopped',
      enable  => false,
    }
  }
  if defined(Package['rpcbind']) {
    package { 'rpcbind':
      ensure  => 'absent',
    }
  }
  if defined(Service['nfs-common']) {
    service { 'nfs-common':
      ensure  => 'stopped',
      enable  => false,
    }
  }
  if defined(Package['nfs-common']) {
    package { 'nfs-common':
      ensure  => 'absent',
    }
  }
}