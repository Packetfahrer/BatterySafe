#import <Preferences/Preferences.h>

@interface BatterySafePrefListController: PSListController {
}
@end

@implementation BatterySafePrefListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"BatterySafePref" target:self] retain];
	}
	return _specifiers;
}

- (void) facebook:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/thejailpad.apple"]];
}

- (void) twitter:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/TheJailPadApple"]];
}

- (void) about:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"About" 
        message:@"BatterySafe is a tweak that allows you to lower the brightness if you have a lot more battery Coded By TheJailpad" 
        delegate:nil 
        cancelButtonTitle:@"Ok" 
        otherButtonTitles:nil];
    [alert show];
    [alert release];
}

@end

// vim:ft=objc
