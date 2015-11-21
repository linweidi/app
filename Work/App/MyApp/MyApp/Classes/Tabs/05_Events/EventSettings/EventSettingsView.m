//
//  EventSettingsView.m
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//
#import "Event+Util.h"
#import "TwoLabelTVCell.h"
#import "EventCellView.h"
#import "MemberListView.h"
#import "InviteeListView.h"
#import "GroupListView.h"
#import "BoardListView.h"
#import "EventSettingsView.h"

#define EVENT_SETTING_VIEW_SECTION_TITLE_INDEX 0
#define EVENT_SETTING_VIEW_SECTION_TIME_INDEX 1
#define EVENT_SETTING_VIEW_SECTION_PLACE_INDEX 2
#define EVENT_SETTING_VIEW_SECTION_INVITEE_INDEX 3
#define EVENT_SETTING_VIEW_SECTION_ALERT_INDEX 4

@interface EventSettingsView ()

@property (strong, nonatomic) Event * event;


// static cell
@property (strong, nonatomic) IBOutlet EventCellView *titleCell;
@property (strong, nonatomic) IBOutlet EventCellView *categoryCell;
@property (strong, nonatomic) IBOutlet EventCellView *busyCell;
@property (strong, nonatomic) IBOutlet EventCellView *locationCell;
@property (strong, nonatomic) IBOutlet EventCellView *placeCell;
@property (strong, nonatomic) IBOutlet EventCellView *startTime;
@property (strong, nonatomic) IBOutlet EventCellView *endTime;
@property (strong, nonatomic) IBOutlet EventCellView *scopeCell;
@property (strong, nonatomic) IBOutlet EventCellView *inviteeCell;
@property (strong, nonatomic) IBOutlet EventCellView *boardsCell;
@property (strong, nonatomic) IBOutlet EventCellView *groupsCell;
@property (strong, nonatomic) IBOutlet EventCellView *membersCell;
@property (strong, nonatomic) IBOutlet EventCellView *alertCell;

// static label
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *busySegement;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scopeSegment;
@property (weak, nonatomic) IBOutlet UILabel *inviteeLabel;
@property (weak, nonatomic) IBOutlet UILabel *boardsLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupsLabel;
@property (weak, nonatomic) IBOutlet UILabel *membersLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@end

@implementation EventSettingsView



- (instancetype)initWithEvent:(Event *)event
{
    self = [super init];
    if (self) {
        self.event = event;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"TwoLabelTVCell" bundle:nil] forCellReuseIdentifier:@"LabelCell"];
    //[self.tableView registerNib:[UINib nibWithNibName:@"EventCellView" bundle:nil] forCellReuseIdentifier:@"EventCellView"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger ret = 0;

    switch (section) {
        case EVENT_SETTING_VIEW_SECTION_TITLE_INDEX:
            ret = 3;
            break;
        case EVENT_SETTING_VIEW_SECTION_TIME_INDEX:
            ret = 2;
            break;
        case EVENT_SETTING_VIEW_SECTION_PLACE_INDEX:
            ret = 1;
            break;
        case EVENT_SETTING_VIEW_SECTION_INVITEE_INDEX:
            if (self.scopeSegment.selectedSegmentIndex == 0) {
                //private
                ret = 0;
            }
            else if (self.scopeSegment.selectedSegmentIndex == 1) {
                //friend
                ret = 3;
            }
            else {
                //public
                ret = 4;
            }
            
            break;
        case EVENT_SETTING_VIEW_SECTION_ALERT_INDEX:
            if (self.event.isAlert) {
                ret = 1;
            }
            else {
                ret = 0;
            }
            
            break;
        default:
            break;
    }
	return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCellView * cell = nil;
    
    //Title
    
    switch (indexPath.section) {
        case EVENT_SETTING_VIEW_SECTION_TITLE_INDEX:
            if (indexPath.row == 0) {
                cell = self.titleCell;
            }
            if (indexPath.row == 1) {
                cell = self.categoryCell;
            }
            if (indexPath.row == 2) {
                cell = self.locationCell;
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_TIME_INDEX:
            if (indexPath.row == 0) {
                cell = self.startTime;
            }
            if (indexPath.row == 1) {
                cell = self.endTime;
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_PLACE_INDEX:
            if (indexPath.row == 0) {
                cell = self.placeCell;
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_INVITEE_INDEX:
            if (indexPath.row == 0) {
                cell = self.membersCell;
            }
            if (indexPath.row == 1) {
                cell = self.inviteeCell;
            }
            if (indexPath.row == 2) {
                cell = self.groupsCell;
            }
            if (indexPath.row == 3) {
                cell = self.boardsCell;
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_ALERT_INDEX:
            if (indexPath.row == 0) {
                cell = self.alertCell;
            }
            break;
        default:
            break;
    }
    return cell;
}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	if (section == 1) return @"Members";
//	return nil;
//}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case EVENT_SETTING_VIEW_SECTION_TITLE_INDEX:
            if (indexPath.row == 0) {
                //cell = self.titleCell;
            }
            if (indexPath.row == 1) {
                //cell = self.categoryCell;
            }
            if (indexPath.row == 2) {
                //cell = self.locationCell;
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_TIME_INDEX:
            if (indexPath.row == 0) {
                //cell = self.startTime;
            }
            if (indexPath.row == 1) {
                //ell = self.endTime;
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_PLACE_INDEX:
            if (indexPath.row == 0) {
                //cell = self.placeCell;
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_INVITEE_INDEX:
            if (indexPath.row == 0) {
                //cell = self.membersCell;
                MemberListView * memberVC = [[MemberListView alloc] init];
                memberVC.userIDs = [NSArray arrayWithArray:self.event.members];
                [self.navigationController pushViewController:memberVC animated:YES];
            }
            if (indexPath.row == 1) {
                //cell = self.inviteeCell;
                InviteeListView * inviteeVC = [[InviteeListView alloc] init];
                inviteeVC.userIDs = [NSArray arrayWithArray:self.event.invitees];
                [self.navigationController pushViewController:inviteeVC animated:YES];
            }
            if (indexPath.row == 2) {
                //cell = self.groupsCell;
                GroupListView * groupVC = [[GroupListView alloc] init];
                groupVC.groupIDs  = [NSArray arrayWithArray:self.event.groupIDs];
                [self.navigationController pushViewController:groupVC animated:YES];
            }
            if (indexPath.row == 3) {
                //cell = self.boardsCell;
                BoardListView * boardVC = [[BoardListView alloc] init];
                boardVC.boardIDs = [NSArray arrayWithArray:self.event.boardIDs];
                [self.navigationController pushViewController:boardVC animated:YES];
                
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_ALERT_INDEX:
            if (indexPath.row == 0) {
                //cell = self.alertCell;
            }
            break;
        default:
            break;
    }
}

#pragma mark -- action
- (IBAction)actionScopeSegment:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.event.scope = @"private";
    }
    else if (sender.selectedSegmentIndex == 1) {
        self.event.scope = @"friend";
    }
    else {
        self.event.scope = @"public";
    }
    [self.tableView reloadData];
}
- (IBAction)actionBusySegment:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.event.busy = @YES;
    }
    else {
        self.event.busy = @NO;
    }
}

#pragma mark -- SingleTextViewController delegate
- (void)updateTextfield:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case EVENT_SETTING_VIEW_SECTION_TITLE_INDEX:
            if (indexPath.row == 0) {
                self.event.title = text;
            }
            if (indexPath.row == 1) {
                //cell = self.categoryCell;
            }
            if (indexPath.row == 2) {
                //cell = self.locationCell;
                self.event.location = text;
            }
            break;
        default:
            break;
    }
}
@end
