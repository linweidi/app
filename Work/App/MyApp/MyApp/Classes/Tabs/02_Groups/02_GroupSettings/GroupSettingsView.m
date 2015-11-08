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
#import "recent.h"


#import "ChatView.h"

#import "User+Util.h"
#import "CurrentUser+Util.h"

#import "Group+Util.h"
#import "GroupRemoteUtil.h"

#import "RecentRemoteUtil.h"
#import "UserRemoteUtil.h"

#import "GroupSettingsView.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface GroupSettingsView()
{

	//NSMutableArray *users;
}

@property (weak, nonatomic) Group * group;

@property (strong, nonatomic) NSMutableArray * userIDs;

@property (strong, nonatomic) IBOutlet UITableViewCell *cellName;

@property (strong, nonatomic) IBOutlet UILabel *labelName;

@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation GroupSettingsView

@synthesize cellName;
@synthesize labelName;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWith:(Group *)group_
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super init];
	self.group = group_;
	return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];
	self.title = @"Group Settings";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.userIDs = [[NSMutableArray alloc] init];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[self loadGroup];
	[self loadUsers];
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    super.managedObjectContext = managedObjectContext;
    
    if (managedObjectContext) {
        // init fetch request
        NSAssert(self.group!= nil, @"group is nil")  ;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        request.predicate = [NSPredicate predicateWithFormat:@"globalID IN %@", self.group.members];
        request.fetchLimit = GROUPVIEW_USER_ITEM_NUM;

        request.sortDescriptors = @[[NSSortDescriptor
                                     sortDescriptorWithKey:@"name"
                                     ascending:YES
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

#pragma mark - Backend actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)loadGroup
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
	labelName.text = self.group.name;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)loadUsers
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [[GroupRemoteUtil sharedUtil] loadRemoteUsersByGroup:self.group completionHandler:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            //			[users removeAllObjects];
            //			[users addObjectsFromArray:objects];
            [self.userIDs removeAllObjects];
            for (User * user in objects) {
                [self.userIDs addObject:user.globalID];
            }
			[self.tableView reloadData];
		}
        else {
            [ProgressHUD showError:@"Network error."];
        }
    }];
}

#pragma mark - User actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionChat {
	NSString *groupId = self.group.globalID;
	//---------------------------------------------------------------------------------------------------------------------------------------------
    [[RecentRemoteUtil sharedUtil] createRemoteRecentItem:[[ConfigurationManager sharedManager] getCurrentUser] groupId:groupId members:self.group.members desciption:self.group.name lastMessage:nil];
    
	//---------------------------------------------------------------------------------------------------------------------------------------------
	ChatView *chatView = [[ChatView alloc] initWith:groupId];
    
#warning move this new view controller to recent tab
	[self.navigationController pushViewController:chatView animated:YES];
}

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return 2;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (section == 0) return 1;
	if (section == 1) return [super tableView:tableView numberOfRowsInSection:section];
	return 0;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (section == 1) return @"Members";
	return nil;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if ((indexPath.section == 0) && (indexPath.row == 0)) return cellName;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (indexPath.section == 1)
	{
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
		if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        
        
        NSIndexPath * newIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
		User *user = [self.fetchedResultsController objectAtIndexPath:newIndexPath];
        
		cell.textLabel.text = user.fullname;

		return cell;
	}
	return nil;
}

#pragma mark - Table view delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ((indexPath.section == 0) && (indexPath.row == 0)) [self actionChat];
    
#warning add new user chat to start
}

@end
