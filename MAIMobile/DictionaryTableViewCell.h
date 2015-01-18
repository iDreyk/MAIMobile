//
//  DictionaryTableViewCell.h
//  MAIMobile
//
//  Created by Алексей Левинтов on 18.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DictionaryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
