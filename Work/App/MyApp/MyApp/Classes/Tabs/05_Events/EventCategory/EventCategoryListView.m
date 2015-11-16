//
//  EventCategoryTableView.m
//  MyApp
//
//  Created by Linwei Ding on 11/13/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "EventCategory+Util.h"
#import "Thumbnail+Util.h"
#import "ConfigurationManager.h"
#import "EventCategoryListView.h"

@interface EventCategoryListView ()

//@property (strong, nonatomic) IBOutlet UIView *viewHeader;



@end

@implementation EventCategoryListView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Select Single";
    
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
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"EventCategory"];
        if (self.parentID) {
            request.predicate = [NSPredicate predicateWithFormat:@"%@ IN parentItems AND level = %d", self.parentID, self.level];

        }
        else {
            request.predicate = [NSPredicate predicateWithFormat:@"level = 1"];
        }
                //request.fetchLimit = USERVIEW_DISPLAY_ITEM_NUM;
        request.sortDescriptors = @[[NSSortDescriptor
                                     sortDescriptorWithKey:@"name"
                                     ascending:YES
                                     selector:@selector(localizedCompare:)],
                                    ];
        
        
        // init fetch result controller
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    EventCategory * category= [self.fetchedResultsController objectAtIndexPath:indexPath];
    //    User * contact = [[UserManager sharedUtil] getUser:people.userID];
    //    if (!contact) {
    //        contact = people.contact;
    //    }
    
    
    cell.textLabel.text = category.name;
    [cell.imageView setImage:[UIImage imageWithData:category.thumb.data]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EventCategory * category = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self.delegate didSelectEventCategory:category level:self.level];
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
