//
//  MAIWebInfoTableViewCell.h
//  MAIMobile
//
//  Created by Алексей Левинтов on 22.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAIWebInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkLabel;
+(CGFloat)heightForCellWithName:(NSString*)name andLink:(NSString*)link;
@end
