#!/bin/bash

source "${PALUDIS_EBUILD_DIR}/echo_functions.bash"

_hook_updater_list=/tmp/paludis-updater  #(if changed correct ~/.bashrc also)

_kill_cave_now()
{
	# only ebuild phase hooks (ebuild in the hook name) have full
	# access to the ebuild environment (including the ability to call
	# `die' from `echo_functions.bash'), but are only used for
	# ebuild-based activities
	# (http://paludis.exherbo.org/configuration/hooks.html)
	# so kill cave directly as error handling is important
	# (https://devmanual.gentoo.org/ebuild-writing/error-handling/index.html)
	# even outsides ebuild phase

	eerror "$*"
	sleep 5s
	pkill -9 -x cave
}

_try_to_apply_patches()
{
	local ppath="/etc/paludis/hooks/autopatches/specific/$1"
	local pset="$2"
	local plist; plist=$(find "${ppath}/${pset}" -name "*.patch")
	local patch_cmd="patch -p0"

	if [[ -z "${plist}" ]]; then
		_kill_cave_now "Can not find any patches"
	fi

	for pname in ${plist}; do
		${patch_cmd} --dry-run -f < "${pname}" 2>&1
		local pret="$?"
		if [[ "${pret}" = "0" ]]; then
			echo "applying $(basename "${pname}")"
			${patch_cmd} < "${pname}" 2>&1
			local pret="$?"
			[[ "${pret}" = "0" ]] || _kill_cave_now "Dry-run patching with ${pname} succeeded but actually failed"
		else
			_kill_cave_now "Patch ${pname} can not be used"
		fi
	done
}

_bypass()
{
	local action=$1
	local hook_override_flag=/tmp/paludis-hooks-override  #(if changed correct ~/.bashrc also)

	case "$action" in
		set_hook_override_flag)
			touch "${hook_override_flag}"
			;;
		delete_hook_override_flag)
			rm -f "${hook_override_flag}"
			;;
		check)
			local exit_code=22

			## check hook exception
			[[ -f "${hook_override_flag}" ]] && return "${exit_code}"
			## check set exception (v2)
			[[ ${CAVE_PERFORM_CMDLINE_managed_output} -eq 1 ]] && return "${exit_code}"
			## check set exception (v1)
			# local set_param
			# set_param=$(grep -cw -- "--set" <<<"${CAVE_CMDLINE_PARAMS}")
			# [[ $set_param -eq 0 ]] && return 0
			# local set_name
			# local set_conf
			# set_name=${CAVE_EXECUTE_RESOLUTION_CMDLINE_world_specs}
			# set_conf=$(find "/etc/paludis/sets" -regex ".*/${set_name}\.\(conf\|bash\)")
			# [[ -n "$set_conf" ]] && return "${exit_code}"
			## normal exit
			return 0
			;;
		*)
			_kill_cave_now "Unknown action for _bypass function"
			;;
	esac
}
