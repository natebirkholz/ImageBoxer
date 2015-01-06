//
//  TransitionFromDetailController.m
//  ImageFiler
//
//  Created by Nathan Birkholz on 1/5/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

#import "TransitionFromDetailController.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "ViewCell.h"

@implementation TransitionFromDetailController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return 0.7;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

}

@end
