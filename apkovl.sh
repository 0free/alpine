#!/bin/sh -e

HOSTNAME="$1"
if [ -z "$HOSTNAME" ]; then
	echo "usage: $0 hostname"
	exit 1
fi

cleanup() {
	rm -rf "$tmp"
}

makefile() {
	OWNER="$1"
	PERMS="$2"
	FILENAME="$3"
	cat > "$FILENAME"
	chown "$OWNER" "$FILENAME"
	chmod "$PERMS" "$FILENAME"
}

rc_add() {
	mkdir -p "$tmp"/etc/runlevels/"$2"
	ln -sf /etc/init.d/"$1" "$tmp"/etc/runlevels/"$2"/"$1"
}

tmp="$(mktemp -d)"
trap cleanup EXIT

mkdir -p "$tmp"/etc
makefile root:root 0644 "$tmp"/etc/hostname <<EOF
$HOSTNAME
EOF

mkdir -p "$tmp"/etc/network
makefile root:root 0644 "$tmp"/etc/network/interfaces <<EOF
auto lo
iface lo inet loopback
EOF

mkdir -p "$tmp"/etc/NetworkManager
makefile root:root 0644 "$tmp"/etc/NetworkManager/NetworkManager.conf <<EOF
[main]
dhcp=internal
plugins=ifupdown,keyfile
[ifupdown]
managed=true
[device]
wifi.backend=iwd
EOF

mkdir -p "$tmp"/etc/apk
makefile root:root 0644 "$tmp"/etc/apk/world <<EOF
alpine-base alpine-baselayout alpine-baselayout-data alpine-conf alpine-keys alpine-release apk-tools
amd-ucode
alsa-lib alsa-plugins-pulse bluez-alsa bluez-alsa-openrc bluez-alsa-utils
bash bash-completion
attr binutils bolt coreutils diffutils curl dialog fakeroot findutils gawk grep less nano ncurses-dev net-tools openssl pciutils readline rsync rsync-openrc rsyslog rsyslog-openrc sed shadow sudo usbutils wget which
brotli-libs bzip2 lz4 lzo unzip xz zip zlib zstd
btrfs-progs btrfs-progs-bash-completion btrfs-progs-extra btrfs-progs-libs
colord colord-bash-completion colord-gtk
dbus dbus-libs dbus-openrc dbus-x11
dosfstools e2fsprogs exfatprogs f2fs-tools gptfdisk hfsprogs jfsutils lvm2 mmc-utils mtools ntfs-3g ntfs-3g-progs sfdisk sgdisk squashfs-tools udftools udisks2 udisks2-bash-completion xfsprogs
elogind elogind-bash-completion elogind-openrc
efibootmgr syslinux
ethtool ethtool-bash-completion
eudev eudev-libs eudev-openrc
font-noto-arabic
git git-bash-completion
hwids-net hwids-pci hwids-udev hwids-usb
ibus ibus-bash-completion
intel-media-driver intel-ucode
iptables iptables-openrc
iwd iwd-openrc wireless-regdb
linux-lts linux-pam
linux-firmware-amd linux-firmware-amd-ucode linux-firmware-amdgpu linux-firmware-i915 linux-firmware-intel linux-firmware-other linux-firmware-rtl_bt linux-firmware-rtl_nic linux-firmware-rtlwifi
mesa mesa-dri-gallium mesa-egl mesa-gbm mesa-gl mesa-glapi mesa-gles mesa-va-gallium mesa-vdpau-gallium mesa-vulkan-intel mesa-vulkan-layers
musl musl-locales musl-utils
networkmanager
openrc openrc-bash-completion openrc-settingsd openrc-settingsd-openrc
polkit polkit-common polkit-elogind polkit-elogind-libs polkit-openrc
gdm gdm-openrc mutter mutter-schemas
gnome-desktop gnome-desktop-lang
gnome-session gnome-shell gnome-shell-schemas
gnome-control-center gnome-control-center-bash-completion
gnome-tweaks gnome-shell-extensions arc-dark-gnome
gsettings-desktop-schemas
pinentry-gnome
gnome-terminal gnome-disk-utility gnome-system-monitor gedit
nautilus
network-manager-applet
networkmanager networkmanager-bash-completion networkmanager-bluetooth networkmanager-common networkmanager-elogind networkmanager-initrd-generator networkmanager-openrc networkmanager-wifi networkmanager-wwan
adwaita-icon-theme hicolor-icon-theme
tzdata
udev-init-scripts udev-init-scripts-openrc
util-linux util-linux-bash-completion util-linux-login util-linux-misc util-linux-openrc
vulkan-loader vulkan-tools
xauth xinit xkbcomp xkeyboard-config xorg-server xorg-server-common xwayland
xf86-input-evdev xf86-input-mtrack xf86-input-synaptics
EOF

makefile root:root 0644 "$tmp"/etc/apk/repositories <<EOF
https://dl-cdn.alpinelinux.org/alpine/edge/main
https://dl-cdn.alpinelinux.org/alpine/edge/community
https://dl-cdn.alpinelinux.org/alpine/edge/testing
EOF

mkdir -p "$tmp"/etc/gdm
makefile root:root 0644 "$tmp"/etc/gdm/custom.conf <<EOF
[daemon]
AutomaticLogin=root
AutomaticLoginEnable=true
WaylandEnable=true
EOF

mkdir -p "$tmp"/etc/
curl -LO https://raw.githubusercontent.com/0free/alpine/1/dconf-settings.ini
mv dconf-settings.ini "$tmp"/etc/

mkdir -p "$tmp"/etc/profile.d/
makefile root:root 0755 "$tmp"/etc/profile.d/bash.sh <<EOF
sed -i 's|/bin/ash|/bin/bash|' /etc/passwd
ln -sf /bin/bash /bin/sh
ln -sf /bin/bash /bin/ash
if [ -f /etc/dconf-settings.ini ]; then 
  dconf load / < /etc/dconf-settings.ini
  rm /etc/dconf-settings.ini
fi
PS1='\[\e[31m\]\[\e[m\]\[\e[38;5;172m\]\u\[\e[m\]@\[\e[38;5;153m\]\h\[\e[m\]\[\e[38;5;214m\] \w\[\e[m\]\[\e[31m\]\[\e[m\] \$ '
install() {
	if ping -q -c1 alpinelinux.org &>/dev/null; then
	    curl -LO https://raw.githubusercontent.com/0free/alpine/1/install && bash install
    else
        echo "no internet"
	fi
}
EOF

rc_add devfs sysinit
rc_add dmesg sysinit
rc_add mdev sysinit
rc_add hwdrivers sysinit
rc_add modloop sysinit

rc_add udev sysinit
rc_add udev-trigger sysinit
rc_add dbus sysinit
rc_add udev-settle sysinit
rc_add udev-postmount sysinit

rc_add hwclock boot
rc_add modules boot
rc_add sysctl boot
rc_add hostname boot
rc_add bootmisc boot
rc_add syslog boot

rc_add networking boot
rc_add local boot
rc_add dbus boot
rc_add iwd boot

rc_add spl boot
rc_add zfs boot
rc_add efivars boot

rc_add iwd default
rc_add rsyncd default
rc_add elogind default
rc_add polkit default
rc_add networkmanager default
rc_add networkmanager-dispatcher default
rc_add bluealsa default
rc_add bluetooth default
rc_add gdm default

rc_add mount-ro shutdown
rc_add killprocs shutdown
rc_add savecache shutdown

tar -c -C "$tmp" etc | gzip -9n > $HOSTNAME.apkovl.tar.gz

#end
