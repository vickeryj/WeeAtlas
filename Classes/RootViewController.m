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

@implementation RootViewController

@synthesize splashView;

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

- (void)handleCountryNav:(NSNumber*)countryTag {
}

- (void)handleReturnToGlobe {
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc {
	[weeAtlasViewController release];
	[splashView release];
    [super dealloc];
}


@end
