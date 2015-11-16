//
//  PlaceListView.m
//  MyApp
//
//  Created by Linwei Ding on 11/14/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "EventCategory+Util.h"
#import "ConfigurationManager.h"
#import "PlaceCellView.h"
#import "Place+Util.h"
#
#import "PlaceTableView.h"

@interface PlaceTableView ()

@end

@implementation PlaceTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Place List";
    
    //self.tableView.tableHeaderView = self.viewHeader;
    self.managedObjectContext = [[ConfigurationManager sharedManager] managedObjectContext];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlaceCellView" bundle:nil] forCellReuseIdentifier:@"PlaceCell"];
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
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
        
        if (self.category) {
            request.predicate = [NSPredicate predicateWithFormat:@"%@ IN categories", self.category];
        }
        
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
    PlaceCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell"];
//    if (cell == nil) cell = [[PlaceCellView alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PlaceCell"];
    
    Place * place= [self.fetchedResultsController objectAtIndexPath:indexPath];
    //    User * contact = [[UserManager sharedUtil] getUser:people.userID];
    //    if (!contact) {
    //        contact = people.contact;
    //    }
    
    [cell bindData:place];
    
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
