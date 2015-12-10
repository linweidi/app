//
//  Place+Annotation.m
//  MyApp
//
//  Created by Linwei Ding on 11/26/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "Place+Annotation.h"
#import <MapKit/MapKit.h>

@implementation Place (Annotation) 

- (CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D coordinate;
    coordinate.longitude = [self.longitude doubleValue];
    coordinate.latitude = [self.latitude doubleValue];
    
    return coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    self.longitude = [NSNumber numberWithDouble:newCoordinate.longitude];
    self.latitude = [NSNumber numberWithDouble:newCoordinate.latitude];
}
@end
