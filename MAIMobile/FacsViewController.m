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
    
    [self addMaiLogo];
    
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

#pragma mark - Init

- (void)addMaiLogo{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    UIImageView *maiLogo = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2 - 21, 0, 41.5, 40)];
    [maiLogo setImage:[UIImage imageNamed:@"mai_logo.png"]];
    [self.navigationController.navigationBar addSubview:maiLogo];
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
        if ([imageFile isEqual:[NSNull null]] == NO) {
            [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!error) {
                    cell.logoImageView.image = [UIImage imageWithData:data];
                }
            }];
        }
    }
    
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
        vc.facultyId = _dataArray[indexPath.row][@"id"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
