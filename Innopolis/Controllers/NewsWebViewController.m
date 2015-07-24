//
//  NewsWebViewController.m
//  Innopolis
//
//  Created by Aleksey Novikov on 20/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NewsWebViewController.h"
#import "SWRevealViewController.h"

@interface NewsWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIWebView *newsWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

static NSString *newsUrl = @"http://www.xn--h1aelen.xn--p1ai/news";

@implementation NewsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    NSURL *news = [NSURL URLWithString:newsUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:news];
    
    [_newsWebView loadRequest:request];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [self hideActivityIndicator:NO];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self injectJavascript:@"news"];
    [self hideActivityIndicator:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        return  NO;
    }
    return YES;
}

- (void)injectJavascript:(NSString *)resource {
//    [_newsWebView stringByEvaluatingJavaScriptFromString:@"document. body.style.zoom = 5.0;"];
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:resource ofType:@"js"];
    NSString *js = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:NULL];
    [_newsWebView stringByEvaluatingJavaScriptFromString:js];
    
//    [_newsWebView stringByEvaluatingJavaScriptFromString:@"document. body.style.zoom = 5.0;"];
}

-(void)hideActivityIndicator:(BOOL) hidden {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = !hidden;
    _activityIndicator.hidden = hidden;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
