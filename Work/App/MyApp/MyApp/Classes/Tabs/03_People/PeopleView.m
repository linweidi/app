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
#import "people.h"
#import "recent.h"


#import "ChatView.h"
#import "SelectSingleView.h"
#import "SelectMultipleView.h"
#import "AddressBookView.h"
#import "FacebookFriendsView.h"
#import "NavigationController.h"

#import "PeopleRemoteUtil.h"
#import "People+Util.h"
#import "User+Util.h"
#import "CurrentUser+Util.h"

#import "UserManager.h"

#import "RecentRemoteUtil.h"

#import "PeopleView.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface PeopleView()
{
	BOOL skipLoading;
	//NSMutableArray *users;

	//NSMutableArray *sections;
}
@property (strong, nonatomic) NSMutableArray *userIds;
@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation PeopleView

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	{
		[self.tabBarItem setImage:[UIImage imageNamed:@"tab_people"]];
		self.tabBarItem.title = @"People";
		//-----------------------------------------------------------------------------------------------------------------------------------------
//		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionCleanup) name:NOTIFICATION_USER_LOGGED_OUT object:nil];
	}
	return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];
	self.title = @"People";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
																						   action:@selector(actionAdd)];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.tableView.tableFooterView = [[UIView alloc] init];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	//users = [[NSMutableArray alloc] init];
	self.userIds = [[NSMutableArray alloc] init];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidAppear:animated];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([CurrentUser getCurrentUser] != nil)
	{
		if (skipLoading) {
            
            skipLoading = NO;
        }else {
            [self loadPeople];
        }
	}
	else {
        LoginUser(self);
    }
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    super.managedObjectContext = managedObjectContext;
    
    if (managedObjectContext) {
        // init fetch request
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"People"];
        //request.predicate = [NSPredicate predicateWithFormat:@"string"];
        request.fetchLimit = PEOPLEVIEW_DISPLAY_ITEM_NUM;
        request.sortDescriptors = @[[NSSortDescriptor
                                     sortDescriptorWithKey:@"name"
                                     ascending:YES
                                     selector:@selector(localizedCompare:)],
                                    ];
        
        
        // init fetch result controller
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"name" cacheName:nil];
    }
    
}


#pragma mark - User actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)loadPeople
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
    NSMutableArray * peoples = [[NSMutableArray alloc] init];
    
    People * latestPeople = nil;
    
    latestPeople = [People latestPeopleEntity :self.managedObjectContext];
    
    [[PeopleRemoteUtil sharedUtil] loadRemotePeoples: latestPeople completionHandler:^(NSArray *objects, NSError *error) {
        if (error == nil)
		{
			//[peoples removeAllObjects];
			//[peoples addObjectsFromArray:objects];
			//[self.tableView reloadData];
            
            People * people = nil;
            for (RemoteObject * object in objects) {
                //[recents setObject:object forKey:object[PF_RECENT_GROUPID]];
                if (latestPeople) {
                    
                    people = [People peopleEntityWithRemoteObject:object inManagedObjectContext:self.managedObjectContext];
                }
                else {
                    people = [People createPeopleEntityWithPFObject:object inManagedObjectContext:self.managedObjectContext];
                }
                
                
                [peoples addObject:people];
            }
            
            
            // load the recents into core data
            
            [self.tableView reloadData];
            
		}
		else [ProgressHUD showError:@"Network error."];
		[self.refreshControl endRefreshing];
    }];
    
    
    
//    [PeopleRemoteUtil sharedUtil] lo
//	PFQuery *query = [PFQuery queryWithClassName:PF_PEOPLE_CLASS_NAME];
//	[query whereKey:PF_PEOPLE_USER1 equalTo:[PFUser currentUser]];
//	[query includeKey:PF_PEOPLE_USER2];
//	[query setLimit:1000];
//	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
//	{
//		if (error == nil)
//		{
//			[users removeAllObjects];
//			[userIds removeAllObjects];
//			for (PFObject *people in objects)
//			{
//				PFUser *user = people[PF_PEOPLE_USER2];
//				[users addObject:user];
//				[userIds addObject:user.objectId];
//			}
//			[self setObjects:users];
//			[self.tableView reloadData];
//		}
//		else [ProgressHUD showError:@"Network error."];
//	}];
}

////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)setObjects:(NSArray *)objects
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	if (sections != nil) [sections removeAllObjects];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	NSInteger sectionTitlesCount = [[[UILocalizedIndexedCollation currentCollation] sectionTitles] count];
//	sections = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	for (NSUInteger i=0; i<sectionTitlesCount; i++)
//	{
//		[sections addObject:[NSMutableArray array]];
//	}
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	NSArray *sorted = [objects sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
//	{
//		PFUser *user1 = (PFUser *)obj1;
//		PFUser *user2 = (PFUser *)obj2;
//		return [user1[PF_USER_FULLNAME] compare:user2[PF_USER_FULLNAME]];
//	}];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	for (PFUser *object in sorted)
//	{
//		NSInteger section = [[UILocalizedIndexedCollation currentCollation] sectionForObject:object collationStringSelector:@selector(fullname)];
//		[sections[section] addObject:object];
//	}
//}

#pragma mark - User actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionCleanup
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
//	[users removeAllObjects];
//	[userIds removeAllObjects];
//	[sections removeAllObjects];
    [People clearPeopleEntityAll:[self managedObjectContext]];
	[self.tableView reloadData];
}


//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionAdd
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
								   otherButtonTitles:@"Search user", @"Select users", @"Address Book", @"Facebook Friends", nil];
	[action showFromTabBar:[[self tabBarController] tabBar]];
}

#pragma mark - UIActionSheetDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (buttonIndex != actionSheet.cancelButtonIndex)
	{
		skipLoading = YES;
		if (buttonIndex == 0)
		{
			SelectSingleView *selectSingleView = [[SelectSingleView alloc] init];
			selectSingleView.delegate = self;
			NavigationController *navController = [[NavigationController alloc] initWithRootViewController:selectSingleView];
			[self presentViewController:navController animated:YES completion:nil];
		}
		if (buttonIndex == 1)
		{
			SelectMultipleView *selectMultipleView = [[SelectMultipleView alloc] init];
			selectMultipleView.delegate = self;
			NavigationController *navController = [[NavigationController alloc] initWithRootViewController:selectMultipleView];
			[self presentViewController:navController animated:YES completion:nil];
		}
		if (buttonIndex == 2)
		{
			AddressBookView *addressBookView = [[AddressBookView alloc] init];
			addressBookView.delegate = self;
			NavigationController *navController = [[NavigationController alloc] initWithRootViewController:addressBookView];
			[self presentViewController:navController animated:YES completion:nil];
		}
		if (buttonIndex == 3)
		{
			FacebookFriendsView *facebookFriendsView = [[FacebookFriendsView alloc] init];
			facebookFriendsView.delegate = self;
			NavigationController *navController = [[NavigationController alloc] initWithRootViewController:facebookFriendsView];
			[self presentViewController:navController animated:YES completion:nil];
		}
	}
}

#pragma mark - SelectSingleDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)didSelectSingleUser:(User *)user
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self addUser:user];
}

#pragma mark - SelectMultipleDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)didSelectMultipleUsers:(NSMutableArray *)users_
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	for (User *user in users_)
	{
		[self addUser:user];
	}
}

#pragma mark - AddressBookDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)didSelectAddressBookUser:(User *)user
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self addUser:user];
}

#pragma mark - FacebookFriendsDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)didSelectFacebookUser:(User *)user
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self addUser:user];
}

#pragma mark - Helper methods

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)addUser:(User *)user
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if ([self.userIds containsObject:user.globalID] == NO)
	{
		//PeopleSave([PFUser currentUser], user);
        
        [[PeopleRemoteUtil sharedUtil] createRemotePeople:user.fullname user:user completionHandler:^(BOOL succeeded, NSError *error, PFObject *object) {
            if (error != nil) {
                [ProgressHUD showError:@"CreateRemotePeople save error."];
            }
            else if (succeeded){
                People * people =
                [People peopleEntityWithRemoteObject:object inManagedObjectContext:self.managedObjectContext];
                
                if (!people) {
                    [ProgressHUD showError:@"CreateRemotePeople does not insert into core data."];
                    ///TODO delete the saved data on server or redo the local save
                    
                }
                else {
                    //[users addObject:user];
                    [self.userIds addObject:user.globalID];
                    //[self setObjects:users];
                    [self.tableView reloadData];
                }
            }
        }];

	}
}

#pragma mark - Table view data source

////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	return [sections count];
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	return [sections[section] count];
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	if ([sections[section] count] != 0)
//	{
//		return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
//	}
//	else return nil;
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

//	NSMutableArray *userstemp =  sections[indexPath.section];
//	PFUser *user = userstemp[indexPath.row];
    
    People * people = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
	cell.textLabel.text = people.name;

	return cell;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return YES;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    People * people = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    User * user = people.contact;
    
    [[PeopleRemoteUtil sharedUtil] deleteRemotePeople:user completionHandler:^(BOOL succeeded, NSError *error, PFObject *object) {
        if (error != nil) {
            [ProgressHUD showError:@"PeopleDelete delete error"];
        }
        else if (succeeded ){
            [People deletePeopleEntityWithRemoteObject:object inManagedObjectContext:self.managedObjectContext];
            
            //---------------------------------------------------------------------------------------------------------------------------------------------
            //[users removeObject:user];
            [self.userIds removeObject:user.globalID];
            //[self setObjects:users];
            //---------------------------------------------------------------------------------------------------------------------------------------------
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }];
    

}

#pragma mark - Table view delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	User *user1 = [CurrentUser  getCurrentUser];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	//NSMutableArray *userstemp = sections[indexPath.section];
	
    People * people = [self.fetchedResultsController objectAtIndexPath:indexPath];
    User *user2 = people.contact;
    //userstemp[indexPath.row];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSString *groupId = StartPrivateChat(user1, user2, self.managedObjectContext);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	ChatView *chatView = [[ChatView alloc] initWith:groupId];
	chatView.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:chatView animated:YES];
}

@end
