//
//  TwoLabelTVCell.m
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "TwoLabelTVCell.h"

@implementation TwoLabelTVCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void) bindData:(id)object accessory:(UITableViewCellAccessoryType)type {
//    self.accessoryType = type;
//}
//
//- (void) bindData:(id)object {
//    
//}

- (void)bindData:(NSString *)title contents:(NSString *)contents accessory:(UITableViewCellAccessoryType)type {
    self.titleLabel.text = title;
    self.contentsLabel.text = contents;
    self.accessoryType = type;
}

@end
