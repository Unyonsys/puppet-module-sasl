class { 'sasl':
  authentication_ldap_servers => 'ldap://localhost',
  ldap_bind_dn                => 'cn=manager,dc=root',
  ldap_bind_pw                => 'mystrongpassword'
}

