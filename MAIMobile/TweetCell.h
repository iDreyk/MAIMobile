//
//  TweetCell.h
//  MAIMobile
//
//  Created by Ilya Tsarev on 20.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell <UITextViewDelegate>

@property (nonatomic, strong) UITextView *tweetTextView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIViewController *parentViewController;
@property (nonatomic, strong) UIImageView *profileImageView;

@end
