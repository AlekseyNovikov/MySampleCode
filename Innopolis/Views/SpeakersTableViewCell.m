//
//  SpeakersTableViewCell.m
//  Innopolis
//
//  Created by Aleksey Novikov on 19/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "SpeakersTableViewCell.h"

@implementation SpeakersTableViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    _borderedBackground.layer.borderColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1].CGColor;
    _borderedBackground.layer.borderWidth = 1.f;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
//    self.descriptionLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.descriptionLabel.frame);
}
- (void)prepareForReuse {
    
    [super prepareForReuse];
    _speakerPhotoImage.image = nil;
    
}


@end
