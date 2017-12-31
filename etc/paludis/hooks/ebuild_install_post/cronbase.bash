#!/usr/bin/env bash

source /etc/paludis/paludis_aux.bash

if [[ "${CATEGORY}/${PN}" != "sys-process/cronbase" ]]; then
	return 0
fi

cd "${D}"

_try_to_apply_patches "${CATEGORY}/${PN}"
