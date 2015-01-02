//
//  CellLabel.m
//  NateBirkholzTest
//
//  Created by Nathan Birkholz on 1/1/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

#import "CellLabel.h"

@implementation CellLabel

// Inset text as in example image
- (void)drawTextInRect:(CGRect)rect {
  UIEdgeInsets insets = {4, 8, 4, 8};
  [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
