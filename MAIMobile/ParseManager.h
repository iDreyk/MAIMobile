//
//  ParseManager.h
//  MAIMobile
//
//  Created by Ilya Tsarev on 21.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ParseManager : NSObject

//singleton
+ (id)sharedInstance;

- (void)getWordsDictionaryWithCallback:(void (^)(BOOL didError, NSArray *array))callback;

@end
