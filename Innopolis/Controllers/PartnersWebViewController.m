//
//  PartnersWebViewController.m
//  Innopolis
//
//  Created by Aleksey Novikov on 21/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "PartnersWebViewController.h"
#import "SWRevealViewController.h"

@interface PartnersWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIWebView *partnersWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

static NSString *partnersUrl = @"http://www.xn--h1aelen.xn--p1ai/partners";

@implementation PartnersWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _partnersWebView.delegate = self;
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    NSURL *partners = [NSURL URLWithString:partnersUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:partners];
    
    [_partnersWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self hideActivityIndicator:NO];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self injectJavascript:@"partners"];
    [self hideActivityIndicator:YES];
}
- (void)injectJavascript:(NSString *)resource {
    [_partnersWebView stringByEvaluatingJavaScriptFromString:@"document. body.style.zoom = 1.5;"];
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:resource ofType:@"js"];
    NSString *js = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:NULL];
    [_partnersWebView stringByEvaluatingJavaScriptFromString:js];
    
//    [_partnersWebView stringByEvaluatingJavaScriptFromString:@"document. body.style.zoom = 5.0;"];
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
