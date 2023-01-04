#!/bin/bash -e

clear && cd ~

sudo apk update
sudo apk upgrade
sudo apk add build-base busybox fakeroot
sudo apk add syslinux xorriso squashfs-tools git
sudo apk add alpine-sdk apk-tools alpine-conf
sudo apk add mtools dosfstools grub grub-efi

USER=$(whoami)

if ! groups | grep -q abuild; then
   sudo addgroup abuild
fi

if ! groups $USER | grep -q abuild; then
   sudo usermod -a -G abuild $USER
fi

if [[ ! -d ~/.abuild ]]; then
   echo -en '\n' | abuild-keygen -i -a
fi

if [[ ! -d ~/aports ]]; then
   git clone --single-branch -b master https://gitlab.alpinelinux.org/alpine/aports.git
else
   cd ~/aports && git pull && cd ~
fi

curl -o ~/aports/scripts/apkovl.sh -LO https://raw.githubusercontent.com/0free/alpine/1/apkovl.sh

chmod 700 ~/aports/scripts/apkovl.sh

cat > ~/aports/scripts/mkimg.linux.sh <<EOF
profile_linux() {
   output_format='iso'
   image_ext='iso'
   arch='x86_64'
   hostname='alpine'
   kernel_cmdline='console=tty0 console=ttyS0,115200'
	initfs_cmdline='modules=loop,squashfs,sd-mod,usb-storage mitigations=off'
	initfs_features='ata base bootchart cdrom btrfs zfs xfs ext4 mmc nvme raid scsi squashfs usb virtio'
	modloop_sign=yes
	grub_mod='all_video disk part_gpt part_msdos linux normal configfile search search_label efi_gop fat iso9660 cat echo ls true gzio'
   boot_addons='amd-ucode intel-ucode'
   initrd_ucode='/boot/amd-ucode.img /boot/intel-ucode.img'
   apkovl='./aports/scripts/apkovl.sh'
   kernel_flavors='lts'
   kernel_addons='zfs'
   apks="\$apks
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
      font-noto-arabic
      git git-bash-completion
      hwids-net hwids-pci hwids-udev hwids-usb
      ibus ibus-bash-completion
      iptables iptables-openrc
      iwd iwd-openrc wireless-regdb
      linux-pam
      linux-firmware-amd linux-firmware-amd-ucode linux-firmware-amdgpu linux-firmware-i915 linux-firmware-intel linux-firmware-other linux-firmware-rtl_bt linux-firmware-rtl_nic linux-firmware-rtlwifi
      mesa mesa-dri-gallium
      musl musl-locales musl-utils
      networkmanager networkmanager-bash-completion networkmanager-common networkmanager-elogind networkmanager-openrc networkmanager-wifi
      openrc openrc-bash-completion openrc-settingsd openrc-settingsd-openrc
      polkit polkit-common polkit-elogind polkit-elogind-libs polkit-openrc
      gdm gdm-openrc mutter mutter-schemas
      gnome-desktop gnome-desktop-lang
      gnome-session gnome-shell gnome-shell-schemas
      gnome-control-center gnome-control-center-bash-completion
      gnome-tweaks gnome-shell-extensions arc-dark-gnome
      gsettings-desktop-schemas
      pinentry-gnome
      pipewire pipewire-libs pipewire-alsa pipewire-jack pipewire-pulse pipewire-tools pipewire-spa-tools pipewire-spa-vulkan pipewire-spa-bluez pipewire-media-session wireplumber
      gnome-terminal gnome-disk-utility gnome-system-monitor gedit
      nautilus
      network-manager-applet
      adwaita-icon-theme hicolor-icon-theme
      udev-init-scripts udev-init-scripts-openrc
      util-linux util-linux-bash-completion util-linux-login util-linux-misc util-linux-openrc
      xauth xinit xkbcomp xkeyboard-config xorg-server xorg-server-common xwayland
      xf86-input-evdev xf86-input-mtrack xf86-input-synaptics
      zfs zfs-openrc zfs-libs
   "
}
EOF

chmod 700 ~/aports/scripts/mkimg.linux.sh

sed -i 's|wireless-regdb||' ~/aports/scripts/mkimg.base.sh
sed -i 's|linux-firmware | |' ~/aports/scripts/mkimg.base.sh
sed -i 's|timeout=1|timeout=0|' ~/aports/scripts/mkimg.base.sh
sed -i 's|"alpine-${profile_abbrev:-$PROFILE} $RELEASE $ARCH"|"alpineLinux"|g' ~/aports/scripts/mkimg.base.sh

sed -i 's|/bin/busybox|/bin/bash|g' ~/aports/scripts/genrootfs.sh

sed -i 's|ln -s /bin/busybox|ln -s /bin/bash|' ~/aports/main/busybox/APKBUILD
sed -i 's|/bin/ash|/bin/bash|' ~/aports/main/alpine-baselayout/passwd

sed -i 's|/bin/ash|/bin/bash|' ~/aports/community/shadow/useradd-defaults.patch
sed -i 's|/bin/ash|/bin/bash|' ~/aports/community/apk-deploy-tool/apk-deploy-tool.pre-install

sed -i 's|timeout=1|timeout=0|' ~/aports/main/syslinux/update-extlinux.conf

sh ~/aports/scripts/mkimage.sh \
--profile linux \
--arch x86_64 \
--outdir ~/ \
--workdir ~/alpine \
--repository https://uk.alpinelinux.org/alpine/edge/main \
--repository https://uk.alpinelinux.org/alpine/edge/community \
--repository https://uk.alpinelinux.org/alpine/edge/testing

#end