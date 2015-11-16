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
#import "AppConstant.h"
#import "common.h"
#import "WelcomeView.h"
#import "PremiumView.h"
#import "ConfigurationManager.h"
#import "UserLocalDataUtil.h"
#import "UserRemoteUtil.h"
#import "NavigationController.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
void LoginUser(id target)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
#ifdef DEBUG_MODE
#ifdef LOCAL_MODE
    [[UserLocalDataUtil sharedUtil] logInWithUsername:@"linweiding@gmail.com" password:@"123456" completionHandler:nil];
#endif
#ifdef REMOTE_MODE
    [[UserRemoteDataUtil sharedUtil] logInWithUsername:@"linweiding@gmail.com" password:@"123456" completionHandler:nil];
#endif
#endif
#ifdef NORMAL_MODE
	NavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:[[WelcomeView alloc] init]];
    navigationController.hidesBottomBarWhenPushed = YES;
	[target presentViewController:navigationController animated:YES completion:nil];
#endif
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void ActionPremium(id target)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PremiumView *premiumView = [[PremiumView alloc] init];
	premiumView.modalPresentationStyle = UIModalPresentationOverFullScreen;
	[target presentViewController:premiumView animated:YES completion:nil];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void PostNotification(NSString *notification)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil];
}
