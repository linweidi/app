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
#import "AppHeader.h"
#import "ProgressHUD.h"

#import "AppConstant.h"

#import "User+Util.h"
#import "CurrentUser+Util.h"

#import "People+Util.h"
#import "PeopleRemoteUtil.h"

#import "UserManager.h"

#import "SelectPeopleView.h"

@interface SelectPeopleView()


@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SelectPeopleView

//@synthesize delegate;
@synthesize viewHeader, searchBar;

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"Select Single";
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self
																						  action:@selector(actionCancel)];
	self.tableView.tableHeaderView = viewHeader;
	//users = [[NSMutableArray alloc] init];
	selection = [[NSMutableArray alloc] init];
    
	[self loadUsers];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.view endEditing:YES];
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    super.managedObjectContext = managedObjectContext;
    
    if (managedObjectContext) {
        // init fetch request
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"People"];
        //request.predicate = [NSPredicate predicateWithFormat:@"string"];
        request.fetchLimit = USERVIEW_DISPLAY_ITEM_NUM;
        request.sortDescriptors = @[[NSSortDescriptor
                                     sortDescriptorWithKey:@"name"
                                     ascending:YES
                                     selector:@selector(localizedCompare:)],
                                    ];
        
        
        // init fetch result controller
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"name" cacheName:nil];
    }
    
}

#pragma mark - Backend methods


- (void)loadUsers {
    
    People * latestPeople = nil;
    
    latestPeople = [People latestEntity:self.managedObjectContext];
    
    [[PeopleRemoteUtil sharedUtil] loadRemotePeoples: latestPeople completionHandler:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            //[peoples removeAllObjects];
            //[peoples addObjectsFromArray:objects];
            //[self.tableView reloadData];
            
            // load the recents into core data
            
            [self.tableView reloadData];
            
        }
        else [ProgressHUD showError:@"Network error."];
        [self.refreshControl endRefreshing];
    }];
//    
//    
//	PFUser *user = [PFUser currentUser];
//
//	PFQuery *query1 = [PFQuery queryWithClassName:PF_BLOCKED_CLASS_NAME];
//	[query1 whereKey:PF_BLOCKED_USER1 equalTo:user];
//
//	PFQuery *query2 = [PFQuery queryWithClassName:PF_USER_CLASS_NAME];
//	[query2 whereKey:PF_USER_OBJECTID notEqualTo:user.objectId];
//	[query2 whereKey:PF_USER_OBJECTID doesNotMatchKey:PF_BLOCKED_USERID2 inQuery:query1];
//	[query2 orderByAscending:PF_USER_FULLNAME];
//	[query2 setLimit:1000];
//	[query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
//	{
//		if (error == nil)
//		{
//			[users removeAllObjects];
//			[users addObjectsFromArray:objects];
//			[self.tableView reloadData];
//		}
//		else [ProgressHUD showError:@"Network error."];
//	}];
}

- (void)searchUsers:(NSString *)search_lower
{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"People"];
    //request.predicate = [NSPredicate predicateWithFormat:@"string"];
    request.fetchLimit = USERVIEW_DISPLAY_ITEM_NUM;
    request.sortDescriptors = @[[NSSortDescriptor
                                 sortDescriptorWithKey:@"name"
                                 ascending:YES
                                 selector:@selector(localizedCompare:)],
                                ];
    
    request.predicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", search_lower];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"name" cacheName:nil];
    
    [self performFetch];

}

#pragma mark - User actions

- (void)actionCancel
{
	[self dismissViewControllerAnimated:YES completion:nil];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	People * people= [self.fetchedResultsController objectAtIndexPath:indexPath];
    User * contact = people.contact;
    
	BOOL selected = [selection containsObject:contact.globalID];
	if (selected) {
        [selection removeObject:contact.globalID];
    } else {
        [selection addObject:contact.globalID];
    }
	[self.tableView reloadData];
    
    //select one user and dismiss
//	[self dismissViewControllerAnimated:YES completion:^{
//		if (delegate != nil) {
//            [delegate didSelectPeople:contact];
//        }
//	}];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	if ([searchText length] > 0)
	{
		[self searchUsers:[searchText lowercaseString]];
	}
	else [self loadUsers];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar_
{
	[searchBar_ setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar_
{
	[searchBar_ setShowsCancelButton:NO animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar_
{
	[self searchBarCancelled];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar_
{
	[searchBar_ resignFirstResponder];
}

- (void)searchBarCancelled
{
	searchBar.text = @"";
	[searchBar resignFirstResponder];

	[self loadUsers];
}

@end
