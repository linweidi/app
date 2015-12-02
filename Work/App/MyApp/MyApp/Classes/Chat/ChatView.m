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

#import <MediaPlayer/MediaPlayer.h>

#import <Parse/Parse.h>
#import "ProgressHUD.h"
#import "IDMPhotoBrowser.h"
#import "RNGridMenu.h"

#import "AppHeader.h"
#import "AppConstant.h"
#import "camera.h"
#import "common.h"
#import "image.h"
#import "push.h"
#import "recent.h"
#import "video.h"

#import "Video+Util.h"
#import "Picture+Util.h"

#import "PhotoMediaItem.h"
#import "VideoMediaItem.h"


#import "Message+Util.h"
#import "User+Util.h"
#import "CurrentUser+Util.h"
#import "Thumbnail+Util.h"
#import "AppHeader.h"
#import "ProfileView.h"

#ifdef REMOTE_MODE
#import "UserRemoteUtil.h"
#import "RecentRemoteUtil.h"
#import "MessageRemoteUtil.h"
#endif
#ifdef LOCAL_MODE
#import "UserLocalDataUtil.h"
#import "RecentLocalDataUtil.h"
#import "MessageLocalDataUtil.h"
#endif
#import "ChatView.h"
//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface ChatView()
{
	NSTimer *timer;
	BOOL isLoading;
	BOOL initialized;

	NSString *groupId;

	//NSMutableArray *users;
	NSMutableArray *messages;
	NSMutableDictionary *avatars;

	JSQMessagesBubbleImage *bubbleImageOutgoing;
	JSQMessagesBubbleImage *bubbleImageIncoming;
	JSQMessagesAvatarImage *avatarImageBlank;
}
@end
//-------------------------------------------------------------------------------------------------------------------------------------------------

@implementation ChatView

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWith:(NSString *)groupId_
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super init];
	groupId = groupId_;
	return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidLoad];
    self.title = @"Chat";

    //users = [[NSMutableArray alloc] init];
    messages = [[NSMutableArray alloc] init];
    avatars = [[NSMutableDictionary alloc] init];

    
    User  * user = [[ConfigurationManager sharedManager] getCurrentUser];
    self.senderId = user.globalID;
    self.senderDisplayName = user.fullname;

    JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    bubbleImageOutgoing = [bubbleFactory outgoingMessagesBubbleImageWithColor:COLOR_OUTGOING];
    bubbleImageIncoming = [bubbleFactory incomingMessagesBubbleImageWithColor:COLOR_INCOMING];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    avatarImageBlank = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"chat_blank"] diameter:30.0];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    isLoading = NO;
    initialized = NO;
    [self loadMessages];
    
//	[super viewDidLoad];
//	self.title = @"Chat";
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	//users = [[NSMutableArray alloc] init];
//	//messages = [[NSMutableArray alloc] init];
//	avatars = [[NSMutableDictionary alloc] init];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	PFUser *user = [PFUser currentUser];
//	self.senderId = user.objectId;
//	self.senderDisplayName = user[PF_USER_FULLNAME];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
//	bubbleImageOutgoing = [bubbleFactory outgoingMessagesBubbleImageWithColor:COLOR_OUTGOING];
//	bubbleImageIncoming = [bubbleFactory incomingMessagesBubbleImageWithColor:COLOR_INCOMING];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	avatarImageBlank = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"chat_blank"] diameter:30.0];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	isLoading = NO;
//	initialized = NO;
//	[self loadMessages];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	self.collectionView.collectionViewLayout.springinessEnabled = YES;
	timer = [NSTimer scheduledTimerWithTimeInterval:MESSAGEVIEW_REFRESH_TIME target:self selector:@selector(loadMessages) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
#ifdef REMOTE_MODE
    [[RecentRemoteUtil sharedUtil] clearRemoteRecentCounter:groupId];
#endif
#ifdef LOCAL_MODE
    [[RecentLocalDataUtil sharedUtil] clearLocalRecentCounter:groupId];
#endif
	//ClearRecentCounter(groupId, self.managedObjectContext);
	[timer invalidate];
}



#pragma mark - Backend methods

- (void)loadMessages {
	if (isLoading == NO)
	{
		isLoading = YES;
        
        
        //INITIALIZATION, load all local data
        NSArray * messageDataArray;
        //initialization
        messageDataArray = [Message messageEntities:groupId inManagedObjectContext:self.managedObjectContext];
        
        for (Message * object in messageDataArray) {
            JSQMessage * jsqMessage = [self addMessage:object];
            //[messages addObject:jsqMessage];
            NSParameterAssert(jsqMessage);
        }
        
        // Load new messages
        
#ifdef REMOTE_MODE
        
        //lastMessageJSQ may be nil;
        
        JSQMessage *lastMessageJSQ = [messages lastObject];
        
        
        [[MessageRemoteUtil sharedUtil] loadRemoteMessages:groupId lastMessage:lastMessageJSQ completionHandler:^(NSArray *objects, NSError *error) {
            
            if (error == nil) {
				BOOL incoming = NO;
				self.automaticallyScrollsToMostRecentMessage = NO;
                
                
                
                
				for (Message *object in [objects reverseObjectEnumerator]) {
                    /// TODO remove this code here
                    // check if there is message later than lastest message
//                    BOOL check = [Message existsMessageEntity:groupId createdTime:lastMessageJSQ.date inManagedObjectContext:self.managedObjectContext];
//                    NSAssert(!check, @"new message already exists in core data");
					JSQMessage *message = [self addMessage:object];
                    if ([self incoming:message]) {
                        incoming = YES;
                    }
				}
				if ([objects count] != 0) {
					if (initialized && incoming) {
                        [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
                    }

					[self finishReceivingMessage];
					[self scrollToBottomAnimated:NO];
				}
				self.automaticallyScrollsToMostRecentMessage = YES;
				initialized = YES;
			}
			else {
                [ProgressHUD showError:@"Network error."];
            }
			isLoading = NO;
        }];
#endif
#ifdef LOCAL_MODE
        //[self finishReceivingMessage];
        //[self scrollToBottomAnimated:NO];
        //self.automaticallyScrollsToMostRecentMessage = YES;
        initialized = YES;
        isLoading = NO;
#endif
        
	}
}


- (JSQMessage *)addMessage:(Message *)object {
	JSQMessage *message;
	
    // core data only read user data once, so that is ok
	User *user = object.createUser;
	NSString *name = user.fullname;
	//	RemoteFile *fileVideo =[RemoteFile fileWithName:object.videoName url:object.videoURL];
//    
//    RemoteFile *filePicture = [RemoteFile fileWithName:object.pictureName url:object.pictureURL];
    
	if ((object.picture == nil) && (object.video == nil))
	{
		message = [[JSQMessage alloc] initWithSenderId:user.globalID senderDisplayName:name date:object.createTime text:object.text];
	}
	
    if (object.video != nil)
	{
		JSQVideoMediaItem *mediaItem = [[JSQVideoMediaItem alloc] initWithFileURL:[NSURL URLWithString:object.video.name] isReadyToPlay:YES];
		mediaItem.appliesMediaViewMaskAsOutgoing = [user.globalID isEqualToString:self.senderId];
		message = [[JSQMessage alloc] initWithSenderId:user.globalID senderDisplayName:name date:object.createTime media:mediaItem];
	}
	if (object.picture  != nil)
	{
		JSQPhotoMediaItem *mediaItem = [[JSQPhotoMediaItem alloc] initWithImage:[UIImage imageWithData:object.picture.data]];
		mediaItem.appliesMediaViewMaskAsOutgoing = [user.globalID isEqualToString:self.senderId];
		message = [[JSQMessage alloc] initWithSenderId:user.globalID senderDisplayName:name date:object.createTime media:mediaItem];

//		[filePicture getDataAsync:^(NSData *imageData, NSError *error)
//		{
//			if (error == nil)
//			{
//				mediaItem.image = [UIImage imageWithData:imageData];
//				[self.collectionView reloadData];
//			}
//		}];
	}
    
    
	/*
#warning users hold the object from core data, in future move this into UserManager
    /// TODO
	[users addObject:user];
 */
	[messages addObject:message];
	
    return message;
}

- (void)loadAvatar:(User *)user {
#warning Maybe I can use thumbnail here
    /*
    ///legacy: this is the code for loading picture
	RemoteFile *file = [RemoteFile fileWithName:user.pictureName url:user.pictureURL];
	[file getDataAsync:^(NSData *imageData, NSError *error)
	{
		if (error == nil)
		{
			avatars[user.globalID] = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageWithData:imageData] diameter:30.0];
			[self.collectionView reloadData];
		}
	}];
     */
    
    NSString * userID = user.globalID;
    
    UserContext * context = [[UserManager sharedUtil] getContext:userID];
    
    NSAssert(context, @"conext is nil");
    if (context) {
        NSData * imageData = context.thumb.data;
        avatars[user.globalID] = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageWithData:imageData] diameter:30.0];
        [self.collectionView reloadData];
    }

}

- (void)sendMessage:(NSString *)text Video:(NSURL *)videoURL Picture:(UIImage *)pictureData {
//	RemoteFile *fileVideo = nil;
//	RemoteFile *filePicture = nil;
    
    Video * video = nil;
    Picture * picture = nil;
	//	if (videoURL != nil)
//	{
//		text = @"[Video message]";
//		fileVideo = [RemoteFile fileWithName:@"video.mp4" data:[[NSFileManager defaultManager] contentsAtPath:videoURL.path]];
//		[fileVideo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//            if (error != nil) {
//               [ProgressHUD showError:@"Network error."];
//            }
//        }];
//	}
//	if (pictureData != nil)
//	{
//		text = @"[Picture message]";
//		filePicture = [RemoteFile fileWithName:@"picture.jpg" data:UIImageJPEGRepresentation(picture, 0.6)];
//		[filePicture saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//            if (error != nil) {
//                [ProgressHUD showError:@"Picture save error."];
//            }
//        }];
//	}
    
    if (videoURL != nil) {
        text = @"[Video message]";
        video = [Video createEntity:nil];
        video.name = @"video.mp4";
        video.dataVolatile = [[NSFileManager defaultManager] contentsAtPath:videoURL.path];
    }
    
    if (pictureData != nil) {
        text = @"[Picture message]";
        picture = [Picture createEntity:nil];
        picture.name = @"picture.jpg";
        picture.data = UIImageJPEGRepresentation(pictureData, 0.6);
    }

#ifdef REMOTE_MODE
    [[MessageRemoteUtil sharedUtil] createRemoteMessage:groupId text:text Video:video Picture:picture completionHandler:^(id object, NSError *error) {
        if (error == nil) {
            [JSQSystemSoundPlayer jsq_playMessageSentSound];
            [self loadMessages];
        }
        else {
            [ProgressHUD showError:@"Network error."];
        }
    }];
	SendPushNotification(groupId, text);
    
    [[RecentRemoteUtil sharedUtil] updateRemoteRecentAndCounter:groupId amount:1 lastMessage:text members:nil];
	//UpdateRecentAndCounter(groupId, 1, text, self.managedObjectContext);
#endif
#ifdef LOCAL_MODE
    [[MessageLocalDataUtil sharedUtil] createLocalMessage:groupId text:text Video:video Picture:picture completionHandler:^(id object, NSError *error) {
        if (error == nil) {
            [JSQSystemSoundPlayer jsq_playMessageSentSound];
            [self loadMessages];
        }
        else {
            [ProgressHUD showError:@"Local Database error."];
        }
    }];
    
#warning TODO send local notification here
#warning TODO the logic here is wrong, we should update the receiver's counter
    [[RecentLocalDataUtil sharedUtil] updateLocalRecentAndCounter:groupId amount:1 lastMessage:text members:nil];
#endif
    [self finishSendingMessage];
}

#pragma mark - JSQMessagesViewController method overrides

- (void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date {
	[self sendMessage:text Video:nil Picture:nil];
}

- (void)didPressAccessoryButton:(UIButton *)sender {
    
	[self.view endEditing:YES];
    
#warning TODO implement all features
	NSArray *menuItems = @[[[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"chat_camera"] title:@"Camera"],
						   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"chat_audio"] title:@"Audio"],
						   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"chat_pictures"] title:@"Pictures"],
						   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"chat_videos"] title:@"Videos"],
						   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"chat_location"] title:@"Location"],
						   [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"chat_stickers"] title:@"Stickers"]];
	RNGridMenu *gridMenu = [[RNGridMenu alloc] initWithItems:menuItems];
	gridMenu.delegate = self;
	[gridMenu showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

#pragma mark - JSQMessages CollectionView DataSource

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
	return messages[indexPath.item];
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView
			 messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
	if ([self outgoing:messages[indexPath.item]])
	{
		return bubbleImageOutgoing;
	}
	else {
        return bubbleImageIncoming;
    }
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView
					avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JSQMessage * message = messages[indexPath.item];
    NSString *userID = message.senderId;
    
	__block User *user = [[UserManager sharedUtil] getUser:userID];
    if (user) {
        //nothing
    }
    else {
        //get the user remotely
#ifdef REMOTE_MODE
        [[UserRemoteUtil sharedUtil] loadRemoteUser:userID completionHandler:^(NSArray *objects, NSError *error) {
            if (!error) {
                RemoteUser * userRemote = [objects firstObject];
                if (userRemote) {
                    user = [[UserRemoteUtil sharedUtil] convertToUser:userRemote];
                    //[User convertFromRemoteUser:userRemote inManagedObjectContext:self.managedObjectContext];
                    [self loadAvatar:user];
                }
                else {
                    [ProgressHUD showError:@"User does not exist, user id is wrong."];

                }
            }
            else {
                [ProgressHUD showError:@"Network error."];

            }

        }];
#endif
#ifdef LOCAL_MODE
        //nothing
        // load user thumb below
#endif
    }
    
    
    if (avatars[user.globalID] == nil) {
        [self loadAvatar:user];
        return avatarImageBlank;
    }
    else {
        return avatars[user.globalID];
    }
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    NSTimeInterval interval ;
    JSQMessage *message = messages[indexPath.item];
    
    BOOL showTime = NO;
    if (indexPath.item -1 >=0) {
        JSQMessage *messagePrev = messages[indexPath.item - 1];
        interval = [message.date timeIntervalSinceDate:messagePrev.date];
        if (interval/60 >= 1) {
            showTime = YES;
        }
    }
    else {
        showTime = YES;
    }
    
    //if (indexPath.item % 3 == 0)
    if (showTime) {
		return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
	}
	else {
        return nil;
    }
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
	JSQMessage *message = messages[indexPath.item];
	if ([self incoming:message])
	{
		if (indexPath.item > 0)
		{
			JSQMessage *previous = messages[indexPath.item-1];
			if ([previous.senderId isEqualToString:message.senderId])
			{
				return nil;
			}
		}
		return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
	}
	else return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [messages count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];

	if ([self outgoing:messages[indexPath.item]])
	{
		cell.textView.textColor = [UIColor whiteColor];
	}
	else
	{
		cell.textView.textColor = [UIColor blackColor];
	}
	return cell;
}

#pragma mark - JSQMessages collection view flow layout delegate

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
				   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    NSTimeInterval interval ;
    JSQMessage *message = messages[indexPath.item];
    
    BOOL showTime = NO;
    if (indexPath.item -1 >=0) {
        JSQMessage *messagePrev = messages[indexPath.item - 1];
        interval = [message.date timeIntervalSinceDate:messagePrev.date];
        if (interval/60 >= 1) {
            showTime = YES;
        }
    }
    else {
        showTime = YES;
    }
    
	if (showTime)
	{
		return kJSQMessagesCollectionViewCellLabelHeightDefault;
	}
	else return 0;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
				   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
	JSQMessage *message = messages[indexPath.item];
	if ([self incoming:message])
	{
		if (indexPath.item > 0)
		{
			JSQMessage *previous = messages[indexPath.item-1];
			if ([previous.senderId isEqualToString:message.senderId])
			{
				return 0;
			}
		}
		return kJSQMessagesCollectionViewCellLabelHeightDefault;
	}
	else return 0;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
				   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout
heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
	return 0;
}

#pragma mark - Responding to collection view tap events

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
				header:(JSQMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagesButton:(UIButton *)sender
{
	NSLog(@"didTapLoadEarlierMessagesButton");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapAvatarImageView:(UIImageView *)avatarImageView
		   atIndexPath:(NSIndexPath *)indexPath
{
	JSQMessage *message = messages[indexPath.item];
	if ([self incoming:message])
	{
		ProfileView *profileView = [[ProfileView alloc] initWith:message.senderId];
		[self.navigationController pushViewController:profileView animated:YES];
	}
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath
{
	JSQMessage *message = messages[indexPath.item];
	if (message.isMediaMessage)
	{
		if ([message.media isKindOfClass:[PhotoMediaItem class]])
		{
			PhotoMediaItem *mediaItem = (PhotoMediaItem *)message.media;
			NSArray *photos = [IDMPhoto photosWithImages:@[mediaItem.image]];
			IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
			[self presentViewController:browser animated:YES completion:nil];
		}
		if ([message.media isKindOfClass:[VideoMediaItem class]])
		{
			VideoMediaItem *mediaItem = (VideoMediaItem *)message.media;
			MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:mediaItem.fileURL];
			[self presentMoviePlayerViewControllerAnimated:moviePlayer];
			[moviePlayer.moviePlayer play];
		}
	}
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation
{
#warning add location service
    /// TODO
	NSLog(@"didTapCellAtIndexPath %@", NSStringFromCGPoint(touchLocation));
}

#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex
{
	[gridMenu dismissAnimated:NO];
	if ([item.title isEqualToString:@"Camera"])		PresentMultiCamera(self, YES);
	if ([item.title isEqualToString:@"Audio"])		ActionPremium(self);
	if ([item.title isEqualToString:@"Pictures"])	PresentPhotoLibrary(self, YES);
	if ([item.title isEqualToString:@"Videos"])		PresentVideoLibrary(self, YES);
	if ([item.title isEqualToString:@"Location"])	ActionPremium(self);
	if ([item.title isEqualToString:@"Stickers"])	ActionPremium(self);
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	NSURL *video = info[UIImagePickerControllerMediaURL];
	UIImage *picture = info[UIImagePickerControllerEditedImage];
	
    [self sendMessage:nil Video:video Picture:picture];
	
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper methods

- (BOOL)incoming:(JSQMessage *)message
{
	return ([message.senderId isEqualToString:self.senderId] == NO);
}

- (BOOL)outgoing:(JSQMessage *)message
{
	return ([message.senderId isEqualToString:self.senderId] == YES);
}

- (NSManagedObjectContext *)managedObjectContext {
    _managedObjectContext = [[ConfigurationManager sharedManager] managedObjectContext];
    return _managedObjectContext;
}
@end
