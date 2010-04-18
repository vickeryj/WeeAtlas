    //
//  RootViewController.m
//  WeeAtlas
//
//  Created by Matthew Arturi on 4/17/10.
//  Copyright 2010 8B Studio, Inc. All rights reserved.
//

#import "RootViewController.h"
#import "WeeAtlasViewController.h"
#import "CountryViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface RootViewController()

- (void)playCountryName;

@end


@implementation RootViewController

@synthesize countryViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleCountryNav:)
												 name:@"CountrySelected" 
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleReturnToGlobe)
												 name:@"GlobeSelected" 
											   object:nil];
	weeAtlasViewController = [[WeeAtlasViewController alloc] init];
	weeAtlasViewController.countryControllerDelegate = self;
	self.countryViewController = [[[CountryViewController alloc] init] autorelease];
	CGRect mapRect = weeAtlasViewController.view.frame;
	mapRect.origin.y += 26;
	weeAtlasViewController.view.frame = mapRect;
	[self.view addSubview:weeAtlasViewController.view];
	[weeAtlasViewController growSplash];
}

- (void)handleCountryNav:(NSNotification*)countryNotification {
	NSDictionary *params = [countryNotification userInfo];
	currentCountry = [params valueForKey:@"countryTag"];
	[weeAtlasViewController shrinkMapGrowCountry];
	[self playCountryName];
}

- (void)handleReturnToGlobe {
}

- (void)playCountryName {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"CountryProperties" ofType:@"plist"];
    NSData *plistData = [NSData dataWithContentsOfFile:path];
    NSString *error; NSPropertyListFormat format;
    NSDictionary *countryData = [NSPropertyListSerialization propertyListFromData:plistData
																 mutabilityOption:NSPropertyListImmutable
																		   format:&format
																 errorDescription:&error];
    if (!countryData) {
        [error release];
    }
	NSString *soundFileKey = [NSString stringWithFormat:@"%@Sound",[countryData valueForKey:[currentCountry stringValue]]];
	NSString *soundFileTypeKey = [NSString stringWithFormat:@"%@SoundType",[countryData valueForKey:[currentCountry stringValue]]];
	NSString *soundFile = [countryData valueForKey:soundFileKey];
	NSString *soundFileType = [countryData valueForKey:soundFileTypeKey];

	SystemSoundID countryNameSound;
	[[NSBundle mainBundle] pathForResource:soundFile ofType:soundFileType];
	CFURLRef url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)[[NSBundle mainBundle] pathForResource:soundFile ofType:soundFileType], kCFURLPOSIXPathStyle, false);
	AudioServicesCreateSystemSoundID(url, &countryNameSound);
	AudioServicesPlaySystemSound(countryNameSound);
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark CountryControllerDelegate methods
- (void)controllerDidFinishSelectionAnimation:(UIViewController *)countryController {
	[self.view addSubview:self.countryViewController.view];
	CGRect countryControllerRect = self.countryViewController.view.frame;
	countryControllerRect.origin.y += 20;
	self.countryViewController.view.frame = countryControllerRect;
	self.countryViewController.view.alpha = 0;
	[UIView beginAnimations:@"fadeInCountryView" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(countryViewControlleFadeInComplete)];
	[UIView setAnimationDuration:2];
	self.countryViewController.view.alpha = 1;
	[UIView commitAnimations];

}

- (void)countryViewControlleFadeInComplete {
	[weeAtlasViewController.view removeFromSuperview];
}

#pragma mark cleanup
- (void)dealloc {
	[currentCountry release];
	[weeAtlasViewController release];
	[countryViewController release];
    [super dealloc];
}


@end
