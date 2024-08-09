
## Setup

1. create a `config.toml` with your settings per `config.toml.sample`
2. run `./build.sh` to generate a qcow2 image

to run in QEMU:

```bash
qemu-system-x86_64 \
    -M accel=kvm \
    -cpu host \
    -smp 2 \
    -m 4096 \
    -bios /usr/share/OVMF/OVMF_CODE.fd \
    -serial stdio \
    -snapshot output/qcow2/disk.qcow2
```