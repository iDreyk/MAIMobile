//
//  FourLabeledCell.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 22.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "FourLabeledCell.h"

@implementation FourLabeledCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        
        _nameLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0, screenWidth - 20, 40)];
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 0;
            [label setFont:[UIFont boldSystemFontOfSize:13.0]];
            label;
        });
        [self addSubview:_nameLabel];
        
        _jobLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, screenWidth - 20, 30)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 0;
            [label setFont:[UIFont systemFontOfSize:11.0]];
            label;
        });
        [self addSubview:_jobLabel];
        
        _locationLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 100, 20)];
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
