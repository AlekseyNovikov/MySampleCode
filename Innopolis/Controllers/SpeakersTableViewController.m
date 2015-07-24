//
//  SpeakersTableViewController.m
//  Innopolis
//
//  Created by Aleksey Novikov on 14/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "SpeakersTableViewController.h"
#import "SpeakerDetailViewController.h"
#import "SpeakersTableViewCell.h"
#import "Speaker.h"

#import "SWRevealViewController.h"

@interface SpeakersTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (nonatomic, strong) NSArray *speakersList;

@end

static NSString *SectionCellIdentifier = @"SpeakerCell";


@implementation SpeakersTableViewController

-(void)createSpeakerList{
    _speakersList = [Speaker findAll];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSpeakerList];
    
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _speakersList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[SpeakersTableViewCell class]])
    {
        SpeakersTableViewCell *speakerCell = (SpeakersTableViewCell *)cell;
        speakerCell.nameLabel.text = ((Speaker *)_speakersList[indexPath.row]).name;
        NSString *imgURLstring = ((Speaker *)_speakersList[indexPath.row]).photoURL;
        [speakerCell.speakerPhotoImage  sd_setImageWithURL:[NSURL URLWithString:imgURLstring]];
//        speakerCell.descriptionLabel.text = _sectionsDescriptions[indexPath.row];
    }
}

#pragma mark - Helpers

- (id)selectedItem
{
    NSIndexPath* path = self.tableView.indexPathForSelectedRow;
    return path ? _speakersList[path.row] : nil;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SpeakerDetailViewController *speakerDetailViewController = segue.destinationViewController;
    speakerDetailViewController.speaker = ((Speaker *)[self selectedItem]);
}


@end
