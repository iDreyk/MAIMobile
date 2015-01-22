//
//  RectorateTableViewController.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 21.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "RectorateTableViewController.h"
#import "ParseManager.h"
#import "RectorateCell.h"

@interface RectorateTableViewController ()

@property (nonatomic, strong) NSArray *rectorateDataArray;

@end

@implementation RectorateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
    [[ParseManager sharedInstance] getRectorateDataWithCallback:^(BOOL didError, NSArray *array) {
        if (!didError) {
            _rectorateDataArray = array;
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
    return _rectorateDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    static NSString *identifier = @"RectorateCellId";
    
    RectorateCell *cell = (RectorateCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[RectorateCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

    cell.nameLabel.text = _rectorateDataArray[row][@"name"];
    cell.jobLabel.text = _rectorateDataArray[row][@"job"];
    cell.locationLabel.text = _rectorateDataArray[row][@"place"];
    cell.phoneLabel.text = _rectorateDataArray[row][@"phone"];

    PFFile *imageFile = _rectorateDataArray[row][@"image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.photoImageView.image= [UIImage imageWithData:data];
        }
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *phoneNumber = ((RectorateCell *)[tableView cellForRowAtIndexPath:indexPath]).phoneLabel.text;
    
    UIActionSheet *actSheet = [[UIActionSheet alloc] initWithTitle:@"Набрать номер"
                                                          delegate:self
                                                 cancelButtonTitle:@"Отмена"
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles:phoneNumber, nil];
    actSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actSheet showInView:self.view];    
}

#pragma mark - Actio Sheet delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSString *phoneNumber = [actionSheet buttonTitleAtIndex:buttonIndex];
        
        NSString *cleanedString = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
        NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", cleanedString]];
        [[UIApplication sharedApplication] openURL:telURL];
    }
}

@end
