//
//  Recent.h
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

@class User;


NS_ASSUME_NONNULL_BEGIN

@interface Recent : UserEntity

@property (nullable, nonatomic, retain) NSString *chatID;
@property (nullable, nonatomic, retain) NSNumber *counter;
@property (nullable, nonatomic, retain) NSString *details;
@property (nullable, nonatomic, retain) NSString *fullname;
@property (nullable, nonatomic, retain) NSString *lastMessage;
@property (nullable, nonatomic, retain) User *lastUser;
@property (nullable, nonatomic, retain) User *user;


@end

NS_ASSUME_NONNULL_END
