//
//  TopPlacesProjectTests.m
//  TopPlacesProjectTests
//
//  Created by Linwei Ding on 7/8/15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "FlickrFetcher.h"
#import <XCTest/XCTest.h>

@interface TopPlacesProjectTests : XCTestCase
@property (nonatomic, strong) NSDictionary * places;
@end

@implementation TopPlacesProjectTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(NSDictionary *)places {
    if (!_places) {
        _places = [[NSDictionary alloc] init];
    }
    return _places;
}


- (void)updatePlacesDict {
    
}

//{
//    places =     {
//        "date_start" = 1436400000;
//        "date_stop" = 1436486399;
//        place =         (
//                         {
//                             "_content" = "Moville, Donegal, Ireland";
//                             latitude = "55.190";
//                             longitude = "-7.043";
//                             "photo_count" = 60;
//                             "place_id" = LsVt3MFUVLsd61s;
//                             "place_type" = locality;
//                             "place_type_id" = 7;
//                             "place_url" = "/Ireland/Donegal/Moville";
//                             timezone = "Europe/Dublin";
//                             "woe_name" = Moville;
//                             woeid = 561765;
//                         },
//                         
- (void)testExample
{
    
     NSLog(@"the places is:\n%@", self.places);
    XCTAssert(YES, @"this is yes");
    NSURL *urlTopPlaces = [FlickrFetcher URLforTopPlaces];
    NSAssert(urlTopPlaces, @"url access fails!!\n");
    
    //[self.refreshControl beginRefreshing];
    
    if (urlTopPlaces) {
        
        
        dispatch_queue_t downloadQueue = dispatch_queue_create("download queue", NULL);
        dispatch_async(downloadQueue, ^{
            NSData * dataTopPlaces = [NSData dataWithContentsOfURL:urlTopPlaces];
            NSAssert(urlTopPlaces, @"download of top places fails!!\n");
            if (dataTopPlaces) {
                NSDictionary *propertyListRes = [NSJSONSerialization JSONObjectWithData:dataTopPlaces options:0 error:NULL];
               // dispatch_async(dispatch_get_main_queue(), ^{
                    //[self.refreshControl endRefreshing];
                    self.places = propertyListRes;
                    NSLog(@"the places is:\n%@", self.places);
                //});
            }
        });
        
    }
    //CFRunLoopStop(CFRunLoopGetMain());
    sleep(10000);
}

@end
