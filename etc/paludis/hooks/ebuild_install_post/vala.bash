#!/usr/bin/env bash

source /etc/paludis/paludis_aux.bash

if [[ "${CATEGORY}/${PN}" != "dev-lang/vala" ]]; then
	return 0
fi

cd "${D}/usr/bin/"
ln -sf valac-* valac
