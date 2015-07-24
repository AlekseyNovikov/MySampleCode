//
//  SpeakersTableViewCell.h
//  Innopolis
//
//  Created by Aleksey Novikov on 19/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakersTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *speakerPhotoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIView *borderedBackground;


@end
