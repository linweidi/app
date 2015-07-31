//
//  PhotoBaseTableViewController.h
//  TopPlacesProject
//
//  Created by Linwei Ding on 7/10/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBaseTableViewController : UITableViewController

@property (nonatomic, strong) NSArray * photos;

@property (nonatomic, strong) NSUserDefaults *userContext;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)fetchTable:(id)sender ;

- (NSMutableArray *)getUpdatedArrayUserCtxt ;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

- (void) addPhotoToUserContext:(NSDictionary *)photo;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end
