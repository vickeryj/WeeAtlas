//
//  WeeAtlasAppDelegate.m
//  WeeAtlas
//
//  Created by Josh Vickery on 4/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "WeeAtlasAppDelegate.h"
#import "WeeAtlasViewController.h"

@implementation WeeAtlasAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	splashView.image = [UIImage imageNamed:@"Default.png"];
	[window addSubview:splashView];
	[window bringSubviewToFront:splashView];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:(UIWindow*)window cache:YES];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
	splashView.alpha = 0.0;
	[UIView commitAnimations];

	return YES;
}

- (void)startupAnimationDone:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context {
	[splashView removeFromSuperview];
	[splashView release];
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
