#
# Copyright 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

# Inherit from common
-include $(COMMON_PATH)/BoardConfigCommon.mk

# TWRP specific build flags
TW_FRAMERATE := 120
TW_MAX_BRIGHTNESS := 550

# Vibrator
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true

TARGET_RECOVERY_DEVICE_MODULES += libexpat android.hardware.vibrator-V2-ndk
RECOVERY_LIBRARY_SOURCE_FILES += \
     $(TARGET_OUT_SHARED_LIBRARIES)/libexpat.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.vibrator-V2-ndk.so
    
# Kernel/Ramdisk
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
BOARD_KERNEL_IMAGE_NAME := kernel
BOARD_RAMDISK_USE_LZ4 := true
TARGET_KERNEL_CONFIG := $(TRG)

ifeq ($(TRG),)
  TARGET_KERNEL_ARCH := arm64
  TARGET_KERNEL_HEADER_ARCH := arm64
  TARGET_KERNEL_CONFIG := ossi
#  TARGET_KERNEL_CONFIG := grus_defconfig
  TARGET_KERNEL_CLANG_COMPILE := true
  TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-androidkernel-
  TARGET_KERNEL_SOURCE := kernel/oneplus/ossi
  TARGET_KERNEL_VERSION := 5.15
  TARGET_COMPILE_WITH_MSM_KERNEL := true
endif
