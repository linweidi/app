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

#import "DataModelHeader.h"

#import "common.h"
#import "RecentUtil.h"




#import "RecentView.h"
#import "RecentCell.h"
#import "ChatView.h"
#import "SelectSingleView.h"
#import "SelectMultipleView.h"
#import "AddressBookView.h"
#import "FacebookFriendsView.h"
#import "NavigationController.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface RecentView()
{
	//NSMutableArray *recents;
}


@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation RecentView

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	{
		[self.tabBarItem setImage:[UIImage imageNamed:@"tab_recent"]];
		self.tabBarItem.title = @"Recent";
		//-----------------------------------------------------------------------------------------------------------------------------------------
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionCleanup) name:NOTIFICATION_USER_LOGGED_OUT object:nil];
	}
	return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];
	self.title = @"Recent";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self
																						   action:@selector(actionCompose)];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[self.tableView registerNib:[UINib nibWithNibName:@"RecentCell" bundle:nil] forCellReuseIdentifier:@"RecentCell"];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(loadRecents) forControlEvents:UIControlEventValueChanged];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	//recents = [[NSMutableArray alloc] init];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidAppear:animated];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([CurrentUser getCurrentUser] != nil)
	{
		[self loadRecents];
	}
	else LoginUser(self);
}


- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    super.managedObjectContext = managedObjectContext;
    
    if (managedObjectContext) {
        // init fetch request
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recent"];
        request.predicate = nil;
        request.fetchLimit = 50;
        request.sortDescriptors = @[[NSSortDescriptor
                                     sortDescriptorWithKey:@"updateDate"
                                     ascending:NO
                                     selector:@selector(compare:)],
                                    ];
        	
        
        // init fetch result controller
        /// TODO change section name
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
    }
    
}


#pragma mark - Backend methods

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)loadRecents
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
#ifdef PARSE_MODE
    [RecentUtil loadRecentFromParse:self managedObjectContext:[super managedObjectContext]];
#elif DEMO_MODE
    
#endif
    
}

#pragma mark - Helper methods

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)updateTabCounter:(NSArray *)recents
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	int total = 0;
	for (Recent *recent in recents)
	{
		total += [recent.counter intValue];
	}
	UITabBarItem *item = self.tabBarController.tabBar.items[0];
	item.badgeValue = (total == 0) ? nil : [NSString stringWithFormat:@"%d", total];
}

- (void)updateTabCounter
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	int total = 0;
    NSArray *recents = [self.fetchedResultsController fetchedObjects];
	for (Recent *recent in recents)
	{
		total += [recent.counter intValue];
	}
	UITabBarItem *item = self.tabBarController.tabBar.items[0];
	item.badgeValue = (total == 0) ? nil : [NSString stringWithFormat:@"%d", total];
}

- (void)clearTabCounter
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	int total = 0;
	UITabBarItem *item = self.tabBarController.tabBar.items[0];
	item.badgeValue = (total == 0) ? nil : [NSString stringWithFormat:@"%d", total];
}

#pragma mark - User actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionChat:(NSString *)groupId
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	ChatView *chatView = [[ChatView alloc] initWith:groupId];
	chatView.hidesBottomBarWhenPushed = NO;
	[self.navigationController pushViewController:chatView animated:YES];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionCleanup
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	//[recents removeAllObjects];
    // only delete local
    [Recent clearRecentEntityAll:[super managedObjectContext]];
	[self.tableView reloadData];
	[self clearTabCounter];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionCompose
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
			   otherButtonTitles:@"Single recipient", @"Multiple recipients", @"Address Book", @"Facebook Friends", nil];
	[action showFromTabBar:[[self tabBarController] tabBar]];
}

#pragma mark - UIActionSheetDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (buttonIndex != actionSheet.cancelButtonIndex)
	{
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
- (void)didSelectSingleUser:(User *)user2
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	CurrentUser *user1 = [CurrentUser getCurrentUser];
	NSString *groupId = StartPrivateChat(user1, user2);
	[self actionChat:groupId];
}

#pragma mark - SelectMultipleDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)didSelectMultipleUsers:(NSMutableArray *)users
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *groupId = StartMultipleChat(users);
	[self actionChat:groupId];
}

#pragma mark - AddressBookDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)didSelectAddressBookUser:(User *)user2
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	User *user1 = [CurrentUser getCurrentUser];
	NSString *groupId = StartPrivateChat(user1, user2);
	[self actionChat:groupId];
}

#pragma mark - FacebookFriendsDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)didSelectFacebookUser:(User *)user2
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	User *user1 = [CurrentUser getCurrentUser];
	NSString *groupId = StartPrivateChat(user1, user2);
	[self actionChat:groupId];
}

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
	RecentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecentCell" forIndexPath:indexPath];
    
    Recent * recent = [self.fetchedResultsController objectAtIndexPath:indexPath];
	[cell bindData:recent];
    
    
	return cell;
    
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Region Cell"];
//    
//    Region *region = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    cell.textLabel.text = region.name;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d photographers", [[region popularity] intValue]];
//    
//    return cell;
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
    
    
	Recent *recent = [self.fetchedResultsController objectAtIndexPath:indexPath];

	//---------------------------------------------------------------------------------------------------------------------------------------------
    PFObject * recentRmt = [PFObject objectWithClassName:PF_RECENT_CLASS_NAME];
    /// TODO confirm if this is ok
    recentRmt.objectId = recent.globalID;
	[recentRmt deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (error != nil) [ProgressHUD showError:@"Network error."];
        else if (succeeded) {
            
            [self.managedObjectContext deleteObject:recent];
            
            //[recents removeObject:recent];
            [self updateTabCounter];
        }
        else {
            [ProgressHUD showError:@"Network error."];
        }
	}];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Table view delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	//PFObject *recent = recents[indexPath.row];
    Recent *recent = [self.fetchedResultsController objectAtIndexPath:indexPath];
	[self actionChat:recent.chatID];
}

@end
