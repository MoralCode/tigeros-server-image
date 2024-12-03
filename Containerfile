FROM quay.io/fedora/fedora-bootc:40


COPY os-release /usr/lib/os-release

RUN dnf -y install cockpit cockpit-ws cockpit-podman git tree tailscale && dnf clean all && systemctl enable cockpit.socket

# bootupd currently does not support Raspberry Pi-specific firmware and bootloader files.
# This shim script copies the firmware and bootloader files to the correct location before
# calling the original bootupctl script.
# This is a temporary workaround until https://github.com/coreos/bootupd/issues/651 is resolved.
RUN dnf install -y bcm283x-firmware uboot-images-armv8 && \
  cp -P /usr/share/uboot/rpi_arm64/u-boot.bin /boot/efi/rpi-u-boot.bin && \
  mkdir -p /usr/lib/bootc-raspi-firmwares && \
  cp -a /boot/efi/. /usr/lib/bootc-raspi-firmwares/ && \
  dnf remove -y bcm283x-firmware uboot-images-armv8 && \
  mkdir /usr/bin/bootupctl-orig && \
  mv /usr/bin/bootupctl /usr/bin/bootupctl-orig/ && \
  dnf clean all

COPY bootupctl-shim /usr/bin/bootupctl
