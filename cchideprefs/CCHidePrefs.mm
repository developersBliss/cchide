#import <Preferences/Preferences.h>

@interface CCHidePrefsListController: PSListController {
    //3 - media
    //4 - air
    //6 - Group
    //7 - MediaSwitch
    //8 - Group
    //9 - air
}
@end

@implementation CCHidePrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"CCHidePrefs" target:self] retain];
	}
    
	return _specifiers;
}

-(void)setMediaControls:(id)value specifier:(id)specifier {
    [self setPreferenceValue:value specifier:specifier];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setAirStuff:(id)value specifier:(id)specifier {
	[self setPreferenceValue:value specifier:specifier];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setConditionalMediaControls:(id)value specifier:(id)specifier {
    [self setPreferenceValue:value specifier:specifier];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setConditionalAirStuff:(id)value specifier:(id)specifier {
    [self setPreferenceValue:value specifier:specifier];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)followOnTwitter {
	if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) {
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tweetbot:///user_profile/developersBliss"]];
	} else if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"tweetings:"]]) {
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tweetings:///user?screen_name=developersBliss"]];
	} else if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"twitter://user?screen_name=developersBliss"]];
	} else {
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://twitter.com/intent/follow?screen_name=developersBliss"]];
	}
}
@end

// vim:ft=objc
