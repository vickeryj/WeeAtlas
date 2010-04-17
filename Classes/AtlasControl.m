//
//  AtlasControl.m
//  WeeAtlas
//
//  Created by Matthew Arturi on 3/15/10.
//  Copyright 2010 8B Studio, Inc. All rights reserved.
//

#define ANGLE 90
#define SCALE 2.1f
#define DURATION 0.5f

#import "AtlasControl.h"
#import <QuartzCore/QuartzCore.h>
#import "QuartzUtils.h"

@implementation AtlasControl


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//	CABasicAnimation *rotation;
//	rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//	rotation.toValue = [NSNumber numberWithFloat:((ANGLE*M_PI)/180)];
//	rotation.removedOnCompletion = YES;
//	rotation.autoreverses = YES;
//	//rotation.fillMode = kCAFillModeForwards;
//	rotation.duration = DURATION;
//	
//	// Set the scaling animation
//	CABasicAnimation *scaling;
//	scaling = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//	scaling.toValue = [NSNumber numberWithFloat:SCALE];
//	scaling.removedOnCompletion = YES;
//	scaling.autoreverses = YES;
//	//scaling.fillMode = kCAFillModeForwards;
//	scaling.duration = DURATION;
//
//	// Set the group animation for both transformations to be applied at the same time
//	CAAnimationGroup *animation = [CAAnimationGroup animation];
//	animation.removedOnCompletion = YES;
//	animation.autoreverses = YES;
//	animation.fillMode = kCAFillModeForwards;
//	animation.duration = DURATION;
//	animation.animations = [NSArray arrayWithObjects:scaling, rotation, nil];
//	[self.layer addAnimation:animation forKey:@"animateLayer"];
//}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(![super pointInside:point withEvent:(UIEvent *)event]) {
		return NO;
	}
	CALayer *myLayer = self.layer;
    float opacity = myLayer.opacity;
    if(opacity < 0.5) {
        return NO;
    }
	float thresholdAlpha = 0.5 / myLayer.opacity;
    
    CGColorRef bg = myLayer.backgroundColor;
    float alpha = bg ? CGColorGetAlpha(bg) : 0.0;
    if( alpha < thresholdAlpha ) {
        CGImageRef image = [self imageForState:UIControlStateNormal].CGImage;
        if(image) {
            alpha = MAX(alpha, GetPixelAlpha(image, myLayer.bounds.size, point));
        }
    }
    return alpha >= thresholdAlpha;
}

@end
