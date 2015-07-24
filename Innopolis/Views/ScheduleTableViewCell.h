//
//  ScheduleTableViewCell.h
//  ITOPK
//
//  Created by Aleksey Novikov on 22/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *borderBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

@end
