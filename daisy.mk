# https://github.com/phhusson/device_phh_treble/blob/android-9.0/base.mk

include build/make/target/product/treble_common.mk

#Use a more decent APN config
PRODUCT_COPY_FILES += \
	device/sample/etc/apns-full-conf.xml:system/etc/apns-conf.xml

BOARD_PLAT_PRIVATE_SEPOLICY_DIR += device/mw/daisy/sepolicy
DEVICE_PACKAGE_OVERLAYS += device/mw/daisy/overlay

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
	ro.adb.secure=0

PRODUCT_PACKAGES += \
	DaisyAppDisabler

#VNDK config files
PRODUCT_COPY_FILES += \
	device/mw/daisy/device-fixups.rc:system/etc/init/device-fixups.rc \
	device/mw/daisy/fix-keymaster.sh:system/bin/fix-keymaster.sh \
	device/mw/daisy/disable-vendor.sh:system/bin/disable-vendor.sh \
	device/mw/daisy/resize-userdata.sh:system/bin/resize-userdata.sh

#USB Audio
PRODUCT_COPY_FILES += \
	frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:system/etc/usb_audio_policy_configuration.xml

PRODUCT_PACKAGES += \
	getSPL \
	bootctl \
	vintf

# 02-07 22:26:57.279  3146  3146 F linker  : CANNOT LINK EXECUTABLE "/vendor/bin/mtd@1.1": library "vendor.xiaomi.hardware.mtdservice@1.0.so" not found
PRODUCT_COPY_FILES += \
	device/mw/daisy/files/system/lib/vendor.xiaomi.hardware.mlipay@1.1.so:system/lib/vendor.xiaomi.hardware.mlipay@1.1.so \
	device/mw/daisy/files/system/lib/vendor.xiaomi.hardware.mtdservice@1.1.so:system/lib/vendor.xiaomi.hardware.mtdservice@1.1.so \
	device/mw/daisy/files/system/lib/vendor.xiaomi.hardware.mfidoca@1.0.so:system/lib/vendor.xiaomi.hardware.mfidoca@1.0.so \
	device/mw/daisy/files/system/lib/vendor.xiaomi.hardware.mtdservice@1.0.so:system/lib/vendor.xiaomi.hardware.mtdservice@1.0.so \
	device/mw/daisy/files/system/lib/vendor.xiaomi.hardware.mlipay@1.0.so:system/lib/vendor.xiaomi.hardware.mlipay@1.0.so \
	device/mw/daisy/files/system/lib64/vendor.xiaomi.hardware.mlipay@1.1.so:system/lib64/vendor.xiaomi.hardware.mlipay@1.1.so \
	device/mw/daisy/files/system/lib64/vendor.xiaomi.hardware.mtdservice@1.1.so:system/lib64/vendor.xiaomi.hardware.mtdservice@1.1.so \
	device/mw/daisy/files/system/lib64/vendor.xiaomi.hardware.mfidoca@1.0.so:system/lib64/vendor.xiaomi.hardware.mfidoca@1.0.so \
	device/mw/daisy/files/system/lib64/vendor.xiaomi.hardware.mtdservice@1.0.so:system/lib64/vendor.xiaomi.hardware.mtdservice@1.0.so \
	device/mw/daisy/files/system/lib64/vendor.xiaomi.hardware.mlipay@1.0.so:system/lib64/vendor.xiaomi.hardware.mlipay@1.0.so

SELINUX_IGNORE_NEVERALLOWS := true

PRODUCT_NAME := daisy
PRODUCT_DEVICE := daisy
PRODUCT_BRAND := Android
PRODUCT_MODEL := daisy Treble vanilla
