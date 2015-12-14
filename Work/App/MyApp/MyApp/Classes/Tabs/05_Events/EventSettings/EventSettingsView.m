//
//  EventSettingsView.m
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "AppConstant.h"
#import "ProgressHUD.h"
#import "Event+Util.h"
#import "Thumbnail+Util.h"

#import "ThemeManager.h"
#import "EventCellView.h"
#import "MemberListView.h"
#import "InviteeListView.h"
#import "GroupListView.h"
#import "BoardListView.h"
#import "EventCategory+Util.h"
#import "Place+Util.h"
#import "Place+Annotation.h"
#import "ConverterUtil.h"
#import "Alert+Util.h"
#import "PlacePropertyView.h"
#import "ThemeManager.h"

#import "PlaceListView.h"

#import "SelectMultiplePeopleView.h"

#import "ConfigurationManager.h"

#import "SelectMultipleBoardView.h"
#import "SelectMultipleGroupView.h"

#import "PlaceLocalDataUtil.h"

#import "EventSettingsView.h"

#define EVENT_SETTING_VIEW_SECTION_TITLE_INDEX 0
#define EVENT_SETTING_VIEW_SECTION_TIME_INDEX 3
#define EVENT_SETTING_VIEW_SECTION_PLACE_INDEX 1
#define EVENT_SETTING_VIEW_SECTION_INVITEE_INDEX 2
#define EVENT_SETTING_VIEW_SECTION_ALERT_INDEX 4

@interface EventSettingsView ()



@property (nonatomic) BOOL editEnable;

@property (strong, nonatomic) NSString * eventID;
@property (nonatomic) BOOL isAlert;
@property (strong, nonatomic) NSString * categoryID;
@property (strong, nonatomic) NSString * categoryName;
@property (strong, nonatomic) NSArray * members;
@property (strong, nonatomic) NSArray * invitees;
@property (strong, nonatomic) NSArray * boards;
@property (strong, nonatomic) NSArray * groups;
@property (strong, nonatomic) NSString * placeID;

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
@property (strong, nonatomic) UITableViewCell *selectInviteeCell;
@property (strong, nonatomic) UITableViewCell *selectMemberCell;
@property (strong, nonatomic) UITableViewCell *selectBoardCell;
@property (strong, nonatomic) UITableViewCell *selectGroupCell;

@property (strong, nonatomic) UITableViewCell *smartScheduleCell;
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

@property (strong, nonatomic) NSIndexPath * curIndexPath;
@end

@implementation EventSettingsView



- (instancetype)initWithEvent:(NSString *)eventID
{
    self = [super init];
    if (self) {
        self.eventID = eventID;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Event";
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
    Event * event = [Event entityWithID:self.eventID inManagedObjectContext:[ConfigurationManager sharedManager].managedObjectContext];
    
    [self updateProperty:event];
    
    self.titleCell.detailTextLabel.text = event.title;
    self.categoryCell.detailTextLabel.text = event.category.name;
    [self.categoryCell.imageView setImage: [UIImage imageWithData:event.category.thumb.data]];
    self.busySegement.selectedSegmentIndex = [event.busy boolValue]?0:1;    //0:yes, 1:no
    self.locationCell.detailTextLabel.text = event.location;
    self.placeCell.detailTextLabel.text = event.place.title;
    [self.placeCell.imageView setImage:[UIImage imageWithData:event.place.thumb.data]];
    
    self.startTimeCell.detailTextLabel.text = [[ConverterUtil sharedUtil] stringFromDateShort: event.startTime];
    self.endTimeCell.detailTextLabel.text = [[ConverterUtil sharedUtil] stringFromDateShort:event.endTime];
    
    if ([event.scope isEqualToString:@"private"]) {
        self.scopeSegment.selectedSegmentIndex = 0;
    }
    else if ([event.scope isEqualToString:@"friend"]) {
        self.scopeSegment.selectedSegmentIndex = 1;
    }
    else if ([event.scope isEqualToString:@"public"]) {
        self.scopeSegment.selectedSegmentIndex = 2;
    }
    self.inviteeCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu invitees", [(NSArray *)event.invitees count] ] ;
    self.boardsCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu boards", [(NSArray *)event.boardIDs count] ] ;
    self.groupsCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu groups", [(NSArray *)event.groupIDs count] ] ;
    self.membersCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu members", [(NSArray *)event.members count] ] ;
    
    self.alertCell.detailTextLabel.text = [[ConverterUtil sharedUtil] stringFromDateShort: event.alert.time];
    
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

- (void) updateProperty: (Event *) event {
    self.isAlert = event.isAlert;
    self.members = [NSArray arrayWithArray:event.members];
    self.invitees = [NSArray arrayWithArray:event.invitees];
    self.groups = [NSArray arrayWithArray:event.groupIDs];
    self.boards = [NSArray arrayWithArray:event.boardIDs];
    self.categoryID = event.category.localID;
    self.categoryName = event.category.name;
    self.placeID = event.place.globalID;
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
            ret = self.editEnable?3:2;
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
                ret = (!self.editEnable)? 3:5;
            }
            else {
                //public
                ret = (!self.editEnable)? 4:7;
            }
            
            break;
        case EVENT_SETTING_VIEW_SECTION_ALERT_INDEX:
            if (self.isAlert) {
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
            if (indexPath.row == 1) {
                cell = self.titleCell;
            }
            if (indexPath.row == 0) {
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
            if (indexPath.row == 2) {
                cell = self.smartScheduleCell;
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
            if (self.editEnable) {
                if (indexPath.row == 0) {
                    cell = self.membersCell;
                }
                if (indexPath.row == 1) {
                    cell = self.inviteeCell;
                }
                if (indexPath.row == 3) {
                    cell = self.groupsCell;
                }
                if (indexPath.row == 5) {
                    cell = self.boardsCell;
                }
//                if (indexPath.row == 1) {
//                    cell = nil;
//                }
//                if (indexPath.row == 3) {
//                    cell = self.selectInviteeCell;
//                }
//                if (indexPath.row == 5) {
//                    cell = self.selectGroupCell;
//                }
//                if (indexPath.row == 7) {
//                    cell = self.selectBoardCell;
//                }
                
                if (indexPath.row == 2) {
                    cell = self.selectInviteeCell;
                }
                if (indexPath.row == 4) {
                    cell = self.selectGroupCell;
                }
                if (indexPath.row == 6) {
                    cell = self.selectBoardCell;
                }

            }
            else {
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
            if (self.isAlert) {
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
    
    self.curIndexPath = indexPath;
    
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
            if (indexPath.row == 1) {
                [self actionOnSelectPlace];
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_INVITEE_INDEX:
            if (self.editEnable) {
                if (indexPath.row == 0) {
                    //cell = self.membersCell;
                    [self actionMembers];
                }
                if (indexPath.row == 1) {
                    //cell = self.inviteeCell;
                    [self actionInvitee];
                }
                if (indexPath.row == 3) {
                    //cell = self.groupsCell;
                    [self actionGroups];
                }
                if (indexPath.row == 5) {
                    //cell = self.boardsCell;
                    [self actionBoards];
                }
//                if (indexPath.row == 1) {
//                    //cell = self.membersCell;
//                    //[self actionOnSelectMember];
//                }
                if (indexPath.row == 2) {
                    //cell = self.inviteeCell;
                    [self actionOnSelectInvitee];
                }
                if (indexPath.row == 4) {
                    //cell = self.groupsCell;
                    [self actionOnSelectGroup];
                }
                if (indexPath.row == 6) {
                    //cell = self.boardsCell;
                    [self actionOnSelectBoard];
                }
            }
            else {
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
            }
            
            break;
        case EVENT_SETTING_VIEW_SECTION_ALERT_INDEX:
            if (indexPath.row == 0) {
                //cell = self.alertCell;
                [self actionDate:self.alertCell.textLabel.text text:self.alertCell.detailTextLabel.text indexPath:indexPath];
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
    Event * event = [Event entityWithID:self.eventID inManagedObjectContext:[ConfigurationManager sharedManager].managedObjectContext];
#warning TODO update remotely as well
    switch (indexPath.section) {
        case EVENT_SETTING_VIEW_SECTION_TITLE_INDEX:
            if (indexPath.row == 0) {

                event.title = text;
                [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@ is updated!", @"title"]];
            }
            if (indexPath.row == 1) {
                //cell = self.categoryCell;
                //self.event.location = text;
            }
            if (indexPath.row == 2) {
                //cell = self.locationCell;
                event.location = text;
                [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@ is updated!", @"location"]];
            }
            break;
            
        case EVENT_SETTING_VIEW_SECTION_TIME_INDEX:
            if (indexPath.row == 0) {
                //cell = self.startTime;
                event.startTime = [[ConverterUtil sharedUtil] dateFromStringShort: text];
                if ([event.startTime compare:event.endTime] != NSOrderedAscending) {
                    event.endTime = nil;
                }
                [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@ is updated!", @"start time"]];
            }
            if (indexPath.row == 1) {
                //ell = self.endTime;
                event.endTime = [[ConverterUtil sharedUtil] dateFromStringShort: text];
                if ([event.startTime compare:event.endTime] == NSOrderedAscending) {
                    [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@ is updated!", @"end time"]];
                }
                else {
                    [ProgressHUD showError:@"your startTime is later than endTime, please update your startTime at first"];
                    event.endTime = nil;
                }
            }
            
            break;
        case EVENT_SETTING_VIEW_SECTION_ALERT_INDEX:
            if (indexPath.row == 0) {
                //cell = self.alertCell;
                event.alert.time = [[ConverterUtil sharedUtil] dateFromStringShort: text];
#warning TODO add alert to local notification system
            }
            break;
        default:
            break;
    }
}
- (void)didSelectSinglePlaceMapItem:(MKMapItem *)place catLocalID:(NSString *)localID{
    if (place) {
        
                         
#warning TODO save this place into our system;
        NSManagedObjectContext * context = [ConfigurationManager sharedManager].managedObjectContext;
        
        Event * event = [Event entityWithID:self.eventID inManagedObjectContext:context];
#ifdef LOCAL_MODE
        Place *newPlace = [Place createEntity:context];
        
        NSArray * catLocalIDs = @[localID];
        
        [self updatePlace:newPlace withMapItem:place withCatLocalIDs:catLocalIDs];
                         
        event.place = newPlace;
        [[PlaceLocalDataUtil sharedUtil] setCommonValues:newPlace];
        self.placeID = newPlace.globalID;
#endif
    }
#warning TODO implement Remote mode here
}

- (void) updatePlace:(Place *)place withMapItem:(MKMapItem *)mapItem withCatLocalIDs:(NSArray *)localIDs{
    place.coordinate = mapItem.placemark.location.coordinate;
    place.likes = 0;
    place.parking = 0;
    place.price = 0;
    place.rankings = 0;
    place.title = mapItem.name?mapItem.name:mapItem.placemark.title;
    place.subtitle = @"";
    place.tips = @"";
    place.catLocalIDs = localIDs;
}

- (void)didSelectSinglePlace:(Place *)place {
    if (place) {
        NSManagedObjectContext * context = [ConfigurationManager sharedManager].managedObjectContext;
        
        Event * event = [Event entityWithID:self.eventID inManagedObjectContext:context];
        
#ifdef LOCAL_MODE
        Place * newPlace = [Place entityWithID:place.globalID inManagedObjectContext:context];
        
        NSAssert(newPlace, @"select new place does not exist");
        
        event.place = newPlace;
        self.placeID = newPlace.globalID;
#endif
#warning TODO implement Remote mode here
//        if (!newPlace) {
//            newPlace = [Place createEntity:context];
//            newPlace populateProperties:
//        }
    }
}


//- (void)didSelectMultipleUsers:(NSMutableArray *)users {
//    if (users) {
//        
//        Event * event = [Event entityWithID:self.eventID inManagedObjectContext:[ConfigurationManager sharedManager].managedObjectContext];
//        
//        //[self updateProperty:event];
//#ifdef LOCAL_MODE
//        
//        if (self.curIndexPath.section == EVENT_SETTING_VIEW_SECTION_INVITEE_INDEX) {
//            switch (self.curIndexPath.row) {
//                case 0:
//                    break;
//                case 1:
//                    event.invitees = users;
//                    break;
//                case 2:
//                    event.groupIDs = users;
//                    break;
//                case 3:
//                    event.boardIDs = users;
//                    break;
//                default:
//                    break;
//            }
//        }
//#endif
//#warning implement Remote mode here
//        //        if (!newPlace) {
//        //            newPlace = [Place createEntity:context];
//        //            newPlace populateProperties:
//        //        }
//    }
//}

- (void)didSelectMultipleUserIDs:(NSMutableArray *)userIDs {
    if (userIDs) {
        
        Event * event = [Event entityWithID:self.eventID inManagedObjectContext:[ConfigurationManager sharedManager].managedObjectContext];
        
        //[self updateProperty:event];
#ifdef LOCAL_MODE
        event.invitees = userIDs;
#endif
#warning TODO implement Remote mode here

    }
}

- (void)didSelectMultipleGroupIDs:(NSMutableArray *)groupIDs {
    if (groupIDs) {
        
        Event * event = [Event entityWithID:self.eventID inManagedObjectContext:[ConfigurationManager sharedManager].managedObjectContext];
        
        //[self updateProperty:event];
#ifdef LOCAL_MODE
        event.groupIDs = groupIDs;
#endif
#warning TODO implement Remote mode here
        
    }
}

- (void)didSelectMultipleBoardIDs:(NSMutableArray *)boardIDs {
    if (boardIDs) {
        
        Event * event = [Event entityWithID:self.eventID inManagedObjectContext:[ConfigurationManager sharedManager].managedObjectContext];
        
        //[self updateProperty:event];
#ifdef LOCAL_MODE
        event.boardIDs = boardIDs;
#endif
#warning TODO implement Remote mode here
        
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
    PlacePropertyView * placePropVC = [[PlacePropertyView alloc] initWithPlace:self.placeID];
    [self.navigationController pushViewController:placePropVC animated:YES];
}

- (void) actionOnSelectPlace {
    if (self.categoryID) {
        
        PlaceListView * placeListVC = [[PlaceListView alloc] init];
        placeListVC.catLocalID = [NSString stringWithFormat:@"%@", self.categoryID];
        placeListVC.catName = [NSString stringWithFormat:@"%@", self.categoryName];
        placeListVC.delegate = self;
        [self.navigationController pushViewController:placeListVC animated:YES];
    }
    else {
        [ProgressHUD showError:@"Please select category at first"];
    }
    
}

- (void) actionOnSelectBoard {
    SelectMultipleBoardView * selectView = [[SelectMultipleBoardView alloc] init];
    //NSParameterAssert(selectView.selection);
    selectView.delegate = self;
    [selectView.selection addObjectsFromArray:self.groups];
    [self.navigationController pushViewController:selectView animated:YES];
}

//- (void) actionOnSelectMember {
//    [self presentUserSelectionView:self.event.members];
//}

- (void) actionOnSelectInvitee {
    SelectMultiplePeopleView * selectView = [[SelectMultiplePeopleView alloc] init];
    //NSParameterAssert(selectView.selection);
    selectView.delegate = self;
    [selectView.selection addObjectsFromArray:self.invitees];
    [self.navigationController pushViewController:selectView animated:YES];
}

- (void) actionOnSelectGroup {
    SelectMultipleGroupView * selectView = [[SelectMultipleGroupView alloc] init];
    //NSParameterAssert(selectView.selection);
    selectView.delegate = self;
    [selectView.selection addObjectsFromArray:self.groups];
    [self.navigationController pushViewController:selectView animated:YES];
}

-  (void) presentUserSelectionView: (NSArray *)selectionIDs {
    SelectMultiplePeopleView * selectView = [[SelectMultiplePeopleView alloc] init];
    //NSParameterAssert(selectView.selection);
    selectView.delegate = self;
    [selectView.selection addObjectsFromArray:selectionIDs];
    [self.navigationController pushViewController:selectView animated:YES];
}
//-  (void) pushUserSelectionView: (NSArray *)selectionIDs {
//    SelectMultiplePeopleView * selectView = [[SelectMultiplePeopleView alloc] init];
//    //NSParameterAssert(selectView.selection);
//    [selectView.selection addObjectsFromArray:selectionIDs];
//    [self.navigationController pushViewController:selectView animated:YES];
//}


#pragma mark -- action members

- (void) actionMembers {
    MemberListView * memberVC = [[MemberListView alloc] init];
    memberVC.userIDs = [NSArray arrayWithArray:self.members];
    [self.navigationController pushViewController:memberVC animated:YES];
}

- (void) actionInvitee {
    InviteeListView * inviteeVC = [[InviteeListView alloc] init];
    inviteeVC.userIDs = [NSArray arrayWithArray:self.invitees];
    [self.navigationController pushViewController:inviteeVC animated:YES];
}

- (void) actionGroups {
    GroupListView * groupVC = [[GroupListView alloc] init];
    groupVC.groupIDs  = [NSArray arrayWithArray:self.groups];
    [self.navigationController pushViewController:groupVC animated:YES];
}

- (void) actionBoards {
    BoardListView * boardVC = [[BoardListView alloc] init];
    boardVC.boardIDs = [NSArray arrayWithArray:self.boards];
    [self.navigationController pushViewController:boardVC animated:YES];
}

- (IBAction)actionScopeSegment:(UISegmentedControl *)sender {
#warning TODO add remote process here
    Event * event = [Event entityWithID:self.eventID inManagedObjectContext:[ConfigurationManager sharedManager].managedObjectContext];
#ifdef LOCAL_MODE
    
    if (sender.selectedSegmentIndex == 0) {
        event.scope = @"private";
    }
    else if (sender.selectedSegmentIndex == 1) {
        event.scope = @"friend";
    }
    else {
        event.scope = @"public";
    }
    [self.tableView reloadData];
#endif
}

- (IBAction)actionBusySegment:(UISegmentedControl *)sender {
#warning TODO add remote process here
    Event * event = [Event entityWithID:self.eventID inManagedObjectContext:[ConfigurationManager sharedManager].managedObjectContext];
#ifdef LOCAL_MODE
    if (sender.selectedSegmentIndex == 0) {
        event.busy = @YES;
    }
    else {
        event.busy = @NO;
    }
#endif
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
        //_selectPlaceCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
//        UIButton * button = [[UIButton alloc] initWithFrame:self.placeCell.bounds];
//        [button addTarget:self action:@selector(actionOnSelectPlace) forControlEvents:UIControlEventTouchDown];
//        //button.backgroundColor = [UIColor redColor];
//        //[button setTintColor:[ThemeManager sharedUtil].buttonColor];
//        [button setTitle:@"Select Place" forState:UIControlStateNormal];
//
//        [button setTitleColor:[ThemeManager sharedUtil].buttonColor forState:UIControlStateNormal];
//        [_selectPlaceCell.contentView addSubview:button];
        
        _selectPlaceCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        _selectPlaceCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //[_selectPlaceCell setTintColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectPlaceCell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [_selectPlaceCell.textLabel setTextColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectPlaceCell.textLabel setText:@"Select Place"];
    }
    return _selectPlaceCell;
}

- (UITableViewCell *)smartScheduleCell {
    if (!_smartScheduleCell) {
        
        _smartScheduleCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        _smartScheduleCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //[_selectPlaceCell setTintColor:[[ThemeManager sharedUtil] buttonColor]];
        [_smartScheduleCell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [_smartScheduleCell.textLabel setTextColor:[[ThemeManager sharedUtil] buttonColor]];
        [_smartScheduleCell.textLabel setText:@"🌟Smart Schedule🌟"];
    }
    return _smartScheduleCell;
}

- (UITableViewCell *)selectBoardCell {
    if (!_selectBoardCell) {
//        _selectBoardCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        
//        UIButton * button = [[UIButton alloc] initWithFrame:self.boardsCell.bounds];
//        [button addTarget:self action:@selector(actionOnSelectBoard) forControlEvents:UIControlEventTouchDown];
//        //button.backgroundColor = [UIColor redColor];
//        //[button setTintColor:[ThemeManager sharedUtil].buttonColor];
//        [button setTitle:@"Add Boards" forState:UIControlStateNormal];
//        
//        [button setTitleColor:[ThemeManager sharedUtil].buttonColor forState:UIControlStateNormal];
//        [_selectBoardCell.contentView addSubview:button];
        _selectBoardCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        _selectBoardCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //[_selectBoardCell setTintColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectBoardCell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [_selectBoardCell.textLabel setTextColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectBoardCell.textLabel setText:@"Add Boards"];
        
    }
    return _selectBoardCell;
}

- (UITableViewCell *)selectGroupCell {
    if (!_selectGroupCell) {
//        _selectGroupCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        
//        UIButton * button = [[UIButton alloc] initWithFrame:self.groupsCell.bounds];
//        [button addTarget:self action:@selector(actionOnSelectGroup) forControlEvents:UIControlEventTouchDown];
//        //button.backgroundColor = [UIColor redColor];
//        //[button setTintColor:[ThemeManager sharedUtil].buttonColor];
//        [button setTitle:@"Add Groups" forState:UIControlStateNormal];
//        
//        [button setTitleColor:[ThemeManager sharedUtil].buttonColor forState:UIControlStateNormal];
//        [_selectGroupCell.contentView addSubview:button];
        
        _selectGroupCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        _selectGroupCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //[_selectGroupCell setTintColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectGroupCell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [_selectGroupCell.textLabel setTextColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectGroupCell.textLabel setText:@"Add Groups"];
    }
    return _selectGroupCell;
}

//- (UITableViewCell *)selectMemberCell {
//    if (!_selectMemberCell) {
//        _selectMemberCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        
//        UIButton * button = [[UIButton alloc] initWithFrame:self.membersCell.bounds];
//        [button addTarget:self action:@selector(actionOnSelectMember) forControlEvents:UIControlEventTouchDown];
//        //button.backgroundColor = [UIColor redColor];
//        //[button setTintColor:[ThemeManager sharedUtil].buttonColor];
//        [button setTitle:@"Select Members" forState:UIControlStateNormal];
//        
//        [button setTitleColor:[ThemeManager sharedUtil].buttonColor forState:UIControlStateNormal];
//        [_selectMemberCell.contentView addSubview:button];
//    }
//    return _selectMemberCell;
//}

- (UITableViewCell *)selectInviteeCell {
    if (!_selectInviteeCell) {
//        _selectInviteeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        
//        UIButton * button = [[UIButton alloc] initWithFrame:self.inviteeCell.bounds];
//        [button addTarget:self action:@selector(actionOnSelectInvitee) forControlEvents:UIControlEventTouchDown];
//        //button.backgroundColor = [UIColor redColor];
//        //[button setTintColor:[ThemeManager sharedUtil].buttonColor];
//        [button setTitle:@"Add Invitees" forState:UIControlStateNormal];
//        
//        [button setTitleColor:[ThemeManager sharedUtil].buttonColor forState:UIControlStateNormal];
//        [_selectInviteeCell.contentView addSubview:button];
        _selectInviteeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        _selectInviteeCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //[_selectInviteeCell setTintColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectInviteeCell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [_selectInviteeCell.textLabel setTextColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectInviteeCell.textLabel setText:@"Add Invitees"];
    }
    return _selectInviteeCell;
}



@end
