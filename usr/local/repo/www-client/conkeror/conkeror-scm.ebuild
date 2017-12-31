# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils toolchain-funcs git-2

DESCRIPTION="A Mozilla-based web browser whose design is inspired by GNU Emacs"
HOMEPAGE="http://conkeror.org/"
SRC_URI=""
EGIT_REPO_URI="git://repo.or.cz/conkeror.git"

LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 ) CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

RDEPEND="|| ( >=www-client/firefox-5.0 >=www-client/firefox-bin-23.0
			 www-client/palemoon www-client/palemoon-bin )"

S="${WORKDIR}/${PN}"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	insinto /usr/share/${PN}
	doins -r branding chrome components content defaults help locale modules \
		search-engines style tests
	doins application.ini *.manifest

	exeinto /usr/libexec/${PN}
	doexe conkeror-spawn-helper
	dosym ../../libexec/${PN}/conkeror-spawn-helper \
		/usr/share/${PN}/conkeror-spawn-helper

	newbin "${FILESDIR}/conkeror-ff.sh" conkeror-firefox
	newbin "${FILESDIR}/conkeror-pm.sh" conkeror-palemoon

	doman contrib/man/conkeror.1
	dodoc CREDITS README
}
