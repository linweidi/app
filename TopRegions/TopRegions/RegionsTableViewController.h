//
//  PlacesTableViewController.h
//  TopPlacesProject
//
//  Created by Linwei Ding on 7/8/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define DEBUG_PLACE
#import "CoreDataTableViewController.h"

@interface RegionsTableViewController : CoreDataTableViewController

@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSArray * places;
//@property (nonatomic, strong) NSArray * place;
@property (nonatomic, strong) NSMutableDictionary * placesDict;
@property (nonatomic, strong) NSMutableArray * countryNames;

/*
 1. implement the schema of photo, photographer and regions, region should count photographer count
 2. UIManagedDocument opens/creates asynchronouly and should wait for 10 secondes. So work with UI asynchronously
 3. get the place and then region from a photo by place_id
 3.1. calculate the most popular regions by URLforRecentGeoreferencedPhotos periodically, a few times an hour in foreground, and background fetching
 3.1. Not use URLforTopPlaces, Not use URLforPhotosInPlace:maxResults:
 3.2 Use URLforInformationAboutPlace: using the FLICKR_PHOTO_PLACE_ID found in a photo dictionary to get the name of place's region from a place_id
 3.3  and then pass the dictionary returned from that to extractRegionNameFromPlaceInformation:
 4. get context via application delegate, segued-to view controller should get context via prepareForSegue
 5. limit the number of results an NSFetchResult fetches with its fetchLimit
 7. turn background fetch on in the Capabilities section under Background Modes.
 8. only show 50 most popular regions in your UI
 9. sort by regions at first and then by name of the region, display the number of different photographers as a subtitle
 
 
 Recent Tab Controller
 1. Recents tab should be driven by CoreData, not NSUserDefaults
 
 Photo View Controller
  6. thumbimage, fetch asynchronoously, store thumbnail image in CoreData
 
 Photo Image View Controller
 1. only fetch photo online
 */
@end
