//
//  OurMenuViewController.m
//  Restaurants
//
//  Created by AppsFoundation on 1/20/15.
//  Copyright (c) 2015 AppsFoundation. All rights reserved.
//

#import "AppHeader.h"
#import "OurMenuViewController.h"
#import "MSViewControllerSlidingPanel.h"
#import "MenuItem.h"
#import "MenuItemsManager.h"
#import "AppDelegate.h"
#import "MenuItemTableViewCell.h"

@interface OurMenuViewController ()

@property (nonatomic,strong) NSArray *menuItems;

@end

@implementation OurMenuViewController

#pragma mark - Lifecycle

- (void)awakeFromNib {
    //listen to managedObjectContext when ready
    #warning remove this line of code, should start not this way
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startMainPage) name:NOTIFICATION_DATA_LOAD_READY object:nil];
}
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startMainPage) name:NOTIFICATION_DATA_LOAD_READY object:nil];
    
    self.menuItems = [[MenuItemsManager sharedManager] loadData];
    

    
//    if ([AppDelegate sharedDelegate].initDone == YES ) {
//        [[AppDelegate sharedDelegate] openMainMenu];
//    }
    
}

- (void) startMainPage {
    if ([AppDelegate sharedDelegate].initDone == YES) {
        //[[AppDelegate sharedDelegate] openMainMenu];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItemTableViewCell *cell = (MenuItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"menuItemCell"];
    
    MenuItem *item = self.menuItems[indexPath.row];
    
    //display data from MenuItems.plist
    cell.menuItemNameLabel.text = item.name;
    cell.ingredientsItemLabel.text = item.ingredients;
    cell.priceItemLabel.text = item.price;
    cell.menuItemImageView.image = [UIImage imageNamed:item.image];
    cell.discountLabel.text = item.discount;
    cell.discountView.hidden = item.discount == nil;
    cell.backgroundColor = [UIColor clearColor];
 
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Actions

- (IBAction)onMenu:(id)sender {
    if ([[self slidingPanelController] sideDisplayed] == MSSPSideDisplayedLeft)
        [[self slidingPanelController] closePanel];
    else
        [[self slidingPanelController] openLeftPanel];
}


@end