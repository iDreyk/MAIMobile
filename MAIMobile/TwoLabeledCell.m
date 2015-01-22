//
//  TwoLabeledCell.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 22.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "TwoLabeledCell.h"

@implementation TwoLabeledCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        
        _logoImageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
            imageView;
        });
        [self addSubview:_logoImageView];
        
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70.0, 0, screenWidth - 100, 40)];
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 0;
            [label setFont:[UIFont boldSystemFontOfSize:13.0]];
            label;
        });
        [self addSubview:_titleLabel];
        
        _detailLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70, 40, screenWidth - 100, 40)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 0;
            [label setFont:[UIFont systemFontOfSize:11.0]];
            label;
        });
        [self addSubview:_detailLabel];
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
