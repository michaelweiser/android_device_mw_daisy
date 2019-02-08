include build/make/target/board/generic_arm64_ab/BoardConfig.mk

BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/mw/daisy/bluetooth

ifeq ($(BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE),)
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2147483648
endif
