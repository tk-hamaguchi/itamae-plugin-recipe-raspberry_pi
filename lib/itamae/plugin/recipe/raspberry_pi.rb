execute 'update package list' do
  user 'root'
  command 'apt-get update -y'
end

execute 'update packages' do
  user 'root'
  command 'apt-get upgrade -y'
end

execute 'rpi update' do
  user 'root'
  command 'SKIP_WARNING=1 rpi-update'
end

execute 'swap off' do
  user 'root'
  command 'swapoff --all'
  not_if "free | grep '^Swap: \+0 \+ \+0 \+ \+0$'"
end

package 'dphys-swapfile' do
  action :remove
end

file '/etc/rc.local' do
  user 'root'
  action :edit
  block do |content|
    content.gsub!(/^exit 0$/, <<-"EOS".gsub(/^\s+\|/, ''))
      |### Itamae cooked
      |mkdir -p /var/log/ConsoleKit
      |mkdir -p /var/log/samba
      |mkdir -p /var/log/fsck
      |mkdir -p /var/log/apt
      |mkdir -p /var/log/ntpstats
      |chown root.ntp /var/log/ntpstats
      |chown root.adm /var/log/samba
      |touch /var/log/lastlog
      |touch /var/log/wtmp
      |touch /var/log/btmp
      |chown root.utmp /var/log/lastlog
      |chown root.utmp /var/log/wtmp
      |chown root.utmp /var/log/btmp
      |### Itamae cooked
      |
      |exit 0
    EOS
  end
  not_if "grep '^### Itamae cooked$' /etc/rc.local"
end

file '/etc/fstab' do
  user 'root'
  action :edit
  block do |content|
    content.concat(<<-"EOS".gsub(/^\s+\|/, ''))
      |
      |### Itamae cooked
      |tmpfs           /tmp            tmpfs   defaults,size=32m,noatime,mode=1777      0       0
      |tmpfs           /var/tmp        tmpfs   defaults,size=16m,noatime,mode=1777      0       0
      |tmpfs           /var/log        tmpfs   defaults,size=32m,noatime,mode=0755      0       0
      |### Itamae cooked
    EOS
  end
  not_if "grep '^### Itamae cooked$' /etc/fstab"
end

execute 'expand rootfs' do
  user 'root'
  command 'raspi-config --expand-rootfs'
end

execute 'reboot' do
  user 'root'
  command 'reboot'
end
