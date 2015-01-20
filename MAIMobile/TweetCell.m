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
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 44, 44)];
            imageView;
        });
        [self addSubview:_profileImageView];
        
        _userNameLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(64.0, 10, 150, 25)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithRed:0 green:144./255. blue:212./255. alpha:1.0];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 1;
            [label setFont:[UIFont boldSystemFontOfSize:14.0]];
            label;
        });
        [self addSubview:_userNameLabel];

        _dateLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 90, 10, 80, 25)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentRight;
            label.numberOfLines = 1;
            [label setFont:[UIFont systemFontOfSize:11.0]];
            label;
        });
        [self addSubview:_dateLabel];
        
        _tweetTextView = ({
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(64, 30, screenWidth - 74, 85)];
            textView.font = [UIFont systemFontOfSize:13.0];
            textView.editable = NO;
//            textView.dataDetectorTypes = UIDataDetectorTypeLink;// | UIDataDetectorTypeAddress | UIDataDetectorTypeCalendarEvent | UIDataDetectorTypePhoneNumber;
//            textView.delegate = self;
            textView.userInteractionEnabled = NO;
            textView;
        });
        [self addSubview:_tweetTextView];        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITextView delegate

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    WebViewController *wv = [[WebViewController alloc] init];
    wv.url = URL;
    [_parentViewController.navigationController pushViewController:wv animated:YES];
    
    return NO;
}


@end
