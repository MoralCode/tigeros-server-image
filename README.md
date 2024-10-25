# TigerOS Server Image

This is a system image that is managed using standard OCI container technology via bootc.





## Setup

1. create a `config.toml` with your settings per `config.toml.sample`
2. run `make build-container` to build the container image (uses `sudo podman`)

to install to a real or virtualized system for the first time, run either `make build-iso` or `make build-qcow2`

to run in QEMU: run `make run-image` (depends on having the built `qcow2` image available)