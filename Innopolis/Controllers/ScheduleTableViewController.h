//
//  ScheduleTableViewController.h
//  ITOPK
//
//  Created by Aleksey Novikov on 22/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleTableViewController : UITableViewController

@property (nonatomic, strong) NSFetchedResultsController  *scheduleResultController;

- (id)selectedItem;

@end
