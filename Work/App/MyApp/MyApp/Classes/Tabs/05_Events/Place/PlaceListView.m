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
//#import "MapViewController.h"

#import <MapKit/MapKit.h>


#import "PlaceCell.h"
#import "Place+Util.h"
#import "PlaceListView.h"


@interface PlaceListView ()

@property (strong, nonatomic) NSArray * places;
@property (strong, nonatomic) NSIndexPath *indexSelected;

@property (strong, nonatomic) NSMutableArray * placesRec;


@property (nonatomic, assign) MKCoordinateRegion boundingRegion;

@property (nonatomic, strong) MKLocalSearch *localSearch;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D userCoordinate;
@property (strong, nonatomic) CLLocation *userLocation;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) IBOutlet UIButton *viewAllButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

static NSString *kCellIdentifier = @"cellIdentifier";

@implementation PlaceListView



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select Place";
    
    //self.places = [[NSMutableArray alloc] init];
    self.placesRec = [[NSMutableArray alloc] init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlaceCell" bundle:nil] forCellReuseIdentifier:@"PlaceCell"];
    
    [self loadPlaces];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)shouldAutorotate {
//    return YES;
//}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //[self.placesRec removeAllObjects];
}


//- (NSUInteger)supportedInterfaceOrientations {
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//        return UIInterfaceOrientationMaskAll;
//    else
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    MapViewController *mapViewController = segue.destinationViewController;
//    
//    if ([segue.identifier isEqualToString:@"showDetail"]) {
//        // Get the single item.
//        NSIndexPath *selectedItemPath = [self.tableView indexPathForSelectedRow];
//        MKMapItem *mapItem = self.places[selectedItemPath.row];
//        
//        // Pass the new bounding region to the map destination view controller.
//        MKCoordinateRegion region = self.boundingRegion;
//        // And center it on the single placemark.
//        region.center = mapItem.placemark.coordinate;
//        mapViewController.boundingRegion = region;
//        
//        // Pass the individual place to our map destination view controller.
//        mapViewController.mapItemList = [NSArray arrayWithObject:mapItem];
//        
//    } else if ([segue.identifier isEqualToString:@"showAll"]) {
//        
//        // Pass the new bounding region to the map destination view controller.
//        mapViewController.boundingRegion = self.boundingRegion;
//        
//        // Pass the list of places found to our map destination view controller.
//        mapViewController.mapItemList = self.places;
//    }
//}


#pragma mark - UITableView delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger ret = 0;
    if (section == 0) {
        ret = [self.placesRec count];
        //ret = 2;
    }
    else if (section == 1) {
        ret = [self.places count];
    }
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlaceCell *cell = nil;
    

    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell" forIndexPath:indexPath];
        Place * place = self.placesRec[indexPath.row];
        [cell bindPlace:place];
    }
    else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell" forIndexPath:indexPath];
        if (!cell) {
#warning TODO provide more information here
            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
        }
        
        MKMapItem *mapItem = [self.places objectAtIndex:indexPath.row];
        [cell bindMapItem:mapItem userLocation:self.userLocation];
        

    }

    

    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString * ret = nil;
    if (section == 0) {
        ret = @"Recommend";
    }
    else {
        ret = @"Search Results";
    }
    return ret;
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
    
    //UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        // placeRec
        [self.delegate didSelectSinglePlace:self.placesRec[indexPath.row]];
        
    }
    else {
        // place
        [self.delegate didSelectSinglePlaceMapItem:self.places[indexPath.row] catLocalID:self.catLocalID];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        
    }
}

#pragma mark - Backend actions

- (void)loadPlaces {
    // Fetch recommended places
    //    NSError * error = nil;
    //    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
    //    request.predicate = [NSPredicate predicateWithFormat:@"ANY catLocalIDs == %@", [NSString stringWithFormat:@"%@",@"4.4"]];
    //    NSArray * matches = [[ConfigurationManager sharedManager].managedObjectContext executeFetchRequest:request error:&error];
    
    
    
#warning TODO implement remote load
#ifdef LOCAL_MODE
    NSArray * matches = [[PlaceLocalDataUtil sharedUtil] loadPlacesRecommended:[NSString stringWithFormat:@"%@", self.catLocalID]];
    for (NSManagedObject * object in matches) {
        Place * newObject = [Place createTempEntity:[ConfigurationManager sharedManager].managedObjectContext];
        [newObject populateProperties:object];
        [self.placesRec addObject:newObject];
    }
    NSError * error = nil;
    [[ConfigurationManager sharedManager].managedObjectContext save:&error];
    NSParameterAssert(error == nil);
#endif
#ifdef REMOTE_MODE
    [[PlaceRemoteUtil sharedUtil] loadPlacesRecommended:self.placesRec catLocalID:[NSString stringWithFormat:@"%@", self.catLocalID]];
#endif
    
    
    // search for local places
    [self updateLocationService];
}



#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    // If the text changed, reset the tableview if it wasn't empty.
    if (self.places.count != 0) {
        
        // Set the list of places to be empty.
        self.places = @[];
        // Reload the tableview.
        [self.tableView reloadData];
        // Disable the "view all" button.
        self.viewAllButton.enabled = NO;
    }
}

- (void)startSearch:(NSString *)searchString {
    if (self.localSearch.searching)
    {
        [self.localSearch cancel];
    }
    
    // Confine the map search area to the user's current location.
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = self.userCoordinate.latitude;
    newRegion.center.longitude = self.userCoordinate.longitude;
    
    // Setup the area spanned by the map region:
    // We use the delta values to indicate the desired zoom level of the map,
    //      (smaller delta values corresponding to a higher zoom level).
    //      The numbers used here correspond to a roughly 8 mi
    //      diameter area.
    //
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    
    request.naturalLanguageQuery = [NSString stringWithFormat:@"%@ %@", [NSString stringWithFormat:@"%@",self.catName], searchString];
    request.region = newRegion;
    
    MKLocalSearchCompletionHandler completionHandler = ^(MKLocalSearchResponse *response, NSError *error) {
        if (error != nil) {
            NSString *errorStr = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not find places"
                                                            message:errorStr
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        } else {
            self.places = [response mapItems];
            
            // Used for later when setting the map's region in "prepareForSegue".
            self.boundingRegion = response.boundingRegion;
            
            self.viewAllButton.enabled = self.places != nil ? YES : NO;
            
            [self.tableView reloadData];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    };
    
    if (self.localSearch != nil) {
        self.localSearch = nil;
    }
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    
    [self.localSearch startWithCompletionHandler:completionHandler];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    
    [self updateLocationService];

}

#pragma mark -- update location
- (void) updateLocationService {
    // Check if location services are available
    if ([CLLocationManager locationServicesEnabled] == NO) {
        NSLog(@"%s: location services are not available.", __PRETTY_FUNCTION__);
        
        // Display alert to the user.
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Location services"
                                                                       message:@"Location services are not enabled on this device. Please enable location services in settings."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}]; // Do nothing action to dismiss the alert.
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    // Request "when in use" location service authorization.
    // If authorization has been denied previously, we can display an alert if the user has denied location services previously.
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        NSLog(@"%s: location services authorization was previously denied by the user.", __PRETTY_FUNCTION__);
        
        // Display alert to the user.
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Location services"
                                                                       message:@"Location services were previously denied by the user. Please enable location services for this app in settings."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}]; // Do nothing action to dismiss the alert.
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    // Start updating locations.
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    // When a location is delivered to the location manager delegate, the search will actually take place. See the -locationManager:didUpdateLocations: method.
}


#pragma mark - CLLocationManagerDelegate methods


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    // Remember for later the user's current location.
    self.userLocation = locations.lastObject;
    self.userCoordinate = self.userLocation.coordinate;
    
    [manager stopUpdatingLocation]; // We only want one update.
    
    manager.delegate = nil;         // We might be called again here, even though we
    // called "stopUpdatingLocation", so remove us as the delegate to be sure.
    
    // We have a location now, so start the search.
    [self startSearch:self.searchBar.text];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // report any errors returned back from Location Services
}

@end
