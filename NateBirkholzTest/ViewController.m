//
//  ViewController.m
//  NateBirkholzTest
//
//  Created by Nathan Birkholz on 12/23/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "ViewController.h"
#import "ViewCell.h"

@interface ViewController ()

  @property NSArray *imageObjects;
@property NSMutableDictionary *imageCache;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [[self tableView] setDataSource:self];
  [[self tableView] setDelegate:self];
  [[self tableView] registerNib:[UINib nibWithNibName:@"ViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"VIEW_CELL"];
  self.networkController = [NetworkController sharedNetworkController];
  self.imageCache = [NSMutableDictionary dictionary];

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[self activityIndicator] startAnimating];
  [[self loadingLabel] setHidden:NO];
  [[self networkController] getArrayOfImageObjectsWithCompletionHandler:^(NSArray *imageObjects) {

    self.imageObjects = imageObjects;
    [UIView transitionWithView:self.tableView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
      [[self tableView] reloadData];
    } completion:nil];


    [UIView transitionWithView:[self view] duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
      [[self loadingLabel] setHidden:YES];
      [[self activityIndicator] stopAnimating];
    } completion:nil];
  }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.imageObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ImageObject *imageObjectForRow = self.imageObjects[indexPath.row];
  ViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:@"VIEW_CELL" forIndexPath:indexPath];
  NSString *imageObjectIDString = [NSString stringWithFormat:@"%@", imageObjectForRow.imageObjectID];
  NSInteger currenttag = cell.tag + 1;
  cell.tag = currenttag;

  cell.cellIDLabel.text = imageObjectIDString;
  cell.cellTitleLabel.text = imageObjectForRow.imageObjectTitle;

  [self getImageForCell:cell fromURLString:imageObjectForRow.imageObjectThumbnailURL];

  return cell;
}

- (void)getImageForCell:(ViewCell *)cell fromURLString:(NSString *)URLString {
  if (self.imageCache[URLString] != nil) {
    [UIView transitionWithView:cell.cellImageView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
      cell.cellImageView.image = self.imageCache[URLString];
    } completion:nil];
  } else {
    NSURL *fetchURL = [[NSURL alloc] initWithString: URLString];
    [self.networkController fetchImageDataFromURL:fetchURL withCompletionHandler:^(NSData *imageData) {
      UIImage *imageForCell = [[UIImage alloc] initWithData: imageData];
      [self.imageCache setObject:imageForCell forKey:URLString];
      [UIView transitionWithView:cell.cellImageView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        cell.cellImageView.image = imageForCell;
      } completion:nil];
    }];
  }
}


@end
