//
//  EnrolleeTableViewController.m
//  MAIMobile
//
//  Created by Алексей Левинтов on 31.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "EnrolleeTableViewController.h"
#import "EnrolleeTableViewCell.h"
#import "WebViewController.h"
@interface EnrolleeTableViewController ()
@property NSArray *tableData;
@end

@implementation EnrolleeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableData = @[
                       @{@"name" : @"Направления подготовки (специальности) и перечень вступительных испытаний", @"link":@"http://priem.mai.ru/spec.php"},
                       @{@"name" : @"План приема на бюджетные места", @"link":@"http://priem.mai.ru/rules/plan/full.php"},
                       @{@"name" : @"Сроки проведения приема", @"link":@"http://priem.mai.ru/rules/schedule.php"},
                       @{@"name" : @"Информация о наличии общежития", @"link":@"http://priem.mai.ru/rules/hostel.php"},
                       @{@"name" : @"Минимальное количество баллов ЕГЭ, подтверждающее успешное прохождение вступительных испытаний", @"link":@"http://priem.mai.ru/rules/ballege.php"},
                       @{@"name" : @"Контактная информация", @"link":@"http://priem.mai.ru/contacts.php"},
                       ];
    [self addMaiLogo];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}


- (EnrolleeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EnrolleeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"enrolleCell" forIndexPath:indexPath];
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
    {
        cell.contentView.frame = cell.bounds;
        cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    }
    cell.nameLabel.text = self.tableData[indexPath.row][@"name"];
    cell.linkLabel.text = self.tableData[indexPath.row][@"link"];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController * wvc = [[WebViewController alloc] init];
    wvc.url = [NSURL URLWithString:self.tableData[indexPath.row][@"link"]];
    [self.navigationController pushViewController:wvc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EnrolleeTableViewCell heightForCellWithName:self.tableData[indexPath.row][@"name"] andLink:self.tableData[indexPath.row][@"link"]];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
