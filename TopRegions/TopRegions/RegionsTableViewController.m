//
//  PlacesTableViewController.m
//  TopPlacesProject
//
//  Created by Linwei Ding on 7/8/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "FlickrFetcher.h"
#include "RegionsTopHeader.h"
#import "Region.h"
#import "PhotosTableViewController.h"
#import "RegionsTableViewController.h"



@interface RegionsTableViewController ()


@end




@implementation RegionsTableViewController

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName: RegionsDatabaseAvailableNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
                    self.managedObjectContext = note.userInfo[RegionsDatabaseAvailableContext];
    }];
    

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self updateTable];

}



- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    
    if (managedObjectContext) {
        // init fetch request
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Region"];
        request.predicate = nil;
        request.fetchLimit = 50;
        request.sortDescriptors = @[[NSSortDescriptor
                                     sortDescriptorWithKey:@"popularity"
                                     ascending:NO
                                     selector:@selector(compare:)],
                                    [NSSortDescriptor
                                     sortDescriptorWithKey:@"name"
                                     ascending:YES
                                     selector:@selector(localizedStandardCompare:)]];
        
        
        // init fetch result controller
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
    }

}


-(void) updateTable {
    //download
    //perform fetch
    
    [self.tableView reloadData];
}

#pragma mark -- Actions

 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([sender isKindOfClass:[UITableViewCell class]]) {
         UITableViewCell *cell = (UITableViewCell *)sender;
         if ([segue.destinationViewController isKindOfClass: [PhotosTableViewController class]]) {
             PhotosTableViewController * dest = (PhotosTableViewController *)segue.destinationViewController;
             
             dest.managedObjectContext = self.managedObjectContext;
             
             NSIndexPath * path = [self.tableView indexPathForCell:cell];
             
             //get the region object by name
             Region * region = [self.fetchedResultsController objectAtIndexPath:path];
             NSArray * photos = [region.photos sortedArrayUsingDescriptors:@[[NSSortDescriptor
                        sortDescriptorWithKey:@"title"
                                ascending:YES
                            selector:@selector(localizedStandardCompare:)]]
                                 ];
             
             // set dest view controller
             dest.photos = photos;
         }
         else {
             NSAssert(NO, @"segue destination is wrong");
         }
     }
     else {
         NSAssert(NO, @"segue sender is wrong");
     }
 }


- (IBAction)fetchTable:(id)sender {
    [self updateTable];
}


#pragma mark -- Properties


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Region Cell"];
    
    Region *region = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = region.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d photographers", [[region popularity] intValue]];
    
    return cell;
    
}

//////////////////////////////////////////////////////////////

//- (NSDictionary *) placeObject:(NSIndexPath *)path {
//    NSString * countryName = [self.countryNames objectAtIndex:path.section];
//    NSMutableArray * placesInSection = [self.placesDict objectForKey:countryName];
//    NSDictionary * place = [placesInSection objectAtIndex:path.row];
//    return place;
//}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    return [self.countryNames objectAtIndex:section];
//}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
