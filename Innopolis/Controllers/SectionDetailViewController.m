//
//  SectionDetailViewController.m
//  Innopolis
//
//  Created by Aleksey Novikov on 18/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "SectionDetailViewController.h"
#import "NetwokManager.h"
#import "QuestionViewController.h"

@interface SectionDetailViewController ()

@end


@implementation SectionDetailViewController{

}

- (void)createSectionDetailsForSectionID:(NSNumber *) sectionID {
    self.sectionDetail = [SectionDetail findDetailBySectionID:sectionID];
    __weak SectionDetailViewController *weakSelf = self;
    if (!self.sectionDetail) {
        [[NetwokManager sharedNetworkManager] sectionDetails:sectionID
    onCompletion:^(BOOL success) {
        DLog(@"Success Section %@ detail", sectionID);
        SectionDetailViewController *strongSelf = weakSelf;
        strongSelf.sectionDetail = [SectionDetail findDetailBySectionID:sectionID];
        [strongSelf updateLabelsWithContentFromSectionDetail:strongSelf.sectionDetail];
    } onError:^(NSError *error) {
        DLog(@"SectionDetail error - %@", error.localizedDescription);
    }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSectionDetailsForSectionID:self.sectionID];
    
    [self updateLabelsWithContentFromSectionDetail:self.sectionDetail];
    
    _borderBackgroundView.layer.borderColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1].CGColor;
    _borderBackgroundView.layer.borderWidth = 1.f;
    _bottomView.layer.shadowColor = [UIColor blackColor].CGColor;
    _bottomView.layer.shadowOffset = CGSizeMake(0, -2);
    _bottomView.layer.shadowOpacity = 0.4;
    _bottomView.layer.shadowRadius = 1.0;
}

- (void) updateLabelsWithContentFromSectionDetail:(SectionDetail *)sectionDetail{
    if (!sectionDetail) {
        return;
    }
    _sectionTitleLabel.text = sectionDetail.title;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM"];
    _sectionDateLabel.text = [dateFormatter stringFromDate: _sectionDetail.dateStart];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSString *startTime = [timeFormatter stringFromDate:sectionDetail.dateStart];
    NSString *endTime = [timeFormatter stringFromDate:sectionDetail.dateEnd];
    _sectionTimeLabel.text = [NSString stringWithFormat:@"%@ - %@", startTime, endTime];
    
    NSDictionary *location = [NSKeyedUnarchiver unarchiveObjectWithData:sectionDetail.location];
    _sectionPlaceLabel.text = location[@"name"];
    
    _sectionDescriptioinLabel.text = sectionDetail.content;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[QuestionViewController class]]) {
        QuestionViewController *askQuestionVC = segue.destinationViewController;
        askQuestionVC.sectionID = self.sectionID;
    }
}


@end
