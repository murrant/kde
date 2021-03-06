# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="KDE Plasma workspace"
KEYWORDS=""
IUSE="dbus gps prison qalculate X"

COMMON_DEPEND="
	$(add_kdebase_dep libksysguard)
	$(add_kdebase_dep baloo)
	$(add_kdebase_dep kwin)
	$(add_frameworks_dep kactivities)
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kdesu)
	$(add_frameworks_dep kdewebkit)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kidletime)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kjs)
	$(add_frameworks_dep kjsembed)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep krunner)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep plasma)
	$(add_frameworks_dep solid)
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5[jpeg]
	dev-qt/qtnetwork:5
	dev-qt/qtscript:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/phonon[qt5]
	sys-libs/pam
	sys-libs/zlib
	x11-libs/libkscreen:5
	dbus? ( dev-libs/libdbusmenu-qt[qt5] )
	gps? ( sci-geosciences/gpsd )
	prison? ( media-libs/prison:5 )
	qalculate? ( sci-libs/libqalculate )
	X? (
		dev-qt/qtx11extras:5
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libxcb
		x11-libs/libXrender
		x11-libs/xcb-util-keysyms
	)
"
RDEPEND="${COMMON_DEPEND}
	$(add_frameworks_dep kded)
	$(add_kdebase_dep milou)
	dev-qt/qdbus:5
	dev-qt/qtpaths:5
	dev-qt/qtquickcontrols:5[widgets]
	!kde-base/freespacenotifier:4
	!kde-base/libtaskmanager:4
	!kde-base/kcminit:4
	!kde-base/kdebase-startkde:4
	!kde-base/klipper:4
	!kde-base/krunner:4
	!kde-base/ksmserver:4
	!kde-base/ksplash:4
	!kde-base/plasma-workspace:4
"
DEPEND="${COMMON_DEPEND}
	X? ( x11-proto/xproto )
"

PATCHES=( "${FILESDIR}/${PN}-startkde-script.patch" )

RESTRICT="test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package dbus dbusmenu-qt5)
		$(cmake-utils_use_find_package gps libgps)
		$(cmake-utils_use_find_package prison)
		$(cmake-utils_use_find_package qalculate Qalculate)
		$(cmake-utils_use_find_package X X11)
	)

	kde5_src_configure
}

src_install() {
	kde5_src_install

	# startup and shutdown scripts
	insinto /etc/plasma/startup
	doins "${FILESDIR}/agent-startup.sh"

	insinto /etc/plasma/shutdown
	doins "${FILESDIR}/agent-shutdown.sh"
}

pkg_postinst () {
	kde5_pkg_postinst

	echo
	elog "To enable gpg-agent and/or ssh-agent in Plasma sessions,"
	elog "edit ${EPREFIX}/etc/plasma/startup/agent-startup.sh and"
	elog "${EPREFIX}/etc/plasma/shutdown/agent-shutdown.sh"
	echo
}
