TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X11 Athena Widget library"
# Licenses: MIT, HPND
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=1.0.16
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXaw-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=731d572b54c708f81e197a6afa8016918e2e06dfd3025e066ca642a5b8c39c8f
TERMUX_PKG_DEPENDS="libxmu-glibc, libxpm-glibc"
TERMUX_PKG_BUILD_DEPENDS="xorg-util-macros-glibc"
