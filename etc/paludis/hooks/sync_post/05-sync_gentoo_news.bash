#!/bin/bash

# https://github.com/hasufell/paludis-gentoo-git-config/blob/master/etc/paludis/hooks/sync_post/05-sync_gentoo_news.bash

source "${PALUDIS_EBUILD_DIR}/echo_functions.bash"
source "/etc/paludis/hooks/set_portdir.bash"

if [[ ${TARGET} == gentoo ]] ; then
	NEWSDIR="${PORTDIR}"/metadata/news
	ebegin "Updating news items"
	if [[ -e ${NEWSDIR} ]]; then
		git -C "${NEWSDIR}" pull -q --ff-only
	else
		git clone -q https://anongit.gentoo.org/git/data/gentoo-news.git "${NEWSDIR}"
	fi
	eend $? "Try to remove ${PORTDIR}/metadata/news"
fi
