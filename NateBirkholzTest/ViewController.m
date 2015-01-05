//
//  ViewController.m
//  NateBirkholzTest
//
//  Created by Nathan Birkholz on 12/23/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "ViewController.h"
#import "ViewCell.h"
#import "DetailViewController.h"
#import "TransitionToDetailController.h"

@interface ViewController ()<UINavigationControllerDelegate>

  @property NSArray *imageObjects;
  @property NSMutableDictionary *imageCache;

@end

@implementation ViewController

// ------------------------
#pragma mark Lifecycle
// ------------------------

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
  [[self navigationController] setDelegate:self];
  [[self activityIndicator] startAnimating];
  [[self loadingLabel] setHidden:NO];
  if (self.imageObjects) {
    [[self activityIndicator] stopAnimating];
    [[self loadingLabel] setHidden:YES];
  } else {
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
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];

  if (self.navigationController.delegate == self) {
    self.navigationController.delegate = nil;
  }
}

// ------------------------
#pragma mark UITableView
// ------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.imageObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ImageObject *imageObjectForRow = self.imageObjects[indexPath.row];
  ViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:@"VIEW_CELL" forIndexPath:indexPath];
  NSString *imageObjectIDString = [NSString stringWithFormat:@"%@", imageObjectForRow.imageObjectID];
  NSInteger currenttag = cell.tag + 1;
  cell.tag = currenttag;

  cell.cellIDLabel.text = imageObjectIDString;
  cell.cellTitleLabel.text = imageObjectForRow.imageObjectTitle;
  cell.cellImageView.image = nil;

  [[cell imgActivityIndicator] startAnimating];

  [self getImageForCell:cell atIndexPath:indexPath fromURLString:imageObjectForRow.imageObjectThumbnailURL];

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  ImageObject *selectedObject = self.imageObjects[indexPath.row];
  [self performSegueWithIdentifier:@"TO_DETAIL_VC" sender:selectedObject];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    if (selectedIndexPath) {
      DetailViewController *detailViewController = segue.destinationViewController;
      ImageObject *selectedObject = self.imageObjects[selectedIndexPath.row];
      detailViewController.detailObject = selectedObject;
      detailViewController.imageThumb = self.imageCache[selectedObject.imageObjectThumbnailURL];
    }
  }
}

// ---------------------------------------
#pragma mark Image caching and fetching
// ---------------------------------------

- (void)getImageForCell:(ViewCell *)cell atIndexPath:(NSIndexPath *)indexPath fromURLString:(NSString *)URLString {
  if (self.imageCache[URLString] != nil) {
    [UIView transitionWithView:cell.cellImageView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
      cell.cellImageView.image = self.imageCache[URLString];
      [[cell imgActivityIndicator] stopAnimating];
    } completion:nil];
  } else {
    NSURL *fetchURL = [[NSURL alloc] initWithString: URLString];

    [self.networkController fetchImageDataFromURL:fetchURL withCompletionHandler:^(NSData *imageData) {
      UIImage *imageForCell = [[UIImage alloc] initWithData: imageData];
      [self.imageCache setObject:imageForCell forKey:URLString];

      // Only update cells on screen
      ViewCell *updateCell = (ViewCell *)[[self tableView] cellForRowAtIndexPath:indexPath];

      [UIView transitionWithView:cell.cellImageView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [[updateCell imgActivityIndicator] startAnimating];
        updateCell.cellImageView.image = imageForCell;
      } completion:^(BOOL finished) {
        [[updateCell imgActivityIndicator] stopAnimating];
      }];
    }];
  }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
  NSLog(@"WILL SHOW");
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {

  if (fromVC == self && [toVC isKindOfClass:[DetailViewController class]]) {
    NSLog(@"TRANSITIONING");
    return  [[TransitionToDetailController alloc] init];
  } else {
    return nil;
  }
}


@end
