#!/bin/bash
# Wrapper script to run Conkeror with Firefox

for cmd in firefox firefox-bin; do
    xr=$(type -p ${cmd})
    if [[ -n ${xr} ]]; then
	: ${MOZ_PLUGIN_PATH:=/usr/lib/nsbrowser/plugins} #497070
	export MOZ_PLUGIN_PATH
	XUL_APP_FILE="/usr/share/conkeror/application.ini" exec "${xr}" "$@"
    fi
done

echo "$0: firefox required, but not found." >&2
exit 1
