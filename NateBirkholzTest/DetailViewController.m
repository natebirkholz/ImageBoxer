//
//  DetailViewController.m
//  ImageFiler
//
//  Created by Nathan Birkholz on 1/4/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

#import "DetailViewController.h"
#import "TransitionFromDetailController.h"

@interface DetailViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.networkController = [NetworkController sharedNetworkController];
  UIScreenEdgePanGestureRecognizer *recognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRecognizer:)];
  recognizer.edges = UIRectEdgeLeft;
  [[self view] addGestureRecognizer:recognizer];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.objectTitleLabel.text = self.detailObject.imageObjectTitle;
  self.objectIDLabel.text = [self.detailObject.imageObjectID stringValue];
  if (self.imageThumb) {
  self.objectThumbView.image = self.imageThumb;
  } else {
    [[self thumbActivityIndicator] startAnimating];
    [[self networkController] fetchImageDataFromURL:[NSURL URLWithString:self.detailObject.imageObjectThumbnailURL] withCompletionHandler:^(NSData *imageData) {
      self.imageThumb = [[UIImage alloc] initWithData:imageData];
      self.objectThumbView.image = self.imageThumb;
      [[self thumbActivityIndicator] stopAnimating];
    }];
  }

  NSArray *layers = [[NSArray alloc] initWithObjects:self.objectTitleLabel.layer, self.objectIDLabel.layer, self.objectThumbView.layer, self.objectFullSizeView.layer, nil];
  for (CALayer *layer in layers) {
    [layer setBorderColor:[UIColor blackColor].CGColor];
    [layer setBorderWidth:2.0];
  }

  [[[self detailCellView] layer] setBorderColor:[UIColor blackColor].CGColor];
  [[[self detailCellView] layer] setBorderWidth:1.0];

  [[self activityIndicator] startAnimating];
  [[self networkController] fetchImageDataFromURL:[NSURL URLWithString:self.detailObject.imageObjectFullSizeURL] withCompletionHandler:^(NSData *imageData) {
    self.objectFullSizeView.image = [[UIImage alloc] initWithData:imageData];
    [[self activityIndicator] stopAnimating];
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleRecognizer:(UIScreenEdgePanGestureRecognizer *)recognizer {
  CGFloat progress = [recognizer translationInView:[self view]].x / (self.view.bounds.size.width *1.0);
  progress = MIN(1.0, MAX(0.0, progress));

  if (recognizer.state == UIGestureRecognizerStateBegan) {
    self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    [[self navigationController] popViewControllerAnimated:YES];
  } else if (recognizer.state == UIGestureRecognizerStateChanged) {
    [[self interactiveTransition] updateInteractiveTransition:progress];
  } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
    if (progress > 0.8) {
      [[self interactiveTransition] finishInteractiveTransition];
    } else {
      [[self interactiveTransition] cancelInteractiveTransition];
    }
    self.interactiveTransition = nil;
  }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
  if ([animationController isKindOfClass:[TransitionFromDetailController class]]) {
    return [self interactiveTransition];
  } else {
    return nil;
  }
}



@end
