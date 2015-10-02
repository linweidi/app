

#import <Parse/Parse.h>
#import "CoreDataTableViewController.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@class User;
@protocol SelectPeopleDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------

- (void)didSelectPeople:(User *)user;

@end

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface SelectPeopleView : CoreDataTableViewController
{
	//NSMutableArray *users;
    //
    NSMutableArray *selection;
}
//-------------------------------------------------------------------------------------------------------------------------------------------------

//@property (nonatomic, assign) id<SelectPeopleDelegate>delegate;

- (void)viewDidLoad;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
