//
//  WeeAtlasViewController.m
//  WeeAtlas
//
//  Created by Josh Vickery on 4/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "WeeAtlasViewController.h"
#import "WeeAtlasAppDelegate.h"
#import "CountryViewController.h"

@implementation WeeAtlasViewController

@synthesize brazilButton, countryVC;

- (IBAction) countryPressed {
	
	UIWindow *window = [(WeeAtlasAppDelegate *)[[UIApplication sharedApplication] delegate] window];
	[[window subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	self.countryVC = [[[CountryViewController alloc] initWithNibName:nil bundle:nil] autorelease];
	[window addSubview:self.countryVC.view];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
- (void)dealloc {
	[brazilButton release];
	[countryVC release];
    [super dealloc];
}

@end
