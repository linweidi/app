//
//  EventVoting.h
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

@class EventVoteItem, User;


NS_ASSUME_NONNULL_BEGIN

@interface EventVoting : UserEntity

@property (nullable, nonatomic, retain) NSString *instruction;
@property (nullable, nonatomic, retain) NSNumber *isPriority;
@property (nullable, nonatomic, retain) NSNumber *selectNum;
@property (nullable, nonatomic, retain) NSNumber *timeSpan;
@property (nullable, nonatomic, retain) NSSet<EventVoteItem *> *voteItems;
@property (nullable, nonatomic, retain) NSSet<User *> *voterList;

@end

@interface EventVoting (CoreDataGeneratedAccessors)

- (void)addVoteItemsObject:(EventVoteItem *)value;
- (void)removeVoteItemsObject:(EventVoteItem *)value;
- (void)addVoteItems:(NSSet<EventVoteItem *> *)values;
- (void)removeVoteItems:(NSSet<EventVoteItem *> *)values;

- (void)addVoterListObject:(User *)value;
- (void)removeVoterListObject:(User *)value;
- (void)addVoterList:(NSSet<User *> *)values;
- (void)removeVoterList:(NSSet<User *> *)values;


@end

NS_ASSUME_NONNULL_END
