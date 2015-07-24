//
//  ViewController.m
//  Innopolis
//
//  Created by Aleksey Novikov on 13/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    _borderBackgroundView.layer.borderColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1].CGColor;
    _borderBackgroundView.layer.borderWidth = 1.f;  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
