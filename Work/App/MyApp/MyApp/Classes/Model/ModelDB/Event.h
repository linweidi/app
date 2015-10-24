//
//  Event.h
//  MyApp
//
//  Created by Linwei Ding on 10/23/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "UserEntity.h"

@class Alert, EventCategory, Place, User;


NS_ASSUME_NONNULL_BEGIN

@interface Event : UserEntity

@property (nullable, nonatomic, retain) id boardIDs;
@property (nullable, nonatomic, retain) NSDate *endTime;
@property (nullable, nonatomic, retain) id groupIDs;
@property (nullable, nonatomic, retain) id invitees;
@property (nullable, nonatomic, retain) NSNumber *isAlert;
@property (nullable, nonatomic, retain) NSNumber *isVoting;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) id members;
@property (nullable, nonatomic, retain) NSString *notes;
@property (nullable, nonatomic, retain) NSString *scope;
@property (nullable, nonatomic, retain) NSDate *startTime;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *votingID;
@property (nullable, nonatomic, retain) Alert *alert;
@property (nullable, nonatomic, retain) EventCategory *category;
@property (nullable, nonatomic, retain) Place *place;
@property (nullable, nonatomic, retain) User *user;


@end

NS_ASSUME_NONNULL_END
