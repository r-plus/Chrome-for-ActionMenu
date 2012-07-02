include framework/makefiles/common.mk

TWEAK_NAME = Chrome
Chrome_FILES = Chrome.m
Chrome_FRAMEWORKS = UIKit QuartzCore
Chrome_PRIVATE_FRAMEWORKS = WebKit WebCore
Chrome_INSTALL_PATH = /Library/ActionMenu/Plugins

include framework/makefiles/tweak.mk
