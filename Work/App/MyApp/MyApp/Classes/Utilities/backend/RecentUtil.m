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
#import "PFUser+Util.h"
#import "ProgressHUD.h"

#import "DataModelHeader.h"


#import "RecentView.h"
#import "RecentUtil.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
NSString* StartPrivateChat(User *user1, User *user2)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{

	NSString *id1 = user1.globalID;
	NSString *id2 = user2.globalID;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSString *groupId = ([id1 compare:id2] < 0) ? [NSString stringWithFormat:@"%@%@", id1, id2] : [NSString stringWithFormat:@"%@%@", id2, id1];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSArray *members = @[user1.globalID, user2.globalID];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	CreateRecentItem(user1, groupId, members, user2.fullname);
	CreateRecentItem(user2, groupId, members, user1.fullname);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return groupId;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
NSString* StartMultipleChat(NSMutableArray *users)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSString *groupId = @"";
	NSString *description = @"";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[users addObject:[CurrentUser getCurrentUser]];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSMutableArray *userIds = [[NSMutableArray alloc] init];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	for (User *user in users)
	{
		[userIds addObject: user.globalID];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSArray *sorted = [userIds sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	
    // Create group id
    for (NSString *userId in sorted)
	{
		groupId = [groupId stringByAppendingString:userId];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	for (User *user in users)
	{
		if ([description length] != 0) description = [description stringByAppendingString:@" & "];
		description = [description stringByAppendingString:user.fullname];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	for (User *user in users)
	{
		CreateRecentItem(user, groupId, userIds, description);
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return groupId;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void CreateRecentItem(User *user, NSString *groupId, NSArray *members, NSString *description)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    //create the remote query
    // HERE, checking the existence of recent on server is required. because the other users may have already deleted the item.
	PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
	[query whereKey:PF_RECENT_USER equalTo:[user convertToPFUser]];
	[query whereKey:PF_RECENT_GROUPID equalTo:groupId];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	{
		if (error == nil)
		{
			if ([objects count] == 0)
			{
                // create a new chat
				PFObject *recent = [PFObject objectWithClassName:PF_RECENT_CLASS_NAME];
				recent[PF_RECENT_USER] = [user convertToPFUser];
				recent[PF_RECENT_GROUPID] = groupId;
				recent[PF_RECENT_MEMBERS] = members;
				recent[PF_RECENT_DESCRIPTION] = description;
				recent[PF_RECENT_LASTUSER] = [PFUser currentUser];
				recent[PF_RECENT_LASTMESSAGE] = @"";
				recent[PF_RECENT_COUNTER] = @0;
				recent[PF_RECENT_UPDATEDACTION] = [NSDate date];
				[recent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
				{
					if (error != nil) NSLog(@"CreateRecentItem save error.");
                    else if (succeeded){
                        if ([user isEqual: [CurrentUser getCurrentUser]]) {
                            Recent * obj = [Recent recentEntityWithPFObject:recent inManagedObjectContext:[RecentUtil sharedUtil].context];
                            
                            if (!obj) {
                                NSLog(@"CreateRecentItem does not insert into core data.");
                                [ProgressHUD showError:@"CreateRecentItem does not insert into core data."];
                                ///TODO delete the saved data on server or redo the local save
                            
                            }
                        }
                    }
				}];
                
                
                
 
			}
		}
		else {
            NSLog(@"CreateRecentItem query error.");
            [ProgressHUD showError:@"Network error."];
        }
        
	}];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
// Update all users' recent and counter
void UpdateRecentAndCounter(NSString *groupId, NSInteger amount, NSString *lastMessage)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
	[query whereKey:PF_RECENT_GROUPID equalTo:groupId];
	[query includeKey:PF_RECENT_USER];
	//[query setLimit:1000];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	{
		if (error == nil)
		{
			for (PFObject *recent in objects)
			{
				if ([recent[PF_RECENT_USER] isEqualTo:[PFUser currentUser]] == NO) {
                    // update the counter of others only
                    [recent incrementKey:PF_RECENT_COUNTER byAmount:[NSNumber numberWithInteger:amount]];
                }
					
				//---------------------------------------------------------------------------------------------------------------------------------
				recent[PF_RECENT_LASTUSER] = [PFUser currentUser];
				recent[PF_RECENT_LASTMESSAGE] = lastMessage;
				recent[PF_RECENT_UPDATEDACTION] = [NSDate date];
				[recent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
				{
					if (error != nil) NSLog(@"UpdateRecentCounter save error.");
                    else if(succeeded){
                        /// TODO only update
                        Recent * obj = [Recent recentEntityWithPFObject:recent inManagedObjectContext:[[RecentUtil sharedUtil] context]];
                        
                        if (!obj) {
                            NSLog(@"CreateRecentItem does not insert into core data.");
                        }
                    }

				}];
			}
            ///TODO if not existed, we need create one recent item for that user
            //use sorted user and update the user group each update, eventually the rest of user group is the ones to be created
		}
		else NSLog(@"UpdateRecentCounter query error.");
	}];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
// clear only my recent counter
void ClearRecentCounter(NSString *groupId)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
	[query whereKey:PF_RECENT_GROUPID equalTo:groupId];
	[query whereKey:PF_RECENT_USER equalTo:[PFUser currentUser]];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	{
		if (error == nil)
		{
			for (PFObject *recent in objects)
			{
				recent[PF_RECENT_COUNTER] = @0;
				[recent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
				{
					if (error != nil) NSLog(@"ClearRecentCounter save error.");
                    else if(succeeded){
                        /// TODO only update
                        Recent * obj = [Recent recentEntityWithPFObject:recent inManagedObjectContext:[[RecentUtil sharedUtil] context]];
                        
                        if (!obj) {
                            NSLog(@"CreateRecentItem does not insert into core data.");
                        }
                    }
				}];
			}
		}
		else NSLog(@"ClearRecentCounter query error.");
	}];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void DeleteRecentItems(User *user1, User *user2)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
	[query whereKey:PF_RECENT_USER equalTo: [User convertFromUser:user1] ];
    ///TODO maybe wrong here
	[query whereKey:PF_RECENT_MEMBERS equalTo:user2.globalID];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	{
		if (error == nil)
		{
			for (PFObject *recent in objects)
			{
				[recent deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
				{
					if (error != nil) NSLog(@"DeleteMessageItem delete error.");
                    else if(succeeded){
                        /// TODO only update
                        BOOL deleted = [Recent deleteRecentEntityWithPFObject:recent inManagedObjectContext:[[RecentUtil sharedUtil] context]];
                        
                        if (!deleted) {
                            NSLog(@"CreateRecentItem does not delete into core data.");
                            /// TODO REDO
                        }
                    }
				}];
			}
		}
		else NSLog(@"DeleteMessages query error.");
	}];
}

@implementation RecentUtil

+ (RecentUtil *)sharedUtil {
    static dispatch_once_t predicate = 0;
    static RecentUtil *sharedObject;
    
    dispatch_once(&predicate, ^{
        //initializing singleton object
        sharedObject = [[self alloc] init];
        
    });
    return sharedObject;
}

+ (void) loadRecentFromParse:(RecentView *)recentView managedObjectContext:(NSManagedObjectContext *)context{
    NSMutableArray * recents = [[NSMutableArray alloc] init];
    //NSMutableDictionary * recents = [[NSMutableDictionary alloc] init];
    
    NSDate * latestUpdateDate = nil;
    Recent * latestRecent = nil;
    
    latestRecent = [Recent latestRecentEntity:context];
    
    
    
    // load from parse
    PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
    [query whereKey:PF_RECENT_USER equalTo:[PFUser currentUser]];
    [query includeKey:PF_RECENT_LASTUSER];
    [query orderByDescending:PF_RECENT_UPDATEDACTION];
    
    if (latestRecent) {
        //found any recent itme
        latestUpdateDate = latestRecent.updateDate;
        [query whereKey:PF_RECENT_UPDATEDACTION greaterThan:latestUpdateDate];
    }
    else {
        // a new load

    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error == nil)
         {
             //[recents removeAllObjects];
             //[recents addObjectsFromArray:objects];
             Recent * recent = nil;
             for (PFObject * object in objects) {
                 //[recents setObject:object forKey:object[PF_RECENT_GROUPID]];
                 if (latestRecent) {
                     
                     recent = [Recent recentEntityWithPFObject:object inManagedObjectContext:[[RecentUtil sharedUtil] context]];
                 }
                 else {
                     recent = [Recent createRecentEntityWithPFObject:object inManagedObjectContext:[[RecentUtil sharedUtil] context]];
                 }


                 [recents addObject:recent];
             }
             
             
             // load the recents into core data
             
             [recentView.tableView reloadData];
             [recentView updateTabCounter];
         }
         else {
             [ProgressHUD showError:@"Network error."];
         }
         [recentView.refreshControl endRefreshing];
     }];
}



@end
