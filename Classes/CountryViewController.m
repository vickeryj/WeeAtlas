    //
//  CountryViewController.m
//  WeeAtlas
//
//  Created by Josh Vickery on 4/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CountryViewController.h"

@interface CountryViewController()

- (void) stopClip;
- (void) playClip;
- (UIButton *)findButtonInView:(UIView *)view;

@end


@implementation CountryViewController

@synthesize contentBackground, contentScroller, contentOverlayButton, contentStripButton;
@synthesize animalsButton, sambaButton, capoeiraButton;

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
	self.contentStripButton.hidden = NO;
	self.contentStripButton.alpha = 0;

	
	[UIView beginAnimations:@"showContent" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(contentShown)];
	[UIView setAnimationDidStopSelector:@selector(contentContainerShown)];
	[UIView setAnimationDuration:1];
	
	self.contentBackground.alpha = 1;
	self.contentScroller.alpha = 1;
	self.contentOverlayButton.alpha = 1;
	self.contentStripButton.alpha = 1;
	
	self.animalsButton.alpha = 0;
	self.sambaButton.alpha = 0;
	self.capoeiraButton.alpha = 0;
	
	[UIView commitAnimations];
	
}

- (void) showVideo {
	//load up an embedded youtube video
	webContent = [[UIWebView alloc] initWithFrame:self.contentScroller.bounds];
	webContent.scalesPageToFit = NO;
	webContent.userInteractionEnabled = NO;
	webContent.delegate = self;
	[self.contentScroller addSubview:webContent];
	[self playClip];
}

- (void) playClip {
	NSLog(@"playing clip");
	clipPlaying = YES;
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

- (void) stopClip {
	NSLog(@"stopping clip");
	if(clipPlaying) {
		[webContent loadHTMLString:@"" baseURL:nil];
		clipPlaying = NO;
	}
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
	[webContent loadHTMLString:@"" baseURL:nil];
	CGFloat pageWidth = scrollView.frame.size.width;
    currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	if(currentPage > 0) {
		[self stopClip];
	} else {
		[self playClip];
	}
}

- (UIButton *)findButtonInView:(UIView *)view {
	UIButton *button = nil;
	
	if ([view isMemberOfClass:[UIButton class]]) {
		return (UIButton *)view;
	}
	
	if (view.subviews && [view.subviews count] > 0) {
		for (UIView *subview in view.subviews) {
			button = [self findButtonInView:subview];
			if (button) return button;
		}
	}
	
	return button;
}

- (void)webViewDidFinishLoad:(UIWebView *)_webView {
	UIButton *b = [self findButtonInView:_webView];
	[b sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void) contentShown {
	
	//add the first bit of content
	[self showVideo]; 
	
	// restore user interaction
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
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
	
	[UIView beginAnimations:@"hideContent" context:nil];
	[UIView setAnimationDuration:1];
	
	
	self.contentOverlayButton.alpha = 0;
	self.contentScroller.alpha = 0;
	self.contentBackground.alpha = 0;
	self.contentStripButton.alpha = 0;
	
	self.animalsButton.alpha = 1;
	self.sambaButton.alpha = 1;
	self.capoeiraButton.alpha = 1;
	
	[UIView commitAnimations];
}

- (IBAction)contentStripButtonPressed {
	CGFloat pageWidth = self.contentScroller.frame.size.width;
	[self.contentScroller scrollRectToVisible:CGRectMake(self.contentScroller.contentOffset.x, 0, pageWidth, 
														 self.contentScroller.frame.size.height) animated:YES];
}

#pragma mark cleanup
- (void)dealloc {
	[webContent release];
	[contentBackground release];
	[contentScroller release];
	[contentOverlayButton release];
	[contentStripButton release];
	[animalsButton release];
	[sambaButton release];
	[capoeiraButton release];
    [super dealloc];
}

@end
