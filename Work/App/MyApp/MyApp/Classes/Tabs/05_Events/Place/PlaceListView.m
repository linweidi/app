//
//  PlaceListView.m
//  MyApp
//
//  Created by Linwei Ding on 12/6/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "AppConstant.h"

#ifdef LOCAL_MODE
#import "PlaceLocalDataUtil.h"
#endif
 
#ifdef REMOTE_MODE
#import "PlaceRemoteUtil.h"
#endif

#import "EventCategory+Util.h"

#import "PlaceListView.h"

@interface PlaceListView ()

@property (strong, nonatomic) NSMutableArray * places;
@property (strong, nonatomic) NSIndexPath *indexSelected;

@property (strong, nonatomic) NSMutableArray * placesRec;


@property (nonatomic, assign) MKCoordinateRegion boundingRegion;

@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *viewAllButton;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D userCoordinate;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation PlaceListView



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Blocked users";
    
    self.places = [[NSMutableArray alloc] init];
    self.placesRec = [[NSMutableArray alloc] init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self loadPlaces];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return YES;
}

#pragma mark - Backend actions

- (void)loadPlaces {
    // Fetch recommended places
#warning TODO implement remote load
#ifdef LOCAL_MODE
    [[PlaceLocalDataUtil sharedUtil] loadPlacesRecommended:self.placesRec category:self.eventCategory];
#endif
#ifdef REMOTE_MODE
    [[PlaceRemoteUtil sharedUtil] loadPlacesRecommended:self.placesRec category:self.eventCategory];
#endif
    
    
    // search for local places
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    PFObject *blocked = self.places[indexPath.row];
    PFUser *user = blocked[PF_BLOCKED_USER2];
    cell.textLabel.text = user[PF_USER_FULLNAME];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    indexSelected = indexPath;
//    
//    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel"
//                                          destructiveButtonTitle:nil otherButtonTitles:@"Unblock user", nil];
//    [action showInView:self.view];
    
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        // Get the single item.
        NSIndexPath *selectedItemPath = [self.tableView indexPathForSelectedRow];
        MKMapItem *mapItem = self.places[selectedItemPath.row];
        
        // Pass the new bounding region to the map destination view controller.
        MKCoordinateRegion region = self.boundingRegion;
        // And center it on the single placemark.
        region.center = mapItem.placemark.coordinate;
        mapViewController.boundingRegion = region;
        
        // Pass the individual place to our map destination view controller.
        mapViewController.mapItemList = [NSArray arrayWithObject:mapItem];
        
    } else if ([segue.identifier isEqualToString:@"showAll"]) {
        
        // Pass the new bounding region to the map destination view controller.
        mapViewController.boundingRegion = self.boundingRegion;
        
        // Pass the list of places found to our map destination view controller.
        mapViewController.mapItemList = self.places;
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
