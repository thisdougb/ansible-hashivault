#!/bin/bash

/usr/local/bin/vault auth-enable ldap

/usr/local/bin/vault write auth/ldap/config url="ldap://ldapserver" \
                userdn="ou=people,ou=development,dc=example,dc=com" \
                groupdn="ou=groups,ou=development,dc=example,dc=com" \
                binddn="cn=Manager,dc=example,dc=com" \
                bindpass='password' \
                starttls=false

/usr/local/bin/vault write auth/ldap/groups/production policies=production
/usr/local/bin/vault write auth/ldap/groups/development policies=development
