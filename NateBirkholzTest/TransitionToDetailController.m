//
//  TransitionToDetailController.m
//  ImageFiler
//
//  Created by Nathan Birkholz on 1/4/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

#import "TransitionToDetailController.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "ViewCell.h"

@implementation TransitionToDetailController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return 0.7;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  ViewController *fromViewController = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  DetailViewController *toViewController = (DetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

  UIView *containerView = [transitionContext containerView];
  NSTimeInterval duration = [self transitionDuration:transitionContext];

  ViewCell *cell = (ViewCell *)[fromViewController.tableView cellForRowAtIndexPath:[fromViewController.tableView indexPathForSelectedRow]];
  UIView *cellSnapshot = [cell snapshotViewAfterScreenUpdates:NO];
  cellSnapshot.frame = [containerView convertRect:cell.frame fromView:fromViewController.tableView];
  [cell setHidden:YES];

  toViewController.frameOrigin = cell.frame;

  toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
  toViewController.view.alpha = 0;
  [[toViewController detailCellView] setHidden:YES];

  [containerView addSubview:toViewController.view];
  [containerView addSubview:cellSnapshot];

  [UIView animateWithDuration:duration animations:^{
    toViewController.view.alpha = 1.0;
    CGRect frame = CGRectMake(0, (toViewController.view.frame.size.height - 152.0), toViewController.view.frame.size.width, 152.0);
    cellSnapshot.frame = frame;
  } completion:^(BOOL finished) {
    toViewController.detailCellView.hidden = NO;
    cell.hidden = NO;
    [cellSnapshot removeFromSuperview];

    [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
  }];
}

@end
