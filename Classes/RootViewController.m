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

- (void)dealloc {
	[currentCountry release];
	[weeAtlasViewController release];
    [super dealloc];
}


@end
