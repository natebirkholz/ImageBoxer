//
//  ViewCell.m
//  NateBirkholzTest
//
//  Created by Nathan Birkholz on 12/23/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "ViewCell.h"

@implementation ViewCell

// Add borders as in example
- (void)awakeFromNib {
  [[[self contentView] layer] setBorderColor:[UIColor blackColor].CGColor];
  [[[self cellImageView] layer] setBorderColor:[UIColor blackColor].CGColor];
  [[[self cellIDLabel] layer] setBorderColor:[UIColor blackColor].CGColor];
  [[[self cellTitleLabel] layer] setBorderColor:[UIColor blackColor].CGColor];
  [[[self contentView] layer] setBorderWidth:1.0];
  [[[self cellImageView] layer] setBorderWidth:2.0];
  [[[self cellIDLabel] layer] setBorderWidth:2.0];
  [[[self cellTitleLabel] layer] setBorderWidth:2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



@end
