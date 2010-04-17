//
//  WeeAtlasViewController.h
//  WeeAtlas
//
//  Created by Josh Vickery on 4/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AtlasControl.h"

@class CountryViewController;

@interface WeeAtlasViewController : UIViewController {
	IBOutlet AtlasControl *brazilButton;
	CountryViewController *countryVC;
	UIView *splashView;
	UIView *mapView;
	UIView *countryView;
}

@property(nonatomic, retain) IBOutlet AtlasControl *brazilButton;
@property(nonatomic, retain) CountryViewController *countryVC;

@property(nonatomic, retain) IBOutlet UIView *splashView;
@property(nonatomic, retain) IBOutlet UIView *mapView;
@property(nonatomic, retain) IBOutlet UIView *countryView;

- (IBAction) countryPressed;
- (void) growSplash;


@end

