

BIB_CONTAINER = localhost/bootc-image-builder:amd64
# BIB_CONTAINER = quay.io/centos-bootc/bootc-image-builder:latest

# OS_CONTAINER = localhost/tigeros-server:latest
OS_CONTAINER_x86 = localhost/tigeros-server:amd64
OS_CONTAINER_ARM = localhost/tigeros-server:arm64


build-container:
	sudo podman build -t "${OS_CONTAINER_x86}" -f Containerfile.amd64 .

build-container-arm:
	sudo podman build --platform linux/arm64 -t "${OS_CONTAINER_ARM}" .


build-qcow2:
	sudo podman run --rm -it --privileged --pull=newer --security-opt label=type:unconfined_t -v ./config.toml:/config.toml:ro -v ./output:/output -v /var/lib/containers/storage:/var/lib/containers/storage "${BIB_CONTAINER}" --type qcow2 --rootfs ext4 --local "${OS_CONTAINER_x86}"

build-iso:
	sudo podman run --rm -it --privileged --pull=newer --security-opt label=type:unconfined_t -v ./config.toml:/config.toml:ro -v ./output:/output -v /var/lib/containers/storage:/var/lib/containers/storage "${BIB_CONTAINER}" --type anaconda-iso --rootfs ext4 --local localhost/tigeros-server:latest


run-image:
	qemu-system-x86_64 -M accel=kvm -cpu host -smp 2 -m 4096 -bios /usr/share/OVMF/OVMF_CODE.fd -nographic -snapshot output/qcow2/disk.qcow2

all: build-container build-image