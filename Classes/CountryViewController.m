    //
//  CountryViewController.m
//  WeeAtlas
//
//  Created by Josh Vickery on 4/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CountryViewController.h"


@implementation CountryViewController

@synthesize contentBackground, contentScroller;

- (IBAction)globePressed:(id)sender {
	
	self.contentBackground.hidden = YES;
	self.contentScroller.hidden = YES;
	
	NSNotification *notification = [NSNotification notificationWithName:@"GlobeSelected" object:nil userInfo:nil];
	[[NSNotificationCenter defaultCenter] postNotification:notification];
}


- (IBAction) animalsButtonPressed {

	// don't allow the user to do anything while we are animating
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];

	self.contentBackground.hidden = NO;
	self.contentBackground.alpha = 0;
	self.contentScroller.hidden = NO;
	self.contentBackground.alpha = 0;
	
	[UIView beginAnimations:@"showContent" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(contentShown)];
	[UIView setAnimationDuration:1];
	
	self.contentBackground.alpha = 1;
	self.contentScroller.alpha = 1;
	
	[UIView commitAnimations];
	
}

- (void) contentShown {
	// restore user interaction
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

#pragma mark cleanup
- (void)dealloc {
	[contentBackground release];
	[contentScroller release];
    [super dealloc];
}


@end
