//
//  PlacesTableViewController.h
//  TopPlacesProject
//
//  Created by Linwei Ding on 7/8/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEBUG_PLACE

@interface PlacesTableViewController : UITableViewController

@property (nonatomic, strong) NSArray * places;
//@property (nonatomic, strong) NSArray * place;
@property (nonatomic, strong) NSMutableDictionary * placesDict;
@property (nonatomic, strong) NSMutableArray * countryNames;
@end
