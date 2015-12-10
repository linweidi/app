

#import <Parse/Parse.h>
#import "CoreDataTableViewController.h"


@class User;
@protocol SelectPeopleDelegate


- (void)didSelectPeople:(User *)user;

@end


@interface SelectPeopleView : CoreDataTableViewController

@property (strong, nonatomic) NSMutableArray *selection;


@end
