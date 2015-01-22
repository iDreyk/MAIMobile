//
//  FacsViewController.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 18.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "FacsViewController.h"
#import "RectorateTableViewController.h"

@interface FacsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *facsTableView;
@property (nonatomic, strong) UITableViewController *tableViewController;
@property (nonatomic, strong) NSDictionary *dataDictionary;

@end

@implementation FacsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataDictionary = @{@"rectorate" : @{@"title" : @"Ректорат",
                                         @"subtitle" : @"Руководители института",
                                         @"image" : @"mai_logo_big"},   // URL in API
                        @"faculties" : @[@{@"title" : @"Первый факультет",
                                           @"subtitle" : @"Авиационная техника",
                                           @"image" : @"fac1.jpg"},
                                         @{@"title" : @"Второй факультет",
                                           @"subtitle" : @"Двигатели летательных аппаратов",
                                           @"image" : @"fac2.jpg"},
                                         @{@"title" : @"Третий факультет",
                                           @"subtitle" : @"Системы управления, информатика и электроэнергетика",
                                           @"image" : @"fac3.jpg"}
                                         ]};
    
    _facsTableView.delegate = self;
    _facsTableView.dataSource = self;
    
    _tableViewController  = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self addChildViewController:_tableViewController];
    
    _tableViewController.tableView = _facsTableView;
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
    return [_dataDictionary[@"faculties"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    static NSString *identifier = @"FacsCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
        cell.textLabel.numberOfLines = 1;
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        cell.detailTextLabel.textColor = [UIColor darkTextColor];
        cell.detailTextLabel.numberOfLines = 0;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }

    if (indexPath.section == 0) {
        cell.textLabel.text = _dataDictionary[@"rectorate"][@"title"];
        cell.detailTextLabel.text = _dataDictionary[@"rectorate"][@"subtitle"];
        cell.imageView.image = [UIImage imageNamed:_dataDictionary[@"rectorate"][@"image"]];
    } else {
        cell.textLabel.text = _dataDictionary[@"faculties"][row][@"title"];
        cell.detailTextLabel.text = _dataDictionary[@"faculties"][row][@"subtitle"];
        cell.imageView.image = [UIImage imageNamed:_dataDictionary[@"faculties"][row][@"image"]];
    }
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

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
