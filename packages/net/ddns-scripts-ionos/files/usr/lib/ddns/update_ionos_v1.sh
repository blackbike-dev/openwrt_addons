# ionos dynamic dns update script (api version 1)
# adapted from sample script
#
local __URL="https://ipv4.api.hosting.ionos.com/dns/v1/dyndns?q=[PASSWORD]&ipv[IPVERSION]=[IP]"

[ -z "$password" ] && write_log 14 "Service section not configured correctly! Missing 'password'"

__IPVERSION="4"
if [ $use_ipv6 -eq 1 ]; then __IPVERSION="6"; fi

# do replaces in URL
__URL=$(echo $__URL | sed -e "s#\[USERNAME\]#$URL_USER#g" -e "s#\[PASSWORD\]#$URL_PASS#g" \
			     -e "s#\[PARAMENC\]#$URL_PENC#g" -e "s#\[IPVERSION\]#$__IPVERSION#g" \
			     -e "s#\[DOMAIN\]#$domain#g"     -e "s#\[IP\]#$__IP#g")
[ $use_https -ne 0 ] && __URL=$(echo $__URL | sed -e 's#^http:#https:#')

if [ "$param_opt" == "privatedual" ]; then
	if nifip=$(ip -f inet addr show dev "$ip_interface" | grep -o "inet .*/24" | grep -o " .*" | grep -o "[^ ].*" | grep -o "^[^/]*"); then
		__URL="${__URL}&ipv4=${nifip}"
	fi
fi

write_log 7 "DDNS Provider request: $__URL"

do_transfer "$__URL" || return 1
return 0
