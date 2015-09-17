#!/bin/bash
#
# Don't run this if you don't know what it's doing. 
#

# base packages
yum install -y git yum-utils epel-release.noarch

# enable zram
mkdir ~/git
git clone https://github.com/vaeth/zram-init.git ~/git/zram-init
cp ~/git/zram-init/sbin/zram-init /usr/sbin/zram-init
chmod +x  /usr/sbin/zram-init
cp -a ~/git/zram-init/systemd/system/* /usr/lib/systemd/system/
systemctl enable zram_swap
systemctl start zram_swap

# add ssh pubkeys

mkdir ~/.ssh
cat <<EOF > ~/.ssh/authorized_keys
# id_rsa.pub
ssh-rsa <pubkey here>
EOF

# install elrepo repo
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
yum-config-manager --enable elrepo-kernel
yum-config-manager --enable elrepo-extras
yum-config-manager --enable epel

# remove network-manager because it's a piece of shit
yum remove -y NetworkManager NetworkManager-libnm
chkconfig network on

# install packages
yum install -y kernel-ml htop yum-cron bash-completion mlocate net-tools tmux wget yum-plugin-versionlock yum-plugin-rpm-warm-cache deltarpm mdadm

# reconfigure grub for kernel-ml, unsure why centos doesn't do this for you
grub2-mkconfig -o /boot/grub2/grub.cfg

# enable automatic updates
systemctl enable yum-cron on
sed -iE 's/apply_updates = no/apply_updates = yes/g' /etc/yum/yum-cron.conf

# setup sshd
echo "PermitRootLogin without-password" >> /etc/ssh/sshd_config
systemctl sshd restart

# set selinux to permissive
sed -iE 's/enforcing/permissive/g' /etc/selinux/config

# docker things
wget -qO- https://get.docker.com/ | sh
systemctl stop docker
rm -rf /var/lib/docker

sed -iE 's/docker daemon -H/docker daemon -s btrfs -H/g' a

# for overlayfs (ontop of ext4 / xfs):
# sed -iE 's/docker daemon -H/docker daemon -s overlay -H/g' a

systemctl daemon-reload
systemctl enable docker

# setup firewall rules if the server is a VPS behind cloudflare

#firewall-cmd --permanent --new-zone=work
#firewall-cmd --permanent --new-zone=samhome
firewall-cmd --permanent --new-zone=cloudflare

#firewall-cmd --permanent --zone=work --add-source=<work ip range here>
#firewall-cmd --permanent --zone=samhome --add-source=<home ip range>
firewall-cmd --permanent --zone=cloudflare --add-source=103.21.244.0/22
firewall-cmd --permanent --zone=cloudflare --add-source=103.22.200.0/22
firewall-cmd --permanent --zone=cloudflare --add-source=103.31.4.0/22
firewall-cmd --permanent --zone=cloudflare --add-source=104.16.0.0/12
firewall-cmd --permanent --zone=cloudflare --add-source=108.162.192.0/18
firewall-cmd --permanent --zone=cloudflare --add-source=141.101.64.0/18
firewall-cmd --permanent --zone=cloudflare --add-source=162.158.0.0/15
firewall-cmd --permanent --zone=cloudflare --add-source=172.64.0.0/13
firewall-cmd --permanent --zone=cloudflare --add-source=173.245.48.0/20
firewall-cmd --permanent --zone=cloudflare --add-source=188.114.96.0/20
firewall-cmd --permanent --zone=cloudflare --add-source=190.93.240.0/20
firewall-cmd --permanent --zone=cloudflare --add-source=197.234.240.0/22
firewall-cmd --permanent --zone=cloudflare --add-source=198.41.128.0/17
firewall-cmd --permanent --zone=cloudflare --add-source=199.27.128.0/21

firewall-cmd --permanent --zone=cloudflare --add-port=443/tcp
firewall-cmd --permanent --zone=cloudflare --add-port=80/tcp

firewall-cmd --permanent --zone=public --remove-service ssh

firewall-cmd --reload
firewall-cmd --list-all-zones

reboot
