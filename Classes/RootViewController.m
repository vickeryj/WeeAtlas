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
}

- (void)handleReturnToGlobe {
}


- (void)dealloc {
	[weeAtlasViewController release];
	[countryViewController release];
    [super dealloc];
}


@end
