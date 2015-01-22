//
//  FacultyViewController.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 22.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "FacultyViewController.h"

@interface FacultyViewController ()

@property (nonatomic, strong) UIButton *departmentButton;
@property (nonatomic, strong) UIButton *deansOfficeButton;
@property (nonatomic, strong) UIButton *divisionsButton;

@end

@implementation FacultyViewController

- (id)initWithImage:(UIImage *)image title:(NSString *)titleText andDetail:(NSString *)detailText{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;

        _logoImageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 86, 80, 80)];
            imageView.image = image;
            imageView;
        });
        [self.view addSubview:_logoImageView];
        
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(110, 86, screenWidth - 140, 20)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 1;
            [label setFont:[UIFont boldSystemFontOfSize:16.0]];
            label.text = titleText;
            label;
        });
        [self.view addSubview:_titleLabel];

        _detailLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(110, 126, screenWidth - 140, 40)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 0;
            [label setFont:[UIFont systemFontOfSize:13.0]];
            label.text = detailText;
            label;
        });
        [self.view addSubview:_detailLabel];
        
        _departmentButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(20, 160, 150, 20)];
            [button setTitle:@"Кафедры" forState:UIControlStateNormal];
            [button setTintColor:MAIBlueColor];
            [button addTarget:self action:@selector(openDepartments) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
        [self.view addSubview:_departmentButton];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)openDepartments{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
