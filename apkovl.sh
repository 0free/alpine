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
         alpine-base iwd dbus curl bash bash-completion nano
         sfdisk sgdisk zfs
         util-linux coreutils usbutils
         e2fsprogs e2fsprogs-extra
         dosfstools mtools lvm2
         btrfs-progs btrfs-progs-extra
         xfsprogs xfsprogs-extra
         exfatprogs
         nfs-utils ntfs-3g ntfs-3g-progs
         f2fs-tools
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

rc_add gdm default
rc_add elogind default
rc_add polkit default
rc_add networkmanager default
rc_add networkmanager-dispatcher default
rc_add bluealsa default
rc_add bluetooth default
rc_add ufw default

rc_add mount-ro shutdown
rc_add killprocs shutdown
rc_add savecache shutdown

tar -c -C "$tmp" etc | gzip -9n > $HOSTNAME.apkovl.tar.gz

#end
