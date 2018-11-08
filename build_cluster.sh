#-------Format LVM Partition-------
#Run this on each node.

echo 'start=2048, type=8E' | sudo sfdisk /dev/sdc
sudo pvcreate /dev/sdc1
sudo vgcreate couchbase /dev/sdc1
sudo lvcreate -l 100%FREE couchbase
sudo mkfs.ext4 /dev/couchbase/lvol0
sudo mkdir /cb/
echo '/dev/couchbase/lvol0 /cb ext4 defaults,nofail 0 0' | sudo tee --append /etc/fstab > /dev/null
sudo mount -a


#-------Install Prereqs and Couchbase-------
#Run this on each node.

sudo apt-get update
sudo apt-get upgrade -y < "/dev/null"
sudo apt-get install -y libssl-dev python-httplib2 ntp < "/dev/null"
wget https://packages.couchbase.com/releases/5.5.0-beta/couchbase-server-enterprise_5.5.0-beta-ubuntu16.04_amd64.deb
sudo dpkg -i ./couchbase-server-enterprise_5.5.0-beta-ubuntu16.04_amd64.deb
rm ./couchbase-server-enterprise_5.5.0-beta-ubuntu16.04_amd64.deb
sudo chown couchbase:couchbase /cb/


#-------Create a DNS A record for each node on your name server


#-------Initialize Couchbase on each node-------
#Run each command on each respective node.

/opt/couchbase/bin/couchbase-cli node-init -c localhost:8091 -u >USERNAME< -p >PASSWORD-NODE1< --node-init-data-path=/cb/data --node-init-hostname=>HOSTNAME-NODE1<.>FQDN<
/opt/couchbase/bin/couchbase-cli node-init -c localhost:8091 -u >USERNAME< -p >PASSWORD-NODE2< --node-init-data-path=/cb/data --node-init-hostname=>HOSTNAME-NODE2<.>FQDN<
/opt/couchbase/bin/couchbase-cli node-init -c localhost:8091 -u >USERNAME< -p >PASSWORD-NODE3< --node-init-data-path=/cb/data --node-init-hostname=>HOSTNAME-NODE3<.>FQDN<
/opt/couchbase/bin/couchbase-cli node-init -c localhost:8091 -u >USERNAME< -p >PASSWORD-NODE4< --node-init-data-path=/cb/data --node-init-hostname=>HOSTNAME-NODE4<.>FQDN<
/opt/couchbase/bin/couchbase-cli node-init -c localhost:8091 -u >USERNAME< -p >PASSWORD-NODE5< --node-init-data-path=/cb/data --node-init-hostname=>HOSTNAME-NODE5<.>FQDN<


#-------Initialize Couchbase Cluster-------
#Run this on the first node.

/opt/couchbase/bin/couchbase-cli cluster-init --cluster-name '>CLUSTER NAME<' --cluster-username=>USERNAME< --cluster-password=>CLUSTEPASSWORD< --cluster-port=8091 --services=data --cluster-ramsize=>RAMSIZEINMB< --cluster-index-ramsize=>RAMSIZEINMB< --index-storage-setting=default


#-------Add couchbase nodes to cluster-------
#Run these on the first node.

/opt/couchbase/bin/couchbase-cli server-add -c >HOSTNAME-NODE1<.>FQDN< -u >USERNAME< -p >CLUSTERPASSWORD< --server-add >HOSTNAME-NODE2<.>FQDN< --server-add-username >USERNAME< --server-add-password >PASSWORD-NODE2< --services data
/opt/couchbase/bin/couchbase-cli server-add -c >HOSTNAME-NODE1<.>FQDN< -u >USERNAME< -p >CLUSTERPASSWORD< --server-add >HOSTNAME-NODE3<.>FQDN< --server-add-username >USERNAME< --server-add-password >PASSWORD-NODE3< --services index,query
/opt/couchbase/bin/couchbase-cli server-add -c >HOSTNAME-NODE1<.>FQDN< -u >USERNAME< -p >CLUSTERPASSWORD< --server-add >HOSTNAME-NODE4<.>FQDN< --server-add-username >USERNAME< --server-add-password >PASSWORD-NODE4< --services data
/opt/couchbase/bin/couchbase-cli server-add -c >HOSTNAME-NODE1<.>FQDN< -u >USERNAME< -p >CLUSTERPASSWORD< --server-add >HOSTNAME-NODE5<.>FQDN< --server-add-username >USERNAME< --server-add-password >PASSWORD-NODE5< --services index,query


#-------Rebalance Cluster-------
#Run this on the first node.

/opt/couchbase/bin/couchbase-cli rebalance -c >HOSTNAME-NODE1<.>FQDN<:8091 -u >USERNAME< -p >CLUSTERPASSWORD<


#-------Configure service to start automatically at boot and restart it to apply changes-------
#Run this on each node.

sudo systemctl enable couchbase-server


#-------Apply kernel tweaks to increase performance-------
#Run this on each node

sudo echo '' | sudo tee --append /etc/sysctl.conf > /dev/null
echo 'net.ipv4.tcp_keepalive_intvl = 30' | sudo tee --append /etc/sysctl.conf > /dev/null
echo 'net.ipv4.tcp_tw_reuse = 1' | sudo tee --append /etc/sysctl.conf > /dev/null
echo 'vm.swappiness = 0' | sudo tee --append /etc/sysctl.conf > /dev/null
echo 'fs.file-max = 500000' | sudo tee --append /etc/sysctl.conf > /dev/null
echo 'vm.zone_reclaim_mode = 0 ' | sudo tee --append /etc/sysctl.conf > /dev/null
sudo sysctl -p

sudo sh -c "echo 'f' > /sys/class/net/eth0/queues/rx-0/rps_cpus"
sudo sh -c "echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled"
sudo sh -c "echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag"
sudo sh -c "echo '1024' > /sys/block/sda/queue/nr_requests"

sudo systemctl enable rc-local
sudo sed -i '$ d' /etc/rc.local
sudo echo '' | sudo tee --append /etc/sysctl.conf > /dev/null > /dev/null
sudo echo 'sh -c "echo 'f' > /sys/class/net/eth0/queues/rx-0/rps_cpus"' | sudo tee --append /etc/rc.local > /dev/null
sudo echo 'sh -c "echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled"' | sudo tee --append /etc/rc.local > /dev/null
sudo echo 'sh -c "echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag"' | sudo tee --append /etc/rc.local > /dev/null
sudo echo 'sh -c "echo '1024' > /sys/block/sda/queue/nr_requests"' | sudo tee --append /etc/rc.local > /dev/null
sudo echo 'exit 0' | sudo tee --append /etc/rc.local > /dev/null

echo '' | sudo tee --append /etc/security/limits.conf > /dev/null
echo 'couchbase soft nofile 131072' | sudo tee --append /etc/security/limits.conf > /dev/null
echo 'couchbase hard nofile 131072' | sudo tee --append /etc/security/limits.conf > /dev/null
echo 'couchbase hard core unlimited' | sudo tee --append /etc/security/limits.conf > /dev/null


#-------Configure SSL Certificates-------
# Copy certificate PFX from first region to first node.
# Run this from the first node.

sudo mkdir /opt/couchbase/var/lib/couchbase/inbox/
sudo chown couchbase:couchbase /opt/couchbase/var/lib/couchbase/inbox/

sudo openssl pkcs12 -in >CERTIFICATE.PFX< -out >CERTIFICATE.KEY< -nocerts -nodes
sudo openssl rsa -in >CERTIFICATE.KEY< -out /opt/couchbase/var/lib/couchbase/inbox/pkey.key
rm >CERTIFICATE.KEY<
sudo openssl pkcs12 -in >CERTIFICATE.PFX< -out /opt/couchbase/var/lib/couchbase/inbox/chain.pem -nokeys -clcerts

sudo /opt/couchbase/bin/couchbase-cli ssl-manage -c >HOSTNAME-NODE1< -u >USERNAME< -p >CLUSTERPASSWORD< --upload-cluster-ca /opt/couchbase/var/lib/couchbase/inbox/chain.pem
sudo /opt/couchbase/bin/couchbase-cli ssl-manage -c >HOSTNAME-NODE1< -u >USERNAME< -p >CLUSTERPASSWORD< --set-node-certificate
sudo /opt/couchbase/bin/couchbase-cli ssl-manage -c >HOSTNAME-NODE1< -u >USERNAME< -p >CLUSTERPASSWORD< --node-cert-info


#-------Apply Couchbase Configurations-------
# Run this from the first node.

sudo /opt/couchbase/bin/couchbase-cli setting-autofailover --enable-auto-failover 1 --auto-failover-timeout 5 --enable-failover-on-data-disk-issues 1 --failover-data-disk-period 120 -c >HOSTNAME-NODE1<.>FQDN<:8091 -u >USERNAME< -p >CLUSTERPASSWORD<
sudo /opt/couchbase/bin/couchbase-cli setting-alert --enable-email-alert 1 --email-recipients >RECIPIENT<@>FQDN<  --email-sender >COUCHBASEEMAIL<@>FQDN< --email-host >SMTPSERVER<.>FQDN< --alert-auto-failover-node --alert-auto-failover-max-reached --alert-auto-failover-node-down --alert-auto-failover-cluster-small --alert-auto-failover-disable --alert-ip-changed --alert-disk-space --alert-meta-overhead --alert-meta-oom --alert-write-failed --alert-audit-msg-dropped --alert-indexer-max-ram --alert-timestamp-drift-exceede --alert-communication-issue -c >HOSTNAME-NODE1<.>FQDN<:8091 -u >USERNAME< -p >CLUSTERPASSWORD< --email-port 25
sudo /opt/couchbase/bin/couchbase-cli setting-security --disable-http-ui 1 -c >HOSTNAME-NODE1<.>FQDN<:8091 -u >USERNAME< -p >CLUSTERPASSWORD<
sudo /opt/couchbase/bin/couchbase-cli setting-audit --audit-enabled 1 --audit-log-path /opt/couchbase/var/lib/couchbase/logs/ --audit-log-rotate-size 100000000 -c >HOSTNAME-NODE1<.>FQDN<:8091 -u >USERNAME< -p >CLUSTERPASSWORD<
sudo /opt/couchbase/bin/couchbase-cli setting-compaction --metadata-purge-interval .08 -c >HOSTNAME-NODE1<.>FQDN<:8091 -u >USERNAME< -p >CLUSTERPASSWORD<


#-------Configure XDCR-------
# Copy certificate PFX from second region to first node.
# Run this from the first node.
sudo openssl pkcs12 -in >CERTIFICATE2.PFX< -out /opt/couchbase/var/lib/couchbase/inbox/chain2.pem -nokeys -clcerts
sudo /opt/couchbase/bin/couchbase-cli xdcr-setup -c >HOSTNAME-NODE1<.>FQDN-SECONDREGION<:8091 -u >USERNAME< -p >CLUSTERPASSWORD< --create --xdcr-cluster-name '>XDCR-CLUSTER-NAME<' --xdcr-hostname >HOSTNAME-CLUSTER2-NODE1<.>FQDN< --xdcr-username >USERNAME< --xdcr-password >CLUSTERPASSWORD-CLUSTER2 --xdcr-demand-encryption 1 --xdcr-encryption-type full --xdcr-certificate /opt/couchbase/var/lib/couchbase/inbox/chain2.pem


-------Configure SSL--------
# Run this from the first node.

#Generate private key, create CSR
mkdir certificate
cd certificate
openssl genrsa -out pkey.key 2048
openssl req -new -key pkey.key -out pkey.csr -subj "/C=>CITY</ST=>STATE</L=>LOCATION</O=>ORGANIZATION</CN=>*.FQDN<"

#Create certificate using CSR
cat pkey.csr

#Download certificate and intermediary bundle. SCP the certs over to the first node of the cluster.
#Connect to the cluster once more. Cat out the gd_bundle chain, copy each individual certificate to the files below.
vim intermediate_certificate_1.crt
vim intermediate_certificate_2.crt
vim root_certificate.crt

#Convert the new certificates to pem format.
openssl x509 -in ace2207a1f84818b.crt -out pkey.pem -outform PEM
openssl x509 -in root_certificate.crt -out ca.pem -outform PEM
openssl x509 -in intermediate_certificate_1.crt -out int1.pem -outform PEM
openssl x509 -in intermediate_certificate_2.crt -out int2.pem -outform PEM

#Stage your final certificates for use in the cluster.
mkdir pems
cp pkey.pem int{1,2}.pem ca.pem pkey.key pems/
cd pems/

#Create your chain certificate using the public key and intermediate certificates
#Copy them to the required directory for Couchbase. Set the permissions.
cat pkey.pem int1.pem int2.pem > chain.pem
sudo cp chain.pem pkey.key /opt/couchbase/var/lib/couchbase/inbox/
sudo chmod 777 /opt/couchbase/var/lib/couchbase/inbox/*

#Upload the certificates to the cluster and node.
cd /opt/couchbase/var/lib/couchbase/inbox/
sudo /opt/couchbase/bin/couchbase-cli ssl-manage -c localhost:8091 -u >USERNAME< -p >CLUSTERPASSWORD< --upload-cluster-ca=/home/>USERNAME</certificate/pems/ca.pem
sudo /opt/couchbase/bin/couchbase-cli ssl-manage -c localhost:8091 -u >USERNAME< -p >CLUSTERPASSWORD< --set-node-certificate

#Copy the certificates to the home folder on the other nodes of the cluster.
scp chain.pem pkey.key >USERNAME<@>HOSTNAME-NODE2<.>FQDN<
scp chain.pem pkey.key >USERNAME<@>HOSTNAME-NODE3<.>FQDN<
scp chain.pem pkey.key >USERNAME<@>HOSTNAME-NODE4<.>FQDN<
scp chain.pem pkey.key >USERNAME<@>HOSTNAME-NODE5<.>FQDN<


#Connect to each node, create required directory, move certs, set permissions, set node cert.
sudo mkdir /opt/couchbase/var/lib/couchbase/inbox
sudo mv ~/chain.pem /opt/couchbase/var/lib/couchbase/inbox/
sudo mv ~/pkey.key /opt/couchbase/var/lib/couchbase/inbox/
sudo chmod 777 /opt/couchbase/var/lib/couchbase/inbox/*
sudo /opt/couchbase/bin/couchbase-cli ssl-manage -c localhost:8091 -u >USERNAME< -p >CLUSTERPASSWORD< --set-node-certificate
