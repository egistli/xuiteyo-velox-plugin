export ARCHS=armv7
export TARGET=iphone:latest:4.3
include theos/makefiles/common.mk

BUNDLE_NAME = XuiteYoVelox
XuiteYoVelox_FILES = XuiteYoVeloxFolderView.mm
XuiteYoVelox_INSTALL_PATH = /Library/Velox/Plugins/
XuiteYoVelox_FRAMEWORKS = Foundation UIKit

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
