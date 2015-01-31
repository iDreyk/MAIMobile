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
    
    //Берем ширину экрана, вычитаем наши констраинты (- 20 - 8) и вычитаем ширину навигационой стрелки (-34)
    CGRect frameName = [name boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20 - 8 - 34, 300.0)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributesDictionaryName
                                      context:nil];
    
    UIFont *fontLink = [UIFont systemFontOfSize:14.0f];
    NSDictionary *attributesDictionaryLink = [NSDictionary dictionaryWithObjectsAndKeys:
                                          fontLink, NSFontAttributeName, nil];
    CGRect frameLink = [link boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20 - 8 - 34, 300.0)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributesDictionaryLink
                                      context:nil];
    //Результирующая высота будет складываться из высот лэйблов и констрэинтов между ними.  +10 - растояние между лжблами
    return frameName.size.height + 8 + frameLink.size.height + 8 + 10;
}
@end
