# !/bin/env bash

export MCHRARCH=amd64;
export MCHRREL=stretch;
export MCHRDIR=/srv/chroot/${MCHRREL}-${MCHRARCH};

echo My chroot dir is ${MCHRDIR};

[ ! -z ${MCHRDIR} ] && echo my chroot dir is ${MCHRDIR}
[ ! -z ${MCHRDIR} ] && umount ${MCHRDIR}/proc
[ ! -z ${MCHRDIR} ] && umount ${MCHRDIR}/dev/pts
[ ! -z ${MCHRDIR} ] && umount ${MCHRDIR}/dev

rm -rf ${MCHRDIR};
