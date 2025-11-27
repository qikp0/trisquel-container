FROM docker.io/pureos/pureos:crimson as builder

RUN apt-get update && apt-get install debootstrap fakeroot -y && apt-get clean

ARG suite
RUN fakeroot debootstrap --no-check-gpg "$suite" /target-rootfs/ https://mirror.math.princeton.edu/pub/trisquel-packages/ gutsy

FROM scratch

COPY --from=builder /target-rootfs/ /

CMD ["/bin/bash"]
