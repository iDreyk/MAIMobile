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

        NSSortDescriptor *idDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:idDescriptor];
        NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
        
        callback(NO, sortedArray);
    }];
}

- (void)getDepartmentsDataForFacultyId:(NSString *)facultyId withCallback:(void (^)(BOOL didError, NSArray *array))callback{
    PFQuery *query = [PFQuery queryWithClassName:@"Chair"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            callback(YES, nil);
            return;
        }
        
        NSMutableArray *array = [NSMutableArray new];
        for (PFObject *obj in objects) {
            if ([obj[@"facultyId"] isEqualToString:facultyId]) {
                NSDictionary *dic =  @{@"detail" : obj[@"name"],
                                       @"title"  : obj[@"number"],
                                       @"link"    : obj[@"site"]};
                [array addObject:dic];
            }
        }
        
        NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:nameDescriptor];
        NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
        
        callback(NO, sortedArray);
    }];
}

- (void)getDeansOfficeDataForFacultyId:(NSString *)facultyId withCallback:(void (^)(BOOL didError, NSArray *array))callback{
    PFQuery *query = [PFQuery queryWithClassName:@"DeansOffice"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            callback(YES, nil);
            return;
        }
        
        NSMutableArray *array = [NSMutableArray new];
        for (PFObject *obj in objects) {
            if ([obj[@"facultyId"] isEqualToString:facultyId]) {
                NSDictionary *dic =  @{@"name"  : obj[@"name"],
                                       @"job"   : obj[@"job"],
                                       @"place" : obj[@"location"],
                                       @"tel"   : obj[@"phone"]};
                [array addObject:dic];
            }
        }
        NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:nameDescriptor];
        NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
        
        callback(NO, sortedArray);
    }];
}

@end
