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
                alpine-base zfs
                dhcpcd ethtool kbd-bkeymaps
                linux-firmware-other
                linux-firmware-amd linux-firmware-amd-ucode
                linux-firmware-amdgpu linux-firmware-radeon
                linux-firmware-nvidia
                linux-firmware-intel linux-firmware-i915
                linux-firmware-rtl_bt linux-firmware-rtl_nic
                linux-firmware-rtlwifi
                linux-firmware-brcm
                linux-firmware-qca
                util-linux coreutils usbutils
                bash bash-completion sudo nano openssl curl
                network-extras iwd dbus wireless-regdb
                e2fsprogs e2fsprogs-extra
                dosfstools mtools lvm2
                btrfs-progs btrfs-progs-extra
                xfsprogs xfsprogs-extra
                exfatprogs
                nfs-utils ntfs-3g ntfs-3g-progs
                f2fs-tools
                sfdisk sgdisk
                openrc openrc-bash-completion openrc-settingsd openrc-settingsd-openrc
                busybox
                busybox-openrc busybox-mdev-openrc busybox-binsh busybox-suid
                musl musl-utils musl-locales
                dbus dbus-openrc dbus-libs dbus-x11
                ibus ibus-bash-completion
                udev-init-scripts udev-init-scripts-openrc
                eudev eudev-openrc eudev-libs
                hwids-net hwids-pci hwids-udev hwids-usb
                xauth xinit xorg-server xorg-server-common
                xwayland
                mesa mesa-dri-gallium
                vulkan-loader vulkan-tools
                polkit-openrc polkit-common polkit-elogind polkit-elogind-libs
                elogind elogind-openrc elogind-bash-completion
                xf86-input-evdev xf86-input-mtrack xf86-input-synaptics
                plasma-desktop plasma-workspace
                breeze-icons
                sddm sddm-openrc sddm-kcm sddm-breeze
EOF

makefile root:root 0644 "$tmp"/etc/apk/repositories <<EOF
https://dl-cdn.alpinelinux.org/alpine/edge/main
https://dl-cdn.alpinelinux.org/alpine/edge/community
https://dl-cdn.alpinelinux.org/alpine/edge/testing
EOF

rc_add dbus default
rc_add elogind default
rc_add polkit default

rc_add udev default
rc_add udev-settle default
rc_add udev-trigger default
rc_add udev-postmount default

rc_add sddm default

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

rc_add mount-ro shutdown
rc_add killprocs shutdown
rc_add savecache shutdown

tar -c -C "$tmp" etc | gzip -9n > $HOSTNAME.apkovl.tar.gz

#end
