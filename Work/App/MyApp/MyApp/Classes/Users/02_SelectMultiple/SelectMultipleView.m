//
// Copyright (c) 2015 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Parse/Parse.h>
#import "ProgressHUD.h"
#import "PFUser+Util.h"

#import "AppConstant.h"
#import "common.h"

#import "User+Util.h"
#import "CurrentUser+Util.h"

#import "ConfigurationManager.h"
#import "UserRemoteUtil.h"
#import "SelectMultipleView.h"


@interface SelectMultipleView()
{
	NSMutableArray *users;
	NSMutableArray *sections;
	NSMutableArray *selection;
}
@end


@implementation SelectMultipleView

@synthesize delegate;


- (void)viewDidLoad

{
	[super viewDidLoad];
	self.title = @"Select Multiple";
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self
																						  action:@selector(actionCancel)];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
																						   action:@selector(actionDone)];
	
	self.tableView.tableFooterView = [[UIView alloc] init];
	
	users = [[NSMutableArray alloc] init];
	selection = [[NSMutableArray alloc] init];
	
	[self loadUsers];
    
    NSParameterAssert(self.delegate);
}

#pragma mark - Backend actions


- (void)loadUsers

{
    
#ifdef REMOTE_MODE
	PFUser *user = [PFUser currentUser];
    
	PFQuery *query1 = [PFQuery queryWithClassName:PF_BLOCKED_CLASS_NAME];
	[query1 whereKey:PF_BLOCKED_USER1 equalTo:user];
    
	PFQuery *query2 = [PFQuery queryWithClassName:PF_USER_CLASS_NAME];
	[query2 whereKey:PF_USER_OBJECTID notEqualTo:user.objectId];
	[query2 whereKey:PF_USER_OBJECTID doesNotMatchKey:PF_BLOCKED_USERID2 inQuery:query1];
	[query2 orderByAscending:PF_USER_FULLNAME];
	[query2 setLimit:1000];
	[query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error == nil)
         {
             [users removeAllObjects];
             [users addObjectsFromArray:objects];
             [self setObjects:users];
             [self.tableView reloadData];
         }
         else [ProgressHUD showError:@"Network error."];
     }];
#endif
#ifdef LOCAL_MODE
    
    User * currentUser = [[ConfigurationManager sharedManager] getCurrentUser];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PF_USER_CLASS_NAME];
    request.predicate = [NSPredicate predicateWithFormat:@"globalID != %@", currentUser.globalID];
    
    request.fetchLimit = USERVIEW_DISPLAY_ITEM_NUM;
    request.sortDescriptors = @[[NSSortDescriptor
                                 sortDescriptorWithKey:PF_USER_FULLNAME
                                 ascending:YES
                                 selector:@selector(localizedCompare:)],
                                ];
    
    
    NSManagedObjectContext * context = [ConfigurationManager sharedManager].managedObjectContext;
    NSError * error = nil;
    NSArray * matches = [context executeFetchRequest:request error:&error];
    
    if (!error) {
        [users removeAllObjects];
        [users addObjectsFromArray:matches];
        [self setObjects:users];
        [self.tableView reloadData];
    }
    else {
        NSParameterAssert(!error) ;
    }
#endif
    
}


- (void)setObjects:(NSArray *)objects

{
	if (sections != nil) [sections removeAllObjects];
	
	NSInteger sectionTitlesCount = [[[UILocalizedIndexedCollation currentCollation] sectionTitles] count];
	sections = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
	
	for (NSUInteger i=0; i<sectionTitlesCount; i++)
	{
		[sections addObject:[NSMutableArray array]];
	}
	
#ifdef REMOTE_MODE
    for (PFUser *object in objects)
    {
        NSInteger section = [[UILocalizedIndexedCollation currentCollation] sectionForObject:object collationStringSelector:@selector(fullname)];
        [sections[section] addObject:object];
    }
#endif
#ifdef LOCAL_MODE
    for (User *object in objects)
    {
        NSInteger section = [[UILocalizedIndexedCollation currentCollation] sectionForObject:object collationStringSelector:@selector(fullname)];
        [sections[section] addObject:object];
    }
#endif
    
}

#pragma mark - User actions


- (void)actionCancel

{
	[self dismissViewControllerAnimated:YES completion:nil];
}


- (void)actionDone

{
	if ([selection count] == 0) { [ProgressHUD showError:@"Please select some users."]; return; }
	
	[self dismissViewControllerAnimated:YES completion:^{
		if (delegate != nil)
		{
			NSMutableArray *selectedUsers = [[NSMutableArray alloc] init];
            
#ifdef REMOTE_MODE
            for (PFUser *user in users) {
                if ([selection containsObject:user.objectId]) {
                    User * userObj = [[UserRemoteUtil sharedUtil] convertToUser:user ];
                    [selectedUsers addObject:userObj];
                }
            }
#endif
#ifdef LOCAL_MODE
            for (User *user in users) {
                if ([selection containsObject:user.globalID]) {
                    [selectedUsers addObject:user];
                }
            }
#endif
            
			
			[delegate didSelectMultipleUsers:selectedUsers];
		}
	}];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
	return [sections count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
	return [sections[section] count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
	if ([sections[section] count] != 0)
	{
		return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
	}
	else return nil;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView

{
	return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index

{
	return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
	NSMutableArray *userstemp = sections[indexPath.section];
    
#ifdef REMOTE_MODE
    PFUser *user = userstemp[indexPath.row];
    cell.textLabel.text = user[PF_USER_FULLNAME];
    
    BOOL selected = [selection containsObject:user.objectId];
#endif
#ifdef LOCAL_MODE
    User *user = userstemp[indexPath.row];
    cell.textLabel.text = user.fullname;
    
    BOOL selected = [selection containsObject:user.globalID];
#endif
    
	cell.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
	return cell;
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSMutableArray *userstemp = sections[indexPath.section];
    
#ifdef REMOTE_MODE
    PFUser *user = userstemp[indexPath.row];
    BOOL selected = [selection containsObject:user.objectId];
    if (selected) [selection removeObject:user.objectId]; else [selection addObject:user.objectId];
#endif
#ifdef LOCAL_MODE
    User * user = userstemp[indexPath.row];
    BOOL selected = [selection containsObject:user.globalID];
    if (selected) [selection removeObject:user.globalID]; else [selection addObject:user.globalID];
#endif

	[self.tableView reloadData];
}

@end


////
//// Copyright (c) 2015 Related Code - http://relatedcode.com
////
//// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//// THE SOFTWARE.
//
//#import <Parse/Parse.h>
//#import "ProgressHUD.h"
//#import "PFUser+Util.h"
//
//#import "AppConstant.h"
//#import "common.h"
//
//#import "PeopleRemoteUtil.h"
//#import "People+Util.h"
//#import "User+Util.h"
//#import "CurrentUser+Util.h"
//
//#import "UserManager.h"
//
//#import "SelectMultipleView.h"
//
//
//@interface SelectMultipleView()
//{
////	NSMutableArray *users;
////	NSMutableArray *sections;
//	NSMutableArray *selection;
//}
//@end
//
//
//@implementation SelectMultipleView
//
//@synthesize delegate;
//
//
//- (void)viewDidLoad
//
//{
//	[super viewDidLoad];
//	self.title = @"Select Multiple";
//	
//	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self
//																						  action:@selector(actionCancel)];
//	
//	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
//																						   action:@selector(actionDone)];
//	
//	self.tableView.tableFooterView = [[UIView alloc] init];
//	
//	//users = [[NSMutableArray alloc] init];
//	selection = [[NSMutableArray alloc] init];
//	
//	[self loadUsers];
//}
//
//- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
//{
//    super.managedObjectContext = managedObjectContext;
//    
//    if (managedObjectContext) {
//        // init fetch request
//        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"People"];
//        //request.predicate = [NSPredicate predicateWithFormat:@"string"];
//        request.fetchLimit = PEOPLEVIEW_DISPLAY_ITEM_NUM;
//        request.sortDescriptors = @[[NSSortDescriptor
//                                     sortDescriptorWithKey:@"name"
//                                     ascending:YES
//                                     selector:@selector(localizedCompare:)],
//                                    ];
//        
//        
//        // init fetch result controller
//        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"name" cacheName:nil];
//    }
//    
//}
//
//
//#pragma mark - Backend actions
//
//
//- (void)loadUsers
//
//{
//    NSMutableArray * peoples = [[NSMutableArray alloc] init];
//    
//    People * latestPeople = nil;
//    
//    latestPeople = [People latestPeopleEntity :self.managedObjectContext];
//    
//    [[PeopleRemoteUtil sharedUtil] loadRemotePeoples: latestPeople completionHandler:^(NSArray *objects, NSError *error) {
//        if (error == nil)
//		{
//			//[peoples removeAllObjects];
//			//[peoples addObjectsFromArray:objects];
//			//[self.tableView reloadData];
//            
//            People * people = nil;
//            for (RemoteObject * object in objects) {
//                //[recents setObject:object forKey:object[PF_RECENT_GROUPID]];
//                if (latestPeople) {
//                    
//                    people = [People peopleEntityWithRemoteObject:object inManagedObjectContext:self.managedObjectContext];
//                }
//                else {
//                    people = [People createPeopleEntityWithPFObject:object inManagedObjectContext:self.managedObjectContext];
//                }
//                
//                
//                [peoples addObject:people];
//            }
//            
//            
//            // load the recents into core data
//            
//            [self.tableView reloadData];
//            
//		}
//		else [ProgressHUD showError:@"Network error."];
//		[self.refreshControl endRefreshing];
//    }];
//    
////	PFUser *user = [PFUser currentUser];
////
////	PFQuery *query1 = [PFQuery queryWithClassName:PF_BLOCKED_CLASS_NAME];
////	[query1 whereKey:PF_BLOCKED_USER1 equalTo:user];
////
////	PFQuery *query2 = [PFQuery queryWithClassName:PF_USER_CLASS_NAME];
////	[query2 whereKey:PF_USER_OBJECTID notEqualTo:user.objectId];
////	[query2 whereKey:PF_USER_OBJECTID doesNotMatchKey:PF_BLOCKED_USERID2 inQuery:query1];
////	[query2 orderByAscending:PF_USER_FULLNAME];
////	[query2 setLimit:1000];
////	[query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
////	{
////		if (error == nil)
////		{
////			[users removeAllObjects];
////			[users addObjectsFromArray:objects];
////			[self setObjects:users];
////			[self.tableView reloadData];
////		}
////		else [ProgressHUD showError:@"Network error."];
////	}];
//}
//
//
////- (void)setObjects:(NSArray *)objects
////
////{
////	if (sections != nil) [sections removeAllObjects];
////	
////	NSInteger sectionTitlesCount = [[[UILocalizedIndexedCollation currentCollation] sectionTitles] count];
////	sections = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
////	
////	for (NSUInteger i=0; i<sectionTitlesCount; i++)
////	{
////		[sections addObject:[NSMutableArray array]];
////	}
////	
////	for (PFUser *object in objects)
////	{
////		NSInteger section = [[UILocalizedIndexedCollation currentCollation] sectionForObject:object collationStringSelector:@selector(fullname)];
////		[sections[section] addObject:object];
////	}
////}
//
//#pragma mark - User actions
//
//
//- (void)actionCancel
//
//{
//	[self dismissViewControllerAnimated:YES completion:nil];
//}
//
//
//- (void)actionDone
//
//{
//	if ([selection count] == 0) {
//        [ProgressHUD showError:@"Please select some users."];
//        return;
//    }
//	
//	[self dismissViewControllerAnimated:YES completion:^{
//		if (delegate != nil)
//		{
//			NSMutableArray *selectedUsers = [[NSMutableArray alloc] init];
//            
//            for (NSString * userID in selection) {
//                User * user = [[UserManager sharedUtil] getUser:userID];
//                NSAssert(user, @"user does not exist");
//                [selectedUsers addObject:user];
//            }
//            [delegate didSelectMultipleUsers:selectedUsers];
//			
//		}
//	}];
//}
//
//#pragma mark - Table view data source
//
////
////- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
////
////{
////	return [sections count];
////}
////
////
////- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
////
////{
////	return [sections[section] count];
////}
////
////
////- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
////
////{
////	if ([sections[section] count] != 0)
////	{
////		return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
////	}
////	else return nil;
////}
////
////
////- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
////
////{
////	return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
////}
////
////
////- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
////
////{
////	return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
////}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//
//    People * people= [self.fetchedResultsController objectAtIndexPath:indexPath];
//    //    User * contact = [[UserManager sharedUtil] getUser:people.userID];
//    //    if (!contact) {
//    //        contact = people.contact;
//    //    }
//    User * contact = people.contact;
//    
//    if ([people.name length]) {
//        cell.textLabel.text = people.name;
//    }
//    else {
//        cell.textLabel.text = contact.fullname;
//    }
//
//	BOOL selected = [selection containsObject:contact.globalID];
//	cell.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
//
//	return cell;
//}
//
//#pragma mark - Table view delegate
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//	[tableView deselectRowAtIndexPath:indexPath animated:YES];
//	
//    People * people= [self.fetchedResultsController objectAtIndexPath:indexPath];
//    User * contact = people.contact;
//    
//	BOOL selected = [selection containsObject:contact.globalID];
//	if (selected) {
//        [selection removeObject:contact.globalID];
//    } else {
//        [selection addObject:contact.globalID];
//    }
//    
//	
//	[self.tableView reloadData];
//}
//
//@end
