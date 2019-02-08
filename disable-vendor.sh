#!/system/bin/sh -e

for f in /vendor/overlay/SysuiDarkTheme/{SysuiDarkTheme.apk,SysuiDarkThemeOverlay.apk} ; do
	[ -f $f ] || continue
	mount -o bind /mnt/disable-vendor/empty $f
done

mount -o bind /mnt/disable-vendor/empty_dir /vendor/etc/audio
