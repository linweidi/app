//
//  Recent+Update.m
//  MyApp
//
//  Created by Linwei Ding on 9/22/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//
#import "AppConstant.h"

#import "Recent+Update.h"

@implementation Recent (Update)

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)recentWithPFObject: (PFObject *)object
    inManagedObjectContext: (NSManagedObjectContext *)context {
    Recent * recent = nil;
    
    NSAssert(object, @"input is nil");
    
    if (object) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recent"] ;
        request.predicate = [NSPredicate predicateWithFormat:@"groupId = %@", object[PF_RECENT_GROUPID]];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error   ];
        
        if (!matches || ([matches count]>1)) {
            NSAssert(NO, @"match count is not unique");
        }
        else if (![matches count]) {
            //create a new one
            recent = [NSEntityDescription insertNewObjectForEntityForName:@"Recent" inManagedObjectContext:context];
             //set the recent values
            [Recent setRecent:recent withPFObject:object];
        }
        else {
            recent = [matches lastObject];
        }
             
            
    }
             
             
    /*
	PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
	[query whereKey:PF_RECENT_USER equalTo:[PFUser currentUser]];
	[query includeKey:PF_RECENT_LASTUSER];
	[query orderByDescending:PF_RECENT_UPDATEDACTION];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error == nil)
         {
             [recents removeAllObjects];
             [recents addObjectsFromArray:objects];
             [self.tableView reloadData];
             [self updateTabCounter];
         }
         else [ProgressHUD showError:@"Network error."];
         [self.refreshControl endRefreshing];
     }];
    
    PFQuery *query = [PFQuery queryWithClassName:PF_RECENT_CLASS_NAME];
	[query whereKey:PF_RECENT_USER equalTo:user];
	[query whereKey:PF_RECENT_GROUPID equalTo:groupId];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error == nil)
         {
             if ([objects count] == 0)
             {
                 PFObject *recent = [PFObject objectWithClassName:PF_RECENT_CLASS_NAME];
                 recent[PF_RECENT_USER] = user;
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
                  }];
             }
         }
         else NSLog(@"CreateRecentItem query error.");
     }];
     */
}
             
+ (void) setRecent:(Recent *)recent withPFObject:(PFObject *)object {
    //recent.user = recent[PF_RECENT_USER];
    recent.chatId =  recent[PF_RECENT_GROUPID];
    recent.chatId = recent[PF_RECENT_MEMBERS] ;
    recent.chatId = recent[PF_RECENT_DESCRIPTION] ;
    //recent.chatId = recent[PF_RECENT_LASTUSER] ;
    recent.chatId = recent[PF_RECENT_LASTMESSAGE] ;
    recent.chatId = recent[PF_RECENT_COUNTER] ;
    recent.chatId = recent[PF_RECENT_UPDATEDACTION];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)bindData:(PFObject *)recent_
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	recent = recent_;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	imageUser.layer.cornerRadius = imageUser.frame.size.width/2;
	imageUser.layer.masksToBounds = YES;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	PFUser *lastUser = recent[PF_RECENT_LASTUSER];
	[imageUser setFile:lastUser[PF_USER_PICTURE]];
	[imageUser loadInBackground];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	labelDescription.text = recent[PF_RECENT_DESCRIPTION];
	labelLastMessage.text = recent[PF_RECENT_LASTMESSAGE];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:recent[PF_RECENT_UPDATEDACTION]];
	labelElapsed.text = TimeElapsed(seconds);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	int counter = [recent[PF_RECENT_COUNTER] intValue];
	labelCounter.text = (counter == 0) ? @"" : [NSString stringWithFormat:@"%d new", counter];
}

- (void)bindDataDemo:(PFObject *)recent_ {
    
}
@end
