//
//  FacultyViewController.h
//  MAIMobile
//
//  Created by Ilya Tsarev on 22.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacultyViewController : UIViewController

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

- (id)initWithImage:(UIImage *)image title:(NSString *)titleText andDetail:(NSString *)detailText;

@end
