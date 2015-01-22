//
//  FacsViewController.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 18.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "FacsViewController.h"
#import "RectorateTableViewController.h"
#import "FacultyViewController.h"
#import "TwoLabeledCell.h"
#import "ParseManager.h"

@interface FacsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *facsTableView;
@property (nonatomic, strong) UITableViewController *tableViewController;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FacsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    _dataArray = @[@{@"title" : @"Первый факультет",
//                     @"subtitle" : @"Авиационная техника",
//                     @"image" : @"fac1.jpg",
//                     @"url" : @"http://www.mai.ru/unit/avia/"},
//                   @{@"title" : @"Второй факультет",
//                     @"subtitle" : @"Двигатели летательных аппаратов",
//                     @"image" : @"fac2.jpg",
//                     @"url" : @"http://www.mai.ru/unit/avia/"},
//                   @{@"title" : @"Третий факультет",
//                     @"subtitle" : @"Системы управления, информатика и электроэнергетика",
//                     @"image" : @"fac3.jpg",
//                     @"url" : @"http://www.mai.ru/unit/avia/"}
//                    ];
    
    _facsTableView.delegate = self;
    _facsTableView.dataSource = self;
    
    _tableViewController  = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self addChildViewController:_tableViewController];
    
    _tableViewController.tableView = _facsTableView;
    
    [[ParseManager sharedInstance] getFacultiesDataWithCallback:^(BOOL didError, NSArray *array) {
        if (!didError) {
            _dataArray = array;
            [_tableViewController.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Ректорат";
    }
    return @"Факультеты";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    static NSString *identifier = @"FacsCellId";
    
    TwoLabeledCell *cell = (TwoLabeledCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[TwoLabeledCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    if (indexPath.section == 0) {
        cell.titleLabel.text = @"Ректорат";
        cell.detailLabel.text = @"Руководители института";
        cell.logoImageView.image = [UIImage imageNamed:@"mai_logo_big"];
    } else {
        cell.titleLabel.text = _dataArray[row][@"title"];
        cell.detailLabel.text = _dataArray[row][@"subtitle"];
        
        PFFile *imageFile = _dataArray[row][@"image"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                cell.logoImageView.image = [UIImage imageWithData:data];
            }
        }];
    }
//    CGSize itemSize = CGSizeMake(40, 40);
//    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
//    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
//    [cell.imageView.image drawInRect:imageRect];
//    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();

//    if (self.imagesDictionary[userName]) {
//        cell.profileImageView.image = self.imagesDictionary[userName];
//    } else {
//        NSString* imageUrl = _tweetsArray[row][@"user"][@"profile_image_url"];
//        [self getImageFromUrl:imageUrl asynchronouslyForImageView:cell.profileImageView andKey:userName];
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        RectorateTableViewController *vc = [[RectorateTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        TwoLabeledCell *cell = (TwoLabeledCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        FacultyViewController *vc = [[FacultyViewController alloc] initWithImage:cell.logoImageView.image
                                                                           title:cell.titleLabel.text
                                                                       andDetail:cell.detailLabel.text];
        vc.urlString = _dataArray[indexPath.row][@"url"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
//    NSString *urlString = [NSString stringWithFormat:@"https://twitter.com/newsMAI/status/%@", _tweetsArray[indexPath.row][@"id_str"]];
//    
//    NSString *urlAddress = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *URL = [NSURL URLWithString:urlAddress];
//    
//    WebViewController *wv = [[WebViewController alloc] init];
//    wv.url = URL;
//    [self.navigationController pushViewController:wv animated:YES];
}

@end
