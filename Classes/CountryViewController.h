//
//  CountryViewController.h
//  WeeAtlas
//
//  Created by Josh Vickery on 4/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CountryViewController : UIViewController<UIScrollViewDelegate> {

	UIView *contentBackground;
	UIScrollView *contentScroller;
	UIButton *contentOverlayButton;
	UIButton *contentStripButton;
	UIWebView *webContent;
	int currentPage;
	BOOL clipPlaying;
	
	UIButton *animalsButton;
	UIButton *sambaButton;
	UIButton *capoeiraButton;
}

@property(nonatomic, retain) IBOutlet UIView *contentBackground;
@property(nonatomic, retain) IBOutlet UIScrollView *contentScroller;
@property(nonatomic, retain) IBOutlet UIButton *contentOverlayButton;
@property(nonatomic, retain) IBOutlet UIButton *contentStripButton;

@property(nonatomic, retain) IBOutlet UIButton *animalsButton;
@property(nonatomic, retain) IBOutlet UIButton *sambaButton;
@property(nonatomic, retain) IBOutlet UIButton *capoeiraButton;

- (IBAction)globePressed:(id)sender;
- (IBAction)animalsButtonPressed;
- (IBAction)contentOverlayButtonPressed;
- (IBAction)contentStripButtonPressed;

@end
