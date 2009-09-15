# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
KMMODULE="libs/plasmagenericshell"
inherit kde4-meta

DESCRIPTION="Libraries for the KDE Plasma shell"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	>=kde-base/libkworkspace-${PV}:${SLOT}[kdeprefix=]
"

KMSAVELIBS="true"
