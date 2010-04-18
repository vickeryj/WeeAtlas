//
//  RootViewController.h
//  WeeAtlas
//
//  Created by Matthew Arturi on 4/17/10.
//  Copyright 2010 8B Studio, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeeAtlasViewController,CountryViewController;

@interface RootViewController : UIViewController {
	WeeAtlasViewController *weeAtlasViewController;
	CountryViewController *countryViewController;
	NSNumber *currentCountry;
}

@end
