//
//  PhotoBaseTableViewController.m
//  TopPlacesProject
//
//  Created by Linwei Ding on 7/10/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//
#import "PhotoImageViewController.h"
#import "FlickrFetcher.h"
#import "PhotoBaseTableViewController.h"

@interface PhotoBaseTableViewController ()

@end

@implementation PhotoBaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)fetchTable:(id)sender {
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) addPhotoToUserContext:(NSDictionary *)photo {
    
    NSMutableArray *array = [self getUpdatedArrayUserCtxt];
    
    [array addObject:photo];
    if ([array count]>20) {
        [array removeObjectAtIndex:0];
    }
    
    [self.userContext setObject:array forKey:@"recent photos"];
    
    [self.userContext synchronize];
}

#pragma mark -- Properties
-(void)setPhotos:(NSArray *)photos {
    _photos = photos;
    
    if (photos) {
        
        [self.tableView reloadData];
    }
}


-(NSUserDefaults *)userContext {
    if (!_userContext) {
        _userContext = [NSUserDefaults standardUserDefaults];
    }
    
    return _userContext;
}

- (NSMutableArray *)getUpdatedArrayUserCtxt {
    NSArray * recentPhotos = [self.userContext arrayForKey:@"recent photos"];
    NSMutableArray * ret = nil;
    if (recentPhotos) {
        ret  = [recentPhotos mutableCopy];
    }
    else {
        ret = [[NSMutableArray alloc] init];
    }
    
    return ret;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.photos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photo item" forIndexPath:indexPath];
    
    
    NSDictionary * photo = self.photos[indexPath.row];
    
    NSAssert(photo, @"photo is nil!!");
    
    
    cell.detailTextLabel.text = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    
    if (![photo[FLICKR_PHOTO_TITLE] length]) {
        if (![[photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION] length]) {
            cell.textLabel.text = @"Unknown";
        }
        else {
            cell.textLabel.text = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        }
    }
    else {
        cell.textLabel.text = photo[FLICKR_PHOTO_TITLE];
    }
    
    NSLog(@"the photo title is: %@", photo[FLICKR_PHOTO_TITLE]);
    NSLog(@"the photo description is: %@", [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION]);
    return cell;
}

#pragma mark -- properties
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get the Detail view controller in our UISplitViewController (nil if not in one)
    id detail = self.splitViewController.viewControllers[1];
    // if Detail is a UINavigationController, look at its root view controller to find it
    if ([detail isKindOfClass:[UINavigationController class]]) {
        detail = [((UINavigationController *)detail).viewControllers firstObject];
    }
    // is the Detail is an ImageViewController?
    if ([detail isKindOfClass:[PhotoImageViewController class]]) {
        // yes ... we know how to update that!
        PhotoImageViewController * ivc = (PhotoImageViewController *)detail;
        ivc.photo = self.photos[indexPath.row];
        ivc.title = [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        
        // add the photo into NSUserDefault
        [self addPhotoToUserContext:self.photos[indexPath.row]];
    }
}

- (void)prepareImageViewController:(PhotoImageViewController *)ivc toDisplayPhoto:(NSDictionary *)photo
{

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)sender;
        if ([segue.destinationViewController isKindOfClass: [PhotoImageViewController class]]) {
            PhotoImageViewController * dest = (PhotoImageViewController *)segue.destinationViewController;
            NSIndexPath * path = [self.tableView indexPathForCell:cell];
            
            //get the photo object
            NSDictionary *photo = [self.photos objectAtIndex:path.row];
            
            // set dest view controller
            dest.photo = photo;
            
            dest.title = cell.textLabel.text;
            
            // add the photo into NSUserDefault
            [self addPhotoToUserContext:photo];
            
        }
        else {
            NSAssert(NO, @"segue destination is wrong");
        }
    }
    else {
        NSAssert(NO, @"segue sender is wrong");
    }
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
