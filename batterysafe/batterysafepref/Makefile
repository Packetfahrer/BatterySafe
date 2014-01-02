include theos/makefiles/common.mk

BUNDLE_NAME = BatterySafePref
BatterySafePref_FILES = BatterySafePref.mm
BatterySafePref_INSTALL_PATH = /Library/PreferenceBundles
BatterySafePref_FRAMEWORKS = UIKit
BatterySafePref_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BatterySafePref.plist$(ECHO_END)
