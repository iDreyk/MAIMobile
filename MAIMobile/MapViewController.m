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
    
    [self addMaiLogo];

    _mapScrollView.delegate = self;
    _mapScrollView.maximumZoomScale = 10;
    _mapScrollView.minimumZoomScale = 1;
    
    [_mapScrollView setZoomScale:2];
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

#pragma mark - Methods

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
