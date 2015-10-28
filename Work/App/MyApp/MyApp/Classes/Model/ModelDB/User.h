//
//  User.h
//  MyApp
//
//  Created by Linwei Ding on 10/27/15.
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

@class Alert, Event, Group, People, Place, Recent, Thumbnail;


NS_ASSUME_NONNULL_BEGIN

@interface User : UserEntity

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *emailCopy;
@property (nullable, nonatomic, retain) NSString *facebookID;
@property (nullable, nonatomic, retain) NSString *fullname;
@property (nullable, nonatomic, retain) NSString *fullnameLower;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *pictureID;
@property (nullable, nonatomic, retain) NSString *pictureName;
@property (nullable, nonatomic, retain) NSString *pictureURL;
@property (nullable, nonatomic, retain) NSString *twitterID;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSSet<Alert *> *alerts;
@property (nullable, nonatomic, retain) NSSet<Event *> *events;
@property (nullable, nonatomic, retain) NSSet<Group *> *groups;
@property (nullable, nonatomic, retain) NSSet<People *> *peoples;
@property (nullable, nonatomic, retain) NSSet<Place *> *places;
@property (nullable, nonatomic, retain) NSSet<Recent *> *recents;
@property (nullable, nonatomic, retain) Thumbnail *thumbnail;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAlertsObject:(Alert *)value;
- (void)removeAlertsObject:(Alert *)value;
- (void)addAlerts:(NSSet<Alert *> *)values;
- (void)removeAlerts:(NSSet<Alert *> *)values;

- (void)addEventsObject:(Event *)value;
- (void)removeEventsObject:(Event *)value;
- (void)addEvents:(NSSet<Event *> *)values;
- (void)removeEvents:(NSSet<Event *> *)values;

- (void)addGroupsObject:(Group *)value;
- (void)removeGroupsObject:(Group *)value;
- (void)addGroups:(NSSet<Group *> *)values;
- (void)removeGroups:(NSSet<Group *> *)values;

- (void)addPeoplesObject:(People *)value;
- (void)removePeoplesObject:(People *)value;
- (void)addPeoples:(NSSet<People *> *)values;
- (void)removePeoples:(NSSet<People *> *)values;

- (void)addPlacesObject:(Place *)value;
- (void)removePlacesObject:(Place *)value;
- (void)addPlaces:(NSSet<Place *> *)values;
- (void)removePlaces:(NSSet<Place *> *)values;

- (void)addRecentsObject:(Recent *)value;
- (void)removeRecentsObject:(Recent *)value;
- (void)addRecents:(NSSet<Recent *> *)values;
- (void)removeRecents:(NSSet<Recent *> *)values;


@end

NS_ASSUME_NONNULL_END
