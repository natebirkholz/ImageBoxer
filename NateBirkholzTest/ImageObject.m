//
//  ImageObject.m
//  NateBirkholzTest
//
//  Created by Nathan Birkholz on 12/31/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "ImageObject.h"

@implementation ImageObject

- (instancetype)initWithID:(NSInteger)imgID andTitle:(NSString *)imgTitle andThumbnailURL:(NSString *)imgThumbnailURL {
  self = [super init];
  if (self) {
    self.imageObjectID = [[NSNumber alloc]initWithInteger:imgID];
    self.imageObjectTitle = [[NSString alloc] initWithString:imgTitle];
    self.imageObjectThumbnailURL = [[NSString alloc] initWithString:imgThumbnailURL];
  }
  return self;
}

@end
