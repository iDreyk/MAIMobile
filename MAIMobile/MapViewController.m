//
//  MapViewController.m
//  MAIMobile
//
//  Created by Алексей Левинтов on 24.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mapScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *mapImage;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapScrollView.delegate = self;
    _mapScrollView.maximumZoomScale = 10;
    _mapScrollView.minimumZoomScale = 1;

    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _mapImage;
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
