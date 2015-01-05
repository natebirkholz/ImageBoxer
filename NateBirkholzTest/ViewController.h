//
//  ViewController.h
//  NateBirkholzTest
//
//  Created by Nathan Birkholz on 12/23/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "NetworkController.h"
#import "ImageObject.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NetworkController *networkController;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

@end

