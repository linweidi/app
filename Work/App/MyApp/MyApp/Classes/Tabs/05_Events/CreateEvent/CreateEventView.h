//
//  CreateEventView.h
//  MyApp
//
//  Created by Linwei Ding on 11/10/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PlaceListView.h"
#import "SelectMultiplePeopleView.h"
#import "SelectMultipleGroupView.h"
#import "SelectMultipleBoardView.h"
#import "EventCategoryLevelView.h"

@class Place;
@interface CreateEventView : UITableViewController <PlaceListViewDelegate, SelectMultiplePeopleDelegate, SelectMultipleBoardDelegate, SelectMultipleGroupDelegate, SelectEventCategoryDelegate>


- (void)didSelectSinglePlaceMapItem:(MKMapItem *)place catLocalID:(NSString *)localID;

- (void)didSelectSinglePlace:(Place *)place;

- (void)didSelectMultipleUserIDs:(NSMutableArray *)userIDs;
- (void)didSelectMultipleGroupIDs:(NSMutableArray *)groupIDs;
- (void)didSelectMultipleBoardIDs:(NSMutableArray *)boardIDs;

- (void)didSelectEventCategory:(EventCategory *)category;

@property (strong, nonatomic) NSMutableArray * days;


@end
