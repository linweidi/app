//
//  Place.h
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
#import "SystemEntity.h"

@class Picture, Thumbnail;


NS_ASSUME_NONNULL_BEGIN

@interface Place : SystemEntity

@property (nullable, nonatomic, retain) NSDate *closeTime;
@property (nullable, nonatomic, retain) NSString *likes;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSString *map;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSDate *openTime;
@property (nullable, nonatomic, retain) NSNumber *parking;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSNumber *rankings;
@property (nullable, nonatomic, retain) NSString *tips;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) Thumbnail *thumb;
@property (nullable, nonatomic, retain) NSSet<Picture *> *photos;

@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Picture *)value;
- (void)removePhotosObject:(Picture *)value;
- (void)addPhotos:(NSSet<Picture *> *)values;
- (void)removePhotos:(NSSet<Picture *> *)values;


@end

NS_ASSUME_NONNULL_END
