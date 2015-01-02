//
//  ImageObject.h
//  NateBirkholzTest
//
//  Created by Nathan Birkholz on 12/31/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageObject : NSObject

@property (nonatomic, strong) NSString *imageObjectThumbnailURL;
@property (nonatomic, strong) NSNumber *imageObjectID;
@property (nonatomic, strong) NSString *imageObjectTitle;

- (instancetype)initWithID:(NSInteger)imgID andTitle:(NSString *)imgTitle andThumbnailURL:(NSString *)imgThumbnailURL;

@end
