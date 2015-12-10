//
//  SelectMultipleGroupView.m
//  MyApp
//
//  Created by Linwei Ding on 12/9/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import <Parse/Parse.h>
#import "AppHeader.h"
#import "ProgressHUD.h"
#import "Group+Util.h"
#import "AppConstant.h"

#import "GroupRemoteUtil.h"

#import "ConverterUtil.h"

#import "SelectMultipleGroupView.h"

@interface SelectMultipleGroupView ()

@end

@implementation SelectMultipleGroupView

@synthesize selection;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionCancel)];
    
    
    self.managedObjectContext = [ConfigurationManager sharedManager].managedObjectContext;
    
    self.title = @"Select Multiple";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                                                           action:@selector(actionDone)];
    
    [self loadGroups];
    NSParameterAssert(self.delegate);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    super.managedObjectContext = managedObjectContext;
    
    if (managedObjectContext) {
        // init fetch request
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Group"];
        //request.predicate = [NSPredicate predicateWithFormat:@"string"];
        request.fetchLimit = USERVIEW_DISPLAY_ITEM_NUM;
        request.sortDescriptors = @[[NSSortDescriptor
                                     sortDescriptorWithKey:@"name"
                                     ascending:YES
                                     selector:@selector(localizedCompare:)],
                                    ];
        
        
        // init fetch result controller
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
    
}

#pragma mark - User actions

- (void)actionCancel
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionDone
{
    if ([self.selection count] == 0) {
        [ProgressHUD showError:@"Please select some users."];
        return;
    }
    if (self.delegate != nil) {

        [self.delegate didSelectMultipleGroupIDs:self.selection];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) loadGroups {
#ifdef REMOTE_MODE
    Group * latestGroup = nil;
    
    latestGroup = [Group latestEntity:self.managedObjectContext];
    
    [[GroupRemoteUtil sharedUtil] loadRemoteGroups: latestGroup completionHandler:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            //[groups removeAllObjects];
            //[groups addObjectsFromArray:objects];
            //[self.tableView reloadData];
            
            // load the recents into core data
            
            [self.tableView reloadData];
            
        }
        else {
            [ProgressHUD showError:@"Network error."];
        }
        [self.refreshControl endRefreshing];
    }];
#endif
#ifdef LOCAL_MODE
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
#endif

}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//	return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//	return [users count];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    Group * group= [self.fetchedResultsController objectAtIndexPath:indexPath];
    //    User * contact = [[UserManager sharedUtil] getUser:group.userID];
    //    if (!contact) {
    //        contact = group.contact;
    //    }
    
    if ([group.name length]) {
        cell.textLabel.text = group.name;
    }
    else {
        cell.textLabel.text = @"group";
    }
    
    NSArray * memberIDs = group.members;
    NSMutableArray * users = [[NSMutableArray alloc] init];
    UserManager * manager = [UserManager sharedUtil];
    for (NSString * userId in memberIDs) {
        [users addObject:[manager getUser:userId]];
    }
    cell.detailTextLabel.text = [[ConverterUtil sharedUtil] createDescriptionByUsers:users];
    
    
    BOOL selected = [selection containsObject:group.globalID];
    cell.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Group * group= [self.fetchedResultsController objectAtIndexPath:indexPath];
    //User * contact = group.contact;
    
    BOOL selected = [selection containsObject:group.globalID];
    if (selected) {
        [selection removeObject:group.globalID];
    } else {
        [selection addObject:group.globalID];
    }
    [self.tableView reloadData];
    
    //select one user and dismiss
    //	[self dismissViewControllerAnimated:YES completion:^{
    //		if (delegate != nil) {
    //            [delegate didSelectGroup:contact];
    //        }
    //	}];
}

#pragma mark -- property methods
- (NSMutableArray *)selection {
    if (!selection) {
        selection = [[NSMutableArray alloc] init];
    }
    return selection;
}
@end
