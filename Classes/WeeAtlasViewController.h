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
}

@property(nonatomic, retain) IBOutlet AtlasControl *brazilButton;
@property(nonatomic, retain) CountryViewController *countryVC;

- (IBAction) countryPressed;

@end

