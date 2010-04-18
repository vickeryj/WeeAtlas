//
//  RootViewController.h
//  WeeAtlas
//
//  Created by Matthew Arturi on 4/17/10.
//  Copyright 2010 8B Studio, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountryControllerDelegateProtocol
	
- (void)controllerDidFinishSelectionAnimation:(UIViewController *)countryController;
- (void)controllerDidFinishReturnToMapAnimation:(UIViewController *)countryController;

@end

@class WeeAtlasViewController,CountryViewController;

@interface RootViewController : UIViewController <CountryControllerDelegateProtocol> {
	WeeAtlasViewController *weeAtlasViewController;
	CountryViewController *countryViewController;
	NSNumber *currentCountry;
}

@property(nonatomic, retain) CountryViewController *countryViewController;

@end
