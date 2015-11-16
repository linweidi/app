//
//  BoardListView.m
//  MyApp
//
//  Created by Linwei Ding on 11/14/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "ConfigurationManager.h"
#import "Board+Util.h"
#import "BoardListView.h"

@interface BoardListView ()

@end

@implementation BoardListView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Board List";
    
    //self.tableView.tableHeaderView = self.viewHeader;
    self.managedObjectContext = [[ConfigurationManager sharedManager] managedObjectContext];
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
        
        request.predicate = [NSPredicate predicateWithFormat:@"globalID IN %@", self.boardIDs];
        //request.fetchLimit = USERVIEW_DISPLAY_ITEM_NUM;
        request.sortDescriptors = @[[NSSortDescriptor
                                     sortDescriptorWithKey:@"name"
                                     ascending:YES
                                     selector:@selector(localizedCompare:)]
                                    ];
        
        
        // init fetch result controller
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    Board * board = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //    User * contact = [[UserManager sharedUtil] getUser:people.userID];
    //    if (!contact) {
    //        contact = people.contact;
    //    }
    
    
    cell.textLabel.text = board.name;
    if ([board.type isEqualToString: @"city"]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@_%@_%@", board.country, board.state, board.city];
    }
    else {
        // category
        cell.detailTextLabel.text = board.categoryName;
        
    }
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
