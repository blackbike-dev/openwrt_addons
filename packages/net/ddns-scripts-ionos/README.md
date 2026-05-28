# ddns-scripts-ionos
## Credit
The ddns-scripts-ionos is based on https://github.com/resmh/ddns-scripts-ionos by Michael Hammes. 

## Introduction
This package integrates with ddns-scripts to offer support for the  IONOS DNS API in order to configure dynamic addresses. Please note: IONOS is a registered trademark of IONOS SE. The script is neither affiliated with nor endorsed by IONOS SE.

## Usage
Follow the IONOS documentation at https://developer.hosting.ionos.com/docs/getstarted  to get your X-API-KEY. If done properly you will get a
public Prefix and a Secret

Example:
   Public Prefix is  01234567890123456789
   Secret is         n0123456789012345678901234567890123456789

The following is an example entry in /etc/config/ddns. Your public prefix will be the username and your secret will be the password. Note
the secret appears to always be longer than the prefix.


config service 'IONOS'
	option enabled '1'
	option interface 'wan'
	option domain 'example.org'
	option username '01234567890123456789'
	option password 'n0123456789012345678901234567890123456789'
	option check_interval '15'
	option check_unit 'minutes'
	option update_url 'update_ionos_v1.sh'
	option ip_source 'web'
	option lookup_host 'example.org'



```
