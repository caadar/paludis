# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

DESCRIPTION="Gohufont is a monospace bitmap font well suited for programming and terminal use"
HOMEPAGE="http://font.gohu.eu"
SRC_URI="http://font.gohu.org/gohufont-2.0.tar.gz"
RESTRICT="mirror"

LICENSE="WTFPL"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 x86-fbsd"
IUSE="X"

DEPEND=""
RDEPEND=""

FONT_SUFFIX="pcf.gz"
FONTDIR=/usr/share/fonts/gohufont
DOCS="README"
