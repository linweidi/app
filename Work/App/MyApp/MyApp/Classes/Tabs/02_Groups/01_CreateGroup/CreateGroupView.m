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
#import "Group+Util.h"

#import "PeopleRemoteUtil.h"
#import "People+Util.h"
#import "User+Util.h"
#import "CurrentUser+Util.h"

#import "UserManager.h"

#import "CreateGroupView.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface CreateGroupView()
{
	//NSMutableArray *users;
	//NSMutableArray *sections;
	NSMutableArray *selection;
}

@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (strong, nonatomic) IBOutlet UITextField *fieldName;

@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation CreateGroupView

@synthesize viewHeader, fieldName;

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];
	self.title = @"Create Group";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self
																						  action:@selector(actionCancel)];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
																						   action:@selector(actionDone)];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
	[self.tableView addGestureRecognizer:gestureRecognizer];
	gestureRecognizer.cancelsTouchesInView = NO;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.tableView.tableHeaderView = viewHeader;
	self.tableView.tableFooterView = [[UIView alloc] init];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	//users = [[NSMutableArray alloc] init];
	selection = [[NSMutableArray alloc] init];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[self loadPeople];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidAppear:animated];
	[fieldName becomeFirstResponder];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewWillDisappear:animated];
	[self dismissKeyboard];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)dismissKeyboard {
	[self.view endEditing:YES];
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
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

#pragma mark - Backend actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)loadPeople {
    
    //NSMutableArray * peoples = [[NSMutableArray alloc] init];
    
    People * latestPeople = nil;
    
    latestPeople = [People latestEntity:self.managedObjectContext];
    
    [[PeopleRemoteUtil sharedUtil] loadRemotePeoples:latestPeople completionHandler:^(NSArray *objects, NSError *error) {
        if (error == nil){
            
            // load the recents into core data
            
            [self.tableView reloadData];
            
        }
        else {
           [ProgressHUD showError:@"Network error."];
        }
        [self.refreshControl endRefreshing];
    }];
    
    
    
    
//    [[GroupRemoteUtil sharedUtil] loadRemotePeoplesWithCompletionHandler:^(NSArray *objects, NSError *error) {
//        if (error == nil)
//		{
//            
////            [User convertFromRemoteUserArray:objects inManagedObjectContext:self.managedObjectContext];
////            [self.tableView reloadData];
//            
//			[users removeAllObjects];
//			for (PFObject *people in objects)
//			{
//				PFUser *user = people[PF_PEOPLE_USER2];
//                User * userObj = [User convertFromRemoteUser:user inManagedObjectContext:self.managedObjectContext];
//				[users addObject:user];
//			}
//			[self setObjects:users];
//			[self.tableView reloadData];
//		}
//		else [ProgressHUD showError:@"Network error."];
//    }];
}

////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)setObjects:(NSArray *)objects
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    /* legacy use UILocalizedIndexedCollation
//	if (sections != nil) [sections removeAllObjects];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//    // update sections
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
//     */
//}

#pragma mark - User actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionCancel {
	[self dismissViewControllerAnimated:YES completion:nil];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionDone {
	NSString *name = fieldName.text;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([name length] == 0)		{
        [ProgressHUD showError:@"Group name must be set."];
        return;
    }
	if ([selection count] == 0) {
        [ProgressHUD showError:@"Please select some users."];
        return;
    }
	//---------------------------------------------------------------------------------------------------------------------------------------------
	User *user = [[ConfigurationManager sharedManager] getCurrentUser];
    
	[selection addObject: user.globalID];
    
	//---------------------------------------------------------------------------------------------------------------------------------------------
    [[GroupRemoteUtil sharedUtil] createRemoteGroup:name members:selection completionHandler:^(id object, NSError *error) {
        if (error == nil) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            [ProgressHUD showError:@"Network error."];
        }
    }];
}

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------------------------------------------
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

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    People * people= [self.fetchedResultsController objectAtIndexPath:indexPath];
//    User * contact = [[UserManager sharedUtil] getUser:people.userID];
//    if (!contact) {
//        contact = people.contact;
//    }
    User * contact = people.contact;
    
    if ([people.name length]) {
        cell.textLabel.text = people.name;
    }
    else {
        cell.textLabel.text = contact.fullname;
    }
    
	

	BOOL selected = [selection containsObject:contact.globalID];
	cell.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

	return cell;
}

#pragma mark - Table view delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	//---------------------------------------------------------------------------------------------------------------------------------------------
    People * people= [self.fetchedResultsController objectAtIndexPath:indexPath];
    User * contact = people.contact;
    
	BOOL selected = [selection containsObject:contact.globalID];
	if (selected) {
        [selection removeObject:contact.globalID];
    } else {
        [selection addObject:contact.globalID];
    }
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[self.tableView reloadData];
}

@end
