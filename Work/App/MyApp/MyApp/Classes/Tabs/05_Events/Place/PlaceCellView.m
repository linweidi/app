//
//  PlaceCellView.m
//  MyApp
//
//  Created by Linwei Ding on 11/14/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "Place+Util.h"
#import "Thumbnail+Util.h"
#import "PlaceCellView.h"

@implementation PlaceCellView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void) bindData:(id)object {
    NSAssert([object isKindOfClass:[Place class]], @"type mismatch");
    Place * place = object;
    //---------------------------------------------------------------------------------------------------------------------------------------------
    self.thumb.layer.cornerRadius = self.thumb.frame.size.width/2;
    self.thumb.layer.masksToBounds = YES;
    
    
    
//    for (EventCategory * category in place.categories) {
//        [self.thumb setImage:[UIImage imageWithData:category.thumb.data]];
//    }
    [self.thumb setImage:[UIImage imageWithData:place.thumb.data]];
    
    //[imageUser loadInBackground];
    
    
    self.title.text = place.name;
    self.details.text = place.location;
    
    
    self.time.text = [NSString stringWithFormat:@"%@ likes", place.likes];
    self.others.text = [NSString stringWithFormat:@"%@ Stars", place.rankings];
    
}

//- (NSString *) dateToString: (NSDate *)date {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"HH':'mm"];
//    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//    return [formatter stringFromDate:date];
//}


@end
