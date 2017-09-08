class os_hardening_config {
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
    ignore_users              => [],
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

  #googleauthenticator::pam {
  #  'login': mode => 'root-only';
  #  'su':    mode => 'root-only';
  #  'sshd':  mode => 'all-users';
  #} ->
  #googleauthenticator::user {'root':
  #  secret_key => '#######',
  #  scratch_codes => ['###', '###', '###', '###', '###'],
  #}
}