$(call inherit-product, vendor/ponces/config/common.mk)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.system.ota.json_url=https://raw.githubusercontent.com/MrFluffyOven/treble_bliss/android-14.0/config/ota.json

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.system.gms.spoof_file=https://raw.githubusercontent.com/MrFluffyOven/treble_bliss/android-14.0/config/spoof.json
