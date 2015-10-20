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
#import "Recent+Util.h"

@class User;
//-------------------------------------------------------------------------------------------------------------------------------------------------
NSString*		StartPrivateChat		(User *user1, User *user2, NSManagedObjectContext * context);
NSString*		StartMultipleChat		(NSMutableArray *users, NSManagedObjectContext * context);

//-------------------------------------------------------------------------------------------------------------------------------------------------
void			CreateRecentItem		(User *user, NSString *groupId, NSArray *members, NSString *description, NSManagedObjectContext * context);

//-------------------------------------------------------------------------------------------------------------------------------------------------
void            UpdateRecentAndCounter  (NSString *groupId, NSInteger amount, NSString *lastMessage, NSManagedObjectContext * context);
void			ClearRecentCounter		(NSString *groupId, NSManagedObjectContext * context);

//-------------------------------------------------------------------------------------------------------------------------------------------------
void			DeleteRecentItems		(User *user1, User *user2, NSManagedObjectContext * context);

@class RecentView;
@interface RecentRemoteUtil : NSObject



+ (RecentRemoteUtil *)sharedUtil;

- (void) deleteRecentFromParse:(Recent *)recent completionHandler:(REMOTE_BOOL_BLOCK)block;

- (void) loadRecentFromParse:(Recent *) latestRecent completionHandler:(REMOTE_ARRAY_BLOCK)block  ;


- (void) loadRemoteRecent:(Recent *) latestRecent completionHandler:(REMOTE_ARRAY_BLOCK)block;
@end