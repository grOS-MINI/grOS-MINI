#! /bin/bash

. /lib/lsb/init-functions

case "$1" in
    start)
        log_action_msg "Basic Firewall: clean up rules"
        iptables -F
        iptables -Z
        iptables -X
        log_action_msg "Basic Firewall: restore iptables rules"
        iptables-restore < /etc/firewall.rules
        ip6tables-restore < /etc/firewall6.rules
        ;;
    restart)
        log_action_msg "Basic Firewall: clean up rules"
        iptables -F
        iptables -Z
        iptables -X
        log_action_msg "Basic Firewall: restore iptables rules"
        iptables-restore < /etc/firewall.rules
        ip6tables-restore < /etc/firewall6.rules
        ;;
    stop)
        iptables -F
        iptables -Z
        iptables -X
        log_action_msg "Basic Firewall: clean up rules"
        ;;
    status)
        log_action_msg "Basic Firewall: print status"
        iptables -L
        ;;
    *)
        echo 'Usage: /etc/init.d/firewall.sh {start|restart|stop|status}'
        exit 1
        ;;
esac
 
exit 0
