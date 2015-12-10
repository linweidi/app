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


@class User;
@protocol SelectSingleDelegate


- (void)didSelectSingleUser:(User *)user;

@end


@interface SelectSingleView : UITableViewController <UISearchBarDelegate>

//@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, weak) IBOutlet id<SelectSingleDelegate>delegate;

@end

////
//// Copyright (c) 2015 Related Code - http://relatedcode.com
////
//// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//// THE SOFTWARE.
//
//#import <Parse/Parse.h>
//#import "CoreDataTableViewController.h"
//
//
//@protocol SelectSingleDelegate
//
//
//- (void)didSelectSingleUser:(User *)user;
//
//@end
//
//
//@interface SelectSingleView : CoreDataTableViewController
//
//
//@property (nonatomic, assign) IBOutlet id<SelectSingleDelegate>delegate;
//
//@end
