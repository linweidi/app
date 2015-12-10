//
//  EventSettingsView.h
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PlaceListView.h"
#import "SelectMultiplePeopleView.h"
#import "SingleTextfieldViewController.h"
#import "SelectMultipleGroupView.h"
#import "SelectMultipleBoardView.h"

@class Event;
@interface EventSettingsView : UITableViewController <SingleTextfieldVCDelegate, PlaceListViewDelegate, SelectMultiplePeopleDelegate, SelectMultipleBoardDelegate, SelectMultipleGroupDelegate>

- (instancetype)initWithEvent:(NSString *)eventID;

- (void)updateTextfield:(NSString *)text indexPath:(NSIndexPath *)indexPath;
//@property (strong, nonatomic) NSString * text;

- (void)didSelectSinglePlaceMapItem:(MKMapItem *)place catLocalID:(NSString *)localID;

- (void)didSelectSinglePlace:(Place *)place;

- (void)didSelectMultipleUserIDs:(NSMutableArray *)userIDs;
- (void)didSelectMultipleGroupIDs:(NSMutableArray *)groupIDs;
- (void)didSelectMultipleBoardIDs:(NSMutableArray *)boardIDs;
//- (void)didSelectMultipleUsers:(NSMutableArray *)users;

@end
