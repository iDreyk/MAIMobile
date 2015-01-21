//
//  ParseManager.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 21.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "ParseManager.h"

@implementation ParseManager

+ (id)sharedInstance
{
    
    static ParseManager *_sharedObject = nil;
    
    if (_sharedObject == nil)
    {
        _sharedObject = [[ParseManager alloc]init];
    }
    
    return _sharedObject;
}


- (void)getWordsDictionaryWithCallback:(void (^)(BOOL didError, NSArray *array))callback{
    PFQuery *query = [PFQuery queryWithClassName:@"SlangWord"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            callback(YES, nil);
            return;
        }
        
        NSMutableArray *array = [NSMutableArray new];
        for (PFObject *obj in objects) {
            NSDictionary *dic =  @{@"word" : obj[@"word"], @"description":obj[@"description"]};
            [array addObject:dic];
            
        }
        callback(NO, array);
    }];
}

@end
