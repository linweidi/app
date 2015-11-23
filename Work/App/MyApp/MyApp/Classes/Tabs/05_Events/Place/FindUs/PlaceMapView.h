//
//  PlaceMapView.h
//  MyApp
//
//  Created by Linwei Ding on 11/22/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import <MapKit/MapKit.h>
#import "BaseSimpleViewController.h"

@interface PlaceMapView : BaseSimpleViewController <MKMapViewDelegate>

@property (assign,nonatomic) IBOutlet MKMapView *mapView;
@property (assign,nonatomic) IBOutlet UILabel *locationLabel;
@property (assign,nonatomic) IBOutlet UILabel *distanceLabel;

- (IBAction)onPreviosLocation:(id)sender;
- (IBAction)onNextLocation:(id)sender;
- (IBAction)onMakeReservation:(id)sender;

@end
