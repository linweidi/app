//
//  PlaceReviewView.h
//  MyApp
//
//  Created by Linwei Ding on 11/22/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseSimpleViewController.h"

@interface PlaceReviewView : BaseSimpleViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (assign,nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (assign,nonatomic) IBOutlet UITableView *feedbacksTableView;
@property (assign,nonatomic) IBOutlet UITextField *nameField;
@property (assign,nonatomic) IBOutlet UITextField *feedbackField;
@property (assign,nonatomic) IBOutlet UIButton *addFeedbackBtn;

@property (assign,nonatomic) IBOutlet UIView *bottomView;
@property (assign,nonatomic) IBOutlet UIView *nameView;
@property (assign,nonatomic) IBOutlet UIView *feedbackView;
@property (assign,nonatomic) IBOutlet UIView *addBtnView;

@property (assign,nonatomic) IBOutlet UIButton *oneStarBtn;
@property (assign,nonatomic) IBOutlet UIButton *twoStarsBtn;
@property (assign,nonatomic) IBOutlet UIButton *threeStarsBtn;
@property (assign,nonatomic) IBOutlet UIButton *fourStarsBtn;
@property (assign,nonatomic) IBOutlet UIButton *fiveStarsBtn;

- (IBAction)sendFeedback:(id)sender;

- (IBAction)onOneStar:(id)sender;
- (IBAction)onTwoStars:(id)sender;
- (IBAction)onThreeStars:(id)sender;
- (IBAction)onFourStars:(id)sender;
- (IBAction)onFiveStars:(id)sender;

@end
