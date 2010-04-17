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

@synthesize brazilButton, countryVC, splashView, mapView, countryView;

- (IBAction) countryPressed {

}

- (void) shrinkMapGrowCountry {
	CGRect mapRect = self.mapView.frame;
	CGRect copyOfMapRect = mapRect;
	[UIView beginAnimations:@"shrinkMapGrowCountry" context:nil];
	[UIView setAnimationDuration:3];
	
	mapRect.size.width = 100;
	mapRect.size.height = 75;
	self.mapView.frame = mapRect;
	
	CGRect countryRect = countryView.frame;
	countryRect.origin.y = 0;
	countryRect.origin.x = 0;
	countryRect.size.width = copyOfMapRect.size.width;
	countryRect.size.height = copyOfMapRect.size.height;
	countryView.frame = countryRect;
	
	[UIView commitAnimations];
}

- (void) growSplash {
	[UIView beginAnimations:@"zoomSplash" context:nil];
	[UIView setAnimationDuration:1.5];
	[UIView setAnimationDidStopSelector:@selector(crossFadeSplashToMap)];
	[UIView setAnimationDelegate:self];
	CGRect splashRect = self.splashView.frame;
	splashRect.origin.x = splashRect.origin.x - (splashRect.size.width/2);
	splashRect.origin.y = splashRect.origin.y - (splashRect.size.height/2);
	splashRect.size.width = splashRect.size.width * 2;
	splashRect.size.height = splashRect.size.height * 2;
	self.splashView.frame = splashRect;
	[UIView commitAnimations];
}

- (void) crossFadeSplashToMap {
	self.mapView.hidden = NO;
	self.mapView.alpha = 0;
	[UIView beginAnimations:@"crossFadeSplashToMap" context:nil];
	[UIView setAnimationDuration:1];
	self.splashView.alpha = 0;
	self.mapView.alpha = 1;
	[UIView commitAnimations];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc {
	[brazilButton release];
	[countryVC release];
	[splashView release];
	[mapView release];
	[countryView release];
    [super dealloc];
}

@end
