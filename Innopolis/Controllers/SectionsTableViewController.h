//
//  SectionsTableViewController.h
//  Innopolis
//
//  Created by Aleksey Novikov on 14/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SectionsTableViewController : UITableViewController


@property (nonatomic, strong) NSFetchedResultsController  *sectionsResultController;

- (id)selectedItem;

@end
