//
//  DictionaryTableViewCell.m
//  MAIMobile
//
//  Created by Алексей Левинтов on 18.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "DictionaryTableViewCell.h"

@implementation DictionaryTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _wordLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
