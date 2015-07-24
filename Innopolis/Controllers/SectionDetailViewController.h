//
//  SectionDetailTableViewController.h
//  Innopolis
//
//  Created by Aleksey Novikov on 18/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionDetail.h"

@interface SectionDetailViewController : UIViewController

@property (nonatomic, strong) NSNumber *sectionID;
@property (nonatomic, strong) SectionDetail *sectionDetail;

@property (weak, nonatomic) IBOutlet UILabel *sectionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionDescriptioinLabel;

@property (weak, nonatomic) IBOutlet UIView *borderBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end
