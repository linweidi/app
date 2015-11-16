//
//  EventCategoryLevelView.m
//  MyApp
//
//  Created by Linwei Ding on 11/13/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "EventCategory+Util.h"
#import "Thumbnail+Util.h"
#import "EventCategoryListView.h"
#import "EventCategoryLevelView.h"

@interface EventCategoryLevelView ()
@property (nonatomic) int index;

@property (strong, nonatomic) EventCategory * categoryFirst;
@property (strong, nonatomic) EventCategory * categorySecond;
@property (strong, nonatomic) EventCategory * categoryThird;

@end

@implementation EventCategoryLevelView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Event Category Level";
    self.index = 0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                                                          action:@selector(actionDone)];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionDone
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    if (self.index == 1) {
        [self.delegate didSelectEventCategory:self.categoryFirst level:self.index];
    }
    if (self.index == 2) {
        [self.delegate didSelectEventCategory:self.categorySecond level:self.index];
    }
    if (self.index == 3) {
        [self.delegate didSelectEventCategory:self.categoryThird level:self.index];
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
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString * ret = nil;
    if (section == 0) {
        ret = @"First Level";
    }
    else if (section == 1) {
        ret = @"Second Level";
    }
    else {
        ret = @"Third Level";
    }
    return ret;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    if (indexPath.section == 0) {
        if (!self.categoryFirst) {
            [self setTableViewCell:cell category:self.categoryFirst];
        }
        else {
            cell.textLabel.text = @"Select Event Category ...";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if (indexPath.section == 1) {
        
        if (!self.categorySecond) {
            [self setTableViewCell:cell category:self.categorySecond];
        }
        else {
            cell.textLabel.text = @"Select Event Category ...";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if (indexPath.section == 2) {
        
        if (!self.categoryThird) {
            [self setTableViewCell:cell category:self.categoryThird];
        }
        else {
            cell.textLabel.text = @"Select Event Category ...";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        [self.navigationController pushViewController:selectTV animated:YES];
    }

}

- (void) setTableViewCell:(UITableViewCell *)cell category:(EventCategory *)category {
    cell.textLabel.text = category.name;
    [cell.imageView setImage:[UIImage imageWithData:category.thumb.data]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.destinationViewController isKindOfClass:[EventCategoryListView class]]) {
        EventCategoryListView * selectTV = segue.destinationViewController;
        selectTV.level = self.index + 1;
        
        if (self.index == 0) {
            selectTV.parentID = nil;
        }
        else if (self.index == 1) {
            selectTV.parentID = self.categoryFirst.localID;
        }
        else if (self.index == 2) {
            selectTV.parentID = self.categorySecond.localID;
        }
        else {
            NSAssert(NO, @"index is greater than 2");
        }
        selectTV.delegate = self;
    }
}

#pragma mark -- next view controller's delegate

- (void)didSelectEventCategory:(EventCategory *)category level:(int)level {
    // increment
    self.index = level;
    if (level == 1) {
        self.categoryFirst = category;
    }
    else if (level == 2) {
        self.categorySecond = category;
    }
    else if (level == 3) {
        self.categoryThird = category;
    }
    else {
        NSAssert(NO, @"level value is out of scope");
    }
    
    //[self.tableView reloadData];
}

@end
