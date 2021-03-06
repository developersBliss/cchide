/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */

#import "SpringBoard-Structs.h"
@class XXUnknownSuperclass;//#import <XXUnknownSuperclass.h> // Unknown library
#import "SBControlCenterObserver.h"

@class SBControlCenterContentContainerView, UIView, SBChevronView;

__attribute__((visibility("hidden")))
@interface SBControlCenterContainerView : NSObject <SBControlCenterObserver> {
	UIView* _darkeningView;
	float _revealPercentage;
	SBChevronView* _chevronToTrack;
	SBControlCenterContentContainerView* _contentContainerView;
}
@property(assign, nonatomic) float revealPercentage;
@property(readonly, assign, nonatomic) SBControlCenterContentContainerView* contentContainerView;
-(void)controlCenterDidFinishTransition;
-(void)controlCenterWillFinishTransitionOpen:(BOOL)controlCenter withDuration:(double)duration;
-(void)controlCenterWillBeginTransition;
-(void)controlCenterDidDismiss;
-(void)controlCenterWillPresent;
-(void)updateBackgroundSettings:(id)settings;
-(id)_contentChevronView;
-(id)_currentBGColor;
-(void)_updateContentFrame;
-(void)_updateDarkeningFrame;
-(void)trackChevronView:(id)view;
-(void)layoutSubviews;
-(void)dealloc;
-(id)initWithFrame:(CGRect)frame;
@end

