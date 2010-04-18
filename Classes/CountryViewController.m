    //
//  CountryViewController.m
//  WeeAtlas
//
//  Created by Josh Vickery on 4/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CountryViewController.h"


@implementation CountryViewController

- (IBAction)globePressed:(id)sender {
	NSNotification *notification = [NSNotification notificationWithName:@"GlobeSelected" object:nil userInfo:nil];
	[[NSNotificationCenter defaultCenter] postNotification:notification];
}


- (IBAction) animalsButtonPressed {
}

#pragma mark cleanup
- (void)dealloc {
    [super dealloc];
}


@end
