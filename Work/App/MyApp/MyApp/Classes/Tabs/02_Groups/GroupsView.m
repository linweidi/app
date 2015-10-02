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
#import "GroupRemoteUtil.h"
#import "recent.h"


#import "CreateGroupView.h"
#import "GroupSettingsView.h"
#import "NavigationController.h"

#import "GroupRemoteUtil.h"
#import "Group+Util.h"

#import "GroupsView.h"
//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface GroupsView()
{
	//NSMutableArray *groups;
}
@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation GroupsView

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self)
	{
		[self.tabBarItem setImage:[UIImage imageNamed:@"tab_groups"]];
		self.tabBarItem.title = @"Groups";
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
	self.title = @"Groups";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
																						   action:@selector(actionNew)];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(loadGroups) forControlEvents:UIControlEventValueChanged];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	//groups = [[NSMutableArray alloc] init];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidAppear:animated];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([PFUser currentUser] != nil)
	{
		[self loadGroups];
	}
	else LoginUser(self);
}

#pragma mark - Backend actions

//-------------------------------------------------------------------------------------------------------------------------------------------------

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    super.managedObjectContext = managedObjectContext;
    
    if (managedObjectContext) {
        // init fetch request
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Group"];
        request.predicate = nil;
        request.fetchLimit = GROUPVIEW_DISPLAY_ITEM_NUM;
        request.sortDescriptors = @[[NSSortDescriptor
                                     sortDescriptorWithKey:@"updateTime"
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



- (void)loadGroups
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    NSMutableArray * groups = [[NSMutableArray alloc] init];
    
    Group * latestGroup = nil;
    
    latestGroup = [Group latestGroupEntity :self.managedObjectContext];
    
    [[GroupRemoteUtil sharedUtil] loadRemoteGroups: latestGroup  completionHandler:^(NSArray *objects, NSError *error) {
        if (error == nil)
		{
			//[groups removeAllObjects];
			//[groups addObjectsFromArray:objects];
			//[self.tableView reloadData];
            
            Group * group = nil;
            for (RemoteObject * object in objects) {
                //[recents setObject:object forKey:object[PF_RECENT_GROUPID]];
                if (latestGroup) {
                    
                    group = [Group groupEntityWithRemoteObject:object inManagedObjectContext:self.managedObjectContext];
                }
                else {
                    group = [Group createGroupEntityWithPFObject:object inManagedObjectContext:self.managedObjectContext];
                }
                
                
                [groups addObject:group];
            }
            
            
            // load the recents into core data
            
            [self.tableView reloadData];
          
		}
		else [ProgressHUD showError:@"Network error."];
		[self.refreshControl endRefreshing];
    }];
}

#pragma mark - User actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionNew
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	CreateGroupView *createGroupView = [[CreateGroupView alloc] init];
	NavigationController *navController = [[NavigationController alloc] initWithRootViewController:createGroupView];
	[self presentViewController:navController animated:YES completion:nil];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionCleanup
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	//[groups removeAllObjects];
	[self.tableView reloadData];
}

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	return 1;
//}

////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	return [groups count];
//}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

	Group  *group = [self.fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = group.name;

    
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%d members", (int) [group.members count]];
	cell.detailTextLabel.textColor = [UIColor lightGrayColor];

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
	Group *group = [self.fetchedResultsController objectAtIndexPath:indexPath];
	//[groups removeObject:group];
	//---------------------------------------------------------------------------------------------------------------------------------------------
//	User *user1 = [CurrentUser getCurrentUser];
//	User *user2 = group.user;
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	if ([user1 isEqual:user2]) {
//        [[GroupRemoteUtil sharedUtil] removeGroupItem:group];
//    }
//    else {
//        [[GroupRemoteUtil sharedUtil] removeGroupMember:group user:user1];
//    }
    User * user = [CurrentUser getCurrentUser];
    [[GroupRemoteUtil sharedUtil] removeGroupMember:group user:user];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	//[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
#warning notify others that you have quit the group
}

#pragma mark - Table view delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	//---------------------------------------------------------------------------------------------------------------------------------------------
    Group * group = [self.fetchedResultsController objectAtIndexPath:indexPath];
	GroupSettingsView *groupSettingsView = [[GroupSettingsView alloc] initWith:group];
	groupSettingsView.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:groupSettingsView animated:YES];
}

@end
