//
//  PhotosTableViewController.m
//  TopPlacesProject
//
//  Created by Linwei Ding on 7/10/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "FlickrFetcher.h"
#import "PhotoImageViewController.h"
#import "PhotosTableViewController.h"

@interface PhotosTableViewController ()


@end

@implementation PhotosTableViewController

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
    
    [self loadPhotos];
}

- (IBAction)fetchTable:(id)sender {
    [self loadPhotos];
    
}

- (void ) loadPhotos {
    NSAssert(self.placeId, @"place id is nil or empty");
    NSURL *urlPhotos = [FlickrFetcher URLforPhotosInPlace:self.placeId maxResults:50];
    
    NSAssert(urlPhotos, @"url access fails!!\n");
    
    [self.refreshControl beginRefreshing];
    
    if (urlPhotos) {
        
        dispatch_queue_t downloadQueue = dispatch_queue_create("download queue", NULL);
        
        dispatch_async(downloadQueue, ^{
            NSData * dataPhotos = [NSData dataWithContentsOfURL:urlPhotos];
            NSAssert(urlPhotos, @"download of top places fails!!\n");
            if (dataPhotos) {
                NSDictionary *propertyListRes = [NSJSONSerialization JSONObjectWithData:dataPhotos options:0 error:NULL];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    
                    self.photos = [propertyListRes valueForKeyPath:FLICKR_RESULTS_PHOTOS];
                    NSLog(@"the photos are:\n%@", self.photos);
                    
                    [self.refreshControl endRefreshing];
                });
            }
        });
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source





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
