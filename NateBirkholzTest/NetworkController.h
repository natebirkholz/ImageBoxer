//
//  NetworkController.h
//  NateBirkholzTest
//
//  Created by Nathan Birkholz on 12/31/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkController : NSObject{
  NSString *someProperty;
}


@property (nonatomic, strong) NSString *apiURL;
@property (nonatomic, strong) NSOperationQueue *networkQueue;
@property (nonatomic, retain) NSString *someProperty;

+ (id)sharedNetworkController;
- (void)getArrayOfImageObjectsWithCompletionHandler:(void (^)(NSArray *imageObjects))completionHandler;
- (void)fetchImageDataFromURL:(NSURL *)fetchURL withCompletionHandler:(void (^)(NSData *imageData))completionHandler;

@end
