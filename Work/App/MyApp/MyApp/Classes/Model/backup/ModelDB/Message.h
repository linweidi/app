//
//  Message.h
//  MyApp
//
//  Created by Linwei Ding on 10/28/15.
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

@class Picture, User, Video;


NS_ASSUME_NONNULL_BEGIN

@interface Message : UserEntity

@property (nullable, nonatomic, retain) NSString *chatID;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) User *user;
@property (nullable, nonatomic, retain) Picture *picture;
@property (nullable, nonatomic, retain) Video *video;


@end

NS_ASSUME_NONNULL_END
