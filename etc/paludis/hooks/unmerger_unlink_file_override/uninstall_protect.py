# http://blog.piotrj.org/2008/01/uninstallprotect-in-paludis-3.html

UNINSTALL_PROTECT=["/lib64/modules/"]

def hook_run_unmerger_unlink_file_override(env, hook_env):
    for path in UNINSTALL_PROTECT:
        if hook_env["UNLINK_TARGET"].startswith(path):
            return "skip"
        else:
            return ""

# #!/bin/bash
# #
# #http://blog.piotrj.org/2007/05/uninstallprotect-in-paludis-2.html
# UNINSTALL_PROTECT="/lib64/modules/"
 
# hook_run_unmerger_unlink_file_override() {
#     for PROTECT in ${UNINSTALL_PROTECT}; do
#         if [[ "${UNLINK_TARGET}" == "${PROTECT}"* ]]; then
#             echo "skip"
#         fi
#     done
# }
