//
//  JSONParser.m
//  NateBirkholzTest
//
//  Created by Nathan Birkholz on 12/31/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//


#import "JSONParser.h"
#import "ImageObject.h"

@implementation JSONParser

// Parse JSON retrieved by the NetworkController and make an array of ImageObjects
- (NSArray *)parseJSONIntoImageObjectsFromData:(NSData *)rawJSONData {
  NSError *error;
  NSMutableArray *arrayOfImageObjects = [[NSMutableArray alloc] init];
  NSArray *arrayOfJSONObjects = [NSJSONSerialization JSONObjectWithData:rawJSONData options:NSJSONReadingAllowFragments error:&error];
  if (error) {
      NSLog(@"Error parsing JSON: %@", [error localizedDescription]);
  }

  for (NSDictionary *JSonDictionary in arrayOfJSONObjects) {
    NSInteger imgID = (NSInteger)JSonDictionary[@"id"];
    ImageObject *newImageObject = [[ImageObject alloc] initWithID:imgID andTitle:JSonDictionary[@"title"] andThumbnailURL:JSonDictionary[@"thumbnailUrl"]];
    [arrayOfImageObjects addObject:newImageObject];
  }
  return arrayOfImageObjects;
}

@end
