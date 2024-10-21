FROM quay.io/fedora/fedora-bootc:40

RUN echo VARIANT="TigerOS Server" >> /usr/lib/os-release
RUN echo VARIANT_ID=com.gitlab.ritlug.tigeros.server  >> /usr/lib/os-release
RUN echo IMAGE_VERSION="0.0.1" >> /usr/lib/os-release
