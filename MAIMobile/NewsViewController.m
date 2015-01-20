//
//  NewsViewController.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 18.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "NewsViewController.h"
#import <TwitterKit/TwitterKit.h>

@interface NewsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
@property (nonatomic, strong) UITableViewController *tableViewController;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *tweetsArray;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tweetsArray = [NSMutableArray new];
    
    _newsTableView.delegate = self;
    _newsTableView.dataSource = self;
    
    _tableViewController  = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self addChildViewController:_tableViewController];
    
    _tableViewController.tableView = _newsTableView;

    [self initTableRefreshControl];
    [self getTwitterFeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init

-(void) initTableRefreshControl{
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    _tableViewController.refreshControl = _refreshControl;
}

#pragma mark - Methods

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self getTwitterFeed];
}

-(id) parseJSON:(NSData*) responseData
{
    id result;
    Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
    if (jsonSerializationClass)
    {
        NSError *jsonParsingError = nil;
        result = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonParsingError];
    }
    return result;
}

-(void) fillDataSource:(id)parsedData{
    [_tweetsArray removeAllObjects];
    for (NSDictionary *dict in parsedData) {
        [_tweetsArray addObject:dict[@"text"]];
    }
}

#pragma mark - API Calls

- (void)getTwitterFeed {
    NSInteger tweetsCount = 100;
    NSString *maiTwitterURL = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=newsMAI&count=%ld", (long)tweetsCount];
    
    [[Twitter sharedInstance] logInGuestWithCompletion:^(TWTRGuestSession *guestSession, NSError *error) {
        NSURLRequest *urlRequest = [[[Twitter sharedInstance] APIClient] URLRequestWithMethod:@"GET" URL:maiTwitterURL parameters:nil error:&error];
        [[[Twitter sharedInstance] APIClient] sendTwitterRequest:urlRequest completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (!connectionError) {
                id parsedData = data ? [self parseJSON:data] : nil;
                
                if (parsedData) {
                    [self fillDataSource:parsedData];
                    
                    [_refreshControl endRefreshing];
                    [self.tableViewController.tableView reloadData];
                } else{
                    NSLog(@"Something went wrong");
                    [_refreshControl endRefreshing];
                }
            } else {
                NSLog(@"Twitter seems to be offline");
                [_refreshControl endRefreshing];
            }
        }];
    }];
}

#pragma mark - Table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tweetsArray count];    //count number of row from counting array hear cataGorry is An Array
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
//    [cell.imageView setImageWithURL:[NSURL URLWithString:@"http://example.com/image.jpg"]
//                   placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.textLabel.text = _tweetsArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
