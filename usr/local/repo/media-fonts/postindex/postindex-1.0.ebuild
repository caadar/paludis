# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit font

DESCRIPTION="Figurnovs postindex font"
HOMEPAGE=""
SRC_URI="posti_t1.zip"
RESTRICT="fetch"

LICENSE="freeware"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 x86-fbsd"
IUSE="X"

DEPEND="app-arch/unzip"
RDEPEND=""

FONT_SUFFIX="afm pfb pfm"
FONT_S="${WORKDIR}"

pkg_nofetch() {
	einfo "Please download font and move it to ${DISTDIR}"
}

src_unpack() {
		unzip -LL -q "${DISTDIR}/${A}" || die
		iconv -f cp1251 -t utf-8 < read_me1.win > README
}
