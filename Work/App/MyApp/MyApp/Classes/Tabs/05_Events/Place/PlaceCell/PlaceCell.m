//
//  PlaceCell.m
//  MyApp
//
//  Created by Linwei Ding on 12/7/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import <AddressBookUI/AddressBookUI.h>
#import "Place+Util.h"
#import "EventCategory+Util.h"
#import "ConverterUtil.h"
#import "PlaceCell.h"
@interface PlaceCell()

@end

@implementation PlaceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) bindPlace: (Place *)place {
    ConverterUtil * converter = [ConverterUtil sharedUtil];
    
    self.name.text = place.title;
    self.stars.text = [converter starString:[place.rankings intValue]];
//    self.hourLabel.text = [NSString stringWithFormat:@"Hours: %@ ~ %@", [converter stringFromDateTimeShort:self.place.openTime], [converter stringFromDateTimeShort:self.place.closeTime]];
    self.reviews.text = @"rev num";
//    self.likesLabel.text = [NSString stringWithFormat:@"%d likes", [self.place.likes intValue]];
    self.miles.text = @"distance";
//    NSDate * currentTime = [converter timeOfDate:[NSDate date]];
//    NSDate * openTime = [converter timeOfDate:self.place.openTime];
//    NSDate * closeTime = [converter timeOfDate:self.place.closeTime];
//    if ([currentTime compare:openTime] == NSOrderedDescending && [currentTime compare:closeTime] == NSOrderedAscending) {
//        self.statusLabel.text = @"Open";
//    }
//    else {
//        self.statusLabel.text = @"Close";
//    }
    
//    //self.reviewNumLabel.text = self.place.
    NSString * catString = @"";
    int index = 0;
    for (EventCategory * category in place.categories) {
        
        
        if (index == [place.categories count] - 1) {
            catString = [catString stringByAppendingString: category.name];
        }
        else {
            catString = [catString stringByAppendingFormat:@"%@, ", category.name];
        }
        index++;
    }
    self.categories.text =
    self.address.text = place.location;
    self.price.text = [[ConverterUtil sharedUtil] dollarString:[place.price intValue]];
//    self.parkingCell.detailTextLabel.text = [[ConverterUtil sharedUtil] starString:[self.place.parking intValue]];
//    self.photoCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu counts", [self.place.photos count]];
}

- (void) bindMapItem:(MKMapItem *)mapItem userLocation:(CLLocation *)userLocation{
    //ConverterUtil * converter = [ConverterUtil sharedUtil];
    
    self.name.text = mapItem.name;
    //self.stars.text = [converter starString:[place.rankings intValue]];
    self.stars.text = @"stars";
    self.reviews.text = @"rev num";

//    NSString * catString = @"";
//    int index = 0;
//    for (EventCategory * category in place.categories) {
//        
//        
//        if (index == [place.categories count] - 1) {
//            catString = [catString stringByAppendingString: category.name];
//        }
//        else {
//            catString = [catString stringByAppendingFormat:@"%@, ", category.name];
//        }
//        index++;
//    }
    
    MKPlacemark * placeMark = mapItem.placemark;
    self.address.text =
    ABCreateStringWithAddressDictionary(placeMark.addressDictionary, NO);
    
    self.price.text = @"price";
#warning TODO add a new view for them
    //[[ConverterUtil sharedUtil] dollarString:[place.price intValue]];
    CLLocation * location = mapItem.placemark.location;
    self.miles.text = [NSString stringWithFormat:@"%f k", [location distanceFromLocation:userLocation]];
    self.categories.text =  [mapItem.url path];
    self.stars.text = mapItem.phoneNumber;
    self.reviews.text = @"";
    self.price.text = @"";
}
@end
