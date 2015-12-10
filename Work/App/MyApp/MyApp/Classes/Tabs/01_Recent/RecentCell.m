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
#import <ParseUI/ParseUI.h>

#import "DataModelHeader.h"
#import "User+Util.h"
#import "Recent+Util.h"
#import "Thumbnail+Util.h"
#import "converter.h"

#import "RecentCell.h"

@interface RecentCell()
{
//	PFObject *recent;
}


@end

@implementation RecentCell

@synthesize imageUser;
@synthesize labelDescription, labelLastMessage;
@synthesize labelElapsed, labelCounter;

////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)bindData:(PFObject *)recent_
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	recent = recent_;
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	imageUser.layer.cornerRadius = imageUser.frame.size.width/2;
//	imageUser.layer.masksToBounds = YES;
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	PFUser *lastUser = recent[PF_RECENT_LASTUSER];
//	[imageUser setFile:lastUser[PF_USER_PICTURE]];
//	[imageUser loadInBackground];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	labelDescription.text = recent[PF_RECENT_DESCRIPTION];
//	labelLastMessage.text = recent[PF_RECENT_LASTMESSAGE];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:recent[PF_RECENT_UPDATEDACTION]];
//	labelElapsed.text = TimeElapsed(seconds);
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	int counter = [recent[PF_RECENT_COUNTER] intValue];
//	labelCounter.text = (counter == 0) ? @"" : [NSString stringWithFormat:@"%d new", counter];
//}

- (void)bindData:(Recent *)recent_
{
	Recent * recent = recent_;
	imageUser.layer.cornerRadius = imageUser.frame.size.width/2;
	imageUser.layer.masksToBounds = YES;
	User *lastUser = recent.lastUser;
    

    
    [imageUser setImage:[UIImage imageWithData:lastUser.thumbnail.data]];
    //[imageUser sizeToFit];
    //[imageUser loadInBackground];
    
    
	labelDescription.text = recent.details;
	labelLastMessage.text = recent.lastMessage;
	NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:recent.updateTime];
	labelElapsed.text = TimeElapsed(seconds);
	int counter = [recent.counter intValue];
	labelCounter.text = (counter == 0) ? @"" : [NSString stringWithFormat:@"%d new", counter];
}



@end
