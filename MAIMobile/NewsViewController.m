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
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=twitterapi&count=2"]];
//
//    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (connectionError == nil)
//        {
//            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&connectionError];
//            NSLog(@"data: %@", object);
//        }
//    }];


//    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {}];
    
//    [[Twitter sharedInstance] logInGuestWithCompletion:^(TWTRGuestSession *guestSession, NSError *error) {
//        [[[Twitter sharedInstance] APIClient] loadTweetWithID:@"550263975154561025" completion:^(TWTRTweet *tweet, NSError *error) {
//            TWTRTweetView *tweetView = [[TWTRTweetView alloc] initWithTweet:tweet style:TWTRTweetViewStyleRegular];
//            [self.view addSubview:tweetView];
//        }];
//    }];

    
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
