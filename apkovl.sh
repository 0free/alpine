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
alsaconf alsa-lib alsa-utils alsa-utils-openrc alsa-plugins-pulse alsa-plugins-jack alsa-ucm-conf
bash bash-completion
attr binutils bolt coreutils diffutils curl dialog fakeroot findutils gawk grep less nano ncurses-dev net-tools openssl pciutils readline rsync rsync-openrc rsyslog rsyslog-openrc sed shadow sudo usbutils wget which
brotli-libs bzip2 lz4 lzo unzip xz zip zlib zstd
btrfs-progs btrfs-progs-bash-completion btrfs-progs-extra btrfs-progs-libs
dbus dbus-libs dbus-openrc dbus-x11
dosfstools e2fsprogs exfatprogs f2fs-tools gptfdisk hfsprogs jfsutils lvm2 mmc-utils mtools ntfs-3g ntfs-3g-progs sfdisk sgdisk squashfs-tools udftools udisks2 udisks2-bash-completion xfsprogs
efibootmgr
elogind elogind-bash-completion elogind-openrc
ethtool ethtool-bash-completion
eudev eudev-libs eudev-openrc
git git-bash-completion
hwids-net hwids-pci hwids-udev hwids-usb
ibus ibus-bash-completion
iptables iptables-openrc
iwd iwd-openrc wireless-regdb
linux-pam
linux-firmware-amd linux-firmware-amd-ucode linux-firmware-amdgpu
linux-firmware-i915 linux-firmware-intel linux-firmware-other
linux-firmware-rtl_bt linux-firmware-rtl_nic linux-firmware-rtlwifi
mesa mesa-dri-gallium
musl musl-locales musl-utils
networkmanager networkmanager-bash-completion networkmanager-common networkmanager-elogind networkmanager-openrc networkmanager-wifi
openrc openrc-bash-completion openrc-settingsd openrc-settingsd-openrc
polkit polkit-common polkit-elogind polkit-elogind-libs polkit-openrc
pipewire pipewire-libs pipewire-alsa pipewire-jack pipewire-pulse pipewire-tools pipewire-spa-tools pipewire-spa-vulkan pipewire-spa-bluez pipewire-media-session wireplumber
udev-init-scripts udev-init-scripts-openrc
util-linux util-linux-bash-completion util-linux-login util-linux-misc util-linux-openrc
xauth xinit xkbcomp xkeyboard-config xorg-server xorg-server-common xwayland
xf86-input-evdev xf86-input-mtrack xf86-input-synaptics
zfs zfs-openrc zfs-libs
greetd greetd-openrc greetd-agreety
wayfire paperde alacritty
EOF

makefile root:root 0644 "$tmp"/etc/apk/repositories <<EOF
https://uk.alpinelinux.org/alpine/edge/main
https://uk.alpinelinux.org/alpine/edge/community
https://uk.alpinelinux.org/alpine/edge/testing
EOF

mkdir -p "$tmp"/etc/greetd/config.toml
makefile root:root 0644 "$tmp"/etc/greetd/config.toml <<EOF
[terminal]
vt = 1
[default_session]
command = "agreety --cmd /bin/sh"
user = "greeter"
[initial_session]
command = "paperdesktop"
user = "user"
EOF

mkdir -p "$tmp"/etc/profile.d/
makefile root:root 0755 "$tmp"/etc/profile.d/bash.sh <<EOF
sed -i 's|/bin/ash|/bin/bash|' /etc/passwd
ln -sf /bin/bash /bin/sh
ln -sf /bin/bash /bin/ash
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u | \[\033[1;32m\]\h | \[\e[35m\]$SHELL\[\e[0m\] | \[\e[33m\]\w\[\e[0m\]\n\> \[\033[0m\]'
install() {
	if curl -s -o /dev/null alpinelinux.org; then
	    curl -LO https://raw.githubusercontent.com/0free/alpine/1/install.sh && bash install.sh
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
rc_add udev-settle sysinit
rc_add udev-postmount sysinit

rc_add dbus sysinit

rc_add procfs boot
rc_add devfs boot
rc_add sysfs boot
rc_add root boot

rc_add hwclock boot
rc_add modules boot
rc_add sysctl boot
rc_add hostname boot
rc_add bootmisc boot
rc_add syslog boot
rc_add networking boot
rc_add local boot

rc_add spl boot
rc_add zfs boot
rc_add efivars boot

rc_add agetty.tty1 default

rc_add acpid default
rc_add iwd default
rc_add rsyncd default
rc_add networkmanager default
rc_add networkmanager-dispatcher default
rc_add alsa default
rc_add bluealsa default
rc_add bluetooth default
rc_add elogind default
rc_add polkit default

rc_add greetd default

rc_add mount-ro shutdown
rc_add killprocs shutdown
rc_add savecache shutdown

tar -c -C "$tmp" etc | gzip -9n > "$HOSTNAME".apkovl.tar.gz

#end