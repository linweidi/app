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

#import "AppHeader.h"
#import "common.h"

#import "UserRemoteUtil.h"
#import "User+Util.h"
#import "Picture+Util.h"
#import "Thumbnail+Util.h"

#import "UserLocalDataUtil.h"
#import "ConfigurationManager.h"


#import "NavigationController.h"
#import "ProfileView.h"

@interface ProfileView()
{
	NSString *userId;
}

@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (strong, nonatomic) IBOutlet UIImageView *imageUser;
@property (strong, nonatomic) IBOutlet UILabel *labelName;

@property (strong, nonatomic) IBOutlet UITableViewCell *cellReport;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellBlock;

@end


@implementation ProfileView

@synthesize viewHeader, imageUser, labelName;
@synthesize cellReport, cellBlock;


- (id)initWith:(NSString *)userId_

{
	self = [super init];
	userId = userId_;
	return self;
}


- (void)viewDidLoad

{
	[super viewDidLoad];
	self.title = @"Profile";
	
	self.tableView.tableHeaderView = viewHeader;
	
	imageUser.layer.cornerRadius = imageUser.frame.size.width/2;
	imageUser.layer.masksToBounds = YES;
}


- (void)viewDidAppear:(BOOL)animated

{
	[super viewDidAppear:animated];
	
	[self loadUser];
}

#pragma mark - Backend actions


- (void)loadUser

{
#ifdef REMOTE_MODE
    [[UserRemoteUtil sharedUtil] loadRemoteUser:userId completionHandler:^(NSArray *objects, NSError *error) {
        if (error == nil)
		{
			RemoteUser * userRemote = [objects firstObject];
            User * user = [[UserRemoteUtil sharedUtil] convertToUser:userRemote];
			if (user != nil)
			{
//                PFFile * filePicture = [PFFile fileWithName:user.thumb.fileName contentsAtPath:user.picture.url];
//				[imageUser setFile:filePicture];
//				[imageUser loadInBackground];

				[imageUser setImage:[UIImage imageWithData:user.thumbnail.data]];
				labelName.text = user.fullname;
			}
		}
		else [ProgressHUD showError:@"Network error."];
    }];
#endif
#ifdef LOCAL_MODE
    User * user = [User entityWithID:userId inManagedObjectContext:[ConfigurationManager sharedManager].managedObjectContext];
    if (user != nil)
    {
//        PFFile * filePicture = [PFFile fileWithName:user.picture.fileName contentsAtPath:user.picture.url];
//        [imageUser setFile:filePicture];
//        [imageUser loadInBackground];
        
        [imageUser setImage:[UIImage imageNamed:user.thumbnail.url]];
        
        labelName.text = user.fullname;
    }
    else {
        [ProgressHUD showError:@"User does not exist."];
    }
#endif
}

#pragma mark - User actions


- (void)actionReport

{
	UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel"
										  destructiveButtonTitle:nil otherButtonTitles:@"Report user", nil];
	action.tag = 1;
	[action showInView:self.view];
}


- (void)actionBlock

{
	UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel"
										  destructiveButtonTitle:@"Block user" otherButtonTitles:nil];
	action.tag = 2;
	[action showInView:self.view];
}

#pragma mark - UIActionSheetDelegate


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
	if (actionSheet.tag == 1) [self actionSheet:actionSheet clickedButtonAtIndex1:buttonIndex];
	if (actionSheet.tag == 2) [self actionSheet:actionSheet clickedButtonAtIndex2:buttonIndex];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex1:(NSInteger)buttonIndex

{
	if (buttonIndex != actionSheet.cancelButtonIndex)
	{
		if ([[UserManager sharedUtil ] exists:userId])
		{
			ActionPremium(self);
		}
	}
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex2:(NSInteger)buttonIndex

{
	if (buttonIndex != actionSheet.cancelButtonIndex)
	{
		if ([[UserManager sharedUtil ] exists:userId])
		{
			ActionPremium(self);
		}
	}
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
	return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
	if ((indexPath.section == 0) && (indexPath.row == 0)) return cellReport;
	if ((indexPath.section == 0) && (indexPath.row == 1)) return cellBlock;
	return nil;
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if ((indexPath.section == 0) && (indexPath.row == 0)) [self actionReport];
	if ((indexPath.section == 0) && (indexPath.row == 1)) [self actionBlock];
}

@end
