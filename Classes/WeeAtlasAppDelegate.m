//
//  WeeAtlasAppDelegate.m
//  WeeAtlas
//
//  Created by Josh Vickery on 4/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "WeeAtlasAppDelegate.h"
#import "RootViewController.h"

@implementation WeeAtlasAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

	return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[[NSNotificationCenter defaultCenter] removeObserver:viewController];
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
