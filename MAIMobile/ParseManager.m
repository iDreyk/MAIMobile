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


- (void)getSlangWordsWithCallback:(void (^)(BOOL didError, NSArray *array))callback{
    PFQuery *query = [PFQuery queryWithClassName:@"SlangWord"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            callback(YES, nil);
            return;        }
        
        NSMutableArray *array = [NSMutableArray new];
        for (PFObject *obj in objects) {
            NSDictionary *dic =  @{@"word"        : obj[@"word"],
                                   @"description" : obj[@"description"]};
            [array addObject:dic];
            
        }
        callback(NO, array);
    }];
}

- (void)getRectorateDataWithCallback:(void (^)(BOOL didError, NSArray *array))callback{
    PFQuery *query = [PFQuery queryWithClassName:@"Management"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            callback(YES, nil);
            return;
        }
        
        NSMutableArray *array = [NSMutableArray new];
        for (PFObject *obj in objects) {
            NSDictionary *dic =  @{@"name"  : obj[@"name"],
                                   @"job"   : obj[@"job"],
                                   @"place" : obj[@"place"],
                                   @"phone" : obj[@"phone"],
                                   @"image" : obj[@"image"]};
            [array addObject:dic];
            
        }
        callback(NO, array);
    }];
}

- (void)getFacultiesDataWithCallback:(void (^)(BOOL didError, NSArray *array))callback{
    PFQuery *query = [PFQuery queryWithClassName:@"Faculty"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            callback(YES, nil);
            return;
        }
        
        NSMutableArray *array = [NSMutableArray new];
        for (PFObject *obj in objects) {
            NSDictionary *dic =  @{@"title"    : obj[@"title"],
                                   @"subtitle" : obj[@"subtitle"],
                                   @"image"    : obj[@"image"],
                                   @"url"      : obj[@"url"],
                                   @"id"       : obj.objectId};
            [array addObject:dic];
        }
        callback(NO, array);
    }];
}


@end
