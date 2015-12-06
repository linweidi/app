//
//  EventSettingsView.m
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "ProgressHUD.h"
#import "Event+Util.h"
#import "TwoLabelTVCell.h"
#import "EventCellView.h"
#import "MemberListView.h"
#import "InviteeListView.h"
#import "GroupListView.h"
#import "BoardListView.h"
#import "EventCategory+Util.h"
#import "Place+Util.h"
#import "ConverterUtil.h"
#import "Alert+Util.h"
#import "PlacePropertyView.h"
#import "ThemeManager.h"

#import "PlaceListView.h"

#import "EventSettingsView.h"

#define EVENT_SETTING_VIEW_SECTION_TITLE_INDEX 0
#define EVENT_SETTING_VIEW_SECTION_TIME_INDEX 1
#define EVENT_SETTING_VIEW_SECTION_PLACE_INDEX 2
#define EVENT_SETTING_VIEW_SECTION_INVITEE_INDEX 3
#define EVENT_SETTING_VIEW_SECTION_ALERT_INDEX 4

@interface EventSettingsView ()

@property (strong, nonatomic) Event * event;

@property (nonatomic) BOOL editEnable;


// static cell
@property (strong, nonatomic) UITableViewCell *titleCell;
@property (strong, nonatomic) UITableViewCell *categoryCell;
@property (strong, nonatomic) UITableViewCell *busyCell;
@property (strong, nonatomic) UITableViewCell *locationCell;
@property (strong, nonatomic) UITableViewCell *placeCell;
@property (strong, nonatomic) UITableViewCell *startTimeCell;
@property (strong, nonatomic) UITableViewCell *endTimeCell;
@property (strong, nonatomic) UITableViewCell *scopeCell;
@property (strong, nonatomic) UITableViewCell *inviteeCell;
@property (strong, nonatomic) UITableViewCell *boardsCell;
@property (strong, nonatomic) UITableViewCell *groupsCell;
@property (strong, nonatomic) UITableViewCell *membersCell;
@property (strong, nonatomic) UITableViewCell *alertCell;

@property (strong, nonatomic) UITableViewCell *selectPlaceCell;
// static label
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *busySegement;
//@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
//@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *scopeSegment;
//@property (weak, nonatomic) IBOutlet UILabel *inviteeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *boardsLabel;
//@property (weak, nonatomic) IBOutlet UILabel *groupsLabel;
//@property (weak, nonatomic) IBOutlet UILabel *membersLabel;
//@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *busySegement;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scopeSegment;

@property (strong, nonatomic) UIDatePicker * datePicker;

@property (strong, nonatomic) UIBarButtonItem * editButton;
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
    
    self.title = self.event.title;
    // Do any additional setup after loading the view from its nib.
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"TwoLabelTVCell" bundle:nil] forCellReuseIdentifier:@"LabelCell"];
    //[self.tableView registerNib:[UINib nibWithNibName:@"EventCellView" bundle:nil] forCellReuseIdentifier:@"EventCellView"];
    
    [self.busySegement setTintColor:[[ThemeManager sharedUtil] buttonColor]];
    [self.scopeSegment setTintColor:[[ThemeManager sharedUtil] buttonColor]];
    
    NSMutableArray * rightBarButtons = [[NSMutableArray alloc] init];
    
    self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actionEditEnable)];
    

    
    [rightBarButtons addObject: self.editButton];
    // add switch view button
    self.navigationItem.rightBarButtonItems = rightBarButtons;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //self.editEnable = NO;
    
    [self updateCellContents];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *busySegement;
//@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
//@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *scopeSegment;
//@property (weak, nonatomic) IBOutlet UILabel *inviteeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *boardsLabel;
//@property (weak, nonatomic) IBOutlet UILabel *groupsLabel;
//@property (weak, nonatomic) IBOutlet UILabel *membersLabel;
//@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
- (void) updateCellContents {
    self.titleCell.detailTextLabel.text = self.event.title;
    self.categoryCell.detailTextLabel.text = self.event.category.name;
    self.busySegement.selectedSegmentIndex = [self.event.busy boolValue]?0:1;    //0:yes, 1:no
    self.locationCell.detailTextLabel.text = self.event.location;
    self.placeCell.detailTextLabel.text = self.event.place.title;

    
    self.startTimeCell.detailTextLabel.text = [[ConverterUtil sharedUtil] stringFromDateShort: self.event.startTime];
    self.endTimeCell.detailTextLabel.text = [[ConverterUtil sharedUtil] stringFromDateShort:self.event.endTime];
    
    if ([self.event.scope isEqualToString:@"private"]) {
        self.scopeSegment.selectedSegmentIndex = 0;
    }
    else if ([self.event.scope isEqualToString:@"friend"]) {
        self.scopeSegment.selectedSegmentIndex = 1;
    }
    else if ([self.event.scope isEqualToString:@"public"]) {
        self.scopeSegment.selectedSegmentIndex = 2;
    }
    self.inviteeCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu invitees", [(NSArray *)self.event.invitees count] ] ;
    self.boardsCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu boards", [(NSArray *)self.event.boardIDs count] ] ;
    self.groupsCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu groups", [(NSArray *)self.event.groupIDs count] ] ;
    self.membersCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu members", [(NSArray *)self.event.members count] ] ;
    
    self.alertCell.detailTextLabel.text = [[ConverterUtil sharedUtil] stringFromDate: self.event.alert.time];
    
    //accessory
    self.placeCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.inviteeCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.boardsCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.groupsCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.membersCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (self.editEnable) {
        self.titleCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.locationCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.startTimeCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.endTimeCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.scopeSegment.enabled = YES;
        self.busySegement.enabled = YES;
        
        self.alertCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else {
        self.titleCell.accessoryType = UITableViewCellAccessoryNone;
        self.locationCell.accessoryType = UITableViewCellAccessoryNone;
        self.startTimeCell.accessoryType = UITableViewCellAccessoryNone;
        self.endTimeCell.accessoryType = UITableViewCellAccessoryNone;
        
        self.scopeSegment.enabled = NO;
        self.busySegement.enabled = NO;
        
        self.alertCell.accessoryType = UITableViewCellAccessoryNone;
    }
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
            ret = 5;
            break;
        case EVENT_SETTING_VIEW_SECTION_TIME_INDEX:
            ret = 2;
            break;
        case EVENT_SETTING_VIEW_SECTION_PLACE_INDEX:
            if (self.editEnable) {
                ret = 2;
            }
            else {
                ret = 1;
            }
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
    UITableViewCell * cell = nil;
    
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
            if (indexPath.row == 3) {
                cell = self.busyCell;
            }
            if (indexPath.row == 4) {
                cell = self.scopeCell;
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_TIME_INDEX:
            if (indexPath.row == 0) {
                cell = self.startTimeCell;
            }
            if (indexPath.row == 1) {
                cell = self.endTimeCell;
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_PLACE_INDEX:
            if (indexPath.row == 0) {
                cell = self.placeCell;
            }
            if (indexPath.row == 1) {
                cell = self.selectPlaceCell;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * ret = nil;
    
    switch (section) {
        case EVENT_SETTING_VIEW_SECTION_TITLE_INDEX:
            ret = @"event";
            break;
        case EVENT_SETTING_VIEW_SECTION_TIME_INDEX:
            ret = @"time";
            break;
        case EVENT_SETTING_VIEW_SECTION_PLACE_INDEX:
            ret = @"location";
            break;
        case EVENT_SETTING_VIEW_SECTION_INVITEE_INDEX:
            ret = @"people";
            
            break;
        case EVENT_SETTING_VIEW_SECTION_ALERT_INDEX:
            if (self.event.isAlert) {
                ret = @"alert";
            }
            else {
                ret = nil;
            }
            break;
        default:
            break;
    }
    return ret;
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case EVENT_SETTING_VIEW_SECTION_TITLE_INDEX:
            if (indexPath.row == 0) {
                //cell = self.titleCell;
                [self actionSingleCell:self.titleCell.textLabel.text text:self.titleCell.detailTextLabel.text indexPath:indexPath];
            }
            if (indexPath.row == 1) {
                //cell = self.categoryCell;
            }
            if (indexPath.row == 2) {
                //cell = self.locationCell;
                
                [self actionSingleCell:self.locationCell.textLabel.text text:self.locationCell.detailTextLabel.text indexPath:indexPath];
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_TIME_INDEX:
            if (indexPath.row == 0) {
                //cell = self.startTime;
                [self actionDate:self.startTimeCell.textLabel.text text:self.startTimeCell.detailTextLabel.text indexPath:indexPath];
            }
            if (indexPath.row == 1) {
                //ell = self.endTime;
                [self actionDate:self.endTimeCell.textLabel.text text:self.endTimeCell.detailTextLabel.text indexPath:indexPath];
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_PLACE_INDEX:
            if (indexPath.row == 0) {
                //cell = self.placeCell;
                [self actionPlace];
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_INVITEE_INDEX:
            if (indexPath.row == 0) {
                //cell = self.membersCell;
                [self actionMembers];
            }
            if (indexPath.row == 1) {
                //cell = self.inviteeCell;
                [self actionInvitee];
            }
            if (indexPath.row == 2) {
                //cell = self.groupsCell;
                [self actionGroups];
            }
            if (indexPath.row == 3) {
                //cell = self.boardsCell;
                [self actionBoards];
                
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

#pragma mark -- Actions
- (void) actionEditEnable {
    self.editEnable = !self.editEnable;
    if (self.editEnable) {
        [ProgressHUD showSuccess:@"Edit is Enabled."];
    }
    else {
        [ProgressHUD showSuccess:@"Edit is Disabled."];
        
    }
    
    [self updateCellContents];
    [self.tableView reloadData];
}



#pragma mark -- SingleTextViewController delegate
- (void)updateTextfield:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    
#warning TODO update remotely as well
    switch (indexPath.section) {
        case EVENT_SETTING_VIEW_SECTION_TITLE_INDEX:
            if (indexPath.row == 0) {

                self.event.title = text;
                [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@ is updated!", @"title"]];
            }
            if (indexPath.row == 1) {
                //cell = self.categoryCell;
                //self.event.location = text;
            }
            if (indexPath.row == 2) {
                //cell = self.locationCell;
                self.event.location = text;
                [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@ is updated!", @"location"]];
            }
            break;
            
        case EVENT_SETTING_VIEW_SECTION_TIME_INDEX:
            if (indexPath.row == 0) {
                //cell = self.startTime;
                self.event.startTime = [[ConverterUtil sharedUtil] dateFromStringShort: text];
                if ([self.event.startTime compare:self.event.endTime] != NSOrderedAscending) {
                    self.event.endTime = nil;
                }
                [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@ is updated!", @"start time"]];
            }
            if (indexPath.row == 1) {
                //ell = self.endTime;
                self.event.endTime = [[ConverterUtil sharedUtil] dateFromStringShort: text];
                if ([self.event.startTime compare:self.event.endTime] == NSOrderedAscending) {
                    [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@ is updated!", @"end time"]];
                }
                else {
                    [ProgressHUD showError:@"your startTime is later than endTime, please update your startTime at first"];
                    self.event.endTime = nil;
                }
            }
            
            break;
        default:
            break;
    }
}


#pragma mark -- action single cell
- (void) actionSingleCell:(NSString *)title text:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    if (self.editEnable) {
        SingleTextfieldViewController * singleTextfieldVC = [[SingleTextfieldViewController alloc] initWithTitle:title text:text];
        singleTextfieldVC.delegate = self;
        singleTextfieldVC.indexPath = indexPath;
        [self.navigationController pushViewController:singleTextfieldVC animated:YES];
    }
    
}

#pragma mark -- action date
- (void) actionDate:(NSString *)title text:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    if (self.editEnable) {
        
        
        SingleTextfieldViewController * singleTextfieldVC = [[SingleTextfieldViewController alloc] initWithTitle:title text:text];
        singleTextfieldVC.delegate = self;
        singleTextfieldVC.indexPath = indexPath;
        singleTextfieldVC.datePicker = self.datePicker;
        
        singleTextfieldVC.dateInputView = YES;
        
        [self.navigationController pushViewController:singleTextfieldVC animated:YES];
        

    }
}

#pragma mark -- action place

- (void) actionPlace {
    PlacePropertyView * placePropVC = [[PlacePropertyView alloc] initWithPlace:self.event.place];
    [self.navigationController pushViewController:placePropVC animated:YES];
}

- (void) actionOnSelectPlace {
    if (self.event.category) {
        PlaceListView * placeListVC = [[PlaceListView alloc] init];
        [self.navigationController pushViewController:placeListVC animated:YES];
    }
    else {
        [ProgressHUD showError:@"Please select category at first"];
    }
    
}

#pragma mark -- action members

- (void) actionMembers {
    MemberListView * memberVC = [[MemberListView alloc] init];
    memberVC.userIDs = [NSArray arrayWithArray:self.event.members];
    [self.navigationController pushViewController:memberVC animated:YES];
}

- (void) actionInvitee {
    InviteeListView * inviteeVC = [[InviteeListView alloc] init];
    inviteeVC.userIDs = [NSArray arrayWithArray:self.event.invitees];
    [self.navigationController pushViewController:inviteeVC animated:YES];
}

- (void) actionGroups {
    GroupListView * groupVC = [[GroupListView alloc] init];
    groupVC.groupIDs  = [NSArray arrayWithArray:self.event.groupIDs];
    [self.navigationController pushViewController:groupVC animated:YES];
}

- (void) actionBoards {
    BoardListView * boardVC = [[BoardListView alloc] init];
    boardVC.boardIDs = [NSArray arrayWithArray:self.event.boardIDs];
    [self.navigationController pushViewController:boardVC animated:YES];
}

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


#pragma mark -- cell method

- (UITableViewCell *)titleCell {
    if (!_titleCell) {
        _titleCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _titleCell.textLabel.text = @"Title";
        _titleCell.detailTextLabel.text = @"-";
    }
    
    return _titleCell;
}

- (UITableViewCell *)categoryCell {
    if (!_categoryCell) {
        _categoryCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _categoryCell.textLabel.text = @"Category";
        _categoryCell.detailTextLabel.text = @"-";
    }
    return _categoryCell;
}

- (UITableViewCell *)locationCell {
    if (!_locationCell) {
        _locationCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _locationCell.textLabel.text = @"Location";
        _locationCell.detailTextLabel.text = @"-";
    }
    return _locationCell;
}

- (UITableViewCell *)placeCell {
    if (!_placeCell) {
        _placeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _placeCell.textLabel.text = @"Place";
        _placeCell.detailTextLabel.text = @"-";
    }
    return _placeCell;
}

- (UITableViewCell *)startTimeCell {
    if (!_startTimeCell) {
        _startTimeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _startTimeCell.textLabel.text = @"StartTime";
        _startTimeCell.detailTextLabel.text = @"11/11/15, 00:00 AM";
    }
    return _startTimeCell;
}

- (UITableViewCell *)endTimeCell {
    if (!_endTimeCell) {
        _endTimeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _endTimeCell.textLabel.text = @"EndTime";
        _endTimeCell.detailTextLabel.text = @"11/11/15, 00:00 AM";
    }
    return _endTimeCell;
}

- (UITableViewCell *)inviteeCell {
    if (!_inviteeCell) {
        _inviteeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _inviteeCell.textLabel.text = @"Invitee";
        _inviteeCell.detailTextLabel.text = @"-";
    }
    return _inviteeCell;
}

- (UITableViewCell *)boardsCell {
    if (!_boardsCell) {
        _boardsCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _boardsCell.textLabel.text = @"Boards";
        _boardsCell.detailTextLabel.text = @"-";
    }
    return _boardsCell;
}

- (UITableViewCell *)groupsCell {
    if (!_groupsCell) {
        _groupsCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _groupsCell.textLabel.text = @"Groups";
        _groupsCell.detailTextLabel.text = @"-";
    }
    return _groupsCell;
}

- (UITableViewCell *)membersCell {
    if (!_membersCell) {
        _membersCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _membersCell.textLabel.text = @"Members";
        _membersCell.detailTextLabel.text = @"-";
    }
    return _membersCell;
}

- (UITableViewCell *)alertCell {
    if (!_alertCell) {
        _alertCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _alertCell.textLabel.text = @"Alert";
        _alertCell.detailTextLabel.text = @"-";
    }
    return _alertCell;
}

- (UITableViewCell *)selectPlaceCell {
    
    if (!_selectPlaceCell) {
        _selectPlaceCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        UIButton * button = [[UIButton alloc] initWithFrame:self.placeCell.bounds];
        [button addTarget:self action:@selector(actionOnSelectPlace) forControlEvents:UIControlEventTouchDown];
        //button.backgroundColor = [UIColor redColor];
        //[button setTintColor:[ThemeManager sharedUtil].buttonColor];
        [button setTitle:@"Select Place" forState:UIControlStateNormal];

        [button setTitleColor:[ThemeManager sharedUtil].buttonColor forState:UIControlStateNormal];
        [_selectPlaceCell.contentView addSubview:button];
    }
    return _selectPlaceCell;
}



@end
