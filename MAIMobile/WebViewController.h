//
//  WebViewController.h
//
//  Created by Ilya Tsarev on 21.04.14.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIWebView *webView;

@end
