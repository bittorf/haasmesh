if [ `/root/script/myip.sh | cut -f 4 -d . ` -eq 1 ]; then
echo "master hub"
if [ $# -lt 1 ]; then echo "have to enter 1 argument, a pw"; exit; fi

opkg list-installed | grep openssh-client-utils
if [ $? -eq 1 ]; then 
  opkg update
  opkg install openssh-client-utils
fi

test -f /root/.ssh/id_rsa
if [ $? -eq 1 ]; then
   rm -f /root/.ssh/id_rsa*; ssh-keygen -f /root/.ssh/id_rsa -N ""
fi

for n in 19; do n="192.168.2.$n"
#for n in `/root/script/nodes.sh` 192.168.2.2 192.168.2.6; do
   echo "Setting pw to \"${1}\" and key for node $n "
   ssh-keygen -R $n #remove old entry for this node from known_hosts
   ssh-keyscan $n >> /root/.ssh/known_hosts
   #ssh $n 'passwd -d root' # remove root password
   ssh $n "tee /etc/dropbear/authorized_keys" < /root/.ssh/id_rsa.pub # tee -a would add the key
   ssh $n "printf \"${1}\n${1}\n\" | passwd"
done

else
echo "just a node"
fi