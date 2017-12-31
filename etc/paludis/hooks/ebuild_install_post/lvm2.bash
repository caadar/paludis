#!/usr/bin/env bash

source /etc/paludis/paludis_aux.bash

if [[ "${CATEGORY}/${PN}" != "sys-fs/lvm2" ]]; then
	return 0
fi

cd "${D}"

_try_to_apply_patches "${CATEGORY}/${PN}"

# see also https://bugs.gentoo.org/show_bug.cgi?id=601998
