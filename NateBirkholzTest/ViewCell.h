//
//  ViewCell.h
//  NateBirkholzTest
//
//  Created by Nathan Birkholz on 12/23/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;

@end
