include ../theos/makefiles/common.mk

BUNDLE_NAME = CCHidePrefs
CCHidePrefs_FILES = CCHidePrefs.mm
CCHidePrefs_INSTALL_PATH = /Library/PreferenceBundles
CCHidePrefs_FRAMEWORKS = UIKit
CCHidePrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CCHidePrefs.plist$(ECHO_END)
