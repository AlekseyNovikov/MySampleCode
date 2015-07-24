//
//  SectionsTableViewCell.m
//  Innopolis
//
//  Created by Aleksey Novikov on 19/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "SectionsTableViewCell.h"

@implementation SectionsTableViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    _borderBackgroundView.layer.borderColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1].CGColor;
    _borderBackgroundView.layer.borderWidth = 1.f;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
    self.descriptionLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.descriptionLabel.frame);
}


@end
