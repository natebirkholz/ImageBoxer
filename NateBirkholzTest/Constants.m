//
//  Constants.m
//  ImageFiler
//
//  Created by Nathan Birkholz on 1/4/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

#import "Constants.h"

@implementation Constants

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.APIURL = @"http://jsonplaceholder.typicode.com/photos/";
  }
  return self;
}

@end
