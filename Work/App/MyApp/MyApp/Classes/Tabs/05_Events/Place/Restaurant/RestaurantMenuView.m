//
//  RestaurantMenuView.m
//  MyApp
//
//  Created by Linwei Ding on 11/22/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import "MenuItem.h"
#import "MenuItemsManager.h"
#import "MenuItemTableViewCell.h"
#import "RestaurantMenuView.h"

@interface RestaurantMenuView ()
@property (nonatomic,strong) NSArray *menuItems;

@end

@implementation RestaurantMenuView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    self.menuItems = [[MenuItemsManager sharedManager] loadData];
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
