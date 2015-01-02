//
//  JSONParser.h
//  NateBirkholzTest
//
//  Created by Nathan Birkholz on 12/31/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSONParser : NSObject

- (NSArray *)parseJSONIntoImageObjectsFromData:(NSData *)rawJSONData ;

@end
