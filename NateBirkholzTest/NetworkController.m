//
//  NetworkController.m
//  NateBirkholzTest
//
//  Created by Nathan Birkholz on 12/31/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "NetworkController.h"
#import "JSONParser.h"
#import "ImageObject.h"

@implementation NetworkController

@synthesize someProperty;

+ (id)sharedNetworkController {
  static NetworkController *sharedNetworkController = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedNetworkController = [[self alloc] init];
  });
  return sharedNetworkController;
}

- (void)dealloc {
  // Recommended by Singleton pattern
}

- (instancetype)init {
  if ((self = [super init])) {
    self.apiURL = @"http://jsonplaceholder.typicode.com/photos/";
    self.networkQueue = [[NSOperationQueue alloc] init];
  }
  return self;
}


- (void)fetchImageDataFromURL:(NSURL *)fetchURL withCompletionHandler:(void (^)(NSData *imageData))completionHandler {
  [[self networkQueue] addOperationWithBlock:^{
    NSData *imageData = [NSData dataWithContentsOfURL: fetchURL];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      completionHandler(imageData);
    }];
  }];
}

- (void)getArrayOfImageObjectsWithCompletionHandler:(void (^)(NSArray *imageObjects))completionHandler {
  NSURL *fetchURL = [[NSURL alloc] initWithString:[self apiURL]];
  [self fetchJSONDataFromURL:fetchURL withCompletionHandler:^(NSData *dataFromURL) {
    NSLog(@"Fetching");
    JSONParser *parser = [[JSONParser alloc] init];
    NSArray *imageObjects = [parser parseJSONIntoImageObjectsFromData:dataFromURL];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      completionHandler(imageObjects);
    }];
  }];
}

- (void)fetchJSONDataFromURL:(NSURL *)fetchURL withCompletionHandler:(void (^)(NSData *dataFromURL))completionHandler {
  NSURLSession *fetchSession = [NSURLSession sharedSession];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:fetchURL];
  request.HTTPMethod = @"GET";
  NSURLSessionDataTask *dataTask = [fetchSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"Error fetching data from server: %@", [error localizedDescription]);
    } else {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSInteger statusCode = [httpResponse statusCode];
      switch (statusCode) {
        case 200: {
          NSLog(@"Success");
          completionHandler(data);
          break;
        }
        default: {
          NSLog(@"Fell through to default");
          NSLog(@"The code is %ld", (long)statusCode);
          completionHandler(data);
        }
      }
    }
  }];
  [dataTask resume];
}



@end
