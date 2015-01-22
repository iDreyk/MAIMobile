//
//  DepartmentsTableViewController.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 22.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "DepartmentsTableViewController.h"
#import "WebViewController.h"
#import "ParseManager.h"

@interface DepartmentsTableViewController ()

@property (nonatomic, strong) NSArray *departmentsArray;

@end

@implementation DepartmentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ParseManager sharedInstance] getDepartmentsDataForFacultyId:_facultyId withCallback:^(BOOL didError, NSArray *array) {
        if (!didError) {
            _departmentsArray = array;
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _departmentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    static NSString *identifier = @"DepartmentsCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];

        cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
        cell.textLabel.numberOfLines = 1;
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.numberOfLines = 0;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _departmentsArray[row][@"title"];
    cell.detailTextLabel.text = _departmentsArray[row][@"detail"];
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *urlAddress = [_departmentsArray[indexPath.row][@"link"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:urlAddress];
    
    WebViewController *wv = [[WebViewController alloc] init];
    wv.url = URL;
    [self.navigationController pushViewController:wv animated:YES];
}

@end
