SUMMARY = "RPI4-DEV RT Core Image"
#  PV shall always match the distro version and 
#  this file's version
PV = "0.0.1"
LICENSE = "MIT"

inherit core-image

###################################################+
#  SD Card Image File Congiruation
###################################################

# IMAGE_ROOTFS_SIZE ?= "8192"
IMAGE_FSTYPES += "wic wic.bmap wic.bz2"
IMAGE_FEATURES += "read-only-rootfs"

###################################################+
#  Base Line Packages
###################################################

IMAGE_INSTALL:append = " \
						tzdata \
                        libpci \
		     	        time \
                        openssh \
		     	        python3 \
  			            libgpiod \
"

###################################################+
#  Development Packages
###################################################

# Install package management tools
IMAGE_INSTALL:append = " \
    dpkg \
    apt \
"
# Kernel and low-level related extra installs
IMAGE_INSTALL:append = " \
    kernel-image \
    kernel-devicetree \
    kernel-devsrc \
    kernel-vmlinux \
    glib-2.0 \
    libgpiod-dev \
    dtc \
"
# Install user-space dev packages
IMAGE_INSTALL:append = " \
    tree \
    nano \
    git \
    htop \
    iotop \
    tmux \
    cmake \
    ncurses \ 
    gcc \
    ldd \
    procps \
    glibc-utils \
"

# Install convenient command line tools
IMAGE_INSTALL:append = " \
    packagegroup-core-full-cmdline \
    packagegroup-rpi-test \
"

# Python3 related packages
IMAGE_INSTALL:append = " \
    python3-pip \
    python3-spidev \
    python3-subunit \
"

# Pi relates packages
IMAGE_INSTALL:append = " \
    raspi-gpio \
    rpio \
    rpi-gpio \
    pi-blaster \
"

# Install development tools
IMAGE_FEATURES:append = " \
    tools-profile \
    debug-tweaks \
    tools-sdk \
    dev-pkgs \
    tools-debug \
    dbg-pkgs \
"
# tools-testapps
IMAGE_INSTALL += " \
    rt-tests \
    hwlatdetect \
    kernel-dev \
"

# unit-testing
IMAGE_INSTALL += " \
    libcheck \
    valgrind \
"

###################################################+
#  Dev SDK ToolChain Configuration
###################################################

# Adds files the SDK for cross compilation
TOOLCHAIN_TARGET_TASK:append = " kernel-devsrc"

# Adds libs and headers to the SDK host (development machine)
TOOLCHAIN_HOST_TASK += "nativesdk-cmake"