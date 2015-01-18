//
//  NewsViewController.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 18.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "NewsViewController.h"
#import <TwitterKit/TwitterKit.h>

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [self getTwitterFeed];
}

- (void)getTwitterFeed {
    NSInteger tweetsCount = 2;
    NSString *maiTwitterURL = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=newsMAI&count=%ld", (long)tweetsCount];
    
    [[Twitter sharedInstance] logInGuestWithCompletion:^(TWTRGuestSession *guestSession, NSError *error) {
        NSURLRequest *urlRequest = [[[Twitter sharedInstance] APIClient] URLRequestWithMethod:@"GET" URL:maiTwitterURL parameters:nil error:&error];
        [[[Twitter sharedInstance] APIClient] sendTwitterRequest:urlRequest completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (!connectionError) {
                id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&connectionError];
                NSLog(@"data: %@", object);
            } else {
                NSLog(@"Twitter seems to be offline");
            }
        }];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
