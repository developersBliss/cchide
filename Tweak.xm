/*
 Copyright (C) 2014 developersBliss
 
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

#include <UIKit/UIKit.h>
#include "SpringBoard/SBControlCenterContentView.H"
#include "SpringBoard/SBControlCenterSeparatorView.h"
#include "SpringBoard/SBControlCenterController.h"

#include "SpringBoard/SBCCAirStuffSectionController.h"
#include "SpringBoard/SBCCBrightnessSectionController.h"
#include "SpringBoard/SBCCMediaControlsSectionController.h"
#include "SpringBoard/SBCCQuickLaunchSectionController.h"
#include "SpringBoard/SBCCSettingsSectionController.h"

#include "SpringBoard/SBControlCenterContentContainerView.h"

#include "SpringBoard/SBMediaController.h"
#include "BluetoothManager/BluetoothManager.h"

NSMutableDictionary * _CCHSections;

void loadPreferences() {
    //Get prefs
    if (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Preferences/com.developersbliss.cchide2.plist"]) {
        //If the plist doesn't exist, make it with default values.
        _CCHSections = [[NSMutableDictionary alloc] init];
        
        [_CCHSections setObject:[NSNumber numberWithBool:YES] forKey:@"com.apple.controlcenter.settings"];
        [_CCHSections setObject:[NSNumber numberWithBool:YES] forKey:@"com.apple.controlcenter.brightness"];
        [_CCHSections setObject:[NSNumber numberWithBool:YES] forKey:@"com.apple.controlcenter.media-controls"];
        [_CCHSections setObject:[NSNumber numberWithBool:YES] forKey:@"com.apple.controlcenter.air-stuff"];
        [_CCHSections setObject:[NSNumber numberWithBool:YES] forKey:@"com.apple.controlcenter.quick-launch"];
        
        [_CCHSections setObject:[NSNumber numberWithBool:YES] forKey:@"conditionalMediaControlsSection"];
        [_CCHSections setObject:[NSNumber numberWithBool:YES] forKey:@"conditionalAirplaySection"];
        
        [_CCHSections setObject:[NSNumber numberWithBool:YES] forKey:@"separators"];
        [_CCHSections setObject:[NSNumber numberWithBool:NO] forKey:@"landscape"];
        
        [_CCHSections writeToFile:@"/var/mobile/Library/Preferences/com.developersbliss.cchide2.plist" atomically:YES];
    } else {
        _CCHSections = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.developersbliss.cchide2.plist"];
    }
}

%hook SBControlCenterController

-(void)_beginPresentation {
    
    loadPreferences();
    
    
    if ([[_CCHSections objectForKey:@"com.apple.controlcenter.air-stuff"] boolValue] && [[_CCHSections objectForKey:@"conditionalAirplaySection"] boolValue]) {
        BluetoothManager* manager = [objc_getClass("BluetoothManager") sharedInstance];
        BOOL bluetoothIsOn = [manager enabled];
        BOOL isAirPlayEnabled = MSHookIvar<SBCCAirStuffSectionController *>(MSHookIvar<id>(MSHookIvar<id>(self, "_viewController"), "_contentView"), "_airplaySection").airPlayEnabled;
        
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"isAirPlayEnabled" message:isAirPlayEnabled?@"YES":@"NO" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show]; [alert release];
        
        if (!(bluetoothIsOn || isAirPlayEnabled)) {
            [_CCHSections setObject:[NSNumber numberWithBool:NO] forKey:@"com.apple.controlcenter.air-stuff"];
        }
    }
    
    if ([[_CCHSections objectForKey:@"com.apple.controlcenter.media-controls"] boolValue] && [[_CCHSections objectForKey:@"conditionalMediaControlsSection"] boolValue]) {
        BOOL nowPlaying = MSHookIvar<BOOL>([objc_getClass("SBMediaController") sharedInstance], "_lastNowPlayingAppIsPlaying");
        
        if (!nowPlaying) {
            [_CCHSections setObject:[NSNumber numberWithBool:NO] forKey:@"com.apple.controlcenter.media-controls"];
        }
    }
    
    %orig;
    
    //Prevent CC from being visible if no sections are set to show.
    if ((![[_CCHSections objectForKey:@"com.apple.controlcenter.settings"] boolValue] &&
         ![[_CCHSections objectForKey:@"com.apple.controlcenter.brightness"] boolValue] &&
         ![[_CCHSections objectForKey:@"com.apple.controlcenter.media-controls"] boolValue] &&
         ![[_CCHSections objectForKey:@"com.apple.controlcenter.air-stuff"] boolValue] &&
         ![[_CCHSections objectForKey:@"com.apple.controlcenter.quick-launch"] boolValue])) {
        [self cancelTransition];
    } else if (![[_CCHSections objectForKey:@"landscape"] boolValue]) {
        //Make everything visible in landscape.
        int orientation = MSHookIvar<int>(self, "_orientation");
        if (orientation == 3 || orientation == 4) {
            [_CCHSections setObject:[NSNumber numberWithBool:YES] forKey:@"com.apple.controlcenter.settings"];
            [_CCHSections setObject:[NSNumber numberWithBool:YES] forKey:@"com.apple.controlcenter.brightness"];
            [_CCHSections setObject:[NSNumber numberWithBool:YES] forKey:@"com.apple.controlcenter.media-controls"];
            [_CCHSections setObject:[NSNumber numberWithBool:YES] forKey:@"com.apple.controlcenter.air-stuff"];
            [_CCHSections setObject:[NSNumber numberWithBool:YES] forKey:@"com.apple.controlcenter.quick-launch"];
        }
    }
}

%end

%hook SBCCAirStuffSectionController
-(BOOL)enabledForOrientation:(int)orientation {
    
    if ([[_CCHSections objectForKey:self.sectionIdentifier] boolValue]) {
        return %orig;
    } else {
        return NO;
    }
}
-(CGSize)contentSizeForOrientation:(int)orientation {
    if ([[_CCHSections objectForKey:self.sectionIdentifier] boolValue]) {
        return %orig;
    } else {
        return CGSizeMake(0, 0);
    }
}
%end

%hook SBCCBrightnessSectionController
-(BOOL)enabledForOrientation:(int)orientation {
    
    if ([[_CCHSections objectForKey:self.sectionIdentifier] boolValue]) {
        return %orig;
    } else {
        return NO;
    }
}
-(CGSize)contentSizeForOrientation:(int)orientation {
    if ([[_CCHSections objectForKey:self.sectionIdentifier] boolValue]) {
        return %orig;
    } else {
        return CGSizeMake(0, 0);
    }
}
%end

%hook SBCCMediaControlsSectionController
-(BOOL)enabledForOrientation:(int)orientation {
    
    if ([[_CCHSections objectForKey:self.sectionIdentifier] boolValue]) {
        return %orig;
    } else {
        return NO;
    }
}
-(CGSize)contentSizeForOrientation:(int)orientation {
    if ([[_CCHSections objectForKey:self.sectionIdentifier] boolValue]) {
        return %orig;
    } else {
        return CGSizeMake(0, 0);
    }
}
%end

%hook SBCCQuickLaunchSectionController
-(BOOL)enabledForOrientation:(int)orientation {
    
    if ([[_CCHSections objectForKey:self.sectionIdentifier] boolValue]) {
        return %orig;
    } else {
        return NO;
    }
}
-(CGSize)contentSizeForOrientation:(int)orientation {
    if ([[_CCHSections objectForKey:self.sectionIdentifier] boolValue]) {
        return %orig;
    } else {
        return CGSizeMake(0, 0);
    }
}
%end

%hook SBCCSettingsSectionController
-(BOOL)enabledForOrientation:(int)orientation {
    
    if ([[_CCHSections objectForKey:self.sectionIdentifier] boolValue]) {
        return %orig;
    } else {
        return NO;
    }
}
-(CGSize)contentSizeForOrientation:(int)orientation {
    if ([[_CCHSections objectForKey:self.sectionIdentifier] boolValue]) {
        return %orig;
    } else {
        return CGSizeMake(0, 0);
    }
}
%end



%hook SBControlCenterSeparatorView

//Hiding the seperators
+(float)defaultBreadthForOrientation:(int)orientation {
    if (!_CCHSections) {
        loadPreferences();
    }
    
    if (![[_CCHSections objectForKey:@"separators"] boolValue]) {
        return 0;
    } else {
        return %orig;
    }
}

%end

