//
//  PlacePropertyView.h
//  MyApp
//
//  Created by Linwei Ding on 11/22/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import <MapKit/MapKit.h>
#import "CoreDataTableViewController.h"

@class Place;
@interface PlacePropertyView <MKMapViewDelegate> : CoreDataTableViewController

- (instancetype)initWithPlace:(NSString *)placeID;

@end
