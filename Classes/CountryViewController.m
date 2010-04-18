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
@synthesize animalsButton, sambaButton, capoeiraButton, selectedClipFrame;

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
	self.selectedClipFrame.hidden = NO;
	self.selectedClipFrame.alpha = 0;

	
	[UIView beginAnimations:@"showContent" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(contentShown)];
	[UIView setAnimationDuration:1];
	
	self.contentBackground.alpha = 1;
	self.contentScroller.alpha = 1;
	self.contentOverlayButton.alpha = 1;
	self.contentStripButton.alpha = 1;
	self.selectedClipFrame.alpha = 1;
	
	self.animalsButton.alpha = 0;
	self.sambaButton.alpha = 0;
	self.capoeiraButton.alpha = 0;

	
	[UIView commitAnimations];
	
}


- (void) showContent {
	
	//TODO this is all hardcoded, sorry
	
	self.contentScroller.contentSize = CGSizeMake(self.contentScroller.frame.size.width * 4, 
												  self.contentScroller.frame.size.height);
	
	
	CGRect contentRect = self.contentScroller.bounds;

	UIImageView *imageView = [[[UIImageView alloc] initWithFrame:contentRect] autorelease];
	imageView.contentMode = UIViewContentModeCenter;
	imageView.image = [UIImage imageNamed:@"macaw.png"];
	[self.contentScroller addSubview:imageView];
	
	
	contentRect.origin.x += contentRect.size.width;

	//load up an embedded youtube video
	webContent = [[UIWebView alloc] initWithFrame:contentRect];
	webContent.scalesPageToFit = NO;
	webContent.userInteractionEnabled = NO;
	webContent.delegate = self;
	[self.contentScroller addSubview:webContent];
	
	contentRect.origin.x += contentRect.size.width;
	
	imageView = [[[UIImageView alloc] initWithFrame:contentRect] autorelease];
	imageView.contentMode = UIViewContentModeCenter;
	imageView.image = [UIImage imageNamed:@"frog.png"];
	[self.contentScroller addSubview:imageView];
	
	contentRect.origin.x += contentRect.size.width;

	imageView = [[[UIImageView alloc] initWithFrame:contentRect] autorelease];
	imageView.contentMode = UIViewContentModeCenter;
	imageView.image = [UIImage imageNamed:@"aligators.png"];
	[self.contentScroller addSubview:imageView];
	
}

- (void) playClip {
	clipPlaying = YES;
	NSString *movieURL = @"http://www.youtube.com/v/Any6gB_tsag&hl=en_US&fs=1&";
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
	int oldPage = currentPage;
    currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	if(currentPage != 1) {
		[self stopClip];
	} else if (currentPage == 1) {
		[self playClip];
	}
	
	if (oldPage != currentPage) {
		[UIView beginAnimations:@"slide" context:nil];
		CGRect selectedFrame = selectedClipFrame.frame;
		selectedFrame.origin.x += selectedFrame.size.width;
		selectedClipFrame.frame = selectedFrame;
		[UIView commitAnimations];
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

	[self showContent]; 
	
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
	self.selectedClipFrame.alpha = 0;
	
	self.animalsButton.alpha = 1;
	self.sambaButton.alpha = 1;
	self.capoeiraButton.alpha = 1;

	
	[UIView commitAnimations];
}

- (IBAction)contentStripButtonPressed {
	CGFloat pageWidth = self.contentScroller.frame.size.width;
	CGFloat xoffset = (currentPage + 1) * pageWidth;

	[self.contentScroller scrollRectToVisible:CGRectMake(xoffset, 0, pageWidth, 
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
	[selectedClipFrame release];
    [super dealloc];
}

@end
