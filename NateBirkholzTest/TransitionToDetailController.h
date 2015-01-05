//
//  TransitionToDetailController.h
//  ImageFiler
//
//  Created by Nathan Birkholz on 1/4/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransitionToDetailController : NSObject <UIViewControllerAnimatedTransitioning>

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
