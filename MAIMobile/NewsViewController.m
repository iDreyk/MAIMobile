//
//  NewsViewController.m
//  MAIMobile
//
//  Created by Ilya Tsarev on 18.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "NewsViewController.h"
#import <TwitterKit/TwitterKit.h>
#import "TweetCell.h"
#import "WebViewController.h"

@interface NewsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
@property (nonatomic, strong) UITableViewController *tableViewController;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *tweetsArray;
@property (atomic, strong) NSMutableDictionary *imagesDictionary;
@property (nonatomic, strong) NSString *twitterFeedPath;
@property (nonatomic, strong) NSString *usersImagesPath;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addMaiLogo];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _twitterFeedPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"twitterFeed.out"];
    _usersImagesPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"usersPics.out"];
    
    _tweetsArray = [NSMutableArray array];
    _imagesDictionary = [NSMutableDictionary dictionary];
    
    _newsTableView.delegate = self;
    _newsTableView.dataSource = self;
    
    _tableViewController  = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self addChildViewController:_tableViewController];
    
    _tableViewController.tableView = _newsTableView;

    NSNotificationCenter* defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(saveAllData:)
                          name:UIApplicationWillTerminateNotification
                        object:nil];

    [defaultCenter addObserver:self
                      selector:@selector(saveAllData:)
                          name:UIApplicationDidEnterBackgroundNotification
                        object:nil];
    
    [self initTableRefreshControl];
    [self loadData];
    [self getTwitterFeed];
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

- (void)initTableRefreshControl{
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    _tableViewController.refreshControl = _refreshControl;
}

#pragma mark - Methods

- (void)saveAllData:(NSNotification *)notification{
    [self saveData];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self getTwitterFeed];
}

- (id)parseJSON:(NSData*) responseData
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

- (void)fillDataSource:(id)parsedData{
    [_tweetsArray removeAllObjects];
    for (NSDictionary *dict in parsedData) {
        [_tweetsArray addObject:dict];
    }
}

- (NSString*)getTimeAsString:(NSDate *)lastDate {
    NSTimeInterval dateDiff =  [[NSDate date] timeIntervalSinceDate:lastDate];
    
    int nrSeconds = dateDiff;//components.second;
    int nrMinutes = nrSeconds / 60;
    int nrHours = nrSeconds / 3600;
    int nrDays = dateDiff / 86400; //components.day;
    
    NSString *time;
    if (nrDays > 5){
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateStyle:NSDateFormatterShortStyle];
        [dateFormat setTimeStyle:NSDateFormatterNoStyle];
        
        time = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:lastDate]];
    } else {
        // days=1-5
        if (nrDays > 0) {
            time = [NSString stringWithFormat:@"%d d", nrDays];
        } else {
            if (nrHours == 0) {
                if (nrMinutes == 0) {
                    time = [NSString stringWithFormat:@"%d s", nrSeconds];
                } else {
                    time = [NSString stringWithFormat:@"%d m", nrMinutes];   
                }
            } else { // days=0 hours!=0
                time = [NSString stringWithFormat:@"%d h", nrHours];
            }
        }
    }
    
    return [NSString stringWithFormat:NSLocalizedString(@"%@", @"label"), time];
}

- (NSDate *)dateForTweet:(NSInteger)tweetNumber{
    NSArray *days = [NSArray arrayWithObjects:@"Mon ", @"Tue ", @"Wed ", @"Thu ", @"Fri ", @"Sat ", @"Sun ", nil];
    NSArray *calendarMonths = [NSArray arrayWithObjects:@"Jan", @"Feb", @"Mar",@"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];
    NSString *dateStr = [_tweetsArray[tweetNumber] objectForKey:@"created_at"];
    
    for (NSString *day in days) {
        if ([dateStr rangeOfString:day].location == 0) {
            dateStr = [dateStr stringByReplacingOccurrencesOfString:day withString:@""];
            break;
        }
    }
    
    NSArray *dateArray = [dateStr componentsSeparatedByString:@" "];
    NSArray *hourArray = [[dateArray objectAtIndex:2] componentsSeparatedByString:@":"];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    NSString *aux = [dateArray objectAtIndex:0];
    int month = 0;
    for (NSString *m in calendarMonths) {
        month++;
        if ([m isEqualToString:aux]) {
            break;
        }
    }
    components.month = month;
    components.day = [[dateArray objectAtIndex:1] intValue];
    components.hour = [[hourArray objectAtIndex:0] intValue];
    components.minute = [[hourArray objectAtIndex:1] intValue];
    components.second = [[hourArray objectAtIndex:2] intValue];
    components.year = [[dateArray objectAtIndex:4] intValue];
    
    NSTimeZone *gmt = [NSTimeZone timeZoneForSecondsFromGMT:2];
    [components setTimeZone:gmt];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *date = [calendar dateFromComponents:components];
    
    return date;
}

- (void)getImageFromUrl:(NSString*)imageUrl asynchronouslyForImageView:(UIImageView*)imageView andKey:(NSString*)key{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:imageUrl];
        
        __block NSData *imageData;
        
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            imageData =[NSData dataWithContentsOfURL:url];
            
            if(imageData){
                if (_imagesDictionary[key] == nil) {
                    [_imagesDictionary setObject:[UIImage imageWithData:imageData] forKey:key];
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    imageView.image = _imagesDictionary[key];
                });
            }
        });
    });
}

- (CGFloat)heightForTextViewRectWithText:(NSString *)text {
    UIFont *font = [UIFont systemFontOfSize:13.0f];
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName, nil];
    
    CGRect frame = [text boundingRectWithSize:CGSizeMake(150, 90.0)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributesDictionary
                                      context:nil];
    return frame.size.height + 10;
}

#pragma mark - Data storage

- (void)saveData {
    NSData *twData = [NSKeyedArchiver archivedDataWithRootObject:_tweetsArray];
    [twData writeToFile:_twitterFeedPath atomically:YES];
    
    NSData *imData = [NSKeyedArchiver archivedDataWithRootObject:_imagesDictionary];
    [imData writeToFile:_usersImagesPath atomically:YES];
}

- (void)loadData {
    BOOL success = NO;
    
    NSData *twData = [NSData dataWithContentsOfFile:_twitterFeedPath];
    if (twData) {
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:twData];
        
        if (array.count > 0) {
            _tweetsArray = [array mutableCopy];
            success = YES;
        }
    }
    
    NSData *imData = [NSData dataWithContentsOfFile:_usersImagesPath];
    if (imData) {
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:imData];
        
        if (dict.count > 0) {
            _imagesDictionary = [dict mutableCopy];
            success = YES;
        }
    }
    if (success == YES) {
        [self.tableViewController.tableView reloadData];
    }
}

#pragma mark - API Calls

- (void)getTwitterFeed {
    NSInteger tweetsCount = 100;
    NSString *maiTwitterURL = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=newsMAI&count=%ld", (long)tweetsCount];
    
    [[Twitter sharedInstance] logInGuestWithCompletion:^(TWTRGuestSession *guestSession, NSError *error) {
        if (!error) {
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
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Не удалось соединиться с Twitter" delegate:nil cancelButtonTitle:@"Закрыть" otherButtonTitles:nil];
                    [av show];
                    [_refreshControl endRefreshing];
                }
            }];
        } else{
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Проверьте интернет подключение" delegate:nil cancelButtonTitle:@"Закрыть" otherButtonTitles:nil];
            [av show];
            [_refreshControl endRefreshing];
        }
    }];
}

#pragma mark - Table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tweetsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * yourText = _tweetsArray[indexPath.row][@"text"];
    return 45 + [self heightForTextViewRectWithText:yourText];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    static NSString *identifier = @"NewsCellId";
    
    TweetCell *cell = (TweetCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.parentViewController = self;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.numberOfLines = 0;
    }

    NSString *userName = _tweetsArray[row][@"user"][@"name"];
    NSDate *datePosted = [self dateForTweet:row];
    NSString *tweetText = _tweetsArray[row][@"text"];
    
    cell.userNameLabel.text = userName;
    cell.dateLabel.text = [self getTimeAsString:datePosted];
    cell.tweetTextLabel.text = tweetText;
    
    CGRect frame = cell.tweetTextLabel.frame;
    frame.size.height = [self heightForTextViewRectWithText:tweetText];
    cell.tweetTextLabel.frame = frame;
    
    if (self.imagesDictionary[userName]) {
        cell.profileImageView.image = self.imagesDictionary[userName];
    } else {
        NSString* imageUrl = _tweetsArray[row][@"user"][@"profile_image_url"];
        [self getImageFromUrl:imageUrl asynchronouslyForImageView:cell.profileImageView andKey:userName];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *urlString = [NSString stringWithFormat:@"https://twitter.com/newsMAI/status/%@", _tweetsArray[indexPath.row][@"id_str"]];
    
    NSString *urlAddress = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:urlAddress];
    
    WebViewController *wv = [[WebViewController alloc] init];
    wv.url = URL;
    [self.navigationController pushViewController:wv animated:YES];
}

@end
