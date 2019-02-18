# !/bin/env/ bash

apt-get update;
apt-get install binutils debootstrap;

export MCHRMIRROR=http://deb.debian.org/debian ;
export MCHRARCH=amd64;
# export MCHRARCH=i386;
export MCHRREL=stretch;
export MCHRDIR=/srv/chroot/${MCHRREL}-${MCHRARCH};

echo My chroot dir is ${MCHRDIR};

mkdir -p ${MCHRDIR};

# next step takes much more time
debootstrap --variant=buildd --arch=${MCHRARCH} ${MCHRREL} ${MCHRDIR} ${MCHRMIRROR}

# prevent that dpkg starts deamons in the chroot environment
cat > ${MCHRDIR}/usr/sbin/policy-rc.d <<EOF
#!/bin/sh
exit 101
EOF

chmod a+x ${MCHRDIR}/usr/sbin/policy-rc.d

# in the chroot "hard code" ischroot to true
cp  ${MCHRDIR}/bin/true ${MCHRDIR}/usr/bin/ischroot

#
cp /etc/hosts ${MCHRDIR}/etc/hosts
cp /etc/resolv.conf ${MCHRDIR}/etc/resolv.conf

# that was what needs be done only once

# mount stuff, you will need more often
mount --bind /dev ${MCHRDIR}/dev
mount --bind /dev/pts ${MCHRDIR}/dev/pts
mount --bind /proc  ${MCHRDIR}/proc

