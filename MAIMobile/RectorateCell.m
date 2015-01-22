//
//  RectorateCell.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 21.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "RectorateCell.h"

@implementation RectorateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        
        _photoImageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 56, 89)];
            imageView;
        });
        [self addSubview:_photoImageView];
        
        _nameLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(64.0, 0, screenWidth - 68, 40)];
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 0;
            [label setFont:[UIFont boldSystemFontOfSize:13.0]];
            label;
        });
        [self addSubview:_nameLabel];
        
        _jobLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(64.0, 40, screenWidth - 68, 30)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 0;
            [label setFont:[UIFont systemFontOfSize:11.0]];
            label;
        });
        [self addSubview:_jobLabel];

        _locationLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(64.0, 70, 100, 20)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor darkGrayColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 1;
            [label setFont:[UIFont boldSystemFontOfSize:11.0]];
            label;
        });
        [self addSubview:_locationLabel];
        
        _phoneLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 160, 70, 150, 20)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = MAIBlueColor;
            label.textAlignment = NSTextAlignmentRight;
            label.numberOfLines = 1;
            [label setFont:[UIFont systemFontOfSize:12.0]];
            label;
        });
        [self addSubview:_phoneLabel];
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

@end
