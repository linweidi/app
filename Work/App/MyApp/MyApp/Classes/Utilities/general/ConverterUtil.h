//
//  ConverterUtil.h
//  MyApp
//
//  Created by Linwei Ding on 11/20/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConverterUtil : NSObject

+ (ConverterUtil *)sharedUtil;

- (NSString *)stringFromDate:(NSDate *)date;

- (NSDate *) dateFromString:(NSString *)dateStr ;

- (NSDate *) dateFromStringShort:(NSString *)dateStr ;

- (NSString *)stringFromDateShort:(NSDate *)date ;

- (NSDate *) dateFromStringTimeShort:(NSString *)dateStr ;

- (NSString *)stringFromDateTimeShort:(NSDate *)date ;

//- (NSString *) timeStringFromDate: (NSDate *)date ;

- (NSString *) starString:(int) count;

@end
