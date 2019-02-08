#!/system/bin/sh -e

# https://github.com/phhusson/device_phh_treble/blob/android-9.0/rw-system.sh

slot=$(getprop ro.boot.slot_suffix)
img=/dev/block/by-name/boot$slot
[ -b "$img" ]

#Rewrite SPL/Android version if needed
setprop ro.keymaster.xxx.release "$(getSPL $img android)"
setprop ro.keymaster.xxx.security_patch "$(getSPL $img spl)"

for f in /vendor/lib{,64}/hw/android.hardware.keymaster@3.0-impl-qti.so \
	/system/lib{,64}/vndk-27/libsoftkeymasterdevice.so .so ; do
	[ -f $f ] || continue
	ctxt="$(ls -lZ $f |grep -oE 'u:object_r:[^:]*:s0')"
	b="$(echo "$f"|tr / _)"

	cp -a $f /mnt/fix-keymaster/$b
	sed -i \
		-e 's/ro.build.version.release/ro.keymaster.xxx.release/g' \
		-e 's/ro.build.version.security_patch/ro.keymaster.xxx.security_patch/g' \
		-e 's/ro.product.model/ro.keymaster.mod/g' \
		/mnt/fix-keymaster/$b
	chcon "$ctxt" /mnt/fix-keymaster/$b
	mount -o bind /mnt/fix-keymaster/$b $f
done

[ "$(getprop init.svc.keymaster-3-0)" != "running" ] || \
	setprop ctl.restart keymaster-3-0
[ "$(getprop init.svc.teed)" != "running" ] || \
	setprop ctl.restart teed
