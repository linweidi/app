//
//  TwoLabelTVCell.h
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoLabelTVCell : UITableViewCell

- (void)bindData:(NSString *)title contents:(NSString *)contents accessory:(UITableViewCellAccessoryType)type ;



@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentsLabel;

@end
