#!/bin/bash

# https://github.com/hasufell/paludis-gentoo-git-config/blob/master/etc/paludis/hooks/sync_post/03-sync_gentoo_glsa.bash

source "${PALUDIS_EBUILD_DIR}/echo_functions.bash"
source "/etc/paludis/hooks/set_portdir.bash"

if [[ ${TARGET} == gentoo ]] ; then
	GLSADIR=${PORTDIR}/metadata/glsa
	ebegin "Updating GLSAs"
	if [[ -e ${GLSADIR} ]]; then
		git -C "${GLSADIR}" pull -q --ff-only
	else
		git clone -q https://anongit.gentoo.org/git/data/glsa.git "${GLSADIR}"
	fi
	eend "$?"
fi
