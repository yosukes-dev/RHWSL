OUT_ZIP=RHWSL.zip
LNCR_EXE=RHWSL.exe

DLR=curl
DLR_FLAGS=-L
LNCR_URL=https://github.com/yuk7/wsldl/releases/download/21020500/Launcher.exe

all: $(OUT_ZIP)

zip: $(OUT_ZIP)
$(OUT_ZIP): ziproot
	@echo -e '\e[1;31mBuilding $(OUT_ZIP)\e[m'
	cd ziproot; zip ../$(OUT_ZIP) *

ziproot: Launcher.exe rootfs.tar.gz
	@echo -e '\e[1;31mBuilding ziproot...\e[m'
	mkdir ziproot
	cp Launcher.exe ziproot/${LNCR_EXE}
	cp rootfs.tar.gz ziproot/

exe: Launcher.exe
Launcher.exe:
	@echo -e '\e[1;31mExtracting Launcher.exe...\e[m'
	$(DLR) $(DLR_FLAGS) $(LNCR_URL) -o Launcher.exe

rootfs.tar.gz: rootfs
	@echo -e '\e[1;31mBuilding rootfs.tar.gz...\e[m'
	cd rootfs; sudo tar -zcpf ../rootfs.tar.gz `sudo ls`
	sudo chown `id -un` rootfs.tar.gz

rootfs: base.tar
	@echo -e '\e[1;31mBuilding rootfs...\e[m'
	mkdir rootfs
	sudo tar -xpf base.tar -C rootfs
	echo "# This file was automatically generated by WSL. To stop automatic generation of this file, remove this line." | sudo tee rootfs/etc/resolv.conf
	sudo chmod +x rootfs

base.tar:
	@echo -e '\e[1;31mExporting base.tar using docker...\e[m'
	docker run --name rhwsl registry.access.redhat.com/ubi8/ubi:8.3-199 /bin/bash -c "dnf update -y; dnf clean all; pwconv; grpconv; chmod 0744 /etc/shadow; chmod 0744 /etc/gshadow;"
	docker export --output=base.tar rhwsl
	docker rm -f rhwsl

clean:
	@echo -e '\e[1;31mCleaning files...\e[m'
	-rm ${OUT_ZIP}
	-rm -r ziproot
	-rm Launcher.exe
	-rm rootfs.tar.gz
	-sudo rm -r rootfs
	-rm base.tar
	-docker rmi registry.access.redhat.com/ubi8/ubi:8.3-199
