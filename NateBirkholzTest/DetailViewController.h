//
//  DetailViewController.h
//  ImageFiler
//
//  Created by Nathan Birkholz on 1/4/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//


#import "ImageObject.h"
#import "CellLabel.h"
#import "NetworkController.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DetailViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UIView *detailCellView;
@property (nonatomic, strong) ImageObject *detailObject;
@property (nonatomic, strong) UIImage *imageThumb;
@property (weak, nonatomic) IBOutlet UIImageView *objectThumbView;
@property (weak, nonatomic) IBOutlet CellLabel *objectIDLabel;
@property (weak, nonatomic) IBOutlet CellLabel *objectTitleLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NetworkController *networkController;
@property (weak, nonatomic) IBOutlet UIImageView *objectFullSizeView;
@property (nonatomic) CGRect frameOrigin;
@property (nonatomic, strong) NSIndexPath *pathForOriginCell;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *thumbActivityIndicator;




@end
