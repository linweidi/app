//
//  EventCategoryLevelView.m
//  MyApp
//
//  Created by Linwei Ding on 11/13/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "ProgressHUD.h"
#import "EventCategory+Util.h"
#import "Thumbnail+Util.h"
#import "EventCategoryListView.h"
#import "ThemeManager.h"
#import "ConfigurationManager.h"
#import "EventCategoryLevelView.h"

@interface EventCategoryLevelView ()
@property (nonatomic) int index;

@property (strong, nonatomic) NSString * categoryFirstLocalID;
@property (strong, nonatomic) NSString * categorySecondLocalID;
@property (strong, nonatomic) NSString * categoryThirdLocalID;

@property (strong, nonatomic) UITableViewCell *selectCell;

@property (strong, nonatomic) UITableViewCell *firstLevelCell;
@property (strong, nonatomic) UITableViewCell *secondLevelCell;
@property (strong, nonatomic) UITableViewCell *thirdLevelCell;

- (void)didSelectEventCategoryLevel:(EventCategory *)category level:(int)level;
@end

@implementation EventCategoryLevelView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Level";
    self.index = 0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                                                          action:@selector(actionDone)];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionDone
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    EventCategory * category = nil;
    NSManagedObjectContext * context = [ConfigurationManager sharedManager].managedObjectContext;
    if (self.index == 1) {
        category = [EventCategory fetchEntityWithLocalID:self.categoryFirstLocalID inManagedObjectContext:context];
        [self.delegate didSelectEventCategory:category];
    }
    if (self.index == 2) {
        category = [EventCategory fetchEntityWithLocalID:self.categorySecondLocalID inManagedObjectContext:context];
        [self.delegate didSelectEventCategory:category];
    }
    if (self.index == 3) {
        category = [EventCategory fetchEntityWithLocalID:self.categoryThirdLocalID inManagedObjectContext:context];
        [self.delegate didSelectEventCategory:category];
    }
    
    
    if (self.index <= 3 && self.index >0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertView * alert = [[UIAlertView alloc] init];
        alert.message = @"no event category is selected!";
        [alert show];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.index + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSInteger ret = 0;
//    if (self.index == 0) {
//        //ret = @"First Level";
//        ret = 2;
//    }
//    else if (self.index == 1) {
//        //ret = @"Second Level";
//        if (section == 0) {
//            ret = 1;
//        }
//        else {
//            ret = 2;
//        }
//    }
//    else if (self.index == 2) {
//        //ret = @"Third Level";
//        if (section == 0) {
//            ret = 1;
//        }
//        else if (section == 1) {
//            ret = 1;
//        }
//        else {
//            ret = 2;
//        }
//        
//    }
//    else if (self.index == 3) {
//        if (section == 0) {
//            ret = 1;
//        }
//        else if (section == 1) {
//            ret = 1;
//        }
//        else {
//            ret = 1;
//        }
//    }
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString * ret = nil;
    if (section == 0) {
        ret = @"1st Level";
    }
    else if (section == 1) {
        ret = @"2nd Level";
    }
    else if (section == 2) {
        ret = @"3rd Level";
    }
    else {
        ret = @"4th Level";
    }
    return ret;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//    }
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        if (self.index == 0) {
            cell = self.selectCell;
        }
        else {
            cell = self.firstLevelCell;
            [self setTableViewCell:cell catLocalID:self.categoryFirstLocalID];
        }
    }
    if (indexPath.section == 1) {
        
        if (self.index == 1) {
            cell = self.selectCell;
        }
        else {
            cell = self.secondLevelCell;
            [self setTableViewCell:cell catLocalID:self.categorySecondLocalID];
        }
    }
    if (indexPath.section == 2) {
        
        if (self.index == 2) {
            cell = self.selectCell;
        }
        else {
            cell = self.thirdLevelCell;
            [self setTableViewCell:cell catLocalID:self.categoryThirdLocalID];
        }
    }
    
    if (indexPath.section == 3) {
        
        if (self.index == 3) {
            cell = self.selectCell;
        }
        else {
            //[self setTableViewCell:cell category:self.categoryThird];
            // nothing
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    [self dismissViewControllerAnimated:YES completion:^{
//        PFUser * userPF = users[indexPath.row];
//        if (delegate != nil) [delegate didSelectSingleUser:[[UserRemoteUtil sharedUtil] convertToUser:userPF]];
//    }];
    if (indexPath.section == self.index) {
        EventCategoryListView * selectTV = [[EventCategoryListView alloc] init];
        selectTV.delegate = self;
        selectTV.level = self.index + 1;
        
        if (self.index == 0) {
            selectTV.parentID = nil;
        }
        else if (self.index == 1) {
            selectTV.parentID = self.categoryFirstLocalID;
        }
        else if (self.index == 2) {
            selectTV.parentID = self.categorySecondLocalID;
        }
        else if (self.index == 3) {
            selectTV.parentID = self.categoryThirdLocalID;
        }
        else {
            NSAssert(NO, @"index is greater than 2");
        }
        
        if (indexPath.section >= 3) {
            [ProgressHUD showError:@"Sorry, currently only support three levels"];
        }
        else {
            [self.navigationController pushViewController:selectTV animated:YES];
        }
        
    }

}

- (void) setTableViewCell:(UITableViewCell *)cell catLocalID:(NSString *)catLocalID {
    EventCategory * category = [EventCategory fetchEntityWithLocalID:catLocalID inManagedObjectContext:[ConfigurationManager sharedManager].managedObjectContext];
    
    cell.textLabel.text = category.name;
    [cell.imageView setImage:[UIImage imageWithData:category.thumb.data]];
}

#pragma mark -- next view controller's delegate

- (void)didSelectEventCategoryLevel:(EventCategory *)category level:(int)level {
    // increment
    self.index = level;
    if (level == 1) {
        self.categoryFirstLocalID = category.localID;
    }
    else if (level == 2) {
        self.categorySecondLocalID = category.localID;
    }
    else if (level == 3) {
        self.categoryThirdLocalID = category.localID;
    }
    else {
        NSAssert(NO, @"level value is out of scope");
    }
    
    //[self.tableView reloadData];
}

#pragma mark -- cell
- (UITableViewCell *)selectCell {
    
    if (!_selectCell) {
        
        _selectCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        _selectCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //[_selectPlaceCell setTintColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectCell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [_selectCell.textLabel setTextColor:[[ThemeManager sharedUtil] buttonColor]];
        [_selectCell.textLabel setText:@"Select Place"];
    }
    return _selectCell;
}

- (UITableViewCell *)firstLevelCell {
    if (!_firstLevelCell) {
        _firstLevelCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return _firstLevelCell;
    
}

- (UITableViewCell *)secondLevelCell {
    if (!_secondLevelCell) {
        _secondLevelCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return _secondLevelCell;
}

- (UITableViewCell *)thirdLevelCell {
    if (!_thirdLevelCell) {
        _thirdLevelCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return _thirdLevelCell;
}
@end
