//
//  SingleTextfieldViewController.h
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//

#import "CoreDataTableViewController.h"

@protocol SingleTextfieldVCDelegate  <NSObject>

//@property (strong, nonatomic) NSString * text;

- (void)updateTextfield:(NSString *)text indexPath:(NSIndexPath *)indexPath;
//
//- (void)updateDatePicker:(NSDate *)date indexPath:(NSIndexPath *) indexPath;
//
//- (void)updateTableView:(NSArray *)array indexPath:(NSIndexPath *) indexPath;

@end

@interface SingleTextfieldViewController : CoreDataTableViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSString * text;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@end
