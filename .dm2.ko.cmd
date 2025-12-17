savedcmd_dm2.ko := ld -r -m elf_x86_64 -z noexecstack --no-warn-rwx-segments --build-id=sha1  -T /usr/src/kernels/6.17.9-300.fc43.x86_64/scripts/module.lds -o dm2.ko dm2.o dm2.mod.o .module-common.o
