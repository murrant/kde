# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib

DESCRIPTION="Environment setting required for all KDE Frameworks apps to run"
HOMEPAGE="http://community.kde.org/Frameworks"
SRC_URI=""

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	x11-misc/xdg-utils
"

S=${WORKDIR}

src_unpack() { :; }

src_prepare() { :; }

pkg_preinst() { :; }

src_install() {
	einfo "Installing environment file..."

	# higher number to be sure not to kill kde4 env
	local envfile="${T}/78kf"
	local libdir="${EPREFIX}/usr/$(get_libdir)"
	local qt5bin="${libdir}/qt5/bin"

	echo "PATH=${qt5bin}" > ${envfile}
	echo "ROOTPATH=${qt5bin}" >> ${envfile}
	echo "CONFIG_PROTECT=${EPREFIX}/usr/share/config" >> ${envfile}
	echo "COLON_SEPARATED=QT_PLUGIN_PATH" >> ${envfile}
	echo "QT_PLUGIN_PATH=${libdir}/plugins:${libdir}/qt5/plugins:${QT_PLUGIN_PATH}" >> ${envfile}
	echo "QML2_IMPORT_PATH=${libdir}/qml:${libdir}/qt5/qml" >> ${envfile}
	doenvd ${envfile}
}

src_test() { :; }
