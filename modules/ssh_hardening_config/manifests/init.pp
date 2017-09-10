class ssh_hardening_config {
  class { 'ssh_hardening':
    server_options => {
      'X11Forwarding' 		      => 'no',
      'PermitRootLogin'		      => 'no',
      'Protocol'			          => '2',
      'Port'			              => '22',
      'UsePrivilegeSeparation'	=> 'yes',
      'PermitEmptyPasswords'	  => 'no',
      'StrictModes'		          => 'yes',
      'PermitTunnel'		        => 'no',
      'UsePAM'			            => 'yes',
      'PasswordAuthentication'	=> 'yes',
      'AllowTcpForwarding'      => 'no',
      'SyslogFacility'		      => 'AUTH',
      'LogLevel'		          	=> 'INFO',
      'MaxAuthTries'		        => '5',
      'IgnoreRhosts'		        => 'yes',
      'HostbasedAuthentication' => 'no',
      'PermitUserEnvironment'	  => 'no',
      #'Ciphers'			          => 'aes128-gcm@openssh.com,aes256-gcm@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr',
      'ClientAliveInterval'	    => '10800',
      'ClientAliveCountMax'	    => '4',
      'Banner'	    		        => '/etc/banner',
    },
  }
  file { 'banner':
    path => '/etc/banner',
    ensure => file,
    source => 'puppet:///modules/os_hardening_config/banner',
  }

  class { 'fail2ban':
    package_ensure    => 'latest',
    config_dir_purge  => true,
    bantime           => '432000',
    jails             => ['ssh', 'ssh-ddos'],
    maxretry          => '3',
    service_ensure    => 'running',
  }
}