//
//  TweetCell.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 20.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "TweetCell.h"
#import "WebViewController.h"

@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        
        _profileImageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
            imageView;
        });
        [self addSubview:_profileImageView];
        
        _userNameLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(64.0, 10, 150, 15)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = MAIBlueColor;
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 1;
            [label setFont:[UIFont boldSystemFontOfSize:14.0]];
            label;
        });
        [self addSubview:_userNameLabel];

        _dateLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 60, 10, 50, 15)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentRight;
            label.numberOfLines = 1;
            [label setFont:[UIFont systemFontOfSize:11.0]];
            label;
        });
        [self addSubview:_dateLabel];
        
        _tweetTextLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(64, 30, screenWidth - 74, 85)];
            label.font = [UIFont systemFontOfSize:13.0];
            label.numberOfLines = 0;
            label.backgroundColor = [UIColor clearColor];
            label;
        });
        [self addSubview:_tweetTextLabel];
    }
    return self;
}

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITextView delegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    WebViewController *wv = [[WebViewController alloc] init];
    wv.url = URL;
    [_parentViewController.navigationController pushViewController:wv animated:YES];
    
    return NO;
}

@end
