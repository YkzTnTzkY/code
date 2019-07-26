#!/bin/bash
#检测后端web服务器页面被篡改
node09='f0bc661643f2dc9b50900c1d2519fab2  -'
node10='a8dbf95c810b37f40160d057cd1ee0b4  -'
vip=192.168.4.250:80
rip1=192.168.4.222
rip2=192.168.4.223
while :
	do
	md09=`curl -s $rip1 | md5sum`
	md10=`curl -s $rip2 | md5sum`
	[ "$node09" = "$md09" ]||ipvsadm -d -t $vip -r $rip1 &>/dev/null 
	[ "$node10" = "$md10" ]||ipvsadm -d -t $vip -r $rip2 &> /dev/null
	[ "$node09" = "$md09" ]&&ipvsadm -a -t $vip -r $rip1 -g -w 1 &>/dev/null 
	[ "$node10" = "$md10" ]&&ipvsadm -a -t $vip -r $rip2 -g -w 1 &> /dev/null
	sleep 1
done	
	
