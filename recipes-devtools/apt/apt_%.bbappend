#  Adds the source list to apt
#  Package management configuration

# Add files to the search paths
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://pkg-server.list.in \
"

# Update apt source list file with the Package Feed URI
# defined in rpi4-core-rt.conf
run_sed() {
    outfile=$(basename "$1" .in)
    sed -e's,@PACKAGE_FEED_URIS@,${PACKAGE_FEED_URIS},g' "$1" > ${WORKDIR}/$outfile
}

do_configure:append() {
    run_sed ${WORKDIR}/pkg-server.list.in
}

do_install:append:() {
    # Create /var/lib/dpkg/status file
    # https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_the_dpkg_command
    install -d ${D}${localstatedir}/lib/dpkg
    touch ${D}${localstatedir}/lib/dpkg/status

    # Create pkg-server.list and 
    # write the yocto build server's (arnold) exposed package server ip
    # to sources.list.d directory
    install -d ${D}${sysconfdir}/apt/sources.list.d
    install -m 0644 ${WORKDIR}/pkg-server.list ${D}${sysconfdir}/apt/sources.list.d
}

FILES:${PN} += "${sysconfdir}/apt/sources.list.d/pkg-server.list"
FILES:${PN} += "${localstatedir}/lib/dpkg/status"