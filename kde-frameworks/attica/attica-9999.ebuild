# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_NLS="false"
inherit kde5

DESCRIPTION="Framework providing access to Open Collaboration Services"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtnetwork:5
"
DEPEND="${RDEPEND}"
