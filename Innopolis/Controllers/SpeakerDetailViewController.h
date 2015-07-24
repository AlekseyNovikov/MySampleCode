//
//  SpeakerDetailTableViewController.h
//  Innopolis
//
//  Created by Aleksey Novikov on 18/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Speaker.h"

@interface SpeakerDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIView *borderBackgroundView;

@property (weak, nonatomic) IBOutlet UIImageView *speakerPhoto;
@property (weak, nonatomic) IBOutlet UILabel *speakerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *speakerAboutLabel;
@property (weak, nonatomic) IBOutlet UILabel *speakerContentLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) Speaker *speaker;

@end
