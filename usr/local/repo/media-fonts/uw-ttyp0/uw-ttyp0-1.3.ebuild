# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

DESCRIPTION="UW ttyp0 is a family of monospaced bitmap fonts"
HOMEPAGE="http://people.mpi-inf.mpg.de/~uwe/misc/uw-ttyp0/"
SRC_URI="https://people.mpi-inf.mpg.de/~uwe/misc/uw-ttyp0/uw-ttyp0-1.3.tar.gz"
RESTRICT="mirror"

LICENSE="FREE MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 x86-fbsd"

IUSE="X accents digit0dotted digit0slashed supasterisk acutes
mtilde nbs-blank nbs-dotted phyphenminus currflorin ltcapengsami
bulgarian serbian"

REQUIRED_USE="digit0dotted? ( !digit0slashed )
	nbs-blank? ( !nbs-dotted )"

DEPEND="dev-lang/perl
	x11-apps/bdftopcf"
RDEPEND=""

FONT_SUFFIX="pcf.gz"
FONTDIR=/usr/share/fonts/uw-ttyp0

FONT_S="${S}/genpcf"
VARIANTS="${S}/VARIANTS.dat"

src_prepare() {
	default
	use accents       && sed -e '/COPYTO AccStress/s@^#@@' \
							 -e '/COPYTO PAmComma/s@^#@@' -i "${VARIANTS}"
	use digit0dotted  && sed    '/COPYTO Digit0Dotted/s@^#@@' -i "${VARIANTS}"
	use digit0slashed && sed    '/COPYTO Digit0Slashed/s@^#@@' -i "${VARIANTS}"
	use supasterisk   && sed    '/COPYTO SupAsterisk/s@^#@@' -i "${VARIANTS}"
	use acutes        && sed -e '/COPYTO MLessAlt1/s@^#@@' \
							 -e '/COPYTO MGreaterAlt1/s@^#@@' -i "${VARIANTS}"
	use mtilde        && sed    '/COPYTO MTilde/s@^#@@' -i "${VARIANTS}"
	use nbs-blank     && sed    '/COPYTO Space/s@^#@@' -i "${VARIANTS}"
	use nbs-dotted    && sed    '/COPYTO DVisibleSpace/s@^#@@' -i "${VARIANTS}"
	use phyphenminus  && sed    '/COPYTO PHyphenMinus/s@^#@@' -i "${VARIANTS}"
	use currflorin    && sed    '/COPYTO CurrFlorin/s@^#@@' -i "${VARIANTS}"
	use ltcapengsami  && sed    '/COPYTO LtCapEngSami/s@^#@@' -i "${VARIANTS}"
	use bulgarian     && sed -e '/COPYTO CyCapElBul/s@^#@@' \
							 -e '/COPYTO CySmlVeBul/s@^#@@' \
							 -e '/COPYTO CySmlGheBul/s@^#@@' \
							 -e '/COPYTO CySmlDeBul/s@^#@@' \
							 -e '/COPYTO CySmlZheBul/s@^#@@' \
							 -e '/COPYTO CySmlZeBul/s@^#@@' \
							 -e '/COPYTO CySmlIBul/s@^#@@' \
							 -e '/COPYTO CySmlIBreveBul/s@^#@@' \
							 -e '/COPYTO CySmlKaBul/s@^#@@' \
							 -e '/COPYTO CySmlElBul/s@^#@@' \
							 -e '/COPYTO CySmlPeBul/s@^#@@' \
							 -e '/COPYTO CySmlTeBul/s@^#@@' \
							 -e '/COPYTO CySmlTseBul/s@^#@@' \
							 -e '/COPYTO CySmlShaBul/s@^#@@' \
							 -e '/COPYTO CySmlShchaBul/s@^#@@' \
							 -e '/COPYTO CySmlYuBul/s@^#@@' \
							 -e '/COPYTO CySmlIGraveBul/s@^#@@' -i "${VARIANTS}"
	use serbian       && sed -e '/COPYTO CySmlBeSrb/s@^#@@' \
							 -e '/COPYTO CySmlGheSrb/s@^#@@' \
							 -e '/COPYTO CySmlDeSrb/s@^#@@' \
							 -e '/COPYTO CySmlPeSrb/s@^#@@' \
							 -e '/COPYTO CySmlTeSrb/s@^#@@' \
							 -e '/COPYTO CySmlGheAcuteMcd/s@^#@@' -i "${VARIANTS}"
}

src_configure() {
	# not autotools-based
	./configure \
		--prefix="${EPREFIX}"/usr || die
}

src_install() {
	dodoc CHARSET DESIGN FAQ LICENSE README
	cd ${FONT_S}
	font_src_install
}
