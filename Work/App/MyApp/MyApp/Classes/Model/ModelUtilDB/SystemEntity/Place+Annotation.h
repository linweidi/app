//
//  Place+Annotation.h
//  MyApp
//
//  Created by Linwei Ding on 11/26/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Place.h"



@interface Place (Annotation) <MKAnnotation>
- (CLLocationCoordinate2D)coordinate ;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
@end
