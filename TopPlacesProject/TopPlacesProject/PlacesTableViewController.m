//
//  PlacesTableViewController.m
//  TopPlacesProject
//
//  Created by Linwei Ding on 7/8/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//
#import "FlickrFetcher.h"
#import "PhotosTableViewController.h"
#import "PlacesTableViewController.h"

@interface PlacesTableViewController ()


@end

@implementation PlacesTableViewController

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




- (void)updatePlaceDictionary {
    if (self.places) {
        NSString * countryName = nil;
        NSString * locName = nil;
        for (NSDictionary * place in self.places) {
            
            
            locName = [place valueForKeyPath:FLICKR_PLACE_NAME];
            
            countryName = [FlickrFetcher getCountryName:locName ];

                
            NSLog(@"the country name is %@", countryName);
            // add country name into place dict
            if (!self.placesDict[countryName]) {
                self.placesDict[countryName] = [[NSMutableArray alloc]init];

            }
            [self.placesDict[countryName] addObject:place];
                
            
        }
        //clear update country names
        self.countryNames = nil;
    }
    else  {
        NSAssert(NO, @"place should not be nil" );
    }
}


- (void) updateTable {
    NSURL *urlTopPlaces = [FlickrFetcher URLforTopPlaces];
    NSAssert(urlTopPlaces, @"url access fails!!\n");
    
    [self.refreshControl beginRefreshing];
    
    if (urlTopPlaces) {
        
        
        
#ifdef DEBUG_PLACE
        //        dispatch_async(downloadQueue, ^{
        NSData * dataTopPlaces = [NSData dataWithContentsOfURL:urlTopPlaces];
        NSAssert(urlTopPlaces, @"download of top places fails!!\n");
        if (dataTopPlaces) {
            NSDictionary *propertyListRes = [NSJSONSerialization JSONObjectWithData:dataTopPlaces options:0 error:NULL];
            //                dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            self.places = [propertyListRes valueForKeyPath:FLICKR_RESULTS_PLACES];
            NSLog(@"the places is:\n%@", self.places);
            //                });
        }
        //        });
#endif
        
#ifndef DEBUG_PLACE
        dispatch_queue_t downloadQueue = dispatch_queue_create("download queue", NULL);
        
        dispatch_async(downloadQueue, ^{
            NSData * dataTopPlaces = [NSData dataWithContentsOfURL:urlTopPlaces];
            NSAssert(urlTopPlaces, @"download of top places fails!!\n");
            if (dataTopPlaces) {
                NSDictionary *propertyListRes = [NSJSONSerialization JSONObjectWithData:dataTopPlaces options:0 error:NULL];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.refreshControl endRefreshing];
                    self.places = [propertyListRes valueForKeyPath:FLICKR_RESULTS_PLACES];
                    NSLog(@"the places is:\n%@", self.places);
                });
            }
        });
        
#endif
        
    }
}

#pragma mark -- Actions

 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([sender isKindOfClass:[UITableViewCell class]]) {
         UITableViewCell *cell = (UITableViewCell *)sender;
         if ([segue.destinationViewController isKindOfClass: [PhotosTableViewController class]]) {
             PhotosTableViewController * dest = (PhotosTableViewController *)segue.destinationViewController;
             NSIndexPath * path = [self.tableView indexPathForCell:cell];
             
             //get the place object
             NSDictionary *place = [self placeObject:path];
             
             // set dest view controller
             dest.title = [place valueForKey:FLICKR_PLACE_NAME];
             dest.placeId = [place valueForKey:FLICKR_PLACE_ID];
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
//-(NSDictionary *)places {
//    if (!_places) {
//        _places = [[NSDictionary alloc] init];
//    }
//    return _places;
//}


-(void)setPlaces:(NSArray *)places {
    _places = places;
    
    //update places dict
    if (places) {
        [self updatePlaceDictionary];
        
        [self.tableView reloadData];
    }

}



-(NSDictionary *)placesDict {
    if (!_placesDict) {
        _placesDict = [[NSMutableDictionary alloc] init];
    }
    return _placesDict;
}

-(NSMutableArray *)countryNames {
    if (!_countryNames) {
        _countryNames = [[self.placesDict allKeys] mutableCopy];
        
    }
    
    return _countryNames;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    NSLog(@"the total country count is %d", [self.countryNames count]);
    return [self.countryNames count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSString * countryName = [self.countryNames objectAtIndex:section];
    NSMutableSet * placeSet = [self.placesDict objectForKey:countryName];
    
    return [placeSet count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"place item" forIndexPath:indexPath];
    

    NSDictionary * place = [self placeObject:indexPath];
    
    
    NSAssert(place, @"place does not exit!!");
    cell.textLabel.text = [FlickrFetcher getCityName: place[FLICKR_PLACE_NAME]];
    cell.detailTextLabel.text = [FlickrFetcher getStateName:place[FLICKR_PLACE_NAME]];
    
    return cell;
}

- (NSDictionary *) placeObject:(NSIndexPath *)path {
    NSString * countryName = [self.countryNames objectAtIndex:path.section];
    NSMutableArray * placesInSection = [self.placesDict objectForKey:countryName];
    NSDictionary * place = [placesInSection objectAtIndex:path.row];
    return place;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.countryNames objectAtIndex:section];
}



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
