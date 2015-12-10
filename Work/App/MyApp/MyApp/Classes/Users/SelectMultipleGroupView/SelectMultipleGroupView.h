//
//  SelectMultipleGroupView.h
//  MyApp
//
//  Created by Linwei Ding on 12/9/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "CoreDataTableViewController.h"

@protocol SelectMultipleGroupDelegate

@optional
- (void)didSelectMultipleGroups:(NSMutableArray *)groups;
- (void)didSelectMultipleGroupIDs:(NSMutableArray *)groupIDs;
@end


@interface SelectMultipleGroupView : CoreDataTableViewController

@property (nonatomic, weak) id<SelectMultipleGroupDelegate>delegate;

@property (strong, nonatomic) NSMutableArray *selection;

@end
