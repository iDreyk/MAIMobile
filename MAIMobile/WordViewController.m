//
//  WordViewController.m
//  MAIMobile
//
//  Created by Алексей Левинтов on 18.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "WordViewController.h"

@interface WordViewController ()

@end

@implementation WordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.descriptionView.text = self.word[@"description"];
    self.wordLabel.text = self.word[@"word"];
    _wordLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:27];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
