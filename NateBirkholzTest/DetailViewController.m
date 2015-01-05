//
//  DetailViewController.m
//  ImageFiler
//
//  Created by Nathan Birkholz on 1/4/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UINavigationControllerDelegate>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.networkController = [NetworkController sharedNetworkController];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.objectTitleLabel.text = self.detailObject.imageObjectTitle;
  self.objectIDLabel.text = [self.detailObject.imageObjectID stringValue];
  self.objectThumbView.image = self.imageThumb;

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




@end
