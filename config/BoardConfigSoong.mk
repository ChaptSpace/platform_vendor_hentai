PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE

# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/LineageOS/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

SOONG_CONFIG_NAMESPACES += hentaiVarsPlugin

SOONG_CONFIG_hentaiVarsPlugin :=

define addVar
  SOONG_CONFIG_hentaiVarsPlugin += $(1)
  SOONG_CONFIG_hentaiVarsPlugin_$(1) := $$(subst ",\",$$($1))
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += hentaiGlobalVars
SOONG_CONFIG_hentaiGlobalVars += \
    target_surfaceflinger_udfps_lib

# Set default values
TARGET_SURFACEFLINGER_UDFPS_LIB ?= surfaceflinger_udfps_lib

# Soong value variables
SOONG_CONFIG_hentaiGlobalVars_target_surfaceflinger_udfps_lib := $(TARGET_SURFACEFLINGER_UDFPS_LIB)

SOONG_CONFIG_NAMESPACES += hentaiQcomVars
SOONG_CONFIG_hentaiQcomVars += \
    supports_extended_compress_format \
    qcom_display_headers_namespace

# Soong value variables
SOONG_CONFIG_hentaiQcomVars_supports_extended_compress_format := $(AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT)
SOONG_CONFIG_hentaiQcomVars_qcom_display_headers_namespace := vendor/qcom/opensource/commonsys-intf/display
