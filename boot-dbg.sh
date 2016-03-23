#!/bin/sh
rm -f xc xem xmkfs root/bin/c root/etc/os os root/etc/sfs.img fs.img *.dml *.s [a-z]*.txt
rm -f root/bin/c root/bin/os root/etc/sfs.img
gcc -o xc -O3 -m32 -Ilinux -Iroot/lib root/bin/c.c
gcc -o xem -O3 -m32 -Ilinux -Iroot/lib root/bin/em.c -lm
gcc -o xmkfs -O3 -m32 -Ilinux -Iroot/lib root/etc/mkfs.c
./xc -o root/bin/c -Iroot/lib root/bin/c.c
./xc -o root/etc/os -Iroot/lib root/etc/os.c
./xc -s -Iroot/lib root/etc/os.c >os.dml 
./xmkfs sfs.img root
mv sfs.img root/etc/.
./xmkfs fs.img root
cp ./root/etc/os .
./xem -g os.dml -f fs.img os
