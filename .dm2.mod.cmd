savedcmd_dm2.mod := printf '%s\n'   dm2.o | awk '!x[$$0]++ { print("./"$$0) }' > dm2.mod
