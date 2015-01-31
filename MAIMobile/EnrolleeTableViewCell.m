//
//  EnrolleeTableViewCell.m
//  MAIMobile
//
//  Created by Алексей Левинтов on 31.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "EnrolleeTableViewCell.h"

@implementation EnrolleeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)heightForCellWithName:(NSString*)name andLink:(NSString*)link
{
    UIFont *fontName = [UIFont systemFontOfSize:17.0f];
    NSDictionary *attributesDictionaryName = [NSDictionary dictionaryWithObjectsAndKeys:
                                          fontName, NSFontAttributeName, nil];
    
    CGRect frameName = [name boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width -20 - 8 - 34, 300.0)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributesDictionaryName
                                      context:nil];
    
    UIFont *fontLink = [UIFont systemFontOfSize:14.0f];
    NSDictionary *attributesDictionaryLink = [NSDictionary dictionaryWithObjectsAndKeys:
                                          fontLink, NSFontAttributeName, nil];
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.width );
    CGRect frameLink = [link boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width -20 - 8, 300.0)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributesDictionaryLink
                                      context:nil];
    
    
    
    
    return frameName.size.height + 8 + frameLink.size.height + 8;
}
@end
