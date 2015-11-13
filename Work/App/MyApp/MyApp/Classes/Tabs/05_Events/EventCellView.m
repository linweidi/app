//
//  EventCellView.m
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "Event+Util.h"
#import "EventCategory+Util.h"
#import "Thumbnail+Util.h"
#import "EventCellView.h"

@implementation EventCellView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) bindData:(id)object {
    NSAssert([object isKindOfClass:[Event class]], @"type mismatch");
    Event * event = object;
    //---------------------------------------------------------------------------------------------------------------------------------------------
    self.thumb.layer.cornerRadius = self.thumb.frame.size.width/2;
    self.thumb.layer.masksToBounds = YES;
    
    EventCategory * category = event.category;
    
    [self.thumb setImage:[UIImage imageWithData:category.thumb.data]];
    //[imageUser loadInBackground];
    
    
    self.title.text = event.title;
    self.details.text = event.location;

    
    self.time.text = [self dateToString:event.startTime];
    self.others.text = event.isAlert?@"Alert":@"";

}

- (NSString *) dateToString: (NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH':'mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return [formatter stringFromDate:date];
}

@end
