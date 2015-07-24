//
//  ScheduleTableViewController.m
//  ITOPK
//
//  Created by Aleksey Novikov on 22/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "ScheduleTableViewController.h"
#import "SectionDetailViewController.h"
#import "ScheduleTableViewCell.h"
#import "ScheduleEvent.h"
#import "Section.h"

#import "SWRevealViewController.h"

#import "NSDate+string.h"

@interface ScheduleTableViewController()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sibebarButton;

@property(nonatomic, strong) NSArray *scheduleEventList;
@property(nonatomic, strong) NSNumber *selectedEvent;

@end

static NSString *ScheduleCellIdentifier = @"ScheduleCell";

@implementation ScheduleTableViewController

- (void)createSchelduleEventsList {
    _scheduleEventList = [ScheduleEvent findAllSortetedBy:@"date,timeStart"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSchelduleEventsList];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sibebarButton setTarget:self.revealViewController];
        [self.sibebarButton setAction:@selector(revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize:)
                                                 name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    self.tableView.estimatedRowHeight = 106.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)didChangePreferredContentSize:(NSNotification *)notification
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _scheduleEventList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ScheduleCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[ScheduleTableViewCell class]])
    {
        ScheduleTableViewCell *scheduleCell = (ScheduleTableViewCell *)cell;
        ScheduleEvent *curentEvent = (ScheduleEvent *)_scheduleEventList[indexPath.row];
        scheduleCell.titleLabel.text = curentEvent.title;
        scheduleCell.descriptionLabel.text = curentEvent.excerpt;
        NSDateFormatter *dayFormatter = [NSDateFormatter new];
        [dayFormatter setDateFormat:@"dd.MM"];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"HH:mm"];
        NSString *day = [dayFormatter stringFromDate:curentEvent.date];
        NSString *startTime = [timeFormatter stringFromDate:curentEvent.timeStart];
        NSString *endTime = [timeFormatter stringFromDate:curentEvent.timeEnd];
        scheduleCell.timeLabel.text = [NSString stringWithFormat:@"%@ %@ - %@",day, startTime, endTime];
        
        if ([curentEvent.type isEqualToString:@"break"]) {
            scheduleCell.arrowImage.hidden = YES;
            scheduleCell.userInteractionEnabled = NO;
        }
    }
}

#pragma mark - Helpers

-(NSInteger)numberOfScheduleEventsInSection:(NSInteger)section {
    NSDate *date = [NSDate dateFromCalendarDateGivenAsString:[NSString stringWithFormat:@"%ld.05.2015",26 + section]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@", date];
    return [ScheduleEvent numberOfSheduleEventsWithPredicate:predicate];
}

- (id)selectedItem
{
    NSIndexPath* path = self.tableView.indexPathForSelectedRow;
    return path ? _scheduleEventList[path.row] : nil;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SectionDetailViewController *sectionDetailViewController = segue.destinationViewController;
    sectionDetailViewController.sectionID = ((ScheduleEvent *)[self selectedItem]).notunicID;
}


@end
