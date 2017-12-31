#!/bin/bash
# Wrapper script to run Conkeror with Pale Moon

for cmd in palemoon palemoon-bin; do
    xr=$(type -p ${cmd})
    if [[ -n ${xr} ]]; then
	: ${MOZ_PLUGIN_PATH:=/usr/lib/nsbrowser/plugins} #497070
	export MOZ_PLUGIN_PATH
	XUL_APP_FILE="/usr/share/conkeror/application.ini" exec "${xr}" "$@"
    fi
done

echo "$0: palemoon required, but not found." >&2
exit 1
