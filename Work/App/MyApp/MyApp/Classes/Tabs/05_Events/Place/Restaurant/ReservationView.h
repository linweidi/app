//
//  ReservationView.h
//  MyApp
//
//  Created by Linwei Ding on 11/22/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "BaseSimpleViewController.h"

@interface ReservationView : BaseSimpleViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) IBOutlet UITableView *tableView;

@end
