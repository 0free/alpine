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

auto eth0
iface eth0 inet dhcp

auto wlan0
iface wlan0 inet dhcp
EOF

mkdir -p "$tmp"/etc/apk

makefile root:root 0644 "$tmp"/etc/apk/world <<EOF
alpine-base apk-tools
alsa-lib alsa-plugins-pulse
bash bash-completion
attr binutils bolt coreutils diffutils curl dialog fakeroot findutils gawk grep less nano ncurses-dev net-tools openssl pciutils readline rsync rsync-openrc rsyslog rsyslog-openrc sed shadow sudo usbutils wget which
brotli-libs bzip2 lz4 lzo unzip xz zip zlib zstd
btrfs-progs btrfs-progs-bash-completion btrfs-progs-extra btrfs-progs-libs
busybox busybox-binsh busybox-mdev-openrc busybox-openrc
chromium
colord colord-bash-completion colord-gtk
dbus dbus-openrc dbus-x11
dosfstools e2fsprogs exfatprogs f2fs-tools gptfdisk hfsprogs jfsutils lvm2 mmc-utils mtools ntfs-3g ntfs-3g-progs sfdisk sgdisk squashfs-tools udftools udisks2 udisks2-bash-completion xfsprogs
efibootmgr syslinux
elogind elogind-bash-completion elogind-openrc
ethtool ethtool-bash-completion
eudev eudev-libs eudev-openrc
git git-bash-completion
grub grub-bash-completion grub-efi
ibus ibus-bash-completion
iproute2 iptables iptables-openrc
iwd iwd-openrc
linux-pam linux-lts
mesa-dri-gallium
musl musl-locales
networkmanager
openrc openrc-bash-completion
polkit polkit-common polkit-elogind polkit-elogind-libs polkit-openrc
    gdm gdm-openrc mutter mutter-schemas
    gnome-desktop gnome-desktop-lang
    gnome-session gnome-shell gnome-shell-extensions gnome-menus
    gnome-control-center gnome-control-center-bash-completion
    gnome-tweaks gnome-colors-common gsettings-desktop-schemas
    tracker tracker-bash-completion
    pinentry-gnome
    gnome-keyring gnome-terminal gnome-disk-utility gnome-system-monitor
    nautilus gedit py3-cairo file-roller
    network-manager-applet gufw
tzdata
udev-init-scripts udev-init-scripts-openrc
ufw ufw-bash-completion ufw-openrc
util-linux util-linux-bash-completion util-linux-login
xf86-input-evdev xf86-input-mtrack xf86-input-synaptics
xorg-server
EOF

makefile root:root 0644 "$tmp"/etc/apk/repositories <<EOF
https://dl-cdn.alpinelinux.org/alpine/edge/main
https://dl-cdn.alpinelinux.org/alpine/edge/community
https://dl-cdn.alpinelinux.org/alpine/edge/testing
EOF

rc_add devfs sysinit
rc_add dmesg sysinit
rc_add mdev sysinit
rc_add hwdrivers sysinit
rc_add modloop sysinit

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

rc_add udev sysinit
rc_add udev-trigger sysinit
rc_add dbus sysinit
rc_add udev-settle sysinit
rc_add udev-postmount sysinit

rc_add iwd default
rc_add rsyncd default
rc_add elogind default
rc_add polkit default
rc_add networkmanager default
rc_add networkmanager-dispatcher default
rc_add bluealsa default
rc_add bluetooth default
rc_add ufw default
rc_add gdm default

rc_add mount-ro shutdown
rc_add killprocs shutdown
rc_add savecache shutdown

tar -c -C "$tmp" etc | gzip -9n > $HOSTNAME.apkovl.tar.gz

#end
