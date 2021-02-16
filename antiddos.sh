# This Anti-DDos is created by Key#0007
#                  1.0

#TCP LIMITS

/sbin/iptables -A INPUT -p tcp -m connlimit --connlimit-above 85 -j REJECT --reject-with tcp-reset
/sbin/iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m limit --limit 50/s --limit-burst 18 -j ACCEPT
/sbin/iptables -A INPUT -p tcp -m conntrack --ctstate NEW -j DROP
/sbin/iptables -t mangle -A PREROUTING -f -j DROP
/sbin/iptables -A INPUT -p tcp -m tcp -m conntrack --ctstate INVALID,UNTRACKED -j SYNPROXY --sack-perm --timestamp --wscale 7 --mss 1460
/sbin/iptables -t raw -A PREROUTING -p tcp -m tcp --syn -j CT --notrack 

#port scan

/sbin/iptables -N port-scan 
/sbin/iptables -A port-scan -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 3 -j RETURN 
/sbin/iptables -A port-scan -j DROP

#SYN FLOOD
/sbin/iptables -N syn-flood
/sbin/iptables -A syn-flood -m limit --limit 100/second --limit-burst 150 -j RETURN
/sbin/iptables -A syn-flood -j LOG --log-prefix "SYN flood: "
/sbin/iptables -A syn-flood -j DROP
/sbin/iptables -N syn-flood
/sbin/iptables -A INPUT -i eth0:2 -p tcp --syn -j syn-flood
/sbin/iptables -A syn-flood -m limit --limit 1/s --limit-burst 4 -j RETURN
/sbin/iptables -A syn-flood -j DROP
/sbin/iptables -A INPUT -p tcp -m tcp --tcp-flags SYN,RST,ACK SYN -m limit --limit 1/sec -j ACCEPT
/sbin/iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK RST -m limit --limit 1/sec -j ACCEPT

#Others

/sbin/iptables -I INPUT -p tcp --syn -m recent --set
/sbin/iptables -I INPUT -p tcp --syn -m recent --update --seconds 10 --hitcount 30 -j DROP
/sbin/iptables -A OUTPUT -p udp -m state --state NEW -j ACCEPT
/sbin/iptables -A OUTPUT -p udp -m limit --limit 100/s -j ACCEPT
/sbin/iptables -A OUTPUT -p udp -j DROP
/sbin/iptables -A INPUT -p tcp --dport 80 -m hashlimit --hashlimit-upto 50/min --hashlimit-burst 80 --hashlimit-mode srcip --hashlimit-name http -j ACCEPT
/sbin/iptables -A INPUT -p tcp --dport 80 -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP 
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j DROP 
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j DROP 
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j DROP 
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j DROP 
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,URG URG -j DROP 
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,FIN FIN -j DROP 
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j DROP 
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL ALL -j DROP 
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL NONE -j DROP 
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP 
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j DROP 
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP

#SSH brute-force protection 
/sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --set
/sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP

#Protection against port scanning 
/sbin/iptables -N port-scanning
/sbin/iptables -A port-scanning -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j RETURN
/sbin/iptables -A port-scanning -j DROP

echo "                                                                                                VPS IS PROTECT"

echo "

									##############################################################
									#                                                            # 
									#                                                            #
									#          This Script is Created For DDoS Mitigation        #
									#                    By MineTwice And Key                    #
									#                                                            # 
									#                                                            #
									##############################################################
	"								
									