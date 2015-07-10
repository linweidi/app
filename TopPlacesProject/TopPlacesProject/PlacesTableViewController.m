//
//  PlacesTableViewController.m
//  TopPlacesProject
//
//  Created by Linwei Ding on 7/8/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//
#import "FlickrFetcher.h"
#import "PlacesTableViewController.h"

@interface PlacesTableViewController ()
@property (weak, nonatomic) IBOutlet UIRefreshControl *refreshControl;

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
    
    
    NSURL *urlTopPlaces = [FlickrFetcher URLforTopPlaces];
    NSAssert(urlTopPlaces, @"url access fails!!\n");
    
    [self.refreshControl beginRefreshing];
    
    if (urlTopPlaces) {
        
        

#ifdef DEBUG_PLACE
////        dispatch_async(downloadQueue, ^{
//            NSData * dataTopPlaces = [NSData dataWithContentsOfURL:urlTopPlaces];
//            NSAssert(urlTopPlaces, @"download of top places fails!!\n");
//            if (dataTopPlaces) {
//                NSDictionary *propertyListRes = [NSJSONSerialization JSONObjectWithData:dataTopPlaces options:0 error:NULL];
////                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.refreshControl endRefreshing];
//                    self.places = [propertyListRes valueForKey:FLICKR_RESULTS_PLACES];
//                    NSLog(@"the places is:\n%@", self.places);
////                });
//            }
////        });
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
                    self.places = [propertyListRes valueForKey:FLICKR_RESULTS_PLACES];
                    NSLog(@"the places is:\n%@", self.places);
                });
            }
        });
        
#endif
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
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
        NSString * countryName = nil;
        for (NSDictionary * place in self.places) {
            NSRange lastComma = [place.description rangeOfString:@"," options:NSBackwardsSearch];
            if (lastComma.location != NSNotFound) {
                countryName = [place.description substringWithRange:lastComma];
                
                NSLog(@"the country name is %@", countryName);
                // add country name into place dict
                if (!self.placesDict[countryName]) {
                    self.placesDict[countryName] = [[NSMutableArray alloc]init];
                    //clear update country names
                    self.countryNames = nil;
                }
                [self.placesDict[countryName] addObject:place];
                
                
            }
            else {
                NSAssert(NO,@"Country name in json is wrong!") ;
            }
        }
    }
    else  {
        NSAssert(NO, @"place should not be nil" );
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
    
    NSString * countryName = [self.countryNames objectAtIndex:indexPath.section];
    NSMutableArray * placesInSection = [self.placesDict objectForKey:countryName];
    NSDictionary * place = [placesInSection objectAtIndex:indexPath.row];
    NSAssert(place, @"place does not exit!!");
    cell.textLabel.text = place.description;
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
