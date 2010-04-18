//
//  WeeAtlasViewController.h
//  WeeAtlas
//
//  Created by Josh Vickery on 4/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AtlasControl.h"
#import "RootViewController.h"

@class CountryViewController;

@interface WeeAtlasViewController : UIViewController {
	IBOutlet AtlasControl *brazilButton;
	CountryViewController *countryVC;
	UIView *splashView;
	UIView *mapView;
	UIView *countryView;
	UIView *countryButtonImage;
	UIView *backgroundView;
	id<CountryControllerDelegateProtocol> countryControllerDelegate;
	UIView *mapFrame;
}

@property(nonatomic, retain) IBOutlet AtlasControl *brazilButton;
@property(nonatomic, retain) CountryViewController *countryVC;
@property(nonatomic, retain) IBOutlet UIView *splashView;
@property(nonatomic, retain) IBOutlet UIView *mapView;
@property(nonatomic, retain) IBOutlet UIView *countryView;
@property(nonatomic, retain) IBOutlet UIView *countryButtonImage;
@property(nonatomic, retain) IBOutlet UIView *backgroundView;
@property(nonatomic, retain) IBOutlet UIView *mapFrame;

@property(nonatomic, assign) id<CountryControllerDelegateProtocol> countryControllerDelegate;

- (IBAction) countryPressed;
- (void) growSplash;
- (void) shrinkMapGrowCountry;
- (void) shrinkCountryGrowMap;

@end

