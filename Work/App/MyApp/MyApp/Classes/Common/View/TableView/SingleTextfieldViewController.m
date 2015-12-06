//
//  SingleTextfieldViewController.m
//  MyApp
//
//  Created by Linwei Ding on 11/12/15.
//  Copyright (c) 2015 Linweiding. All rights reserved.
//
#import "ConverterUtil.h"
#import "SingleTextfieldViewController.h"

@interface SingleTextfieldViewController ()

@property (strong, nonatomic) IBOutlet UITableViewCell *textCell;

@property (strong, nonatomic) NSString * titleText;
@property (strong, nonatomic) NSString * defaultText;
@property (strong, nonatomic) UIBarButtonItem * saveButton;
@end

@implementation SingleTextfieldViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (instancetype) initWithTitle:(NSString *)title text:(NSString *)text {
    
    self = [super init];
    if (self) {
        self.titleText = title;
        self.defaultText = text;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.textfield.
    self.title = self.titleText;
    
    self.textfield.text = self.defaultText;
    self.textfield.placeholder = self.defaultText;
    
    NSMutableArray * rightBarButtons = [[NSMutableArray alloc] init];
    
    self.saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(actionSaveButton)];
    
    [rightBarButtons addObject: self.saveButton];
    // add switch view button
    self.navigationItem.rightBarButtonItems = rightBarButtons;
    
    if (self.dateInputView) {
        [self.textfield setInputView:self.datePicker];
        if (self.defaultText) {
            self.datePicker.date = [[ConverterUtil sharedUtil] dateFromStringShort:self.defaultText];
        }
        else {
            self.datePicker.date = [NSDate date];
        }
        
    }
}



- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	//[self.textfield becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self dismissKeyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- text field
- (void)dismissKeyboard {
	[self.view endEditing:YES];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self dismissKeyboard];
    //[self.navigationController popViewControllerAnimated:YES];
    return YES;
}

#pragma mark -- action on button
- (void) actionSaveButton {
    [self.delegate updateTextfield:self.textfield.text indexPath:self.indexPath];
    [self dismissKeyboard];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titleText;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	return self.textCell;
}

#pragma mark -- date picker
- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker =[[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.hidden = NO;
        
        [self.datePicker addTarget:self action:@selector(updateDateTextView:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    return _datePicker;
}

- (void) updateDateTextView: (id)sender {
    self.textfield.text =  [[ConverterUtil sharedUtil] stringFromDateShort:self.datePicker.date];
}


@end
