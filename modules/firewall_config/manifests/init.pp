class firewall_config {
  package { 'iptables-persistent':
    ensure  => 'latest',
  }

  firewallchain { 'INPUT:filter:IPv4':
    ensure  => present,
    policy  => drop,
  }
  firewallchain { 'FORWARD:filter:IPv4':
    ensure  => present,
    policy  => drop,
  }
  firewallchain { 'OUTPUT:filter:IPv4':
    ensure  => present,
    policy  => accept,
  }

  firewall { '001 accept all to lo interface':
    proto   => all,
    iniface => 'lo',
    action  => accept,
  }->
  firewall { '002 reject local traffic not on loopback interface':
    iniface     => '! lo',
    proto       => all,
    destination => '127.0.0.1/8',
    action      => reject,
  }->
  firewall { '003 accept related established rules':
    proto  => all,
    state  => ['RELATED', 'ESTABLISHED'],
    action => accept,
  }->
  firewall { '004 accept SSH':
    proto   => tcp,
    dport   => [22],
    action  => accept,
  }->
  exec { 'fail2ban-client reload': # reload the fail2ban rules into iptables
    path    => ['/usr/bin', '/usr/sbin',],
  }
}