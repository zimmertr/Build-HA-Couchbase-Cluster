#-------Configure static ip on each node-------
#Run each respective block on each respective node

sudo sed -i 's/dhcp/static/' /etc/network/interfaces.d/50-cloud-init.cfg
echo 'address >IPADDR-NODE1<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'netmask >SUBNET<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'gateway >GATEWAY<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'dns-nameservers >NAMESERVER<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'dns-search >SEARCH DOMAIN<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo '>HOSTNAME-NODE1<' | sudo tee /etc/hostname > /dev/null
echo '>IPADDR-NODE1< >HOSTNAME-NODE1<.>FQDN<' | sudo tee --append /etc/hosts > /dev/null
sudo hostnamectl set-hostname >HOSTNAME-NODE1<
sudo ufw allow ssh; sudo ufw allow 4369; sudo ufw allow 8091:8096/tcp; sudo ufw allow 18091:18096/tcp; sudo ufw allow 9100:9105/tcp; sudo ufw allow 9110:9122/tcp; sudo ufw allow 9998:9999/tcp; sudo ufw allow 11209:11210/tcp; sudo ufw allow 11207; sudo ufw allow 11211; sudo ufw allow 11213; sudo ufw allow 21100:21299/tcp; sudo ufw --force enable; sudo ufw status
sudo systemctl restart networking.service




sudo sed -i 's/dhcp/static/' /etc/network/interfaces.d/50-cloud-init.cfg
echo 'address >IPADDR-NODE2<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'netmask >SUBNET<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'gateway >GATEWAY<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'dns-nameservers >NAMESERVER<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'dns-search >SEARCH DOMAIN<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo '>HOSTNAME-NODE2<' | sudo tee /etc/hostname > /dev/null
echo '>IPADDR-NODE2< >HOSTNAME-NODE2<.>FQDN<' | sudo tee --append /etc/hosts > /dev/null
sudo hostnamectl set-hostname >HOSTNAME-NODE2<
sudo ufw allow ssh; sudo ufw allow 4369; sudo ufw allow 8091:8096/tcp; sudo ufw allow 18091:18096/tcp; sudo ufw allow 9100:9105/tcp; sudo ufw allow 9110:9122/tcp; sudo ufw allow 9998:9999/tcp; sudo ufw allow 11209:11210/tcp; sudo ufw allow 11207; sudo ufw allow 11211; sudo ufw allow 11213; sudo ufw allow 21100:21299/tcp; sudo ufw --force enable; sudo ufw status
sudo systemctl restart networking.service




sudo sed -i 's/dhcp/static/' /etc/network/interfaces.d/50-cloud-init.cfg
echo 'address >IPADDR-NODE3<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'netmask >SUBNET<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'gateway >GATEWAY<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'dns-nameservers >NAMESERVER<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'dns-search >SEARCH DOMAIN<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo '>HOSTNAME-NODE3<' | sudo tee /etc/hostname > /dev/null
echo '>IPADDR-NODE3< >HOSTNAME-NODE3<.>FQDN<' | sudo tee --append /etc/hosts > /dev/null
sudo hostnamectl set-hostname >HOSTNAME-NODE3<
sudo ufw allow ssh; sudo ufw allow 4369; sudo ufw allow 8091:8096/tcp; sudo ufw allow 18091:18096/tcp; sudo ufw allow 9100:9105/tcp; sudo ufw allow 9110:9122/tcp; sudo ufw allow 9998:9999/tcp; sudo ufw allow 11209:11210/tcp; sudo ufw allow 11207; sudo ufw allow 11211; sudo ufw allow 11213; sudo ufw allow 21100:21299/tcp; sudo ufw --force enable; sudo ufw status
sudo systemctl restart networking.service




sudo sed -i 's/dhcp/static/' /etc/network/interfaces.d/50-cloud-init.cfg
echo 'address >IPADDR-NODE4<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'netmask >SUBNET<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'gateway >GATEWAY<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'dns-nameservers >NAMESERVER<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'dns-search >SEARCH DOMAIN<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo '>HOSTNAME-NODE4<' | sudo tee /etc/hostname > /dev/null
echo '>IPADDR-NODE4< >HOSTNAME<.>FQDN<' | sudo tee --append /etc/hosts > /dev/null
sudo hostnamectl set-hostname >HOSTNAME-NODE4<
sudo ufw allow ssh; sudo ufw allow 4369; sudo ufw allow 8091:8096/tcp; sudo ufw allow 18091:18096/tcp; sudo ufw allow 9100:9105/tcp; sudo ufw allow 9110:9122/tcp; sudo ufw allow 9998:9999/tcp; sudo ufw allow 11209:11210/tcp; sudo ufw allow 11207; sudo ufw allow 11211; sudo ufw allow 11213; sudo ufw allow 21100:21299/tcp; sudo ufw --force enable; sudo ufw status
sudo systemctl restart networking.service




sudo sed -i 's/dhcp/static/' /etc/network/interfaces.d/50-cloud-init.cfg
echo 'address >IPADDR-NODE5<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'netmask >SUBNET<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'gateway >GATEWAY<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'dns-nameservers >NAMESERVER<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo 'dns-search >SEARCH DOMAIN<' | sudo tee --append /etc/network/interfaces.d/50-cloud-init.cfg > /dev/null
echo '>HOSTNAME-NODE5<' | sudo tee /etc/hostname > /dev/null
echo '>IPADDR-NODE5< >HOSTNAME-NODE5<.>FQDN<' | sudo tee --append /etc/hosts > /dev/null
sudo hostnamectl set-hostname >HOSTNAME-NODE5<
sudo ufw allow ssh; sudo ufw allow 4369; sudo ufw allow 8091:8096/tcp; sudo ufw allow 18091:18096/tcp; sudo ufw allow 9100:9105/tcp; sudo ufw allow 9110:9122/tcp; sudo ufw allow 9998:9999/tcp; sudo ufw allow 11209:11210/tcp; sudo ufw allow 11207; sudo ufw allow 11211; sudo ufw allow 11213; sudo ufw allow 21100:21299/tcp; sudo ufw --force enable; sudo ufw status
sudo systemctl restart networking.service

