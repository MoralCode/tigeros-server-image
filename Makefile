

build-container:
	sudo podman build -t tigeros-server:latest .


build-image: build-container
	sudo podman run     --rm     -it     --privileged     --pull=newer     --security-opt label=type:unconfined_t     -v $(pwd)/config.toml:/config.toml:ro     -v $(pwd)/output:/output     -v /var/lib/containers/storage:/var/lib/containers/storage     quay.io/centos-bootc/bootc-image-builder:latest     --type qcow2 --rootfs ext4     --local     localhost/tigeros-server:latest

run-image: build_image
	qemu-system-x86_64     -M accel=kvm     -cpu host     -smp 2     -m 4096     -bios /usr/share/OVMF/OVMF_CODE.fd     -serial stdio     -snapshot output/qcow2/disk.qcow2
