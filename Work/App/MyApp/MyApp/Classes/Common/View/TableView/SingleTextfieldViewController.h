//
//  SingleTextfieldViewController.h
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol SingleTextfieldVCDelegate  <NSObject>

//@property (strong, nonatomic) NSString * text;

- (void)updateTextfield:(NSString *)text indexPath:(NSIndexPath *)indexPath;
//
//- (void)updateDatePicker:(NSDate *)date indexPath:(NSIndexPath *) indexPath;
//
//- (void)updateTableView:(NSArray *)array indexPath:(NSIndexPath *) indexPath;

@end

@interface SingleTextfieldViewController : UITableViewController <UITextFieldDelegate>

- (instancetype) initWithTitle:(NSString *)title text:(NSString *)text;



@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property (strong, nonatomic) UIDatePicker * datePicker;

@property (strong, nonatomic) id <SingleTextfieldVCDelegate> delegate;

@property (strong, nonatomic) NSIndexPath * indexPath;

@property (nonatomic) BOOL dateInputView;
@end
