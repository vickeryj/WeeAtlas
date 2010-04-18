    //
//  CountryViewController.m
//  WeeAtlas
//
//  Created by Josh Vickery on 4/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CountryViewController.h"


@implementation CountryViewController

@synthesize contentBackground, contentScroller, contentOverlayButton;

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
	self.contentScroller.alpha = 0;
	self.contentOverlayButton.hidden = NO;
	self.contentOverlayButton.alpha = 0;

	
	[UIView beginAnimations:@"showContent" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(contentContainerShown)];
	[UIView setAnimationDuration:1];
	
	self.contentBackground.alpha = 1;
	self.contentScroller.alpha = 1;
	self.contentOverlayButton.alpha = 1;
	
	[UIView commitAnimations];
	
}

- (void) showVideo {
	//load up an embedded youtube video
	UIWebView *webContent = [[[UIWebView alloc] initWithFrame:self.contentScroller.bounds] autorelease];
	[self.contentScroller addSubview:webContent];
	NSString *movieURL = @"http://www.youtube.com/v/7WbrzlTnEQ4&hl=en_US&fs=1&";
	
	NSString *youtubeTemplate = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"youtube_embed" 
																								   ofType:@"html"]
														  encoding:NSUTF8StringEncoding
															 error:nil];
	NSString *youtubeContent = [NSString stringWithFormat:youtubeTemplate,
								[NSString stringWithFormat:@"%f", self.contentScroller.frame.size.width],
								[NSString stringWithFormat:@"%f", self.contentScroller.frame.size.height],
								movieURL, movieURL];
	
	[webContent loadHTMLString:youtubeContent baseURL:nil];	
}

- (void) showImage {
	self.contentScroller.contentSize = CGSizeMake(self.contentScroller.frame.size.width * 2, 
												  self.contentScroller.frame.size.height);
	CGRect secondRect = self.contentScroller.bounds;
	secondRect.origin.x = secondRect.size.width;
	UIImageView *imageView = [[[UIImageView alloc] initWithFrame:secondRect] autorelease];
	imageView.contentMode = UIViewContentModeCenter;
	imageView.image = [UIImage imageNamed:@"toucan.jpg"];
	[self.contentScroller addSubview:imageView];
}

- (void) contentContainerShown {
	
	//add the first bit of content
	[self showVideo]; 
	
	[self showImage];
	
	// restore user interaction
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (IBAction)contentOverlayButtonPressed {
	self.contentOverlayButton.hidden = YES;
	self.contentScroller.hidden = YES;
	self.contentBackground.hidden = YES;
}

#pragma mark cleanup
- (void)dealloc {
	[contentBackground release];
	[contentScroller release];
	[contentOverlayButton release];
    [super dealloc];
}


@end
