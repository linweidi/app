//
//  TableViewCell.m
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()

@end

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) bindData:(id)object {
    NSAssert(NO, @"virtual functions");
}

@end
