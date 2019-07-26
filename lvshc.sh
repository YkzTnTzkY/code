#!/bin/bash
#LVS健康检查动态检测脚本
vip=192.168.4.15:80
rip1=192.168.4.100
rip2=192.168.4.200
ipvsadm -A -t $vip -s wrr &> /dev/null
while :
do
	for ip in $rip2 $rip1
		do
		curl $ip &> /dev/null
		if [ $? -eq 0 ];then
		ipvsadm -Ln | grep -q $ip || ipvsadm -a -t $vip -r $ip -w 1 &>/dev/null
		else
		ipvsadm -Ln | grep -q $ip && ipvsadm -d -t $vip -r $ip &>/dev/null
		fi
		sleep 1
		done
done 


