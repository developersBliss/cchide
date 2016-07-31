/*
 Copyright (C) 2016 developersBliss

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

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
