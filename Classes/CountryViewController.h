//
//  CountryViewController.h
//  WeeAtlas
//
//  Created by Josh Vickery on 4/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CountryViewController : UIViewController {

	UIView *contentBackground;
	UIScrollView *contentScroller;
	
}

@property(nonatomic, retain) IBOutlet UIView *contentBackground;
@property(nonatomic, retain) IBOutlet UIScrollView *contentScroller;

- (IBAction)globePressed:(id)sender;
- (IBAction) animalsButtonPressed;

@end
