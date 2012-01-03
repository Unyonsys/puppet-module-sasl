class sasl (
  $authentication_ldap_servers,
  $ldap_bind_dn,
  $ldap_bind_pw
  ) {

  if ! $authentication_ldap_servers or ! $ldap_bind_dn or ! $ldap_bind_pw{
    fail('You must provide valid values for LDAP connection.')
  }
  
  package { 'sasl2-bin': ensure => present }

  file { '/etc/default/saslauthd':
    ensure  => file,
    mode    => '0600',
    content => template('sasl/saslauthd.erb'),
    notify  => Service['saslauthd']
  }

  file { '/etc/saslauthd.conf':
    ensure  => file,
    mode    => '0600',
    content => template('sasl/saslauthd.conf.erb'),
    notify  => Service['saslauthd']
  }

  service { 'saslauthd':
    ensure      => running,
    enable      => true,
    hasstatus   => false,
    pattern     => 'saslauthd',
    hasrestart  => true,
    require     => Package['sasl2-bin']
  }
}

