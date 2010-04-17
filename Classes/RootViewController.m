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
	[self.view addSubview:weeAtlasViewController.view];
	[weeAtlasViewController growSplash];
}

- (void)handleCountryNav:(NSNumber*)countryTag {
	currentCountry = countryTag;
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
}

- (void)dealloc {
	[currentCountry release];
	[weeAtlasViewController release];
	[countryViewController release];
    [super dealloc];
}


@end
