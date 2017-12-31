# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit stardict

DESCRIPTION="Stardict etc. dictionaries pack"
HOMEPAGE="http://xdxf.sourceforge.net
https://sites.google.com/site/gtonguedict/home/stardict-dictionaries"
SRC_URI="mirror://sourceforge/xdxf/stardict-comn_sdict05_brokg-2.4.2.tar.bz2
mirror://sourceforge/xdxf/stardict-comn_sdict05_dal-2.4.2.tar.bz2
mirror://sourceforge/xdxf/stardict-atla02_rus-rus_brok_efr-2.4.2.tar.bz2
mirror://sourceforge/xdxf/stardict-atla02_rus-rus_dalf-2.4.2.tar.bz2
mirror://sourceforge/xdxf/stardict-comn_dictd04_brok_and_efr-2.4.2.tar.bz2
mirror://sourceforge/xdxf/stardict-comn_dictd04_dalf-2.4.2.tar.bz2
mirror://sourceforge/xdxf/stardict-comn_dictd04_jargon-2.4.2.tar.bz2
mirror://sourceforge/xdxf/stardict-comn_dictd04_web1913-2.4.2.tar.bz2"
KEYWORDS="amd64 x86"

LICENSE="all-rights-reserved"
RESTRICT="mirror"

S=${WORKDIR}

src_unpack() {
	local a
	local b
	for a in ${A}; do
		unpack ${a}
	done
	for b in $(find $(pwd) -maxdepth 1 -mindepth 1 -type d); do
		cd ${b}
		mv * ..
	done
}

src_install() {
	stardict_src_install
	insinto /usr/share/stardict/dic
	# newins dict.xdxf
}
