#import <UIKit/UIKit2.h>
#import <WebKit/WebKit.h>
#import <WebCore/WebCore.h>
#import <Preferences/Preferences.h>
#import "ActionMenu.h"

@interface UIWebBrowserView ()
- (WebFrame *)_focusedOrMainFrame;
@end

@interface WebFrame ()
- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)string forceUserGesture:(BOOL)forceUserGesture;
@end

@implementation UIWebBrowserView (ChromeforActionMenu)

- (BOOL)canOpenInChrome:(id)sender
{
	WebThreadLock();
	WebFrame *webFrame = [self _focusedOrMainFrame];
	NSString *URL = [webFrame stringByEvaluatingJavaScriptFromString:@"location.href" forceUserGesture:NO];
	WebThreadUnlock();
	return [URL hasPrefix:@"http://"] || [URL hasPrefix:@"https://"];
}

- (void)openInChrome:(id)sender
{
  WebThreadLock();
  WebFrame *webFrame = [self _focusedOrMainFrame];
  NSString *websiteURL = [webFrame stringByEvaluatingJavaScriptFromString:@"location.href" forceUserGesture:NO];
  NSString *withoutProtocolURL = [websiteURL substringFromIndex:4];
  NSString *chromeURL = [NSString stringWithFormat:@"googlechrome%@", withoutProtocolURL];
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:chromeURL]];
  WebThreadUnlock();
}

+ (void)load
{
	id<AMMenuItem> menuItem = [[UIMenuController sharedMenuController] registerAction:@selector(openInChrome:) title:@"Chrome" canPerform:@selector(canOpenInChrome:) forPlugin:@"Chrome"];
	menuItem.priority = 1000;
	menuItem.image = [UIImage imageWithContentsOfFile:([UIScreen mainScreen].scale == 2.0f) ? @"/Library/ActionMenu/Plugins/Chrome@2x.png" : @"/Library/ActionMenu/Plugins/Chrome.png"];
}

@end

