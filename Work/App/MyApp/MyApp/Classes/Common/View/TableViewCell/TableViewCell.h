//
//  TableViewCell.h
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumb;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *others;

- (void) bindData:(id)object ;

@end
