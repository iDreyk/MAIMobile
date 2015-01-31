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

- (void)getWebLinksWithCallback:(void (^)(BOOL didError, NSArray *array))callback{
    PFQuery *query = [PFQuery queryWithClassName:@"WebLink"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            callback(YES, nil);
            return;
        }
        
        NSMutableArray *array = [NSMutableArray new];
        for (PFObject *obj in objects) {
            NSString *link = obj[@"link"];
            NSString *name = obj[@"name"];
            
            NSDictionary *dic =  @{@"link" : link ? link : @"",
                                   @"name" : name ? name : @""};
            [array addObject:dic];
            
        }
        callback(NO, array);
    }];
}
- (void)getSlangWordsWithCallback:(void (^)(BOOL didError, NSArray *array))callback{
    PFQuery *query = [PFQuery queryWithClassName:@"SlangWord"];
    [query orderByAscending:@"word"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            callback(YES, nil);
            return;
        }
        
        NSMutableArray *array = [NSMutableArray new];
        for (PFObject *obj in objects) {
            NSString *word = obj[@"word"];
            NSString *desc = obj[@"description"];
            
            NSDictionary *dic =  @{@"word"        : word ? word : @"",
                                   @"description" : desc ? desc : @""};
            [array addObject:dic];
            
        }
        callback(NO, array);
    }];
}

- (void)getRectorateDataWithCallback:(void (^)(BOOL didError, NSArray *array))callback{
    PFQuery *query = [PFQuery queryWithClassName:@"Management"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            callback(YES, nil);
            return;
        }
        
        NSMutableArray *array = [NSMutableArray new];
        for (PFObject *obj in objects) {
            NSString *name = obj[@"name"];
            NSString *job = obj[@"job"];
            NSString *place = obj[@"place"];
            NSString *phone = obj[@"phone"];
            NSString *img = obj[@"image"];
            
            NSDictionary *dic =  @{@"name"  : name ? name : @"",
                                   @"job"   : job ? job : @"",
                                   @"place" : place ? place : @"",
                                   @"phone" : phone ? phone : @"",
                                   @"image" : img ? img : [NSNull null]};
            [array addObject:dic];
            
        }
        callback(NO, array);
    }];
}

- (void)getFacultiesDataWithCallback:(void (^)(BOOL didError, NSArray *array))callback{
    PFQuery *query = [PFQuery queryWithClassName:@"Faculty"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            callback(YES, nil);
            return;
        }
        
        NSMutableArray *array = [NSMutableArray new];
        for (PFObject *obj in objects) {
            NSString *title = obj[@"title"];
            NSString *subtitle = obj[@"subtitle"];
            NSString *img = obj[@"image"];
            NSString *URL = obj[@"url"];
            
            NSDictionary *dic =  @{@"title"    : title ? title : @"",
                                   @"subtitle" : subtitle ? subtitle : @"",
                                   @"image"    : img ? img : [NSNull null],
                                   @"url"      : URL ? URL : @"",
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
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            callback(YES, nil);
            return;
        }
        
        NSMutableArray *array = [NSMutableArray new];
        for (PFObject *obj in objects) {
            if ([obj[@"facultyId"] isEqualToString:facultyId]) {
                NSString *detail = obj[@"name"];
                NSString *title = obj[@"number"];
                NSString *link = obj[@"site"];
                
                NSDictionary *dic =  @{@"detail" : detail ? detail : @"",
                                       @"title"  : title ? title : @"",
                                       @"link"   : link ? link : @""};
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
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            callback(YES, nil);
            return;
        }
        
        NSMutableArray *array = [NSMutableArray new];
        for (PFObject *obj in objects) {
            if ([obj[@"facultyId"] isEqualToString:facultyId]) {
                NSString *name = obj[@"name"];
                NSString *job = obj[@"job"];
                NSString *place = obj[@"location"];
                NSString *tel = obj[@"phone"];
                
                NSDictionary *dic =  @{@"name"  : name ? name : @"",
                                       @"job"   : job ? job : @"",
                                       @"place" : place ? place : @"",
                                       @"tel"   : tel ? tel : @""};
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
