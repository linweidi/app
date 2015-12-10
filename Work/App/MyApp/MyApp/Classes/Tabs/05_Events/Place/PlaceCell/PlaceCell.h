//
//  PlaceCell.h
//  MyApp
//
//  Created by Linwei Ding on 12/7/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class Place;

@interface PlaceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *stars;
@property (strong, nonatomic) IBOutlet UILabel *reviews;
@property (strong, nonatomic) IBOutlet UILabel *miles;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *categories;

@property (strong, nonatomic) IBOutlet UIImageView *thumb;

- (void) bindPlace: (Place *)place ;

- (void) bindMapItem: (MKMapItem *)mapItem userLocation:(CLLocation *)userLocation;
@end
