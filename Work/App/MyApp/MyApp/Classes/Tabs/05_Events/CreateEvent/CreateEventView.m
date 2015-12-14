//
//  CreateEventView.m
//  MyApp
//
//  Created by Linwei Ding on 11/10/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//


#import "AppConstant.h"
#import "ProgressHUD.h"
#import "Event+Util.h"

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
#import "Thumbnail+Util.h"
#import "PlacePropertyView.h"
#import "ThemeManager.h"

#import "PlaceListView.h"

#import "SelectMultiplePeopleView.h"

#import "ConfigurationManager.h"

#import "SelectMultipleBoardView.h"
#import "SelectMultipleGroupView.h"

#import "PlaceLocalDataUtil.h"

#import "EventCategoryLevelView.h"
#import "EventLocalDataUtil.h"

#import "EventActionView.h"
#import "CreateEventView.h"


#define EVENT_SETTING_VIEW_SECTION_TITLE_INDEX 0
#define EVENT_SETTING_VIEW_SECTION_TIME_INDEX 3
#define EVENT_SETTING_VIEW_SECTION_PLACE_INDEX 1
#define EVENT_SETTING_VIEW_SECTION_INVITEE_INDEX 2
#define EVENT_SETTING_VIEW_SECTION_ALERT_INDEX 4
#define EVENT_SETTING_VIEW_SECTION_CATEGORY_INDEX 5

@interface CreateEventView ()


@property (strong, nonatomic) NSString * eventID;


@property (nonatomic) BOOL isAlert;
@property (strong, nonatomic) NSString * categoryID;
@property (strong, nonatomic) NSString * categoryName;
@property (nonatomic) NSUInteger categoryLevel;
@property (strong, nonatomic) UIImage * categoryImage;
@property (strong, nonatomic) NSArray * members;
@property (strong, nonatomic) NSArray * invitees;
@property (strong, nonatomic) NSArray * boards;
@property (strong, nonatomic) NSArray * groups;
@property (strong, nonatomic) NSString * placeID;
@property (strong, nonatomic) NSString * placeName;
@property (strong, nonatomic) UIImage * placeImage;
@property (nonatomic) BOOL isBusy;
@property (nonatomic) BOOL isVoting;
@property (strong, nonatomic) NSString * scope;
@property (strong, nonatomic) NSString * eventTitle;
@property (strong, nonatomic) NSString * location;
@property (strong, nonatomic) NSDate * startTime;
@property (strong, nonatomic) NSDate * endTime;
@property (strong, nonatomic) NSDate * alert;

// static cell

@property (strong, nonatomic) UITableViewCell *categoryCell;
@property (strong, nonatomic) UITableViewCell *placeCell;
@property (strong, nonatomic) UITableViewCell *inviteeCell;
@property (strong, nonatomic) UITableViewCell *boardsCell;
@property (strong, nonatomic) UITableViewCell *groupsCell;
@property (strong, nonatomic) UITableViewCell *membersCell;

@property (strong, nonatomic) IBOutlet UITableViewCell *titleCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *busyCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *locationCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *startTimeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *endTimeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *scopeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *alertCell;


@property (strong, nonatomic) UITableViewCell *selectPlaceCell;
@property (strong, nonatomic) UITableViewCell *selectInviteeCell;
@property (strong, nonatomic) UITableViewCell *selectMemberCell;
@property (strong, nonatomic) UITableViewCell *selectBoardCell;
@property (strong, nonatomic) UITableViewCell *selectGroupCell;

@property (strong, nonatomic) UITableViewCell *smartScheduleCell;


@property (strong, nonatomic) IBOutlet UITextField *alertTextField;
@property (strong, nonatomic) IBOutlet UITextField *locationTextField;
@property (strong, nonatomic) IBOutlet UITextField *textTextField;
@property (strong, nonatomic) IBOutlet UITextField *endTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTextField;


@property (weak, nonatomic) IBOutlet UISegmentedControl *busySegement;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scopeSegment;

@property (strong, nonatomic) UIDatePicker * startDatePicker;
@property (strong, nonatomic) UIDatePicker * endDatePicker;
@property (strong, nonatomic) UIDatePicker * alertDatePicker;

@property (strong, nonatomic) UIBarButtonItem * saveButton;

@property (strong, nonatomic) NSIndexPath * curIndexPath;



@end

@implementation CreateEventView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [super viewDidLoad];
	self.title = @"Create Event";
    
    [self.busySegement setTintColor:[[ThemeManager sharedUtil] buttonColor]];
    [self.scopeSegment setTintColor:[[ThemeManager sharedUtil] buttonColor]];
    
    [self.startTimeTextField setInputView:self.startDatePicker];
    [self.endTimeTextField setInputView:self.endDatePicker];
    [self.alertTextField setInputView:self.alertDatePicker];
    

    NSMutableArray * rightBarButtons = [[NSMutableArray alloc] init];
    
    self.saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(actionSaveButton)];
    
    NSUInteger dayCount = [self.days count];
    if (dayCount == 0) {
        //nothing
    }
    else if (dayCount == 1) {
        // only start day
        self.startTime = [self.days firstObject];
    }
    else if (dayCount == 2) {
        // this is a range
        self.startTime = [self.days firstObject];
        self.endTime = [self.days lastObject];
    }
    else {
        NSAssert(NO, @"day count is not valid");
    }
    self.isAlert = NO;
    self.isVoting = NO;
    self.scope = @"private";
    self.isBusy = NO;
    
    
    
    [rightBarButtons addObject: self.saveButton];
    // add switch view button
    self.navigationItem.rightBarButtonItems = rightBarButtons;
    
    self.categoryLevel = 0;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //self.editEnable = NO;
    
    [self updateCellContents];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self dismissKeyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void) updateCellContents {
    //Event * event = [Event entityWithID:self.eventID inManagedObjectContext:[ConfigurationManager sharedManager].managedObjectContext];
    
    //[self updateProperty:event];
    
    if (self.categoryName) {
        self.categoryCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu:%@",self.categoryLevel, self.categoryName];
    }
    
    [self.categoryCell.imageView setImage: self.categoryImage];
    self.busySegement.selectedSegmentIndex = self.isBusy?0:1;    //0:yes, 1:no
    
    self.placeCell.detailTextLabel.text = self.placeName;
    [self.placeCell.imageView setImage: self.placeImage];
    
    if ([self.scope isEqualToString:@"private"]) {
        self.scopeSegment.selectedSegmentIndex = 0;
    }
    else if ([self.scope isEqualToString:@"friend"]) {
        self.scopeSegment.selectedSegmentIndex = 1;
    }
    else if ([self.scope isEqualToString:@"public"]) {
        self.scopeSegment.selectedSegmentIndex = 2;
    }
    self.inviteeCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu invitees", [(NSArray *)self.invitees count] ] ;
    self.boardsCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu boards", [(NSArray *)self.boards count] ] ;
    self.groupsCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu groups", [(NSArray *)self.groups count] ] ;
    self.membersCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu members", [(NSArray *)self.members count] ] ;
    
    //accessory
    self.placeCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.inviteeCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.boardsCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.groupsCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.membersCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

        
    self.scopeSegment.enabled = YES;
    self.busySegement.enabled = YES;

    if (self.startTime) {
        self.startDatePicker.date = self.startTime;
        self.startTimeTextField.text = [[ConverterUtil sharedUtil] stringFromDateShort:self.startTime];
    }
    else {
        self.startDatePicker.date = [NSDate date];
    }
    
    
    if (self.endTime) {
        self.endDatePicker.date = self.endTime;
        self.endTimeTextField.text = [[ConverterUtil sharedUtil] stringFromDateShort:self.endTime];
    }
    else {
        if (self.startTime) {
            if (self.endTime) {
                self.endDatePicker.date = self.endTime;
                self.endTimeTextField.text = [[ConverterUtil sharedUtil] stringFromDateShort:self.endTime];
            }
            else {
                self.endDatePicker.date = [NSDate date];
            }
        }
        else {
            self.endDatePicker.date = [NSDate date];
        }
    }
    
    if (self.alert) {
        self.alertDatePicker.date = self.alert;
        self.alertTextField.text = [[ConverterUtil sharedUtil] stringFromDateShort:self.alert];
    }
    else {
        self.alertDatePicker.date = [NSDate date];
    }
    
    
}

- (Event *) createEventProperty {
    NSManagedObjectContext * context = [ConfigurationManager sharedManager].managedObjectContext;
#ifdef LOCAL_MODE
    
    
    Event * event = [Event createEntity:context];
    [[EventLocalDataUtil sharedUtil] setCommonValues:event];
    
    event.title = self.eventTitle;
    event.busy = [NSNumber numberWithBool:self.isBusy];
    event.location = self.location;
    event.scope = self.scope;
    
    event.startTime = self.startTime;
    event.endTime = self.endTime;
    
    event.members = [NSArray arrayWithArray:self.members] ;
    event.invitees = [NSArray arrayWithArray:self.invitees] ;
    event.groupIDs = [NSArray arrayWithArray:self.groups] ;
    event.boardIDs = [NSArray arrayWithArray:self.boards] ;
    
    EventCategory * category = [EventCategory fetchEntityWithLocalID:self.categoryID inManagedObjectContext:context];
    event.category = category;
    
    Place * place = [Place entityWithID:self.placeID inManagedObjectContext:context];
    event.place = place;
    
    event.isAlert = [NSNumber numberWithBool: self.isAlert] ;
#endif
    
#warning TODO -- Implement remote operation here
    return event;
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
            ret = 3;
            break;
        case EVENT_SETTING_VIEW_SECTION_PLACE_INDEX:
            ret = 2;
            break;
        case EVENT_SETTING_VIEW_SECTION_INVITEE_INDEX:
            
            if (self.scopeSegment.selectedSegmentIndex == 0) {
                //private
                ret = 0;
            }
            else if (self.scopeSegment.selectedSegmentIndex == 1) {
                //friend
                ret = 5;
            }
            else {
                //public
                ret = 7;
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
//        case EVENT_SETTING_VIEW_SECTION_CATEGORY_INDEX;
//            if (self.categoryLevel == 0) {
//                ret = 1;
//            }
//            else if (self.categoryLevel == 1) {
//                ret = 2;
//            }
//            else
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
            
            if (indexPath.row == 2) {
                cell = self.selectInviteeCell;
            }
            if (indexPath.row == 4) {
                cell = self.selectGroupCell;
            }
            if (indexPath.row == 6) {
                cell = self.selectBoardCell;
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
                //cell = self.categoryCell;
                EventCategoryLevelView * eventCatLevelVC = [[EventCategoryLevelView alloc] init];
                eventCatLevelVC.delegate = self;
                [self.navigationController pushViewController:eventCatLevelVC animated:YES];
                
            }
            if (indexPath.row == 1) {
                //cell = self.titleCell;
                //[self actionSingleCell:self.titleCell.textLabel.text text:self.titleCell.detailTextLabel.text indexPath:indexPath];
            }
            if (indexPath.row == 2) {
                //cell = self.locationCell;
                
                //[self actionSingleCell:self.locationCell.textLabel.text text:self.locationCell.detailTextLabel.text indexPath:indexPath];
            }
            break;
        case EVENT_SETTING_VIEW_SECTION_TIME_INDEX:
            if (indexPath.row == 0) {
                //cell = self.startTime;
                //[self actionDate:self.startTimeCell.textLabel.text text:self.startTimeCell.detailTextLabel.text indexPath:indexPath];
            }
            if (indexPath.row == 1) {
                //ell = self.endTime;
                //[self actionDate:self.endTimeCell.textLabel.text text:self.endTimeCell.detailTextLabel.text indexPath:indexPath];
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
            
            break;
        case EVENT_SETTING_VIEW_SECTION_ALERT_INDEX:
            if (indexPath.row == 0) {
                //cell = self.alertCell;
                //[self actionDate:self.alertCell.textLabel.text text:self.alertCell.detailTextLabel.text indexPath:indexPath];
            }
            break;
        default:
            break;
    }
    
    
}

#pragma mark -- Actions
- (void) actionSaveButton {
    
#warning TODO implement Remote mode here
    if (!self.title ) {
        [ProgressHUD showError:@"title is required"];
    }
    else if (!self.categoryID) {
        [ProgressHUD showError:@"category is required"];
    }
    else {
        Event * event = [self createEventProperty];
        
        if (event) {
            [ProgressHUD showSuccess:@"Save Success"];
        }
        
        [self updateCellContents];
        //[self.navigationController popViewControllerAnimated:YES];
        
        EventActionView * actionVC = [[EventActionView alloc] initWithEventID:event.globalID];
        [self.navigationController pushViewController:actionVC animated:YES];
    }
    
}

- (IBAction)didChangeScopeSegment:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.scope = @"private";
    }
    else if (sender.selectedSegmentIndex == 1) {
        self.scope = @"friend";
    }
    else if (sender.selectedSegmentIndex == 2) {
        self.scope = @"public";
    }
    else {
        NSAssert(NO, @"it is out of scope of scope value");
    }
    
    [self updateCellContents];
    [self.tableView reloadData];
}

- (IBAction)didChangeBusySegment:(UISegmentedControl *)sender {
    self.isBusy = sender.selectedSegmentIndex?YES:NO;
    
}

- (void)didSelectSinglePlaceMapItem:(MKMapItem *)place catLocalID:(NSString *)localID{
    if (place) {
#warning TODO save this place into our system;
        
        NSManagedObjectContext * context = [ConfigurationManager sharedManager].managedObjectContext;
        
#ifdef LOCAL_MODE
        Place *newPlace = [Place createEntity:context];
        
        NSArray * catLocalIDs = @[localID];
        
        [self updatePlace:newPlace withMapItem:place withCatLocalIDs:catLocalIDs];
        
        [[PlaceLocalDataUtil sharedUtil] setCommonValues:newPlace];
        self.placeID = newPlace.globalID;
        self.placeName = newPlace.title;
        self.placeImage = [UIImage imageWithData:newPlace.thumb.data];
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
        
#ifdef LOCAL_MODE
        Place * newPlace = [Place entityWithID:place.globalID inManagedObjectContext:context];
        
        NSAssert(newPlace, @"select new place does not exist");
        
        self.placeID = newPlace.globalID;
        
        self.placeName = newPlace.title;
        self.placeImage = [UIImage imageWithData:newPlace.thumb.data];
#endif
#warning TODO implement Remote mode here
        //        if (!newPlace) {
        //            newPlace = [Place createEntity:context];
        //            newPlace populateProperties:
        //        }
    }
}

- (void)didSelectMultipleUserIDs:(NSMutableArray *)userIDs {
    if (userIDs) {
        
        //[self updateProperty:event];
        self.invitees = userIDs;
        
    }
}

- (void)didSelectMultipleGroupIDs:(NSMutableArray *)groupIDs {
    if (groupIDs) {
        //[self updateProperty:event];
        self.groups = groupIDs;
    }
}

- (void)didSelectMultipleBoardIDs:(NSMutableArray *)boardIDs {
    if (boardIDs) {
#ifdef LOCAL_MODE
        self.boards = boardIDs;
#endif
        
    }
}

- (void)didSelectEventCategory:(EventCategory *)category {
    if (category) {
        self.categoryID = category.localID;
        self.categoryName = category.name;
        self.categoryImage = [UIImage imageWithData:category.thumb.data];
        self.categoryLevel = [category.level integerValue];
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

- (UITableViewCell *)categoryCell {
    if (!_categoryCell) {
        _categoryCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _categoryCell.textLabel.text = @"Category";
        _categoryCell.detailTextLabel.text = @"-";
        _categoryCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    return _categoryCell;
}


- (UITableViewCell *)placeCell {
    if (!_placeCell) {
        _placeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _placeCell.textLabel.text = @"Place";
        _placeCell.detailTextLabel.text = @"-";
    }
    return _placeCell;
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

- (UITableViewCell *)selectPlaceCell {
    
    if (!_selectPlaceCell) {
        
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
        
        _selectGroupCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        _selectGroupCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //[_selectGroupCell setTintColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectGroupCell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [_selectGroupCell.textLabel setTextColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectGroupCell.textLabel setText:@"Add Groups"];
    }
    return _selectGroupCell;
}

- (UITableViewCell *)selectInviteeCell {
    if (!_selectInviteeCell) {
        
        _selectInviteeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        _selectInviteeCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //[_selectInviteeCell setTintColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectInviteeCell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [_selectInviteeCell.textLabel setTextColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectInviteeCell.textLabel setText:@"Add Invitees"];
    }
    return _selectInviteeCell;
}

- (NSMutableArray *)days {
    if (!_days) {
        _days = [[NSMutableArray alloc] init];
    }
    return _days;
}

#pragma mark -- text field
- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self dismissKeyboard];
    //[self.navigationController popViewControllerAnimated:YES];
    
    if (textField.tag  == 1) {
        self.eventTitle = textField.text;
    }
    else if (textField.tag == 2) {
        self.location = textField.text;
    }
    
    return YES;
}


#pragma mark -- date picker
- (UIDatePicker *)startDatePicker {
    if (!_startDatePicker) {
        _startDatePicker =[[UIDatePicker alloc] init];
        _startDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _startDatePicker.hidden = NO;
        
        [_startDatePicker addTarget:self action:@selector(updateStartDateTextView:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    return _startDatePicker;
}

- (UIDatePicker *)endDatePicker {
    if (!_endDatePicker) {
        _endDatePicker =[[UIDatePicker alloc] init];
        _endDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _endDatePicker.hidden = NO;
        
        [_endDatePicker addTarget:self action:@selector(updateEndDateTextView:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    return _endDatePicker;
}

- (UIDatePicker *)alertDatePicker {
    if (!_alertDatePicker) {
        _alertDatePicker =[[UIDatePicker alloc] init];
        _alertDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _alertDatePicker.hidden = NO;
        
        [_alertDatePicker addTarget:self action:@selector(updateAlertDateTextView:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    return _alertDatePicker;
}

- (void) updateStartDateTextView: (id)sender {
    self.startTimeTextField.text =  [[ConverterUtil sharedUtil] stringFromDateShort:self.startDatePicker.date];
    
    self.startTime = self.startDatePicker.date;
}

- (void) updateEndDateTextView: (id)sender {
    self.endTimeTextField.text =  [[ConverterUtil sharedUtil] stringFromDateShort:self.endDatePicker.date];
    self.endTime = self.endDatePicker.date;
}

- (void) updateAlertDateTextView: (id)sender {
    self.alertTextField.text =  [[ConverterUtil sharedUtil] stringFromDateShort:self.alertDatePicker.date];
    self.alert = self.alertDatePicker.date;
}
@end
