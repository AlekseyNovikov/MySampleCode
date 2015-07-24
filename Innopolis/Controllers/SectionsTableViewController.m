//
//  SectionsTableViewController.m
//  Innopolis
//
//  Created by Aleksey Novikov on 14/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "SectionsTableViewController.h"
#import "SectionDetailViewController.h"
#import "SectionsTableViewCell.h"
#import "Section.h"

#import "SWRevealViewController.h"


@interface SectionsTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (nonatomic, strong) NSArray *sectionsList;

@property (nonatomic, strong) NSNumber *selectedSection;

@end

static NSString *SectionCellIdentifier = @"SectionCell";


@implementation SectionsTableViewController

-(void)createSectionList{
    _sectionsList = [Section findAll];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSectionList];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize:)
                                                 name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    self.tableView.estimatedRowHeight = 106.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
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
    return _sectionsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[SectionsTableViewCell class]])
    {
        SectionsTableViewCell *sectionCell = (SectionsTableViewCell *)cell;
        sectionCell.titleLabel.text = ((Section *)_sectionsList[indexPath.row]).title;
        sectionCell.descriptionLabel.text = ((Section *)_sectionsList[indexPath.row]).excerpt;
    }
}

#pragma mark - Helpers

- (id)selectedItem
{
    NSIndexPath* path = self.tableView.indexPathForSelectedRow;
    return path ? _sectionsList[path.row] : nil;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SectionDetailViewController *sectionDetailViewController = segue.destinationViewController;
    sectionDetailViewController.sectionID = ((Section *)[self selectedItem]).sectionID;    
}


@end
