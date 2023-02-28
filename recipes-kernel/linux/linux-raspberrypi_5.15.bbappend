# Grabs the Linux RT patch for Linux Kernel Version 5.15.34 from
# https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15.34-rt40.tar.gz

###################################################+
#  Commands used to grab the linux-rt patch 
###################################################

# LINUX_KERNEL_VERSION=5.15
# export PATCH=$(curl -s https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/${LINUX_KERNEL_VERSION}/ | sed -n 's:.*<a href="\(.*\).patch.gz">.*:\1:p' | sort -V | tail -1) && 
# curl https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/${LINUX_KERNEL_VERSION}/${PATCH}.patch.gz --output ${PATCH}.patch.gz 
# gzip -cd ./${PATCH}.patch.gz | patch -p1 --verbose

###################################################+
#  Kernel Configurations
###################################################

# Add files to the search paths
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Kernel config that enables fully preemptable kernel
# Applies the rt kernel patch to linux-raspberrypi fork of linux kernel
# Note that Kernel based Virtualization must be disabled in order
# for the RT patch to be applicable to ARM/ARM64
# https://lore.kernel.org/linux-rt-users/20200824154605.v66t2rsxobt3r5jg@linutronix.de/
SRC_URI += " \
    file://0001-add-kernel-rt.patch \
    file://preempt-rt-full.cfg \
"

# Kernel Config that enables kgdb serial debug
# if KERNEL_DEBUG flag is set to "1" in local.conf
SRC_URI += "${@bb.utils.contains('KERNEL_DEBUG', '1', 'file://debug-configs.cfg', '', d)}"

# Applies the PREEMPT_RT patches and the configuration 
# options required to build a real-time Linux kernel
LINUX_KERNEL_TYPE = "preempt-rt"

###################################################+
#  Custom Device Tree Overlays
###################################################