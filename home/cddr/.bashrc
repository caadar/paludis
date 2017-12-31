paludis_updater=/tmp/paludis-updater
paludis_hooks_override=/tmp/paludis-hooks-override

# Forcing `_cave' load, otherwise bash completions for
# cave.resolve_complete etc will work only after:
# $ cave <TAB>
source /usr/share/bash-completion/completions/cave

cave.resolve_complete() {
	rm -f "${paludis_updater}"
	rm -f "${paludis_hooks_override}"
	# https://stackoverflow.com/questions/1668649/how-to-keep-quotes-in-args#1669548
	nice cave resolve --complete --purge '*/*' --permit-downgrade '*/*' --permit-uninstall '*/*' --permit-old-version '*/*' --uninstalls-may-break '*/*' --continue-on-failure if-independent --my-laconic-display "$@"
}
make-completion-wrapper _cave _cave.resolve_complete cave resolve
complete -o bashdefault -o default -F _cave.resolve_complete cave.resolve_complete

cave.reinstall_everything() {
	rm -f "${paludis_updater}"
	rm -f "${paludis_hooks_override}"
	nice cave resolve --everything --permit-downgrade '*/*' --permit-uninstall '*/*' --permit-old-version '*/*' --uninstalls-may-break '*/*' --continue-on-failure always --my-laconic-display "$@"
}
make-completion-wrapper _cave _cave.reinstall_everything cave resolve
complete -o bashdefault -o default -F _cave.reinstall_everything cave.reinstall_everything

alias cave.fix-perm="nice /usr/local/sbin/cave.fix-perm"
alias cave.errors="find /var/log/paludis -mtime -2 | xargs egrep -wi failed\|error\|incorrect"

alias config-decruft="config-decruft --log-level warning"
