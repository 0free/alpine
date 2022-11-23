#!/bin/bash

bootSize='190MiB'
timezone='Asia/Muscat'
pool='rpool'
hostname='linux'
user='user'
password='0000'
trex_version='0.26.8'
kernel='6.0.9'

packages_list() {

    packages=(
        # alpine
        alpine-base alpine-baselayout alpine-baselayout-data alpine-conf alpine-keys alpine-release
        # openrc
        openrc openrc-bash-completion openrc-settingsd openrc-settingsd-openrc
        # busybox
        busybox
        # busybox@edge
        busybox-openrc busybox-mdev-openrc busybox-binsh busybox-suid
        # musl
        musl musl-utils musl-locales
        # dbus
        dbus dbus-openrc dbus-libs dbus-x11
        # ibus
        ibus ibus-bash-completion
        # udev
        udev-init-scripts udev-init-scripts-openrc
        # eudev
        eudev eudev-openrc eudev-libs
        # hardware
        hwids-net hwids-pci hwids-udev hwids-usb
        # xorg
        xauth xinit xorg-server xorg-server-common
        # wayland
        xwayland
        # mesa
        mesa mesa-dri-gallium
        # vulkan
        vulkan-loader vulkan-tools
        # polkit/elogind
        polkit-openrc polkit-common polkit-elogind polkit-elogind-libs
        elogind elogind-openrc elogind-bash-completion
        # input
        xf86-input-evdev xf86-input-mtrack xf86-input-synaptics
        # base
        sudo bash bash-completion binutils fakeroot file fortify-headers g++ gcc libc-dev patch remake-make shadow rsyslog rsyslog-openrc sed attr dialog which grep pciutils usbutils findutils readline lsof less nano curl wget coreutils gawk diffutils autoconf
        # util-linux
        util-linux util-linux-openrc util-linux-login util-linux-misc util-linux-bash-completion
        # utilities
        openssl ncurses-dev
        # git
        git git-bash-completion
        # compression
        brotli-libs zstd zlib zip lz4 lzo unzip xz bzip2
        # disks
        e2fsprogs lvm2 gptfdisk dosfstools mtools ntfs-3g ntfs-3g-progs xfsprogs hfsprogs exfatprogs f2fs-tools udftools sfdisk sgdisk mmc-utils jfsutils
        udisks2 udisks2-bash-completion 
        # network
        ethtool ethtool-bash-completion
        networkmanager networkmanager-openrc networkmanager-common networkmanager-bash-completion networkmanager-elogind
        # firewall
        ufw ufw-openrc ufw-bash-completion
        iptables iptables-openrc
        # sound
        alsa-plugins-pulse alsa-lib alsa-utils alsa-utils-openrc
        # bluetooth
        bluez-alsa bluez-alsa-openrc bluez-alsa-utils
        # fonts
        font-hack font-adobe-source-code-pro
        font-noto-arabic
        font-opensans font-xfree86-type1
        ttf-font-awesome ttf-dejavu ttf-freefont ttf-droid
        # keyboard
        kbd-bkeymaps kbd-openrc setxkbmap xkbcomp xkeyboard-config
        # timezone
        tzdata
        # colord
        colord colord-bash-completion colord-gtk
        # efi
        efibootmgr
    )

    if grep -q btrfs /root/list; then
        packages+=(
            # btrfs
            btrfs-progs btrfs-progs-extra btrfs-progs-libs btrfs-progs-bash-completion
            snapper snapper-bash-completion
        )
    fi

    if grep -q qemu /root/list; then
        packages+=(
            qemu-tools
            qemu-audio-alsa qemu-audio-dbus qemu-audio-pa
            qemu-hw-display-virtio-gpu qemu-hw-display-virtio-gpu-gl
            qemu-hw-display-virtio-gpu-pci qemu-hw-display-virtio-gpu-pci-gl
            qemu-hw-display-virtio-vga qemu-hw-display-virtio-vga-gl
            qemu-hw-usb-host qemu-hw-usb-redirect
        )
    fi

    if grep -q VirtualBox /root/list; then
        packages+=(
            virtualbox-guest-additions virtualbox-guest-additions-openrc virtualbox-guest-additions-x11
        )
    else
        packages+=(
            # hardware
            bolt pciutils
            # firmware
            fwupd fwupd-openrc fwupd-efi
            # mesa
            mesa-dri-gallium mesa-va-gallium mesa-vdpau-gallium mesa-gl mesa-glapi mesa-egl mesa-gles mesa-gbm
            mesa-vulkan-layers mesa-libd3dadapter9
            # intel GPU
            mesa-vulkan-intel intel-media-driver
            # vulkan
            vulkan-loader vulkan-tools
            # wireless
            wireless-regdb iwd iwd-openrc
            # network
            ethtool ethtool-bash-completion
            rsync rsync-openrc
            networkmanager-wwan networkmanager-wifi networkmanager-bluetooth networkmanager-openvpn networkmanager-initrd-generator
        )
    fi

    if grep -q gnome /root/list; then
        packages+=(
            # gnome session
            gdm gdm-openrc mutter mutter-schemas gnome-desktop gnome-desktop-lang gnome-session
            gnome-shell gnome-shell-schemas gnome-shell-extensions gnome-menus
            gnome-control-center gnome-control-center-bash-completion
            gnome-tweaks gnome-colors-common gsettings-desktop-schemas
            tracker tracker-bash-completion
            pinentry-gnome
            # connector
            chrome-gnome-shell gnome-browser-connector
            # theme
            adwaita-icon-theme hicolor-icon-theme
            # gnome tools
            gnome-keyring gnome-terminal gnome-disk-utility gnome-system-monitor file-roller
            # nautilus
            nautilus
            # text
            gedit gedit-plugins py3-cairo
            # firmware
            gnome-firmware-updater
            # gnome theme
            arc-theme arc-dark arc-dark-gnome
            # gedit spell check
            aspell hunspell hunspell-en nuspell
            # network
            network-manager-applet
            # firewall
            gufw
        )
    fi

    if grep -q kde /root/list; then
        packages+=(
            # sddm
            sddm sddm-openrc sddm-kcm sddm-breeze
            # plasma
            plasma-desktop
            plasma-workspace plasma-workspace-lang plasma-workspace-libs
            plasma-settings
            plasma-framework
            plasma-integration plasma-browser-integration
            plasma-thunderbolt plasma-disks
            # system
            systemsettings ksysguard
            # kwallet
            kwallet kwallet-pam kwalletmanager
            # theme
            breeze-gtk breeze-icons
            # bluetooth
            bluedevil
            # power
            powerdevil
            # wayland
            kwayland
            # network
            plasma-nm
            # firewall
            iproute2 net-tools
            # audio
            plasma-pa kmix
            # kde
            kde-cli-tools ki18n kwin kinit kcron kdecoration krecorder kscreen kscreenlocker kmenuedit konsole kde-gtk-config
            # file manager
            dolphin dolphin-plugins kfind
            # text
            kate kate-common
            # archive
            ark
        )
    fi

    if grep -q workstation /root/list; then

        if grep -q gnome /root/list; then
            packages+=(
                # gnome apps
                gnome-software gnome-software-plugin-apk gnome-software-plugin-flatpak gnome-photos gnome-music gnome-clocks gnome-contacts gnome-calculator gnome-maps gnome-logs gnome-remote-desktop gnome-screenshot gnome-boxes gnome-calendar gnome-sound-recorder gnome-font-viewer gnome-colors gnome-bluetooth gnome-podcasts gnome-characters gnome-builder gnome-shortwave getting-things-gnome sushi simple-scan
                # config
                dconf dconf-bash-completion
                # web
                epiphany
                # documents
                evince evince-nautilus
                # photos
                gthumb eog shotwell
                # mail
                geary
                # sound
                gnome-metronome lollypop
                # other
                glade ghex baobab confy
                # bluetooth
                blueman
                # flatpak
                xdg-desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-gtk xdg-user-dirs
            )
        fi

        if grep -q kde /root/list; then
            packages+=(
                # plasma
                plasma-systemmonitor plasma-firewall
                plasma-camera plasma-videoplayer plasma-phonebook
                # kde
                kactivities kactivities-stats kactivitymanagerd ksystemstats
                shelf knetattach kmail ktorrent kdeconnect akregator kphotoalbum kmymoney kdeedu-data kalk rocs calligra marble clip buho vvave communicator qrca step kmousetool krename kcolorchooser kunitconversion
                # widgets
                kconfigwidgets
                # print
                print-manager
                # screen
                spectacle kscreenlocker kruler
                # image
                gwenview
                # audio
                juk kwave elisa
                # video
                kmediaplayer kdenlive dragon haruna
                # YouTube
                plasmatube audiotube
                # camera
                kamera kamoso
                # spelling
                sonnet
                # office
                kcalc okular skanlite
                # input
                plasma-remotecontrollers
                # draw
                kolourpaint
                # math
                cantor kalgebra kig kmplot
                # music
                minuet
                # flatpak
                xdg-desktop-portal xdg-desktop-portal-kde xdg-user-dirs
                # hex
                okteta
            )
        fi

        packages+=(
            # shell
            starship starship-bash-completion
            # wine
            wine vkd3d
            # thumbnail
            ffmpegthumbnailer
            # mkimage
            abuild alpine-sdk apk-tools mkinitfs xorriso squashfs-tools
            # fonts tools
            font-manager font-viewer
            # office
            libreoffice-base libreoffice-common libreoffice-writer libreoffice-math libreoffice-calc libreoffice-draw libreoffice-lang-en_us libreoffice-lang-ar
            # google
            google-authenticator
            # mail
            thunderbird
            # music
            amberol musescore
            # audio
            ardour tenacity calf calf-jack calf-lv2
            # video edit
            shotcut pitivi x265
            # video subtitle
            gaupol
            # book
            foliate
            # openvc
            opencv py3-opencv
            # python
            black
            # JavaScript
            npm npm-bash-completion nodejs esbuild reason
            # code
            code-oss code-oss-bash-completion lapce codeblocks
            # code format
            prettier tidyhtml
            # html/css to pdf
            weasyprint
            # screenshot
            flameshot
            # electronic
            kicad
            # screen
            obs-studio kooha peek
            # video
            mplayer totem celluloid
            # photos
            krita gimp inkscape gmic curtail
            # printer
            cups cups-openrc cups-pdf bluez-cups
            # driver
            xinput gkraken ccid solaar razercfg razercfg-gui razergenie openrazer piper
            # math
            mathjax2
            # finance
            homebank
            # 2d
            tiled
            # 3d
            blender freecad godot leocad solvespace goxel
            # 3d printer
            cura
            # text editor
            kakoune
            # mauikit
            mauikit mauikit-accounts mauikit-filebrowsing mauikit-imagetools mauikit-texteditor
            # bitcoin
            bitcoin bitcoin-openrc
            # game emu
            pcsx2 dolphin-emu xwiimote pcsxr
            # rust
            rust rustfmt rust-analysis cargo
            # go
            go
            # php
            composer php82 php82-bcmath php82-bz2 php82-cgi php82-curl php82-common php82-phpdbg php82-dom php82-exif php82-fileinfo php82-fpm php82-gd php82-gettext php82-iconv php82-intl php82-litespeed php82-mbstring php82-mysqli php82-mysqlnd php82-opcache php82-openssl php82-phar php82-pear php82-session php82-snmp php82-soap php82-xml php82-zip
            # android
            gradle android-tools android-tools-bash-completion go-mtpfs scrcpy scrcpy-bash-completion
            # iPhone/iPod/mac
            ifuse ideviceinstaller idevicerestore libirecovery libirecovery-progs libideviceactivation libimobiledevice libimobiledevice-progs
            # pdf
            corepdf pdfarranger poppler
            # drives
            onedrive onedrive-openrc
            # twitter
            cawbird
            # Corsair
            ckb-next
            # RGB
            openrgb
            # plan
            planner
            # music player
            amberol sublime-music
            # music server
            navidrome navidrome-openrc
            # youtube
            ffmpeg yt-dlp yt-dlp-bash-completion pipe-viewer-gtk audiotube tartube youtube-viewer-gtk
            # javascript/css
            minify minify-bash-completion
            # photos
            darktable
            # drawing
            drawing
            # remote
            remmina
            # touch
            touchegg touchegg-openrc
            # CPU
            corectrl
            # cctv
            zoneminder zoneminder-openrc
            # iso
            thumbdrives
        )

        if grep -q gnome /root/list; then
            packages+=(
                libreoffice-gnome
            )
        fi

    fi

    if grep -q server /root/list; then
        packages+=(
            # system
            rsyslog rsyslog-openrc rsyslog-mysql rsyslog-tls rsyslog-http
            # SSL/TLS
            certbot
            # php
            php81 php81-bcmath php81-brotli php81-bz2 php81-cgi php81-curl php81-common php81-phpdbg php81-dom php81-exif php81-fileinfo php81-fpm php81-gd php81-gettext php81-iconv php81-intl php81-litespeed php81-mbstring php81-memcache php81-memcached php81-mysqli php81-mysqlnd php81-opcache php81-openssl php81-phar php81-pear php81-redis php81-session php81-snmp php81-soap php81-xml php81-zip php81-pecl-imagick
            # php admin
            phpmyadmin
            # database
            mariadb
            # mail
            postfix postfix-openrc postfix-mysql postfix-pcre postfixadmin
            dovecot dovecot-openrc dovecot-submissiond dovecot-ldap dovecot-lmtpd dovecot-pop3d dovecot-sql dovecot-mysql
            opendkim opendkim-utils
            cyrus-sasl
            # tools
            imagemagick redis redis-openrc memcached memcached-openrc
            # server
            litespeed litespeed-openrc
            # http
            hetty
            # cab
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
        if [ $i -ge 0 ]; then
            if [ $i -le ${#options[@]} ]; then
                echo -en "\033[${#options[@]}A"
            fi
        else
            i=0
        fi
    done
    printf -v $output ${options[$i]}

}

setup_drive() {

    if [ -f /root/list ]; then
        rm -r /root/list
    fi

    echo '# created by Saif AlSubhi'
    printf -- '-%.0s' {1..100}; echo ''
    lsblk -o name,type,fstype,size,fsused,fsuse%,mountpoint,label,model
    printf -- '-%.0s' {1..100}; echo ''

    drives=($(ls /dev/ | grep -E '^nvme[0-9]n[1-9]$|^sd[a-z]$'))

    for i in ${!drives[@]}; do
        drives[i]=/dev/${drives[i]}
    done

    menu 'select a drive' drive ${drives[@]}
    echo "drive=$drive" > /root/list

    if ls $drive* | grep -Eq "$drive.{1}|$drive.{2}"; then
        partitions=($(ls $drive*))
        menu 'select a root partition or use the complete drive' partition ${partitions[@]}
        if [[ $drive == $partition ]] ; then
            swapSizes=(disable 1GiB 2GiB 3GiB 4GiB)
            menu 'select swap partition size in MB' swapSize ${swapSizes[@]}
        else
            rootDrive=$partition
            if ls $drive* | grep -E "$drive.{1}|$drive.{2}" | grep -v $partition; then
                partitions=($(ls $drive* | grep -E "$drive.{1}|$drive.{2}" | grep -v $partition))
                menu 'select a boot partition to mount ' bootDrive ${partitions[@]}
            fi
        fi
    fi

    filesystems=(btrfs zfs xfs ext4)
    menu 'select a filesystem' filesystem ${filesystems[@]}
    echo "filesystem=$filesystem" >> /root/list

    computers=(minimal miner qemu server VirtualBox workstation)
    menu 'select a computer' computer ${computers[@]}
    echo "computer=$computer" >> /root/list

    desktops=(kde gnome none)
    menu 'select a desktop' desktop ${desktops[@]}
    echo "desktop=$desktop" >> /root/list

    if [[ $filesystem == zfs ]]; then
        bootloaders=(gummiboot grub)
    elif [[ $filesystem == btrfs ]]; then
        bootloaders=(gummiboot grub rEFInd)
    else
        bootloaders=(gummiboot grub rEFInd clover)
    fi
    menu 'select a bootloader' bootloader ${bootloaders[@]}
    echo "bootloader=$bootloader" >> /root/list

    kernels=(no "Linux-$kernel")
    menu 'build a custom kernel?' choise ${kernels[@]}
    if grep -q $kernel $choise; then
        echo "kernel=$choise" >> /root/list
    fi

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

        i=1

        echo ">>> creating boot partition"
        sgdisk -n 0:0:+$bootSize -c 0:BOOT -t 0:ef00 $drive
        bootDrive=$(ls $drive* | grep -E "$drive.$i|$drive.p.$i")
        echo "bootDrive=$bootDrive" >> /root/list

        if grep -q GiB $swapSize; then
            echo ">>> creating swap partition"
            sgdisk -n 0:0:+$swapSize -c 0:SWAP -t 0:8200 $drive
            ((++i))
            swapDrive=$(ls $drive* | grep -E "$drive.$i|$drive.p.$i")
            echo "swapDrive=$swapDrive" >> /root/list
        fi

        echo ">>> creating root partition"
        if [[ $filesystem == zfs ]]; then
            sgdisk -n 0:0:0 -c 0:ROOT -t 0:bf00 $drive
        else
            sgdisk -n 0:0:0 -c 0:ROOT -t 0:8300 $drive
        fi
        ((++i))
        rootDrive=$(ls $drive* | grep -E "$drive.$i|$drive.p.$i")
        echo "rootDrive=$rootDrive" >> /root/list

        echo ">>> reading partition tables"
        mdev -s && mdev -s

        echo ">>> creating boot filesystem"
        mkfs.vfat -F32 -n BOOT $bootDrive

        if [[ $swapDrive ]]; then
            echo ">>> creating swap filesystem"
            mkswap $swapDrive
        fi

    fi

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
    if [[ $bootDrive ]]; then
        mount_boot
    fi
    install_base

}

create_zfs() {

    echo ">>> loading ZFS modules"
    modprobe zfs
    echo ">>> checking ZFS modules"
    if ! lsmod | grep -qi zfs; then
       echo 'ERROR: ZFS modules are missing'
       create_rootfs
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

    echo ">>> updating packages"
    cat > /etc/apk/repositories <<EOF
http://dl-cdn.alpinelinux.org/alpine/edge/main
http://dl-cdn.alpinelinux.org/alpine/edge/community
http://dl-cdn.alpinelinux.org/alpine/edge/testing
#https://dl-cdn.alpinelinux.org/alpine/latest-stable/main
#https://dl-cdn.alpinelinux.org/alpine/latest-stable/community
EOF

    echo ">>> installing alpine-base"
    apk add --root=/mnt/ --initdb alpine-base --keys-dir /etc/apk/keys --repositories-file /etc/apk/repositories

    echo ">>> copying repositories"
    cp /etc/apk/repositories /mnt/etc/apk/repositories

    echo ">>> creating /dev/null"
    rm /mnt/dev/null
    cp /dev/null /mnt/dev/null
    chmod 0666 /mnt/dev/null

    echo ">>> loading modules"
    modprobe efivars

    set_network
    set_fstab
    setup_linux

}

set_network() {

    echo ">>> adding name resolution"
    cat > /mnt/etc/resolv.conf <<EOF
nameserver 10.0.254.3
nameserver 1.0.0.1
nameserver 8.8.8.8
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

    echo "$(blkid $swapDrive -o export | grep ^UUID=) none swap sw 0 0" >> /mnt/etc/fstab

}

setup_linux() {

    install_linux
    install_packages
    set_timezone
    set_host
    change_root

}

install_linux() {

    if grep -Eq 'qemu|VirtualBox' /root/list; then
        list='linux-virt'
        if grep -q zfs /root/list; then
            list+=' zfs-virt zfs zfs-openrc zfs-libs zfs-udev'
        fi
    else
        if grep -q zfs /root/list; then
            list='linux-lts'
            list+=' zfs-lts zfs zfs-openrc zfs-libs zfs-udev'
        else
            list='linux-lts linux-edge'
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

    echo ">>> installing linux"
    apk add --root=/mnt/ linux-firmware-none
    apk add --root=/mnt/ $list

}

install_packages() {

    echo ">>> packages list"
    packages_list

    list=''
    for i in ${!packages[@]}; do
        list+=${packages[$i]}
        list+=' '
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
    else
        read -rp " --- timezone Asia/Muscat: " timezone
        set_timezone
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
    dir=(proc dev sys)
    for d in ${dir[@]}; do
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
    echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
    chmod 0400 /etc/sudoers.d/wheel
    echo ">>> creating user"
    echo -en "$password\n$password" | adduser -h /home/$user -s /bin/bash -G wheel -g $user $user
    usermod -aG input,audio,video,netdev,usb,disk,lp,adm $user
    if grep -q zfs /root/list; then
        zfs allow $user create,mount,mountpoint,snapshot $pool
    fi

}

setup_desktop() {

    enable_services
    configure_alpine

    if ! grep -Eq 'qemu|VirtualBox' /root/list; then
        if grep -q $kernel /root/list; then
            custom_kernel
            build_zfs
        fi
        install_nvidia
    fi

    install_flatpak
    install_google_chrome

    if grep -q miner /root/list; then
        install_miner
    fi

    if ! grep -Eq "server|miner" /root/list; then
        create_iso
        openwrt
    fi

    make_initramfs

    if mountpoint -q /mnt/boot; then
        setup_bootloader
    fi

}

enable_services() {

    echo ">>> enabling services"

    rc-update add devfs sysinit
    rc-update add dmesg sysinit
    rc-update add mdev sysinit
    rc-update add hwdrivers sysinit
    rc-update add udev sysinit
    rc-update add udev-trigger sysinit
    rc-update add dbus sysinit
    rc-update add udev-settle sysinit
    rc-update add udev-postmount sysinit

    rc-update add procfs boot
    rc-update add devfs boot
    rc-update add sysfs boot
    rc-update add root boot

    rc-update add modules boot
    rc-update add cgroups boot
    rc-update add mtab boot
    rc-update add hwclock boot
    rc-update add save-keymaps boot
    rc-update add lvm boot
    rc-update add swap boot
    rc-update add localmount boot
    rc-update add sysctl boot
    rc-update add hostname boot
    rc-update add bootmisc boot
    rc-update add syslog boot
    rc-update add networking boot

    if grep -q zfs /root/list; then
        rc-update add zfs-import boot
        rc-update add zfs-mount sysinit
        rc-update add zfs-share boot
        rc-update add zfs-zed boot
        rc-update add zfs-load-key boot
    fi

    rc-update add loadkeys default
    rc-update add elogind default
    rc-update add polkit default

    rc-update add networkmanager default
    rc-update add networkmanager-dispatcher default

    rc-update add alsa default
    rc-update add bluealsa default
    rc-update add bluetooth default
    rc-update add ufw default

    if grep -q VirtualBox /root/list; then
        rc-update add virtualbox-guest-additions default
        rc-update add virtualbox-drm-client default
    else
        rc-update add iwd default
        rc-update add rsyncd default
        rc-update add fwupd default
    fi

    if grep -q gnome /root/list; then
        rc-update add gdm default
        rc-update add agetty default
    fi

    if grep -q kde /root/list; then
        rc-update add sddm default
    fi

    if grep -q workstation /root/list; then
        rc-update add cupsd default
    fi

    if grep -q server /root/list; then
        rc-update add mariadb default
        rc-update add litespeed default
        rc-update add postfix default
        rc-update add dovecot default
        rc-update add opendkim default
        mkdir /var/mysql && chown -R mysql:mysql /var/mysql
        mkdir /var/log/mysql && chown -R mysql:mysql /var/log/mysql
    fi

    rc-update add mount-ro shutdown
    rc-update add killprocs shutdown
    rc-update add savecache shutdown

}

configure_alpine() {

    echo ">>> configuring alpine"

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

    if [ -f /etc/profile.d/color_prompt.sh.disabled ]; then
        mv /etc/profile.d/color_prompt.sh.disabled /etc/profile.d/color_prompt.sh
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

    if ! grep -q snd_seq /etc/modules; then
        echo snd_seq >> /etc/modules
    fi

    if [ ! -d /usr/share/icons/windows-11-icons/ ]; then
        echo ">>> cloning Windows-11-icons"
        git clone https://github.com/0free/windows-11-icons.git
        rm -r windows-11-icons/.git
        cp -rlf windows-11-icons/ /usr/share/icons/
        rm -r windows-11-icons/
    fi

    echo ">>> configuring firewall"
    sed -i 's|IPV6=yes|IPV6=no|' /etc/default/ufw
    sed -i 's|"DROP"|"REJECT"|g' /etc/default/ufw
    sed -i 's|ENABLED=no|ENABLED=yes|' /etc/ufw/ufw.conf

    if [ ! -d /home/$user/.config/ ]; then
        mkdir /home/$user/.config/
    fi

    if grep -q gnome /root/list; then
        cat > /etc/profile.d/gnome.sh <<EOF
if [ -f ~/dconf-settings.ini ]; then
    dconf load / < ~/dconf-settings.ini
    rm ~/dconf-settings.ini
fi
EOF
        if [ ! -f /home/$user/dconf-settings.ini ]; then
            echo ">>> downloading gnome dconf-settings"
            curl -o /home/$user/dconf-settings.ini -LO https://raw.githubusercontent.com/0free/alpine/1/dconf-settings.ini
        fi
    fi

    if grep -q kde /root/list; then
        if [ ! -f /home/$user/.config/kde.org/systemsettings.conf ]; then
            echo ">>> configuring kde"
            git clone https://github.com/0free/kde.git
            cp -rlf /kde/config/* /home/$user/.config/
            rm -r kde/
        fi
        echo ">>> configuring PAM"
        cat >> /etc/pam.d/login <<EOF
auth            optional        pam_kwallet5.so
session         optional        pam_kwallet5.so auto_start force_run
EOF
        if [ ! -d /etc/sddm.conf.d/ ]; then
            mkdir /etc/sddm.conf.d/
        fi
    fi

    echo ">>> setting ~/"
    chown -R $user:wheel /home/$user/
    chown -R $user:wheel /home/$user/.config/
    chmod -R 700 /home/$user/
    chmod -R 700 /home/$user/.config/

    cat > /etc/profile.d/custom.sh <<EOF
PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$ \[\033[0m\]'
export QT_IM_MODULE=ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
update() {
    sudo apk fix
    sudo apk update
    sudo apk upgrade
    sudo flatpak update -y
    sudo flatpak uninstall -y --unused
    if [ -f /etc/profile.d/nvidia.sh ]; then
        nvidia
    fi
    if [ -f /etc/profile.d/gummiboot.sh ]; then
        gummiboot
    fi
    if [ -f /etc/profile.d/trex.sh ]; then
        update_trex
    fi
}
search() {
    apk search
}
install() {
    sudo apk add
}
remove() {
    sudo apk del
}
c() {
    clear
}
disk() {
    lsblk -o name,type,mountpoints,size,fsused,fsuse%,uuid,model
}
fwupd() {
    fwupdmgr get-devices
    fwupdmgr refresh
    fwupdmgr get-updates
    fwupdmgr update
}
youtube() {
    yt-dlp -o '~/%(title)s.%(ext)s' -f 'bv[vcodec~="^((he|a)vc|h26[45])"][height<=1080][fps<=60]+ba' --merge-output-format mp4 --downloader ffmpeg --external-downloader ffmpeg --external-downloader-args ffmpeg:'-ss 00:00:00 -to 03:00:00'
}
EOF

}

custom_kernel() {

    kernel_url="https://cdn.kernel.org/pub/linux/kernel/v${kernel::1}.x/linux-$kernel.tar.xz"

    echo ">>> installing required packages to build Linux-$kernel"
    depend='bc file fortify-headers g++ gcc kmod libc-dev patch remake-make ncurses-dev xz-libs libssl1.1 bc flex libelf bison pahole e2fsprogs jfsutils reiserfsprogs squashfs-tools btrfs-progs pcmciautils quota-tools ppp nfs-utils procps udev mcelog iptables openssl libcrypto cpio'
    apk add $depend
    echo ">>> downloading Linux-$kernel source"
    curl -o /root/linux-$kernel.tar.xz -LO $kernel_url
    echo ">>> extracting Linux-$kernel source"
    tar -xf /root/linux-$kernel.tar.xz -C /root/
    echo ">>> deleting *.tar.xz"
    rm /root/*.tar.xz
    echo ">>> copying alpine linux-edge kernel configuration"
    if [ -f /boot/config-virt ]; then
        cp /boot/config-virt /root/linux-$kernel/.config
    elif [ -f /boot/config-edge ]; then
        cp /boot/config-edge /root/linux-$kernel/.config
    else
        cp /boot/config-lts /root/linux-$kernel/.config
    fi
    sed -i 's|CONFIG_LOCALVERSION=.*|CONFIG_LOCALVERSION=""|' /root/linux-$kernel/.config
    sed -i 's|CONFIG_DEFAULT_HOSTNAME=.*|CONFIG_DEFAULT_HOSTNAME=""|' /root/linux-$kernel/.config
    echo ">>> configuring Linux kernel"
    cd /root/linux-$kernel/ && make -j$(nproc) menuconfig
    echo ">>> making Linux kernel"
    cd /root/linux-$kernel/ && make -j$(nproc)
    echo ">>> installing modules"
    cd /root/linux-$kernel/ && make -j$(nproc) modules_install
    echo ">>> installing Linux kernel"
    #cd /root/linux-$kernel/ && make install
    installkernel $kernel /root/linux-$kernel/arch/x86/boot/bzImage /root/linux-$kernel/System.map /boot/
    echo ">>> deleting Linux kernel source"
    rm -r /root/Linux-$kernel/
    echo ">>> deleting un-needed dependencies"
    apk del $depend

}

build_zfs() {

    echo ">>> installing required packages to build ZFS"
    depend='installkernel fortify-headers libc-dev patch remake-make ncurses-dev xz-libs libssl1.1 bc flex libelf bison autoconf automake libtool gawk alien fakeroot dkms libblkid-dev uuid-dev libudev-dev libssl-dev zlib1g-dev libaio-dev libattr1-dev libelf-dev python3 python3-dev python3-setuptools python3-cffi libffi-dev python3-packaging libcurl4-openssl-dev'
    apk add $depend

    echo ">>> installing zfs-src"
    apk add zfs-src
    echo ">>> building zfs-src"
    cd /usr/src/zfs/ && sh autogen.sh
    cd /usr/src/zfs/ && ./configure
    cd /usr/src/zfs/ && make -s -j"$(nproc)"
    cd /usr/src/zfs/ && make install
    cd /usr/src/zfs/ && ldconfig
    cd /usr/src/zfs/ && depmod

    echo ">>> deleting un-needed dependencies"
    apk del $depend

}

install_nvidia() {

    echo ">>> installing linux-lts-dev"
    sudo apk add linux-lts-dev
    echo ">>> installing linux-edge-dev"
    sudo apk add linux-edge-dev

    echo ">>> installing nvidia-src"
    apk add akms nvidia-src

    if [ -d /usr/src/nvidia-src/ ]; then
        rm -r /usr/src/nvidia-src/*
    fi

    cat > /etc/profile.d/nvidia.sh <<EOF
version=$(apk search -e nvidia-src)
nvidia() {
    if wget -q --spider alpinelinux.org &>/dev/null; then
        if find /lib/modules/ -type f -name 'nvidia.ko.gz' | grep -q nvidia; then
            if grep -q \$(apk search -e nvidia-src) /etc/profile.d/nvidia.sh; then
                echo "nvidia driver is up-to-date"
            else
                install_modules
            fi
        fi
    else
        install_modules
    fi
}
install_modules() {
    echo '>>> building nvidia kernel modules'
    sudo akms install all
    sudo sed -i 's|version=.*|version=\$(apk search -e nvidia-src)|' /etc/profile.d/nvidia.sh
    if [ -d /usr/src/nvidia-src/ ]; then
        rm -r /usr/src/nvidia-src/*
    fi
}
EOF

}

install_flatpak() {

    echo ">>> installing flatpak"
    apk add flatpak flatpak-bash-completion xdg-user-dirs
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    adduser $user flatpak
    xdg-user-dirs-update

}

install_google_chrome() {

    echo ">>> installing google-chrome from flatpak"
    flatpak install -y flathub com.google.Chrome
    flatpak override com.google.Chrome --filesystem=/home/$user/

    echo ">>> installing google-chrome dependencies"
    depend='ca-certificates font-liberation libcurl libglibutil libwoff2common wget alsa-lib aom-libs at-spi2-core brotli-libs cairo cups-libs dbus-libs eudev-libs ffmpeg-libs flac-libs font-opensans fontconfig freetype glib gtk+3.0 harfbuzz icu-libs jsoncpp lcms2 libatk-1.0 libatk-bridge-2.0 libatomic libc6-compat libdav1d libdrm libevent libexpat libgcc libjpeg-turbo libpng libpulse libstdc++ libwebp libwoff2enc libx11 libxcb libxcomposite libxdamage libxext libxfixes libxkbcommon libxml2 libxrandr libxslt mesa-gbm minizip nspr nss opus pango pipewire-libs re2 snappy wayland-libs-client xdg-utils zlib'
    apk add $depend

}

install_miner() {

    if [ ! -f /usr/bin/t-rex ]; then
        echo ">>> downloading T-Rex $trex_version"
        curl -o /root/t-rex.tar.gz -LO https://trex-miner.com/download/t-rex-$trex_version-linux.tar.gz
        echo ">>> extracting T-Rex $trex_version"
        tar -zxf t-rex.tar.gz t-rex -C /usr/bin/
        echo ">>> deleting T-Rex files"
        rm /root/t-rex.tar.gz
    fi

    cat > /etc/profile.d/t-rex.sh << EOF
version=$trex_version
trex() {
    if wget -q --spider alpinelinux.org &>/dev/null; then
        if [ ! -f ~/config ]; then
            echo ">>> downloading t-rex config file"
            curl -o ~/config -LO https://raw.githubusercontent.com/0free/t-rex/$trex_version/config
        fi
        /usr/bin/t-rex -c ~/config
        xdg-open http://127.0.0.1:8080
    fi
}
update_trex() {
    latest="0.$(calc \${version:0-4}+0.1)"
    if wget -q --spider https://trex-miner.com/download/t-rex-\$latest-linux.tar.gz
        echo ">>> downloading T-Rex \$latest"
        curl -O https://trex-miner.com/download/t-rex-\$latest-linux.tar.gz -o ~/
        echo ">>> extracting T-Rex \$latest"
        sudo tar -zxf t-rex-\$latest-linux.tar.gz t-rex -C /usr/bin/
        sudo sed -i 's|version=.*|version=\$latest|' /etc/prfile.d/trex.sh
        echo ">>> deleting T-Rex files"
        rm ~/t-rex-\$latest-linux.tar.gz
    else
        echo ">>> t-rex is up-to-date"
    fi
}
calc() {
    printf "%s" \$@ | bc -l
}
EOF

}

create_iso() {

    cat > /etc/profile.d/iso.sh << EOF
iso() {
    if wget -q --spider https://alpinelinux.org &>/dev/null; then
        curl -o ~/iso.sh -LO https://raw.githubusercontent.com/0free/alpine/1/iso.sh
        sh iso.sh
    fi
}
EOF

}

openwrt() {

    cat > /etc/profile.d/openwrt.sh << EOF
version=$(apk search -e musl-dev)
openwrt() {
    if wget -q --spider https://alpinelinux.org &>/dev/null; then
        sudo apk add gcc g++ argp-standalone musl-dev musl-fts-dev musl-obstack-dev musl-libintl rsync tar libcap-dev
        sudo sed -z 's|if wget.*\n.*\n.*\nfi||' -i /etc/profile.d/openwrt.sh
    fi
    if ! grep -q "\$(apk search -e musl-dev)" /etc/profile.d/openwrt.sh; then
        sudo sed -i 's|calloc|xcalloc|g' /usr/include/sched.h
        sudo sed -i 's|version=.*|version=\$(apk search -e musl-dev)|' /etc/profile.d/openwrt.sh
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
}
EOF

}

configure_lightdm() {

    echo ">>> configuring lightdm"
    sed -i 's|#allow-guest=.*|allow-guest=false|' /etc/lightdm/lightdm.conf
    sed -i 's|#autologin-guest=.*|autologin-guest=false|' /etc/lightdm/lightdm.conf
    sed -i "s|#autologin-user=.*|autologin-user=$user|" /etc/lightdm/lightdm.conf
    sed -i 's|#autologin-user-timeout=.*|autologin-user-timeout=0|' /etc/lightdm/lightdm.conf
    sed -i 's|#autologin-in-background=.*|autologin-in-background=false|' /etc/lightdm/lightdm.conf
    sed -i 's|#user-session=.*|user-session=default|' /etc/lightdm/lightdm.conf
    sed -i 's|#greeter-session=.*|greeter-session=slick-greeter|' /etc/lightdm/lightdm.conf

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

    if grep -q VirtualBox /root/list; then
        modules+=(vboxvideo virtio-gpu vmvga vmwgfx)
    elif grep -q qemu /root/list; then
        modules+=()
    else
        modules+=(intel_agp i915)
        modules+=(amdgpu)
        modules+=(nvidia nvidia_modeset nvidia_uvm nvidia_drm nvidia_peermem)
    fi

    list=''
    for i in ${!modules[@]}; do
        list+=${modules[$i]}
        list+=' '
    done

    echo ">>> configuring mkinitfs"
    echo "features=\"$list\"" > /etc/mkinitfs/mkinitfs.conf

    kernel_lts=$(echo $(apk search -e linux-lts | sed 's|linux-lts-||' | sed 's|r||')-lts)
    kernel_edge=$(echo $(apk search -e linux-edge | sed 's|linux-edge-||' | sed 's|r||')-edge)
    kernel_virt=$(echo $(apk search -e linux-virt | sed 's|linux-virt-||' | sed 's|r||')-virt)

    if [ ! -d /lib/modules/$kernel_virt ]; then
        mkdir /lib/modules/$kernel_virt
    fi
    if [ ! -d /lib/modules/$kernel_edge ]; then
        mkdir /lib/modules/$kernel_edge
    fi
    if [ ! -d  /lib/modules/$kernel_lts ]; then
        mkdir /lib/modules/$kernel_lts
    fi

    if [ -f /boot/vmlinuz ]; then
        echo ">>> building linux-$kernel initial ramdisk"
        mkinitfs -b / -c /etc/mkinitfs/mkinitfs.conf -f /etc/fstab -o /boot/initramfs $kernel
    fi
    if [ -f /boot/vmlinuz-virt ]; then
        echo ">>> building linux VirtualMachine initial ramdisk"
        mkinitfs -b / -c /etc/mkinitfs/mkinitfs.conf -f /etc/fstab -o /boot/initramfs-virt $kernel_virt
    fi
    if [ -f /boot/vmlinuz-lts ]; then
        echo ">>> building linux LTS initial ramdisk"
        mkinitfs -b / -c /etc/mkinitfs/mkinitfs.conf -f /etc/fstab -o /boot/initramfs-lts $kernel_lts
    fi
    if [ -f /boot/vmlinuz-edge ]; then
        echo ">>> building linux edge initial ramdisk"
        mkinitfs -b / -c /etc/mkinitfs/mkinitfs.conf -f /etc/fstab -o /boot/initramfs-edge $kernel_edge
    fi

    mkdir /boot/efi/

}

setup_bootloader() {

    find_windows

    param="rootfstype=$filesystem rw loglevel=1 quiet mitigations=off modules=sd-mod,usb-storage"

    if grep -q zfs /root/list; then
        disk="root=$pool $param"
    else
        disk="root=$(blkid $rootDrive -o export | grep ^UUID=) $param"
    fi

    if grep -q gummiboot /root/list; then
        install_gummiboot
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
                        if [ ! -d /windows/ ]; then
                            mkdir /windows/
                        fi
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

install_gummiboot() {

    echo ">>> installing gummiboot"
    apk add gummiboot

    mkdir /boot/efi/alpineLinux/
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

    if [ -f /usr/libexec/fwupd/efi/fwupdx64.efi ]; then
        echo ">>> adding fwupd to gummiboot"
        mkdir -p /boot/efi/fwupd/
        cp /usr/libexec/fwupd/efi/fwupdx64.efi /boot/efi/fwupd/
        cat > /boot/loader/entries/fwupd.conf <<EOF
title   update firmware
efi     /fwupd/fwupdx64.efi
EOF
    fi

    cat > /etc/profile.d/gummiboot.sh <<EOF
version=$(apk search -e gummiboot)
gummiboot() {
    if wget -q --spider alpinelinux.org &>/dev/null; then
        if grep -q \$(apk search -e gummiboot) etc/profile.d/gummiboot.sh; then
            echo "gummiboot is up-to-date"
        else
            sudo apk update gummiboot
            sudo cp /usr/lib/gummiboot/gummibootx64.efi	/boot/efi/alpineLinux/bootx64.efi
            sudo sed -i 's|version=.*|version=\$(apk search -e guammiboot)|' /etc/profile.d/gummiboot.sh
        fi
    fi
}
EOF

}

install_grub() {

    echo ">>> installing grub package"
    apk fix
    apk add grub grub-efi grub-bash-completion
    echo ">>> installing grub bootloader"
    grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id="alpine linux" $drive

    if [ ! -d /boot/grub/themes/ ]; then
        mkdir /boot/grub/themes
    fi

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

    if [ -f /boot/efi/refind/refind_x64.efi ]; then
        cp /boot/efi/refind/refind_x64.efi /boot/efi/refind/bootx64.efi
    fi

    if [ ! -d /boot/efi/refind/drivers_x64/ ]; then
        mkdir -p /boot/efi/refind/drivers_x64/
        echo ">>> copying rEFInd drivers"
        cp /usr/share/refind/drivers_x86_64/*.efi /boot/efi/refind/drivers_x64/
        echo ">>> downloading efifs drivers"
        curl -o /boot/efi/refind/drivers_x64/xfs_x64.efi -LO github.com/pbatard/efifs/releases/download/v1.9/xfs_x64.efi
        curl -o /boot/efi/refind/drivers_x64/zfs_x64.efi -LO github.com/pbatard/efifs/releases/download/v1.9/zfs_x64.efi
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
menuentry "alpine Linux edge" {
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
        cp -rlf CloverBootLoader/* /boot/
        rm -r CloverBootLoader/
        echo ">>> downloading efifs drivers"
        curl -o /boot/EFI/CLOVER/drivers/off/UEFI/FileSystem/btrfs_x64.efi -LO github.com/pbatard/efifs/releases/download/v1.9/btrfs_x64.efi
        curl -o /boot/EFI/CLOVER/drivers/off/UEFI/FileSystem/ntfs_x64.efi -LO github.com/pbatard/efifs/releases/download/v1.9/ntfs_x64.efi
        curl -o /boot/EFI/CLOVER/drivers/off/UEFI/FileSystem/xfs_x64.efi -LO github.com/pbatard/efifs/releases/download/v1.9/xfs_x64.efi
        curl -o /boot/EFI/CLOVER/drivers/off/UEFI/FileSystem/zfs_x64.efi -LO github.com/pbatard/efifs/releases/download/v1.9/zfs_x64.efi
    fi

}

finish() {

    echo ">>> installation is completed"
    echo '' > /root/reboot
    exit 0

}

set -e

if [ -f /mnt/lib/apk/db/lock ]; then
    rm /mnt/lib/apk/db/lock
fi

if [ -f /mnt/root/reboot ]; then
    rm /mnt/root/install.sh
    rm /mnt/root/reboot
    echo ">>> un-mounting & reboot"
    dir=(/mnt/boot/ /mnt/sys/ /mnt/dev/ /mnt/proc/)
    for d in ${dir[@]}; do
        umount $d
    done
    umount -Rf /mnt/
    if grep -q zfs /root/list; then
        zfs umount -a
        zpool export -a
    fi
    reboot
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
            user=$(ls /home)
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