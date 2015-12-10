//
//  PlaceListView.h
//  MyApp
//
//  Created by Linwei Ding on 12/6/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "BaseSimpleViewController.h"

@class EventCategory;

@protocol PlaceListViewDelegate


- (void)didSelectSinglePlace:(Place *)place;

- (void)didSelectSinglePlaceMapItem:(MKMapItem *)place catLocalID:(NSString *)localID;

@end

@interface PlaceListView : BaseSimpleViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

//@property (strong, nonatomic) EventCategory * eventCategory;
@property (strong, nonatomic) NSString * catLocalID;
@property (strong, nonatomic) NSString * catName;
//@property (strong, nonatomic) NSString * searchBarText;

@property (nonatomic, weak) id <PlaceListViewDelegate>delegate;
@end
