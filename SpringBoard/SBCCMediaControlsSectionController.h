/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */

#import "SBControlCenterSectionViewController.h"
#import "MPUSystemMediaControlsDelegate.h"
#import "SpringBoard-Structs.h"

@class MPUSystemMediaControlsViewController;

__attribute__((visibility("hidden")))
@interface SBCCMediaControlsSectionController : SBControlCenterSectionViewController <MPUSystemMediaControlsDelegate> {
	MPUSystemMediaControlsViewController* _systemMediaViewController;
}
-(void)systemMediaControlsViewController:(id)controller didReceiveTapOnControlType:(int)type;
-(void)viewDidLoad;
-(CGSize)contentSizeForOrientation:(int)orientation;
-(id)sectionIdentifier;
-(void)dealloc;
-(id)initWithNibName:(id)nibName bundle:(id)bundle;
@end

