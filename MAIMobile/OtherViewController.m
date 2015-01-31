//
//  OtherViewController.m
//  MAIMobile
//
//  Created by Алексей Левинтов on 18.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "OtherViewController.h"
#import "WebViewController.h"
@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addMaiLogo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init

- (void)addMaiLogo{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    UIImageView *maiLogo = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2 - 21, 0, 41.5, 40)];
    [maiLogo setImage:[UIImage imageNamed:@"mai_logo.png"]];
    [self.navigationController.navigationBar addSubview:maiLogo];
}
- (IBAction)extracurricularLife:(id)sender {
    WebViewController * wvc = [[WebViewController alloc] init];
    wvc.url = [NSURL URLWithString:@"http://www.mai.ru/life/"];
    [self.navigationController pushViewController:wvc animated:YES];
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
