#!/bin/bash

bootSize='190MiB'
timezone='Asia/Muscat'
pool='rpool'
hostname='linux'
user='user'
password='0000'
mirror='https://uk.alpinelinux.org/alpine'

packages_list() {

    packages=(
        #alpine
        alpine-base alpine-baselayout alpine-baselayout-data
        alpine-conf alpine-keys alpine-release apk-tools
        #openrc
        openrc openrc-bash-completion openrc-settingsd openrc-settingsd-openrc
        #busybox
        busybox busybox-openrc busybox-mdev-openrc busybox-binsh busybox-suid
        #musl
        musl musl-utils musl-locales
        #glibc
        gcompat
        #dbus
        dbus dbus-openrc dbus-libs dbus-x11
        #ibus
        ibus ibus-bash-completion
        #udev
        udev-init-scripts udev-init-scripts-openrc
        #eudev
        eudev eudev-openrc eudev-libs
        #hardware
        hwids-net hwids-pci hwids-udev hwids-usb
        #xorg
        xauth xinit xorg-server xorg-server-common
        #wayland
        xwayland
        #mesa
        mesa-dri-gallium
        #polkit/elogind
        polkit-openrc polkit-common polkit-elogind polkit-elogind-libs
        elogind elogind-openrc elogind-bash-completion
        #input
        xf86-input-evdev xf86-input-mtrack xf86-input-synaptics
        #base
        sudo bash bash-completion binutils fakeroot file fortify-headers
        g++ gcc libc-dev patch remake-make shadow
        rsyslog rsyslog-openrc sed attr dialog
        which grep pciutils usbutils findutils readline
        lsof less curl wget coreutils gawk diffutils autoconf
        #util-linux
        util-linux util-linux-openrc util-linux-login
        util-linux-misc util-linux-bash-completion
        #utilities
        openssl ncurses-dev
        #git
        git git-bash-completion
        #compression
        brotli-libs zstd zlib zip lz4 lzo unzip xz bzip2 gzip
        #disks
        e2fsprogs lvm2 gptfdisk dosfstools mtools ntfs-3g ntfs-3g-progs
        xfsprogs hfsprogs exfatprogs f2fs-tools
        udftools sfdisk sgdisk mmc-utils jfsutils
        udisks2 udisks2-bash-completion
        #rsync
        rsync rsync-openrc
        #network
        networkmanager networkmanager-openrc
        networkmanager-common networkmanager-bash-completion
        networkmanager-elogind
        #firewall
        ufw ufw-openrc ufw-bash-completion
        iptables iptables-openrc
        #pipewire
        pipewire pipewire-libs pipewire-alsa pipewire-jack pipewire-pulse
        pipewire-tools
        pipewire-spa-tools pipewire-spa-vulkan pipewire-spa-bluez
        pipewire-media-session wireplumber
        #alsa
        alsaconf alsa-lib alsa-utils alsa-utils-openrc
        alsa-plugins-pulse alsa-plugins-jack alsa-ucm-conf 
        #bluetooth
        bluez-alsa bluez-alsa-openrc bluez-alsa-utils
        #intel hda
        sof-firmware sof-bin
        #fonts
        font-hack font-adobe-source-code-pro
        font-noto-arabic
        font-opensans font-xfree86-type1
        ttf-font-awesome ttf-dejavu ttf-freefont ttf-droid
        #timezone
        tzdata
        #efi
        efibootmgr
    )

    if grep -q btrfs /root/list; then
        packages+=(
            #btrfs
            btrfs-progs btrfs-progs-extra btrfs-progs-libs btrfs-progs-bash-completion
            snapper snapper-bash-completion
        )
    fi

    if grep -q qemu /root/list; then
        packages+=(
            qemu-audio-alsa qemu-audio-dbus qemu-audio-pa
            qemu-hw-display-virtio-gpu qemu-hw-display-virtio-gpu-gl
            qemu-hw-display-virtio-gpu-pci qemu-hw-display-virtio-gpu-pci-gl
            qemu-hw-display-virtio-vga qemu-hw-display-virtio-vga-gl
            qemu-hw-usb-host qemu-hw-usb-redirect
        )
    else
        packages+=(
            #hardware
            bolt pciutils
            #firmware
            fwupd fwupd-openrc fwupd-efi
            #mesa
            mesa mesa-dri-gallium mesa-va-gallium
            mesa-vdpau-gallium
            mesa-gl mesa-glapi mesa-egl mesa-gles mesa-gbm
            mesa-vulkan-layers mesa-libd3dadapter9
            #intel GPU
            mesa-vulkan-intel intel-media-driver
            #vulkan
            vulkan-loader vulkan-tools
            #wireless
            wireless-regdb iwd iwd-openrc
            #network
            networkmanager-wwan networkmanager-wifi networkmanager-openvpn
            networkmanager-initrd-generator
        )
    fi

    if grep -q gnome /root/list; then
        packages+=(
            #gnome session
            gdm gdm-openrc mutter mutter-schemas
            gnome-desktop gnome-desktop-lang gnome-session
            gnome-shell gnome-shell-schemas gnome-menus
            gnome-control-center gnome-control-center-bash-completion
            gnome-tweaks gnome-colors-common gsettings-desktop-schemas
            tracker tracker-bash-completion
            #connector
            chrome-gnome-shell gnome-browser-connector
            #theme
            adwaita-icon-theme hicolor-icon-theme
            #gnome tools
            gnome-terminal gnome-disk-utility gnome-system-monitor file-roller
            #nautilus
            nautilus
            #text
            gedit py3-cairo
            #firmware
            gnome-firmware-updater
            #gnome theme
            arc-theme arc-dark arc-dark-gnome
            #gedit spell check
            aspell-en hunspell-en nuspell
            #network
            network-manager-applet
            #firewall
            gufw
            #colord
            colord colord-bash-completion colord-gtk
        )
    fi

    if grep -q kde /root/list; then
        packages+=(
            #sddm
            sddm sddm-openrc sddm-kcm sddm-breeze
            #plasma
            plasma-desktop
            plasma-workspace plasma-workspace-lang plasma-workspace-libs
            plasma-settings
            plasma-framework
            plasma-integration plasma-browser-integration
            plasma-thunderbolt plasma-disks
            #system
            kwrited systemsettings ksysguard polkit-kde-agent-1
            #theme
            breeze-gtk breeze-icons
            #bluetooth
            bluedevil
            #power
            powerdevil
            #wayland
            kwayland
            #network
            plasma-nm
            #firewall
            iproute2 net-tools
            #audio
            kpipewire kmix
            #kde
            ki18n kwin kinit kcron kdecoration krecorder
            kscreen kscreenlocker libkscreen kmenuedit konsole
            kde-gtk-config khotkeys
            #file manager
            dolphin dolphin-plugins kfind
            #text
            kate kate-common hunspell-en
            #archive
            ark
        )
    fi

    if grep -q wayfire /root/list; then
        packages+=(
            seatd seatd-openrc
            greetd greetd-openrc greetd-gtkgreet
            wayfire waybar alacritty
        )
    fi

    if grep -q workstation /root/list; then

        if grep -q gnome /root/list; then
            packages+=(
                #gnome apps
                gnome-software gnome-software-plugin-apk gnome-software-plugin-flatpak
                gnome-photos gnome-music gnome-clocks gnome-contacts gnome-calculator gnome-maps
                gnome-logs gnome-remote-desktop gnome-screenshot gnome-boxes gnome-calendar
                gnome-sound-recorder gnome-font-viewer gnome-colors gnome-bluetooth gnome-podcasts
                gnome-characters gnome-builder gnome-shortwave getting-things-gnome sushi simple-scan
                #config
                dconf dconf-bash-completion
                #web
                epiphany
                #documents
                evince evince-nautilus
                #photos
                gthumb eog shotwell
                #mail
                geary
                #sound
                gnome-metronome lollypop
                #other
                glade ghex baobab confy
                #bluetooth
                blueman
                #flatpak
                xdg-desktop-portal xdg-desktop-portal-gnome
                xdg-desktop-portal-gtk xdg-user-dirs
            )
        fi

        if grep -q kde /root/list; then
            packages+=(
                #plasma
                plasma-systemmonitor plasma-firewall
                plasma-camera plasma-videoplayer plasma-phonebook
                #kde
                kactivities kactivities-stats kactivitymanagerd ksystemstats
                shelf knetattach kmail ktorrent kdeconnect akregator kphotoalbum
                kmymoney kdeedu-data kalk rocs calligra marble clip
                buho vvave communicator qrca step kmousetool krename
                kcolorchooser kunitconversion
                #widgets
                kconfigwidgets
                #print
                print-manager
                #screen
                spectacle kscreenlocker kruler
                #image
                gwenview
                #audio
                juk kwave elisa
                #video
                kmediaplayer kdenlive dragon haruna
                #YouTube
                plasmatube audiotube
                #camera
                kamera kamoso
                #spelling
                sonnet
                #office
                kcalc okular skanlite
                #input
                plasma-remotecontrollers
                #draw
                kolourpaint
                #math
                cantor kalgebra kig kmplot
                #music
                minuet
                #flatpak
                xdg-desktop-portal xdg-desktop-portal-kde xdg-user-dirs
                #hex
                okteta
            )
        fi

        packages+=(
            #shell
            starship starship-bash-completion
            #wine
            wine vkd3d
            #thumbnail
            ffmpegthumbnailer
            #mkimage
            abuild alpine-sdk apk-tools mkinitfs xorriso squashfs-tools
            #fonts tools
            font-manager font-viewer
            #office
            libreoffice-base libreoffice-common libreoffice-writer
            libreoffice-math libreoffice-calc libreoffice-draw
            libreoffice-lang-en_us libreoffice-lang-ar
            #google
            google-authenticator
            #mail
            thunderbird
            #music
            amberol musescore
            #audio
            ardour tenacity calf calf-jack calf-lv2
            #video edit
            shotcut pitivi x265
            #video subtitle
            gaupol
            #book
            foliate
            #openvc
            opencv py3-opencv
            #python
            black
            #JavaScript
            npm npm-bash-completion nodejs esbuild reason
            #code
            code-oss code-oss-bash-completion lapce codeblocks
            #code format
            prettier tidyhtml
            #html/css to pdf
            weasyprint
            #screenshot
            flameshot
            #electronic
            kicad
            #screen
            obs-studio kooha peek
            #video
            mplayer totem celluloid
            #photos
            krita gimp inkscape gmic curtail
            #printer
            cups cups-openrc cups-pdf bluez-cups
            #driver
            xinput gkraken ccid solaar
            razercfg razercfg-gui razergenie openrazer
            piper
            #math
            mathjax2
            #finance
            homebank
            #2d
            tiled
            #3d
            blender freecad godot leocad solvespace goxel
            #3d printer
            cura
            #text editor
            kakoune
            #mauikit
            mauikit mauikit-accounts mauikit-filebrowsing
            mauikit-imagetools mauikit-texteditor
            #bitcoin
            bitcoin bitcoin-openrc
            #game emu
            pcsx2 dolphin-emu xwiimote pcsxr
            #rust
            rust rustfmt rust-analysis cargo
            #go
            go
            #android
            gradle android-tools android-tools-bash-completion
            go-mtpfs scrcpy scrcpy-bash-completion
            #iPhone/iPod/mac
            ifuse ideviceinstaller idevicerestore libirecovery libirecovery-progs
            libideviceactivation libimobiledevice libimobiledevice-progs
            #pdf
            corepdf pdfarranger poppler
            #drives
            onedrive onedrive-openrc
            #twitter
            cawbird
            #Corsair
            ckb-next
            #RGB
            openrgb
            #plan
            planner
            #music player
            amberol sublime-music
            #music server
            navidrome navidrome-openrc
            #youtube
            ffmpeg yt-dlp yt-dlp-bash-completion pipe-viewer-gtk
            audiotube tartube youtube-viewer-gtk
            #javascript/css
            minify minify-bash-completion
            #photos
            darktable
            #drawing
            drawing
            #remote
            remmina
            #touch
            touchegg touchegg-openrc
            #CPU
            corectrl
            #cctv
            zoneminder zoneminder-openrc
            #iso
            thumbdrives
        )

        if grep -q gnome /root/list; then
            packages+=(
                libreoffice-gnome
            )
        fi

    fi

    if grep -Eq 'server|workstation' /root/list; then
        packages+=(
            #php
            phpmyadmin composer php82 php82-bcmath php82-bz2 php82-cgi
            php82-curl php82-common php82-phpdbg php82-dom php82-exif
            php82-fileinfo php82-fpm php82-gd php82-gettext php82-iconv
            php82-intl php82-litespeed php82-mbstring php82-mysqli
            php82-mysqlnd php82-opcache php82-openssl php82-phar php82-pear
            php82-session php82-snmp php82-soap php82-xml php82-zip
        )
    fi

    if grep -q server /root/list; then
        packages+=(
            #system
            rsyslog rsyslog-openrc rsyslog-mysql rsyslog-tls rsyslog-http
            #SSL/TLS
            certbot
            #database
            mariadb
            #mail
            postfix postfix-openrc postfix-mysql postfix-pcre postfixadmin
            dovecot dovecot-openrc dovecot-submissiond dovecot-ldap
            dovecot-lmtpd dovecot-pop3d dovecot-sql dovecot-mysql
            opendkim opendkim-utils
            cyrus-sasl
            #tools
            imagemagick redis redis-openrc memcached memcached-openrc
            #server
            litespeed litespeed-openrc
            #cab
            cabextract
        )
    fi

}

menu() {

    echo -e "\n --> $1:\n"
    local output=$2
    shift 2
    local options=($@)
    local i=0
    while true; do
        for option in ${options[@]}; do
            if [[ $option == ${options[$i]} ]]; then
                echo -e "\t\e[7m$option\e[0m"
            else
                echo -e "\t$option"
            fi
        done
        read -rsn3 key
        case $key in
            $(echo -e '\033[A')) i=$((i-1));;
            $(echo -e '\033[B')) i=$((i+1));;
            '') break;;
        esac
        if [ $i -le 0 ] || [ $i -ge ${#options[@]} ]; then
            i=0
        fi
        echo -en "\033[${#options[@]}A"
    done
    printf -v $output ${options[$i]}

}

setup_drive() {

    if [ -f /root/list ]; then
        rm -r /root/list
    fi

    echo '# created by Saif AlSubhi'
    printf -- '-%.0s' {1..100}; echo ''
    lsblk -o name,type,fstype,size,fsused,mountpoint,parttypename,label,model
    printf -- '-%.0s' {1..100}; echo ''

    drives=($(ls /dev/ | grep -E '^nvme[0-9]n[1-9]$|^sd[a-z]$'))

    for i in ${!drives[@]}; do
        drives[i]=/dev/${drives[i]}
    done

    menu 'select a drive' drive ${drives[@]}
    echo "drive=$drive" > /root/list

    partitions=($(ls $drive* | grep -E "$drive$|$drive.{1}|$drive.{2}"))

    if [[ $partitions ]]; then
        menu 'select a root partition or use the complete drive' partition ${partitions[@]}
        if [[ $drive != $partition ]] ; then
            rootDrive=$partition
            if lsblk -o parttypename | grep -q 'EFI System'; then
                partitions=(${paritions[@]/$partition})
                if [[ $partitions ]]; then
                    menu 'select a boot partition ' bootDrive ${partitions[@]}
                    bootDrive=$partition
                fi
            fi
            if lsblk -o parttypename | grep -q 'Linux swap'; then
                partitions=(${paritions[@]/$partition})
                if [[ $partitions ]]; then
                    menu 'select a swap partition ' swapDrive ${partitions[@]}
                    swapDrive=$partition
                fi
            fi
        fi
    fi

    if [[ ! $swapDrive ]]; then
        swapSizes=(no-swap 1GiB 2GiB 3GiB 4GiB)
        menu 'select swap partition size in MB' swapSize ${swapSizes[@]} 
    fi

    filesystems=(btrfs zfs xfs ext4)
    menu 'select a filesystem' filesystem ${filesystems[@]}
    echo "filesystem=$filesystem" >> /root/list

    computers=(minimal miner qemu server workstation)
    menu 'select a computer' computer ${computers[@]}
    echo "computer=$computer" >> /root/list

    desktops=(kde gnome wayfire none)
    menu 'select a desktop' desktop ${desktops[@]}
    echo "desktop=$desktop" >> /root/list

    if [[ $filesystem == zfs ]]; then
        bootloaders=(gummiboot clover grub)
    elif [[ $filesystem == btrfs ]]; then
        bootloaders=(gummiboot clover rEFInd grub)
    else
        bootloaders=(gummiboot syslinux clover rEFInd grub)
    fi
    menu 'select a bootloader' bootloader ${bootloaders[@]}
    echo "bootloader=$bootloader" >> /root/list

    echo -e "\n"

    if ! test sgdisk; then
        echo ">>> installing sgdisk"
        apk add sgdisk
    fi

    if [[ ! $rootDrive ]]; then

        echo ">>> wiping filesystm"
        wipefs -a -f $drive
        echo ">>> deleting partitions"
        sgdisk -Z $drive
        echo ">>> creating GPT"
        sgdisk -o -U $drive

        if [[ ! $bootDrive ]]; then
            echo ">>> creating boot partition"
            sgdisk -n 0:0:+$bootSize -c 0:BOOT -t 0:ef00 $drive
            i=1
            bootDrive=$(ls $drive* | grep -E "${drive}${i}|${drive}p${i}")
            echo ">>> creating boot filesystem"
            mkfs.vfat -F32 -n BOOT $bootDrive
        fi

        if grep -q GiB $swapSize; then
            echo ">>> creating swap partition"
            sgdisk -n 0:0:+$swapSize -c 0:SWAP -t 0:8200 $drive
            i=$((i+1))
            swapDrive=$(ls $drive* | grep -E "${drive}${i}|${drive}p${i}")
            echo ">>> creating swap filesystem"
            mkswap $swapDrive
            echo "swapDrive=$swapDrive" >> /root/list
            echo "swapSize=$swapSize" >> /root/list
        fi

        echo ">>> creating root partition"
        if [[ $filesystem == zfs ]]; then
            sgdisk -n 0:0:0 -c 0:ROOT -t 0:bf00 $drive
        else
            sgdisk -n 0:0:0 -c 0:ROOT -t 0:8300 $drive
        fi
        i=$((i+1))
        rootDrive=$(ls $drive* | grep -E "${drive}${i}|${drive}p${i}")

    fi

    echo ">>> reading partition tables"
    mdev -s && mdev -s

    echo "bootDrive=$bootDrive" >> /root/list
    echo "rootDrive=$rootDrive" >> /root/list

    echo ">>> creating root filesystem"
    if [[ $filesystem == zfs ]]; then
        create_zfs
        set_zfs
    elif [[ $filesystem == btrfs ]]; then
        mkfs.btrfs -f -L btrfs $rootDrive
    elif [[ $filesystem == ext4 ]]; then
        mkfs.ext4 -L ext4 $rootDrive
    elif [[ $filesystem == xfs ]]; then
        mkfs.xfs -f -L xfs $rootDrive
    fi

    mount_root
    mount_boot
    install_base

}

create_zfs() {

    echo ">>> unloading ZFS modules"
    for i in zavl icp zlua znvpair spl zunicode zcommon zfs zzstd; do
        find /lib/modules -name $i.ko.gz | modprobe -r $i
    done
    echo ">>> loading ZFS modules"
    modprobe zfs
    echo ">>> checking ZFS modules"
    if ! lsmod | grep -qi zfs; then
       echo 'ERROR: ZFS modules are missing'
       setup_drive
    fi
    echo ">>> creating ZFS pool"
    zpool create -f -o ashift=9 -o autotrim=on \
    -o cachefile=/etc/zfs/zpool.cache \
    -O recordsize=8192 -O compression=lz4 -O acltype=posixacl -O dedup=off \
    -O devices=off -O xattr=sa -O relatime=off -O atime=off \
    -O dnodesize=legacy -O normalization=formD \
    -O canmount=noauto -O mountpoint=/ -R /mnt $pool $rootDrive
    echo ">>> checking ZFS pool"
    zpool status

}

set_zfs() {

    echo ">>> setting ZFS pool as rootfs"
    zpool set bootfs=$pool $pool
    echo ">>> setting ZFS cache"
    mkdir -p /mnt/etc/zfs/
    cp /etc/zfs/zpool.cache /mnt/etc/zfs/zpool.cache
    chmod a-w /mnt/etc/zfs/zpool.cache
    chattr +i /mnt/etc/zfs/zpool.cache
    echo ">>> adding ZFS options"
    mkdir -p /mnt/etc/modprobe.d/

    cat > /mnt/etc/modprobe.d/zfs.conf <<EOF
options zfs l2arc_noprefetch=0
options zfs l2arc_write_max=536870912
options zfs l2arc_write_boost=1073741824
options zfs l2arc_headroom=12
options zfs zfs_arc_max=536870912
options zfs zfs_arc_min=268435456
options zfs zfs_prefetch_disable=0
options zfs zfs_top_maxinflight=320
options zfs zfs_txg_timeout=15
options zfs zfs_vdev_scheduler=deadline
options zfs zfs_vdev_async_read_min_active=8
options zfs zfs_vdev_async_read_max_active=32
options zfs zfs_vdev_async_write_min_active=8
options zfs zfs_vdev_async_write_max_active=32
options zfs zfs_vdev_sync_write_min_active=8
options zfs zfs_vdev_sync_write_max_active=32
options zfs zfs_vdev_sync_read_min_active=8
options zfs zfs_vdev_sync_read_max_active=32
EOF

}

mount_root() {

    if grep -q zfs /root/list; then
        echo ">>> exporting zpool"
        zpool export $pool
        echo ">>> importing zpool"
        zpool import $pool -d $rootDrive -R /mnt/
        echo ">>> mounting zfs dataset"
        zfs mount -a
    else
        echo ">>> mounting root drive"
        mount $rootDrive /mnt/
    fi
    if ! mountpoint -q /mnt; then
        exit
    fi
    mkdir -p /mnt/boot/

}

mount_boot() {

    echo ">>> mounting boot drive"
    mount "$bootDrive" /mnt/boot/

}

install_base() {

    echo ">>> creating repositories"
    cat > /etc/apk/repositories <<EOF
$mirror/edge/main
$mirror/edge/community
$mirror/edge/testing
#$mirror/latest-stable/main
#$mirror/latest-stable/community
EOF

    echo ">>> installing alpine-base"
    apk add --root=/mnt/ --initdb alpine-base --keys-dir /etc/apk/keys --repositories-file /etc/apk/repositories

    echo ">>> copying repositories"
    cp /etc/apk/repositories /mnt/etc/apk/repositories

    echo ">>> creating /dev/null"
    rm /mnt/dev/null
    cp /dev/null /mnt/dev/null
    chmod 0666 /mnt/dev/null

    echo ">>> loading efi modules"
    modprobe efivarfs

    set_network
    set_fstab
    setup_linux

}

set_network() {

    echo ">>> adding name resolution"
    cat > /mnt/etc/resolv.conf <<EOF
nameserver 94.140.14.49
nameserver 94.140.14.59
EOF
    echo ">>> adding interfaces"
    cat > /mnt/etc/network/interfaces <<EOF
auto lo
iface lo inet loopback
EOF

}

set_fstab() {

    echo ">>> setting fstab"

    if grep -q zfs /root/list; then
        echo "$pool / $filesystem rw,nodev,noauto,xattr,zfsutil,posixacl 0 0" > /mnt/etc/fstab
    elif grep -q btrfs /root/list; then
        echo "$(blkid $rootDrive -o export | grep ^UUID=) / $filesystem rw,ssd,nofail,discard,noatime 0 0" > /mnt/etc/fstab
    else
        echo "$(blkid $rootDrive -o export | grep ^UUID=) / $filesystem rw.ssd,nofail,discard,noatime 0 0" > /mnt/etc/fstab
    fi

    echo "$(blkid "$bootDrive" -o export | grep ^UUID=) /boot vfat rw,noatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro 0 0" >> /mnt/etc/fstab

    if grep -q swapDrive /root/list; then
        echo "$(blkid $swapDrive -o export | grep ^UUID=) none swap sw 0 0" >> /mnt/etc/fstab
    fi

}

setup_linux() {

    install_linux
    install_packages
    set_timezone
    set_host
    change_root

}

install_linux() {

    if grep -q qemu /root/list; then
        list='linux-virt'
        if grep -q zfs /root/list; then
            list+=' zfs-virt'
        fi
    else
        list='linux-lts linux-edge'
        if grep -q zfs /root/list; then
            list+=' zfs-lts'
        fi
        list+=' amd-ucode intel-ucode'
        list+=' linux-firmware-intel'
        list+=' linux-firmware-i915'
        list+=' linux-firmware-amd'
        list+=' linux-firmware-amd-ucode'
        list+=' linux-firmware-amdgpu'
        list+=' linux-firmware-other'
        list+=' linux-firmware-rtlwifi'
        list+=' linux-firmware-rtl_bt'
        list+=' linux-firmware-rtl_nic'
        list+=' linux-pam'
    fi

    if grep -q zfs /root/list; then
        list+=' zfs zfs-openrc zfs-libs zfs-udev'
    fi

    echo ">>> installing linux"
    apk add --root=/mnt/ linux-firmware-none
    apk add --root=/mnt/ $list

}

install_packages() {

    echo ">>> packages list"
    packages_list

    list=''
    for p in ${packages[@]}; do
        list+="$p "
    done
    echo ">>> installing packages"
    apk add --root=/mnt/ $list
    apk fix --root=/mnt/

}

set_timezone() {

    echo ">>> setting timezone"
    if [ -f /mnt/usr/share/zoneinfo/$timezone ]; then
        install -Dm 0644 /mnt/usr/share/zoneinfo/$timezone /mnt/etc/localtime
        echo $timezone > /mnt/etc/timezone
    fi

}

set_host() {

    echo ">>> setting hostname"
    echo $hostname > /mnt/etc/hostname
    echo "127.0.0.1 localhost $hostname" > /mnt/etc/hosts
    echo "::1       localhost $hostname" >> /mnt/etc/hosts

}

change_root() {

    echo ">>> copying install script"
    cp /root/list /mnt/root/list
    cp /root/install.sh /mnt/root/install.sh

    echo ">>> changing root"
    echo '' > /mnt/root/chroot
    for d in proc dev sys sys/firmware/efi/efivars; do
        mount --bind /$d/ /mnt/$d/
    done
    chroot /mnt/ /bin/bash /root/install.sh

}

configure() {

    disable_root
    create_user
    setup_desktop

}

disable_root() {

    usermod -s /bin/bash root
    echo ">>> changing root password"
    echo -en "$password\n$password" | passwd root
    echo -en "$password\n$password" | passwd root
    echo ">>> disabling root login"
    passwd -l root
    echo ">>> disabling root password"
    passwd -d root

}

create_user() {

    if id $user &>/dev/null; then
        echo ">>> deleting $user"
        userdel $user
    fi
    echo ">>> adding wheel to sudo"
    sed -i 's|# %wheel ALL=(ALL:ALL) ALL|%wheel ALL=(ALL:ALL) ALL|' /etc/sudoers
    echo ">>> creating user"
    echo -en "$password\n$password" | adduser -h /home/$user -s /bin/bash -G wheel -g $user $user
    usermod -aG input,audio,video,netdev,usb,disk,lp,adm $user
    if grep -q zfs /root/list; then
        zfs allow $user create,mount,mountpoint,snapshot $pool
    fi
    mkdir -p $H/.config/autostart/

}

setup_desktop() {

    enable_services
    configure_alpine

    if grep -q server /root/list; then
        setup_mariadb
    fi

    if [ -f /etc/greetd/config.toml ]; then
        configure_greetd
    fi

    custom_kernel

    if grep -q zfs /root/list; then
        if ! grep qemu /root/list ; then
            build_zfs
        fi
    fi

    if ! grep -q qemu /root/list; then
        install_nvidia
    fi

    if ! grep server /root/list; then
        install_flatpak
    fi

    install_google_chrome

    if grep -q miner /root/list; then
        install_miner
    fi

    if ! grep -Eq "server|miner" /root/list; then
        create_iso
        openwrt
    fi

    make_initramfs

    if mountpoint -q /mnt/boot/; then
        setup_bootloader
    fi

}

services() {

    services="$1"
    run_level="$2"
    for i in $services[@]; do
        if [ -f /etc/init.d/$i ]; then
            rc-update -q add $i $run_level
        else
            echo "no service '$i'"
        fi
    done

}

enable_services() {

    echo ">>> enabling services"
    #openrc
    services 'procfs devfs dmesg hwdrivers modloop root' sysinit
    services 'modules cgroups mtab hwclock swap localmount sysctl hostname bootmisc networking local' boot
    service 'mount-ro killprocs savecache' shutdown
    #busybox
    services 'mdev' sysinit
    services 'syslog' boot
    services 'acpid crond' default
    #udev
    services 'udev udev-trigger udev-settle udev-postmount' sysinit
    #dbus
    services 'dbus' sysinit
    #lvm2
    services 'lvm' boot
    #zfs
    services 'zfs-mount' sysinit
    service 'zfs-import zfs-share zfs-zed zfs-load-key' boot
    #logind
    services 'elogind' default
    #polkit
    services 'polkit' default
    #networkmanager
    services 'networkmanager networkmanager-dispatcher' default
    #alsa
    services 'alsa' default
    #bluez
    services 'bluetooth bluealsa' default
    #firewall
    services 'ufw' default
    #rsync
    services 'rsyncd' default
    #wireless
    services 'iwd' default
    #firmware
    services 'fwupd' default
    #login-manager
    service 'seatd' boot
    services 'gdm greetd sddm' default
    #printer
    services 'cupsd' default
    #database
    services 'mariadb' default
    #web-server
    services 'litespeed' default
    #mail-server
    services 'postfix dovecot opendkim' default

}

configure_alpine() {

    echo ">>> configuring openRC"
    sed -i 's|#unicode=.*|unicode="YES"|' /etc/rc.conf
    sed -i 's|#rc_parallel=.*|rc_parallel="YES"|' /etc/rc.conf
    sed -i 's|#rc_interactive=.*|rc_interactive="NO"|' /etc/rc.conf
    sed -i 's|#rc_shell=.*|rc_shell=/bin/sh|' /etc/rc.conf
    sed -i 's|#rc_depend_strict=.*|rc_depend_strict="NO"|' /etc/rc.conf
    sed -i 's|#rc_logger=.*|rc_logger="YES"|' /etc/rc.conf
    sed -i 's|#rc_env_allow=.*|rc_env_allow="*"|' /etc/rc.conf
    sed -i 's|#rc_hotplug=.*|rc_hotplug="!net.*"|' /etc/rc.conf
    sed -i 's|#rc_send_sighup=.*|rc_send_sighup="YES"|' /etc/rc.conf
    sed -i 's|#rc_timeout_stopsec=.*|rc_timeout_Stopsec="0"|' /etc/rc.conf
    sed -i 's|#rc_send_sigkill=.*|rc_send_sigkill="YES"|' /etc/rc.conf
    sed -i 's|rc_tty_number=.*|rc_tty_number=0|' /etc/rc.conf

    echo ">>> configuring alpineLinux"
    if [ -f /etc/profile.d/color_prompt.sh.disabled ]; then
        mv /etc/profile.d/color_prompt.sh.disabled /etc/profile.d/color_prompt.sh
    fi

    if [ -d /etc/NetworkManager/ ]; then
        cat > /etc/NetworkManager/NetworkManager.conf <<EOF
[main]
dhcp=internal
plugins=ifupdown,keyfile
[ifupdown]
managed=true
[device]
wifi.backend=iwd
EOF
    fi

    echo ">>> setting locales"
    cat > /etc/profile.d/locale.sh <<EOF
LANG='en_US'
LANGUAGE=en_US:en
LC_NUMERIC='en_US'
LC_TIME='en_US'
LC_MONETARY='en_US'
LC_PAPER='en_US'
LC_MEASUREMENT='en_US'
EOF

    cat > /etc/default/locale <<EOF
LANG=en_US.UTF-8
EOF

    if ! grep -q snd_seq /etc/modules; then
        echo snd_seq >> /etc/modules
    fi

    echo ">>> configuring pipewire"
    mkdir -p $H/.config/pipewire/
    cp /usr/share/pipewire/*.conf $H/.config/pipewire/

    if [ ! -d /usr/share/icons/windows-11-icons/ ]; then
        echo ">>> cloning Windows-11-icons"
        git clone https://github.com/0free/windows-11-icons.git
        rm -r windows-11-icons/.git
        cp -rlf windows-11-icons/ /usr/share/icons/
        rm -r windows-11-icons/
    fi

    echo ">>> disabling IPv6"
    echo 'ipv6' >> /etc/modules
    echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.d/01-disable-ipv6.conf

    echo ">>> configuring firewall"
    sed -i 's|IPV6=yes|IPV6=no|' /etc/default/ufw
    sed -i 's|"DROP"|"REJECT"|g' /etc/default/ufw
    sed -i 's|ENABLED=no|ENABLED=yes|' /etc/ufw/ufw.conf

    if grep -q gnome /root/list; then
        if [ ! -f $H/dconf-settings.ini ]; then
            echo ">>> downloading gnome dconf-settings"
            curl -o $H/dconf-settings.ini -LO https://raw.githubusercontent.com/0free/alpine/1/dconf-settings.ini
            cat > /etc/profile.d/gnome.sh <<EOF
if [ -f ~/dconf-settings.ini ]; then
    dconf load / < ~/dconf-settings.ini
    rm ~/dconf-settings.ini
fi
EOF
        fi
    fi

    if grep -q kde /root/list; then
        if [ ! -d $H/.config/kde.org/ ]; then
            echo ">>> configuring kde"
            git clone https://github.com/0free/kde-settings.git
            cp -rlf /kde-settings/config/* $H/.config/
            rm -r kde-settings/
        fi
        mkdir -p /etc/sddm.conf.d/
    fi

    echo ">>> setting ~/"
    chown -R $user:wheel $H/
    chown -R $user:wheel $H/.config/
    chmod -R 700 $H/
    chmod -R 700 $H/.config/

}

setup_mariadb() {

    echo ">>> setting mariadb"
    mkdir -p /var/lib/mysql/
    chown -R mysql:mysql /var/lib/mysql/
    mkdir -p /var/log/mysql/
    chown -R mysql:mysql /var/log/mysql/
    /etc/init.d/mariadb setup
    /usr/bin/mysql_install_db --defaults-file=/mysql.cnf

}

configure_greetd() {

    echo ">>> configuring greetd"
    cat > /etc/wayfire.ini <<EOF
[autostart]
autostart_wf_shell = false
gtkgreet = /usr/bin/gtkgreet -l
[core]
plugins = autostart
vheight = 1
vwidth = 1
xwayland = true
EOF

    cat > /etc/greetd/config.toml <<EOF
[terminal]
vt = 1
[default_session]
command = "wayfire -c /etc/wayfire.ini"
user = "$user"
[initial_session]
command = "wayfire -c /etc/wayfire.ini"
user = "$user"
EOF

    cat > /etc/greetd/gtkgreet.css <<EOF
window {
   background-image: url("file:///usr/share/backgrounds/default.png");
   background-size: cover;
   background-position: center;
}

box#body {
   background-color: rgba(50, 50, 50, 0.5);
   border-radius: 10px;
   padding: 50px;
}
EOF

    gtkgreet -l -s /etc/greetd/gtkgreet.css

}

custom_kernel() {

    cat > /etc/profile.d/kernel.sh <<EOF
kernel() {
    echo ">>> installing required packages to build Linux kernel"
    depend='bc file fortify-headers g++ gcc kmod libc-dev patch
    remake-make ncurses-dev xz-libs libssl1.1 bc flex libelf
    bison pahole e2fsprogs jfsutils reiserfsprogs squashfs-tools
    btrfs-progs pcmciautils quota-tools ppp nfs-utils procps
    udev mcelog iptables openssl libcrypto cpio'
    apk add \$depend
    echo ">>> getting latest stable Linux kernel version"
    curl -o ~/Makefile -LO "git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Makefile"
    #curl -o ~/Makefile -LO "git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/Makefile"
    version=$(grep -E '^VERSION = ' ~/Makefile | grep -o '[0-9]{1,4}')
    patchLevel=$(grep -E '^PATCHLEVEL = ' ~/Makefile | grep -o '[0-9]{1,4}')
    subLevel=$(grep -E '^SUBLEVEL = ' ~/Makefile | grep -o '[0-9]{1,4}')
    extraVersion=$(grep -E '^EXTRAVERSION = ' ~/Makefile | grep -o '-rc[0-9]{1,2}')
    rm ~/Makefile
    kernel="\${version}.\${patchLevel}.\${subLevel}\${extraVersion}"
    if [[ \$extraVersion ]]; then
        url="git.kernel.org/torvalds/t/linux-\${version}.\${patchLevel}-\${extraVersion}.tar.gz"
    else
        url="cdn.kernel.org/pub/linux/kernel/v\${version}.x/linux-\$kernel.tar.xz"
    fi
    echo ">>> downloading Linux-\$kernel source"
    curl -o ~/linux-\$kernel.tar.xz -LO \$url
    echo ">>> extracting Linux-\$kernel source"
    tar -xf ~/linux-\kernel.tar.xz -C ~/
    echo ">>> deleting linux-\$kernel.tar.xz"
    rm ~/linux-\$kernel.tar.xz
    echo ">>> copying alpine linux kernel configuration"
    if [ -f /boot/config-virt ]; then
        cp /boot/config-virt ~/linux-\$kernel/.config
    elif [ -f /boot/config-edge ]; then
        cp /boot/config-edge ~/linux-\kernel/.config
    else
        cp /boot/config-lts ~/linux-\$kernel/.config
    fi
    sed -i 's|CONFIG_LOCALVERSION=.*|CONFIG_LOCALVERSION=""|' ~/linux-\$kernel/.config
    sed -i 's|CONFIG_DEFAULT_HOSTNAME=.*|CONFIG_DEFAULT_HOSTNAME=""|' ~/linux-\$kernel/.config
    echo ">>> configuring Linux-\$kernel"
    cd ~/linux-\$kernel/ && make -j$(nproc) xconfig
    echo ">>> making Linux kernel"
    cd ~/linux-\$kernel/ && make -j$(nproc)
    echo ">>> installing modules"
    cd ~/linux-\$kernel/ && make -j$(nproc) modules_install
    cd ~
    echo ">>> installing Linux-\$kernel"
    installkernel \$kernel ~/linux-\$kernel/arch/x86/boot/bzImage ~/linux-\$kernel/System.map /boot/
    if [ -f /boot/vmlinuz ]; then
        echo ">>> building linux-\$kernel initial ramdisk"
        mkinitfs -b / -c /etc/mkinitfs/mkinitfs.conf -f /etc/fstab -o /boot/initramfs \$kernel
    fi
    echo ">>> deleting Linux-\$kernel source"
    rm -r ~/Linux-\$kernel/
    echo ">>> cleaning packages"
    apk del \$depend
}
EOF

}

build_zfs() {

    version=$(apk search -e zfs-src)
    cat > /etc/profile.d/zfs.sh <<EOF
version='$version'
zfs-install() {
    if ! grep -q \$(apk search -e zfs-src) /etc/profile.d/zfs.sh; then
        echo ">>> installing zfs-src"
        depend='akms zfs-src installkernel fortify-headers libc-dev
        patch remake-make ncurses-dev xz-libs libssl1.1 bc flex libelf
        bison autoconf automake libtool gawk alien fakeroot dkms
        libblkid-dev uuid-dev libudev-dev libssl-dev zlib1g-dev libaio-dev
        libattr1-dev libelf-dev python3 python3-dev python3-setuptools
        python3-cffi libffi-dev python3-packaging libcurl4-openssl-dev'
        apk add \$depend
        echo ">>> building zfs-src"
        cd /usr/src/zfs/ && sh autogen.sh
        cd /usr/src/zfs/ && ./configure
        cd /usr/src/zfs/ && make -s -j"$(nproc)"
        cd /usr/src/zfs/ && make install
        cd /usr/src/zfs/ && ldconfig
        cd /usr/src/zfs/ && depmod
        cd /root/
        echo '>>> building kernel modules'
        kernel_edge=$(apk search -e linux-edge | sed 's|linux-edge-||' | sed 's|r||')-edge)
        sudo akms install -k \$kernel_edge all
        sudo sed -i "s|^version='.*'|version='\$(apk search -e zfs-src)'|" /etc/profile.d/zfs.sh
        echo ">>> cleaning packages"
        apk del \$depend
    fi
}
EOF

}

install_nvidia() {

    version=$(apk search -e nvidia-src)
    cat > /etc/profile.d/nvidia.sh <<EOF
version='$version'
nvidia() {
    if find /lib/modules/ -type f -name nvidia.ko.gz | grep -q nvidia; then
        if grep -q \$(apk search -e nvidia-src) /etc/profile.d/nvidia.sh; then
            echo ">>> nvidia driver is up-to-date"
        else
            install_modules
        fi
    else
        install_modules
    fi
}
install_modules() {
    echo ">>> installing nvidia-src"
    depend='nvidia-src akms linux-lts-dev linux-edge-dev'
    apk add \$depend 
    echo '>>> building kernel modules'
    sudo akms install all
    sudo sed -i "s|^version='.*'|version='\$(apk search -e nvidia-src)'|" /etc/profile.d/nvidia.sh
    echo ">>> cleaning packages"
    apk del \$depend
}
EOF

}

install_flatpak() {

    echo ">>> installing flatpak"
    apk add flatpak flatpak-bash-completion xdg-user-dirs
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    adduser $user flatpak

    cat > /etc/profile.d/flatpak.sh <<EOF
flatpak-update() {
    sudo flatpak update -y
    sudo flatpak uninstall -y --unused
}
EOF

    echo ">>> installing google-chrome from flathub"
    flatpak install -y flathub com.google.Chrome
    echo ">>> adding access to google-chrome"
    flatpak override com.google.Chrome --filesystem=/home/
    flatpak override com.google.Chrome --filesystem=/run/media/

}

install_google_chrome() {

    echo ">>> installing google-chrome dependencies"
    depend='alsa-lib ca-certificates alsa-lib aom-libs at-spi2-core
    brotli-libs cairo cups-libs dbus-libs eudev-libs ffmpeg-libs
    flac-libs font-liberation font-opensans fontconfig freetype glib
    gtk+3.0 harfbuzz icu-libs jsoncpp lcms2 libatk-1.0 libatk-bridge-2.0
    libatomic libcurl libc6-compat libdav1d libdrm libevent libexpat
    libgcc libglibutil libjpeg-turbo libpng libpulse libstdc++ libwebp
    libwoff2enc libx11 libxcb libxcomposite libxdamage libxext libxfixes
    libxkbcommon libxml2 libxrandr libxscrnsaver libxtst libxslt
    libwoff2common mesa-gbm minizip nspr nss opus pango pipewire-libs
    re2 snappy vulkan-loader wayland-libs-client xdg-utils wget zlib'
    apk add $depend

    echo ">>> installing google-signing-key"
    curl -o $H/google-key.pub -LO https://dl.google.com/linux/linux_signing_key.pub
    gpg --batch --import $H/google-key.pub
    rm $H/*.pub

    url='https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'

    echo ">>> downloading google-chrome-stable"
    curl -o $H/google-chrome.deb -LO $url

    echo ">>> installing google-chrome"
    ar -x $H/google-chrome.deb data.tar.xz
    rm $H/google-chrome.deb
    tar -xf $H/data.tar.xz ./opt/
    tar -xf $H/data.tar.xz ./usr/share/applications/google-chrome.desktop
    mv $H/opt/google/ /opt/
    rm -r /opt/google/chrome/cron/
    mv $H/usr/share/applications/google-chrome.desktop /usr/share/applications/
    rm -r $H/opt/
    rm -r $H/usr/
    chown -R root:root /opt/
    ln -s /opt/google/chrome/chrome /usr/bin/google-chrome-stable

    echo ">>> configuring google-chrome"
	for i in 16x16 24x24 32x32 48x48 64x64 128x128 256x256; do
		install -Dm644 /opt/google/chrome/product_logo_${i/x*/}.png /usr/share/icons/hicolor/$i/apps/google-chrome.png
	done
    sudo rm /opt/google/chrome/product_logo_*.png

    version=$(curl -s -o /dev/null $url | head -c96 | cut -c 5-)

    cat > /etc/profile.d/google-chrome.sh <<EOF
version='$version'
url='$url'
google-update() {
    current=\$(curl -s \$url | head -c96 | cut -c 5-)
    if grep -q \$current /etc/profile.d/google-chrome.sh; then
        echo ">>> google-chrome is up-to-date"
    else
        echo ">>> downloading latest google-chrome-stable"
        curl -o ~/google-chrome.deb -LO \$url
        echo ">>> updating google-chrome"
        ar -x ~/google-chrome.deb data.tar.xz
        rm ~/google-chrome.deb
        tar -xf ~/data.tar.xz ./opt/
        sudo mv ~/opt/google/ /opt/
        rm -r ~/opt/
        sudo chown -R root:root /opt/
        sudo sed -i "s|^version='.*'|version='\$current'|" /etc/profile.d/google-chrome.sh
        XDG_ICON_RESOURCE=\$(which xdg-icon-resource 2> /dev/null || true)
        for icon in /opt/google/chrome/product_logo_*.png; do
            size="\${icon##*/product_logo_}"
            \$XDG_ICON_RESOURCE install --size \${size%%.png} \$icon 'google-chrome'
        done
        sudo rm /opt/google/chrome/product_logo_*.png
    fi
}
EOF

}

install_miner() {

    echo ">>> getting T-Rex latest release from github"
    version=$(curl -s https://api.github.com/repos/trexminer/T-Rex/releases/latest | grep '"tag_name":' | sed -E 's|.*"([^"]+)".*|\1|')

    if [ ! -f /usr/bin/t-rex ]; then
        echo ">>> downloading T-Rex $version"
        curl -o /root/trex.tar.gz -LO trex-miner.com/download/t-rex-$version-linux.tar.gz
        echo ">>> extracting T-Rex $version"
        tar -zxf /root/trex.tar.gz t-rex -C /usr/bin/
        echo ">>> deleting T-Rex file"
        rm /root/trex.tar.gz
    fi

    if grep -q gnome /root/list; then
        cat > $H/.config/autostart/terminal.desktop <<EOF
[Desktop Entry]
Name=terminal
Type=Application
Exec=gnome-terminal -e t-rex -c ~/config
X-GNOME-Autostart-enabled=true
EOF
    fi

    if grep -q kde /root/list; then
        cat > $H/.config/autostart/konsole.desktop <<EOF
[Desktop Entry]
Name=konsole
Type=Application
Exec=konsole -e t-rex -c ~/config
EOF
    fi

    sudo chmod +x $H/.config/autostart/*.desktop

    cat > /etc/profile.d/trex.sh << EOF
version='$version'
trex() {
    if curl -s -o /dev/null alpinelinux.org; then
        if [ ! -f ~/config ]; then
            echo ">>> downloading t-rex config file"
            curl -o ~/config -LO https://raw.githubusercontent.com/0free/t-rex/\$version/config
        fi
        update
        /usr/bin/t-rex -c ~/config
        xdg-open 127.0.0.1:8080
    fi
}
update_trex() {
    latest=\$(curl -s https://api.github.com/repos/trexminer/T-Rex/releases/latest | grep '"tag_name":' | sed -E 's|.*"([^"]+)".*|\1|')
    if ! grep -q \$latest <<< \$version; then
        echo ">>> downloading T-Rex \$latest"
        curl -o ~/trex.tar.gz -LO trex-miner.com/download/t-rex-\$latest-linux.tar.gz
        echo ">>> extracting T-Rex \$latest"
        sudo tar -zxf trex.tar.gz t-rex -C /usr/bin/
        sudo sed -Ei "s|^version='.*'|version='\$latest'|" /etc/prfile.d/trex.sh
        echo ">>> deleting T-Rex file"
        rm ~/trex.tar.gz
    fi
}
EOF

}

create_iso() {

    echo "adding iso script"
    cat > /etc/profile.d/iso.sh << EOF
iso() {
    if curl -s -o /dev/null alpinelinux.org; then
        curl -o ~/iso.sh -LO https://raw.githubusercontent.com/0free/alpine/1/iso.sh
        sh ~/iso.sh
    fi
}
EOF

}

openwrt() {

    echo ">>> adding openwrt script"
    version=$(apk search -e musl-dev)
    cat > /etc/profile.d/openwrt.sh << EOF
version='$version'
openwrt() {
    if curl -s -o /dev/null alpinelinux.org; then
        sudo apk add gcc g++ argp-standalone musl-dev musl-fts-dev musl-obstack-dev musl-libintl rsync tar libcap-dev gzip && sudo sed -i 's|.*sudo apk.*||' /etc/profile.d/openwrt.sh
        if ! grep -q \$(apk search -e musl-dev) /etc/profile.d/openwrt.sh; then
            sudo sed -i 's|calloc|xcalloc|g' /usr/include/sched.h
            sudo sed -i "s|^version='.*'|version='\$(apk search -e musl-dev)'|" /etc/profile.d/openwrt.sh
        fi
        if [ -d ~/openwrt ]; then
            cd ~/openwrt && git pull
            ./scripts/feeds update -a
            ./scripts/feeds install -a
            make menuconfig
            make -j$(nproc)
        else
            git clone -b master https://git.openwrt.org/openwrt/openwrt.git
            echo "src-git-full packages https://git.openwrt.org/feed/packages.git" > ~/openwrt/feeds.conf
            echo "src-git-full luci https://git.openwrt.org/project/luci.git" >> ~/openwrt/feeds.conf
            openwrt
        fi
    fi
}
EOF

}

make_initramfs() {

    echo ">>> installing mkinitfs"

    modules=(base ata nvme ide scsi usb lvm keymap virtio kms mmc)

    if grep -q zfs /root/list; then
        modules+=(zfs)
    fi
    if grep -q btrfs /root/list; then
        modules+=(btrfs)
    fi
    if grep -q xfs /root/list; then
        modules+=(xfs)
    fi
    if grep -q ext4 /root/list; then
        modules+=(ext4)
    fi

    if grep -q qemu /root/list; then
        modules+=(vboxvideo virtio-gpu vmvga vmwgfx)
    else
        modules+=(intel_agp i915)
        modules+=(amdgpu)
        modules+=(nvidia nvidia_modeset nvidia_uvm nvidia_drm nvidia_peermem)
    fi

    list=''
    for m in ${modules[@]}; do
        list+="$m "
    done

    echo ">>> configuring mkinitfs"
    echo "features=\"$list\"" > /etc/mkinitfs/mkinitfs.conf

    for k in $(ls /lib/modules/); do
        echo ">>> building linux-$k initial ramdisk"
        mkinitfs -b / -c /etc/mkinitfs/mkinitfs.conf -f /etc/fstab -o /boot/initramfs-$(echo $k | sed 's|[0-9.-]||g') $k
    done

    mkdir -p /boot/efi/

}

setup_bootloader() {

    find_windows

    param="rootfstype=$filesystem rw loglevel=0 quiet mitigations=off modules=sd-mod,usb-storage amd_iommu=on amd_iommu=pt intel_iommu=on intel_iommu=pt"

    if grep -q zfs /root/list; then
        disk="root=$pool $param"
    else
        disk="root=$(blkid $rootDrive -o export | grep ^UUID=) $param"
    fi

    if [ -f /usr/libexec/fwupd/efi/fwupdx64.efi ]; then
        firmware_update
    fi

    if grep -q gummiboot /root/list; then
        install_gummiboot
    elif grep -q syslinux /root/list; then
        install_syslinux
    elif grep -q grub /root/list; then
        install_grub
    elif grep -q rEFInd /root/list; then
        install_refind
    elif grep -q clover /root/list; then
        install_clover
    fi

    finish

}

find_windows() {

    echo ">>> looking for Windows"
    drives=($(ls /dev/ | grep -E '^nvme[0-9]n[1-9]$|^sd[a-z]$'))
    for d in ${drives[@]}; do
        if ls /dev/ | grep -Eq "$d.*p1|$d.*1"; then
            partitions=($(ls /dev/ | grep -E "$d.*p1|$d.*1"))
            for p in ${partitions[@]}; do
                p=/dev/$p
                if ! df | grep -q $p; then
                    if [[ $p != $bootDrive ]]; then
                        mkdir -p /windows/
                        mount -r $p /windows/
                        if [ -f /windows/EFI/Microsoft/Boot/BCD ]; then
                            echo ">>> copying Windows Boot Manager"
                            cp -rlf /windows/* /boot/
                            windowsDrive=$d
                            windowsBoot=$p
                            echo "windowsDrive=$d" >> /root/list
                            echo "windowsBoot=$p" >> /root/list
                        fi
                        umount /windows/
                        if [ -d /windows/ ]; then
                            rm -r /windows/
                        fi
                    fi
                fi
            done
        fi
    done

}

firmware_update() {

    mkdir -p /boot/efi/fwupd/
    cp /usr/libexec/fwupd/efi/fwupdx64.efi /boot/efi/fwupd/
    version=$(apk search -e fwupd)
    cat > /etc/profile.d/fwupd.sh <<EOF
version='$version'
update-firmware() {
    latest=\$(apk search -e fwupd)
    if ! grep -q \$latest /etc/profile.d/fwupd.sh; then
        sudo cp /usr/libexec/fwupd/efi/fwupdx64.efi /boot/efi/fwupd/
        sudo sed -i "s|^version='.*'|version='\$latest'|" /etc/profile.d/fwupd.sh
    fi
}
EOF

}

install_gummiboot() {

    echo ">>> installing gummiboot"
    apk add gummiboot

    mkdir -p /boot/efi/alpineLinux/
    cp /usr/lib/gummiboot/gummibootx64.efi	/boot/efi/alpineLinux/bootx64.efi

    efibootmgr -c -d $drive -p 1 -t 0 -L 'alpineLinux' -l '\EFI\alpineLinux\bootx64.efi'

    mkdir -p /boot/loader/entries/

    echo ">>> configuring gummiboot"
    cat > /boot/loader/loader.conf <<EOF
default linux.conf
timeout 1
console-mode auto
EOF

    echo ">>> adding entries to gummiboot"
    if [[ $windowsDrive ]]; then
        cat > /boot/loader/entries/windows.conf <<EOF
title       Windows
initrd      /EFI/Microsoft/Boot/BOOTMGFW.EFI
options     'root=$(blkid $windowsBoot -o export | grep ^UUID=)'
EOF
    fi
    if [ -f /boot/initramfs ]; then
        cat > /boot/loader/entries/linux.conf <<EOF
title       Linux-$kernel
linux       /vmlinuz
initrd      /amd-ucode.img
initrd      /intel-ucode.img
initrd      /initramfs
options     $disk
EOF
    fi
    if [ -f /boot/initramfs-virt ]; then
        cat > /boot/loader/entries/linux-virt.conf <<EOF
title       alpine Linux virt
linux       /vmlinuz-virt
initrd      /initramfs-virt
options     $disk
EOF
    fi
    if [ -f /boot/initramfs-edge ]; then
        cat > /boot/loader/entries/linux-edge.conf <<EOF
title       alpine Linux edge
linux       /vmlinuz-edge
initrd      /amd-ucode.img
initrd      /intel-ucode.img
initrd      /initramfs-edge
options     $disk
EOF
    fi
    if [ -f /boot/initramfs-lts ]; then
        cat > /boot/loader/entries/linux-lts.conf <<EOF
title       alpine Linux LTS
linux       /vmlinuz-lts
initrd      /amd-ucode.img
initrd      /intel-ucode.img
initrd      /initramfs-lts
options     $disk
EOF
    fi

    if [ -f /boot/fwupd/efi/fwupdx64.efi ]; then
        echo ">>> adding fwupd to gummiboot"
        cat > /boot/loader/entries/fwupd.conf <<EOF
title       firmware-update
efi         /efi/fwupd/fwupdx64.efi
EOF
    fi

    version=$(apk search -e gummiboot)
    cat > /etc/profile.d/gummiboot.sh <<EOF
version='$version'
gummiboot() {
    latest=\$(apk search -e gummiboot)
    if ! grep -q \$latest /etc/profile.d/gummiboot.sh; then
        sudo cp /usr/lib/gummiboot/gummibootx64.efi	/boot/efi/alpineLinux/bootx64.efi
        sudo sed -i "s|^version='.*'|version='\$latest'|" /etc/profile.d/gummiboot.sh
    fi
}
EOF

}

install_syslinux() {

    echo ">>> installing syslinux"
    apk add syslinux
    extlinux --install /boot
    dd bs=440 conv=notrunc count=1 if=/usr/share/syslinux/gptmbr.bin of=$drive

    mkdir -p /boot/efi/syslinux/
    cp /usr/share/syslinux/efi64/* /boot/efi/syslinux/
    mv /boot/efi/syslinux/*.efi /boot/efi/syslinux/bootx64.efi

    echo ">>> configuring extlinux"
    sed -i "s|overwrite=1|overwrite=0|" /etc/update-extlinux.conf
    sed -i "s|root=.*|root=$(blkid $rootDrive -o export | grep ^UUID=)|" /etc/update-extlinux.conf

    cat > /boot/extlinux.conf <<EOF
timeout 1
prompt 1
MENU TITLE 'a l p i n e  L i n u x'
MENU AUTOBOOT 'booting in # seconds'
default 'alpineLinux LTS'
EOF

    if [ -f /boot/vmlinuz-virt ]; then
        cat >> /boot/extlinux.conf <<EOF
label 'alpineLinux virt'
      linux /vmlinuz-virt
      initrd /initramfs-virt
      append $disk
EOF
    fi
    if [ -f /boot/vmlinuz-edge ]; then
        cat >> /boot/extlinux.conf <<EOF
label 'alpineLinux edge'
      linux /vmlinuz-edge
      initrd /initramfs-edge
      append $disk
EOF
    fi
    if [ -f /boot/vmlinuz-lts ]; then
        cat >> /boot/extlinux.conf <<EOF
label 'alpineLinux LTS'
      linux /vmlinuz-lts
      initrd /initramfs-lts
      append $disk
EOF
    fi

    cp /boot/extlinux.conf /boot/efi/syslinux/syslinux.cfg

}

install_grub() {

    echo ">>> installing grub package"
    apk fix
    apk add grub grub-efi grub-bash-completion
    echo ">>> installing grub bootloader"
    grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id="alpine linux" $drive

    mkdir -p /boot/grub/themes

    if [ ! -d /boot/grub/themes/grub-theme/ ]; then
        echo ">>> cloning grub-theme"
        git clone https://github.com/0free/grub-theme.git
        rm -r grub-theme/.git/
        mv grub-theme/ /boot/grub/themes/
    fi

    sed -i "s|CLASS=\".*\"|CLASS=\"--class \$( . /etc/os-release; echo \"$ID\")\"|" /etc/grub.d/10_linux
    sed -i "s|menuentry \'\$LABEL\'|menuentry \'\$LABEL\' --class efi|" /etc/grub.d/30_uefi-firmware

    cat > /etc/default/grub <<EOF
loglevel=0
GRUB_DEFAULT=0
GRUB_TIMEOUT=1
GRUB_SAVEDEFAULT=true
GRUB_DISABLE_RECOVERY=true
GRUB_THEME="/boot/grub/themes/grub-theme/theme.txt"
GRUB_DISABLE_OS_PROBER=false
GRUB_DISABLE_SUBMENU=y
GRUB_CMDLINE_LINUX_DEFAULT=""
GRUB_CMDLINE_LINUX=""
GRUB_GFXMODE=1280x720,1920x1080,auto
EOF

    sed -i "s|GRUB_CMDLINE_LINUX=\"\"|GRUB_CMDLINE_LINUX=\"$disk\"|" /etc/default/grub

    list='search'
    list+=' msdospart part_msdos part_gpt part_apple'
    list+=' usb usb_keyboard'
    list+=' linux chain btrfs xfs fat exfat ntfs'
    list+=' gfxterm gfxmenu'

    if grep -q zfs /root/list; then
        list+=' zfs zfscrypt zfsinfo'
        sed -i "s|rpool=.*|rpool=$pool|" /etc/grub.d/10_linux
        sed -i 's|stat -f -c %T /|echo zfs|' /usr/sbin/grub-mkconfig
    fi

    echo "GRUB_PRELOAD_MODULES=\"$list\"" >> /etc/default/grub

    echo ">>> making grub config"
    grub-mkconfig -o /boot/grub/grub.cfg

    echo ">>> checking grub-probe"
    grub-probe /
    grub-probe -t fs -d $rootDrive
    grub-probe -t fs_label -d $rootDrive

    echo ">>> creating Windows efi record"
    efibootmgr -c -d $windowsDrive -p 1 -t 0 -L "Windows" -l '\EFI\Boot\BOOTX64.EFI'

}

install_refind() {

    echo ">>> installing rEFInd bootloader"
    apk add refind
    refind-install --root /boot
    cp /boot/efi/refind/refind_x64.efi /boot/efi/refind/bootx64.efi

    if [ ! -d /boot/efi/refind/drivers_x64/ ]; then
        mkdir -p /boot/efi/refind/drivers_x64/
        echo ">>> copying rEFInd drivers"
        cp /usr/share/refind/drivers_x86_64/*.efi /boot/efi/refind/drivers_x64/
        echo ">>> downloading efifs drivers"
        version=$(curl -s https://api.github.com/repos/pbatard/efifs/releases/latest | grep '"tag_name":' | sed -E 's|.*"([^"]+)".*|\1|')
        curl -o /boot/efi/refind/drivers_x64/xfs_x64.efi -LO https://github.com/pbatard/efifs/releases/download/$version/xfs_x64.efi
        curl -o /boot/efi/refind/drivers_x64/zfs_x64.efi -LO https://github.com/pbatard/efifs/releases/download/$version/zfs_x64.efi
    fi

    echo ">>> configuring rEFInd bootloader"

    if [[ $windowsDrive ]]; then
        uuid=$(blkid $windowsBoot -o export | grep ^UUID= | sed 's|UUID=||')
        cat >> /boot/efi/refind/refind.conf <<EOF
menuentry "Windows Boot Manager" {
    icon \EFI\refind\icons\os_win8.png
    volume $uuid
    loader \EFI\Boot\BOOTX64.EFI
    options ''
}
menuentry "Windows Boot" {
    icon \EFI\refind\icons\os_win8.png
    volume $uuid
    loader \EFI\Microsoft\Boot\BOOTMGFW.EFI
    options ''
}
menuentry "Windows 11" {
    icon \EFI\refind\icons\os_win8.png
    volume $uuid
    loader \Windows\Boot\EFI\bootmgfw.efi
    options ''
}
EOF
    fi

    uuid=$(blkid "$bootDrive" -o export | grep ^UUID= | sed 's|UUID=||')

    if [ -f /boot/initramfs-virt ]; then
        cat >> /boot/efi/refind/refind.conf <<EOF
menuentry "alpine Linux VirtualMachine" {
    icon /EFI/refind/icons/os_linux.png
    volume $uuid
    loader /vmlinuz-virt
    initrd /initramfs-virt
    options $disk
}
EOF
    fi

    if [ -f /boot/initramfs ]; then
        cat >> /boot/efi/refind/refind.conf <<EOF
menuentry "alpine Linux" {
    icon /EFI/refind/icons/os_linux.png
    volume $uuid
    loader /vmlinuz
    initrd /initramfs
    options "$disk initrd=/amd-ucode.img initrd=/intel-ucode.img"
}
EOF
    fi

    if [ -f /boot/initramfs-virt ]; then
        cat >> /boot/efi/refind/refind.conf <<EOF
menuentry "alpine Linux virt" {
    icon /EFI/refind/icons/os_linux.png
    volume $uuid
    loader /vmlinuz-virt
    initrd /initramfs-virt
    options "$disk initrd=/amd-ucode.img initrd=/intel-ucode.img"
}
EOF
    fi

    if [ -f /boot/initramfs-edge ]; then
        cat >> /boot/efi/refind/refind.conf <<EOF
menuentry "alpine Linux edge" {
    icon /EFI/refind/icons/os_linux.png
    volume $uuid
    loader /vmlinuz-edge
    initrd /initramfs-edge
    options "$disk initrd=/amd-ucode.img initrd=/intel-ucode.img"
}
EOF
    fi

    if [ -f /boot/initramfs-lts ]; then
        cat >> /boot/efi/refind/refind.conf <<EOF
menuentry "alpine Linux LTS" {
    icon /EFI/refind/icons/os_linux.png
    volume $uuid
    loader /vmlinuz-lts
    initrd /initramfs-lts
    options "$disk initrd=/amd-ucode.img initrd=/intel-ucode.img"
}
EOF
    fi

    sed -i 's|timeout 20|timeout 2|' /boot/efi/refind/refind.conf
    sed -i 's|#loglevel 1|loglevel 0|' /boot/efi/refind/refind.conf
    sed -i 's|#enable_mouse|enable_mouse|' /boot/efi/refind/refind.conf
    sed -i 's|#mouse_size 16|mouse_size 16|' /boot/efi/refind/refind.conf
    sed -i 's|#mouse_speed 4|mouse_speed 4|' /boot/efi/refind/refind.conf
    sed -i 's|#use_graphics_for .*|use_graphics_for osx,linux,windows|' /boot/efi/refind/refind.conf
    sed -i 's|#scan_driver_dirs .*|scan_driver_dirs EFI/refind/drivers_x64|' /boot/efi/refind/refind.conf
    sed -i 's|#scanfor|scanfor|' /boot/efi/refind/refind.conf
    sed -i 's|#extra_kernel_version_strings |extra_kernel_version_strings linux-edge,linux-virt,|' /boot/efi/refind/refind.conf

}

install_clover() {

    if [ ! -d CloverBootLoader/ ]; then
        echo ">>> cloning CloverBootLoader"
        git clone https://github.com/0free/CloverBootLoader.git
        rm -r CloverBootLoader/.git/
        echo ">>> copying clover bootloader"
        mkdir -p /boot/efi/clover/
        cp -rlf CloverBootLoader/* /boot/efi/clover/
        rm -r CloverBootLoader/
        echo ">>> downloading efifs drivers"
        version=$(curl -s https://api.github.com/repos/pbatard/efifs/releases/latest | grep '"tag_name":' | sed -E 's|.*"([^"]+)".*|\1|')
        curl -o /boot/efi/clover/drivers/off/btrfs_x64.efi -LO https://github.com/pbatard/efifs/releases/download/$version/btrfs_x64.efi
        curl -o /boot/efi/clover/drivers/off/ntfs_x64.efi -LO https://github.com/pbatard/efifs/releases/download/$version/ntfs_x64.efi
        curl -o /boot/efi/clover/drivers/off/xfs_x64.efi -LO https://github.com/pbatard/efifs/releases/download/$version/xfs_x64.efi
        curl -o /boot/efi/clover/drivers/off/zfs_x64.efi -LO https://github.com/pbatard/efifs/releases/download/$version/zfs_x64.efi
    fi

}

custom_commands() {

    echo ">>> adding custom commands"
    cat > /etc/profile.d/colors.sh <<EOF
export color_black='\e[0;30m'
export color_gray='\e[1;30m'
export color_red='\e[0;31m'
export color_light_red='\e[1;31m'
export color_green='\e[0;32m'
export color_light_green='\e[1;32m'
export color_brown='\e[0;33m'
export color_yellow='\e[1;33m'
export color_blue='\e[0;34m'
export color_light_blue='\e[1;34m'
export color_purple='\e[0;35m'
export color_light_purple='\e[1;35m'
export color_cyan='\e[0;36m'
export color_light_cyan='\e[1;36m'
export color_light_gray='\e[0;37m'
export color_white='\e[1;37m'
EOF
    cat > /etc/profile.d/commands.sh <<EOF
export PS1=' \[color_yellow\]shell: \[color_blue\]$SHELL \[color_red\]| \[color_yellow\]user: \[color_cyan\]\u \[color_red\]| \[color_yellow\]host: \[color_light_cyan\]\h \[color_red\]| \[color_yellow\]dir: \[color_purple\]\w\n \[color_red\]> \[color_gray\]'
export QT_IM_MODULE=ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
search() {
    apk search
}
install() {
    sudo apk add
}
remove() {
    sudo apk del
}
disk() {
    lsblk -o name,type,mountpoints,size,fsused,fsuse%,uuid,model
}
clean() {
    sudo rm -rf /var/tmp/*
    find / ! -path /sys/kernel ! -prune \( -iname readme -o -iname *.md -o -iname readme.txt -o -iname license -o -iname license.txt -o -iname *.license -o -iname *.docbook \) -type f -exec rm {} \;
EOF

    if grep -Eq 'grup|syslinux' /root/list; then
        cat > /etc/profile.d/commands.sh <<EOF
}
EOF
    else
        cat > /etc/profile.d/commands.sh <<EOF
    sudo apk del grub* syslinux* *-doc
}
EOF
    fi

    if [ -f /usr/bin/yt-dlp ]; then
    cat >> /etc/profile.d/commands.sh <<EOF
youtube() {
    yt-dlp -o '~/%(title)s.%(ext)s' -f 'bv[vcodec~="^((he|a)vc|h26[45])"][height<=1080][fps<=60]+ba' --merge-output-format mp4 --downloader ffmpeg --external-downloader ffmpeg --external-downloader-args ffmpeg:'-ss 00:00:00 -to 03:00:00'
}
EOF
    fi

    cat >> /etc/profile.d/commands.sh <<EOF
update() {
    if curl -s -o /dev/null alpinelinux.org; then
        echo ">>> updating alpineLinux packages"
        if [ -f /lib/apk/db/lock ]; then
            sudo rm /lib/apk/db/lock
        fi
        sudo apk fix
        sudo apk update
        sudo apk upgrade
EOF

    if [ -f /etc/profile.d/flatpak.sh ]; then
        cat >> /etc/profile.d/commands.sh <<EOF
        flatpak-update
EOF
    fi

    if [ -f /etc/profile.d/google-chrome.sh ]; then
        cat >> /etc/profile.d/commands.sh <<EOF
        google-update
EOF
    fi

    if [ -f /etc/profile.d/zfs.sh ]; then
        cat >> /etc/profile.d/commands.sh <<EOF
        zfs-install
EOF
    fi

    if [ -f /etc/profile.d/nvidia.sh ]; then
        cat >> /etc/profile.d/commands.sh <<EOF
        nvidia
EOF
    fi

    if [ -f /etc/profile.d/trex.sh ]; then
        cat >> /etc/profile.d/commands.sh <<EOF
        update_trex
EOF
    fi

    if [ -f /etc/profile.d/gummiboot.sh ]; then
        cat >> /etc/profile.d/commands.sh <<EOF
        gummiboot
EOF
    fi

    if [ -f /usr/bin/fwupdmgr ]; then
        cat >> /etc/profile.d/commands.sh <<EOF
        fwupdmgr get-devices
        fwupdmgr refresh
        fwupdmgr get-updates
        fwupdmgr update
EOF
    fi

    if [ -f /etc/profile.d/fwupd.sh ]; then
        cat >> /etc/profile.d/commands.sh <<EOF
        update-firmware
EOF
    fi

    cat >> /etc/profile.d/commands.sh <<EOF
    fi
}
EOF

}

finish() {

    custom_commands

    echo ">>> cleaning packages"
    apk del *-doc
    if ! grep -q syslinux /root/list; then
        apk del syslinux*
    fi
    if ! grep -q grub /root/list; then
        apk del grub*
    fi
    echo ">>> cleaning files"
    rm -rf /var/tmp/*
    find / ! -path /sys/kernel ! -prune \( -iname readme -o -iname *.md -o -iname readme.txt -o -iname license -o -iname license.txt -o -iname *.license -o -iname *.docbook \) -type f -exec rm {} \;

    echo ">>> installation is completed"
    cp /root/list /reboot
    exit

}

set -e

if [ -f /mnt/lib/apk/db/lock ]; then
    rm /mnt/lib/apk/db/lock
fi

if [ -f /mnt/reboot ]; then
    echo ">>> cleaning /root/"
    rm -rf /mnt/root/.*
    rm -rf /mnt/root/*
    echo ">>> un-mounting"
    for d in /mnt/boot/ /mnt/sys/ /mnt/dev/ /mnt/proc/; do
        if mountpoint -q $d; then
            umount -Rfl $d
        fi
    done
    if grep -q zfs /mnt/reboot; then
        echo ">>> un-mounting ZFS pool"
        zfs umount -a
        zpool export -a
    else
        umount -Rfl /mnt/
    fi
    echo ">>> rebooting"
    reboot -f
elif [ -f /mnt/root/chroot ]; then
    if [ -f /mnt/root/list ]; then
        cp /mnt/root/list /root/list
    fi
    change_root
else
    if [ -f /root/list ]; then
        drive=$(. /root/list; echo $drive)
        filesystem=$(. /root/list; echo $filesystem)
        bootDrive=$(. /root/list; echo $bootDrive)
        swapDrive=$(. /root/list; echo $swapDrive)
        rootDrive=$(. /root/list; echo $rootDrive)
        windowsDrive=$(. /root/list; echo $windowsDrive)
        windowsBoot=$(. /root/list; echo $windowsBoot)
    fi
    if [ -f /root/chroot ]; then
        if [ -d /boot/efi/ ]; then
            setup_bootloader
        elif [[ $(find /home -maxdepth 1 -type d | wc -l) -ne 1 ]]; then
            user=$(ls /home/)
            H="/home/$user"
            setup_desktop
        else
            configure
        fi
    else
        if mountpoint -q /mnt; then
            if ! mountpoint -q /mnt/boot/; then
                mount_boot
            fi
            if [ -d /mnt/root/ ]; then
                setup_linux
            else
                install_base
            fi
        else
            clear
            setup_drive
        fi
    fi
fi

#end