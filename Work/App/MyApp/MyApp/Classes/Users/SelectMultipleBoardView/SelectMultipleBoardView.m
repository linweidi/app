//
//  SelectMultipleBoardView.m
//  MyApp
//
//  Created by Linwei Ding on 12/9/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//


#import <Parse/Parse.h>
#import "AppHeader.h"
#import "ProgressHUD.h"
#import "Board+Util.h"
#import "AppConstant.h"

#import "BoardRemoteUtil.h"

#import "ConverterUtil.h"

#import "SelectMultipleBoardView.h"

@interface SelectMultipleBoardView ()

@end

@implementation SelectMultipleBoardView

@synthesize selection;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionCancel)];
    
    
    self.managedObjectContext = [ConfigurationManager sharedManager].managedObjectContext;
    
    self.title = @"Select Multiple";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                                                           action:@selector(actionDone)];
    
    [self loadBoards];
    
    NSParameterAssert(self.delegate);
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    super.managedObjectContext = managedObjectContext;
    
    if (managedObjectContext) {
        // init fetch request
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Board"];
        //request.predicate = [NSPredicate predicateWithFormat:@"string"];
        request.fetchLimit = USERVIEW_DISPLAY_ITEM_NUM;
        request.sortDescriptors = @[[NSSortDescriptor
                                     sortDescriptorWithKey:@"name"
                                     ascending:YES
                                     selector:@selector(localizedCompare:)],
                                    ];
        
        
        // init fetch result controller
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
    
}

#pragma mark - User actions

- (void)actionCancel
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionDone
{
    if ([self.selection count] == 0) {
        [ProgressHUD showError:@"Please select some users."];
        return;
    }
    if (self.delegate != nil) {
        
        [self.delegate didSelectMultipleBoardIDs:self.selection];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) loadBoards {
#ifdef REMOTE_MODE
    Board * latestBoard = nil;
    
    latestBoard = [Board latestEntity:self.managedObjectContext];
    
    [[BoardRemoteUtil sharedUtil] loadRemoteBoards: latestBoard completionHandler:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            //[boards removeAllObjects];
            //[boards addObjectsFromArray:objects];
            //[self.tableView reloadData];
            
            // load the recents into core data
            
            [self.tableView reloadData];
            
        }
        else {
            [ProgressHUD showError:@"Network error."];
        }
        [self.refreshControl endRefreshing];
    }];
#endif
#ifdef LOCAL_MODE
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
#endif
    
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//	return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//	return [users count];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    Board * board= [self.fetchedResultsController objectAtIndexPath:indexPath];
    //    User * contact = [[UserManager sharedUtil] getUser:board.userID];
    //    if (!contact) {
    //        contact = board.contact;
    //    }
    
    if ([board.name length]) {
        cell.textLabel.text = board.name;
    }
    else {
        cell.textLabel.text = @"board";
    }
    
//    NSArray * memberIDs = board.members;
//    NSMutableArray * users = [[NSMutableArray alloc] init];
//    UserManager * manager = [UserManager sharedUtil];
//    for (NSString * userId in memberIDs) {
//        [users addObject:[manager getUser:userId]];
//    }
//    cell.detailTextLabel.text = [[ConverterUtil sharedUtil] createDescriptionByUsers:users];
    if ([board.type isEqualToString:@"location"]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@, %@", board.city, board.state, board.country];
    }
    else {
        //@"category"
        cell.detailTextLabel.text =[NSString stringWithFormat:@"Category/%@", board.categoryName];
    }
    
    BOOL selected = [selection containsObject:board.globalID];
    cell.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Board * board= [self.fetchedResultsController objectAtIndexPath:indexPath];
    //User * contact = board.contact;
    
    BOOL selected = [selection containsObject:board.globalID];
    if (selected) {
        [selection removeObject:board.globalID];
    } else {
        [selection addObject:board.globalID];
    }
    [self.tableView reloadData];
    
    //select one user and dismiss
    //	[self dismissViewControllerAnimated:YES completion:^{
    //		if (delegate != nil) {
    //            [delegate didSelectBoard:contact];
    //        }
    //	}];
}

#pragma mark -- property methods
- (NSMutableArray *)selection {
    if (!selection) {
        selection = [[NSMutableArray alloc] init];
    }
    return selection;
}
@end
