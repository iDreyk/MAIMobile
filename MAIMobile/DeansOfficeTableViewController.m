//
//  DeansOfficeTableViewController.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 22.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "DeansOfficeTableViewController.h"
#import "FourLabeledCell.h"
#import "ParseManager.h"

@interface DeansOfficeTableViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DeansOfficeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [[ParseManager sharedInstance] getDeansOfficeDataForFacultyId:_facultyId withCallback:^(BOOL didError, NSArray *array) {
        if (!didError) {
            _dataArray = array;
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    static NSString *identifier = @"DepartmentsCellId";
    
     FourLabeledCell *cell = (FourLabeledCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[FourLabeledCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];                
    }
    
    cell.nameLabel.text = _dataArray[row][@"name"];
    cell.jobLabel.text = _dataArray[row][@"job"];
    cell.locationLabel.text = _dataArray[row][@"place"];
    cell.phoneLabel.text = _dataArray[row][@"tel"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *phoneNumber = ((FourLabeledCell *)[tableView cellForRowAtIndexPath:indexPath]).phoneLabel.text;
    
    UIActionSheet *actSheet = [[UIActionSheet alloc] initWithTitle:@"Набрать номер"
                                                          delegate:self
                                                 cancelButtonTitle:@"Отмена"
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles:phoneNumber, nil];
    actSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actSheet showInView:self.view];
}

#pragma mark - Action Sheet delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSString *phoneNumber = [actionSheet buttonTitleAtIndex:buttonIndex];
        
        NSString *cleanedString = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
        NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", cleanedString]];
        [[UIApplication sharedApplication] openURL:telURL];
    }
}

@end
