//
//  SpeakerDetailViewController.m
//  Innopolis
//
//  Created by Aleksey Novikov on 18/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "SpeakerDetailViewController.h"

@interface SpeakerDetailViewController ()

@end


@implementation SpeakerDetailViewController{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _borderBackgroundView.layer.borderColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1].CGColor;
    _borderBackgroundView.layer.borderWidth = 1.f;
    
    NSURL *photoURL = [NSURL URLWithString:self.speaker.photoURL];
    [_speakerPhoto sd_setImageWithURL:photoURL];
     _speakerNameLabel.text = self.speaker.name;
    _speakerAboutLabel.text = self.speaker.excerpt;
    _speakerContentLabel.text = self.speaker.content;
    
    _bottomView.layer.shadowColor = [UIColor blackColor].CGColor;
    _bottomView.layer.shadowOffset = CGSizeMake(0, -2);
    _bottomView.layer.shadowOpacity = 0.4;
    _bottomView.layer.shadowRadius = 1.0;

}
- (IBAction)backButtonPressed:(id)sender {
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
