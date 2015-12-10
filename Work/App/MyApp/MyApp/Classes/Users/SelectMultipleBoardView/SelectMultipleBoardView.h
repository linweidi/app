//
//  SelectMultipleBoardView.h
//  MyApp
//
//  Created by Linwei Ding on 12/9/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "CoreDataTableViewController.h"

@protocol SelectMultipleBoardDelegate

@optional
- (void)didSelectMultipleBoards:(NSMutableArray *)boards;
- (void)didSelectMultipleBoardIDs:(NSMutableArray *)boardIDs;
@end


@interface SelectMultipleBoardView : CoreDataTableViewController

@property (nonatomic, weak) id<SelectMultipleBoardDelegate>delegate;

@property (strong, nonatomic) NSMutableArray *selection;

@end
