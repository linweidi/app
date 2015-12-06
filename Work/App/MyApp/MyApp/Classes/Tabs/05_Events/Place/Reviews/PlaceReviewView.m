//
//  PlaceReviewView.m
//  MyApp
//
//  Created by Linwei Ding on 11/22/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "FeedbacksManager.h"
#import "Feedback.h"
#import "FeedbackTableViewCell.h"
#import "KeyboardListener.h"
#import "PlaceReviewView.h"

typedef enum {
    OneStarRating = 0,
    TwoStarsRating,
    ThreeStarsRating,
    FourStarsRating,
    FiveStarsRating
}Rating;

@interface PlaceReviewView ()

@property (strong,nonatomic) NSMutableArray *feedbacks;
@property (strong,nonatomic) KeyboardListener *keyboardListener;
@property int currentFeedbackRating;

@end


@implementation PlaceReviewView
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//
//    [textField endEditing:YES];
//    
//    
//    return YES;
//    
//}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    if (textField == self.nameField) {
//        [self.nameField becomeFirstResponder];
//    }
//    else {
//        [self.feedbackField becomeFirstResponder];
//    }
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if (textField == self.nameField) {
//        [self.feedbackField becomeFirstResponder];
//    }
//    else {
//        // nothing
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Review";
    
    self.feedbacks = [NSMutableArray arrayWithArray:[[FeedbacksManager sharedManager] loadData]];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    //self.bottomView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self.feedbacksTableView registerNib:[UINib nibWithNibName:@"FeedbackTableViewCell" bundle:nil] forCellReuseIdentifier:@"feedBackCell"];
    
    self.keyboardListener = [[KeyboardListener alloc] initWithScrollView:self.feedbacksTableView andConstraint:self.bottomConstraint];
    
    [self initBottomViewShadow];
    [self initTextFieldsUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Customize UI

- (void)initBottomViewShadow {
    self.bottomView.layer.shadowOpacity = 1.0f;
    self.bottomView.layer.shadowRadius = 1.0f;
    self.bottomView.layer.shadowOffset = CGSizeMake(0, -1);
}

- (void)initTextFieldsUI {
    UIColor *color = [UIColor colorWithRed:130.0/255.0 green:123.0/255.0  blue:120.0/255.0  alpha:1.0f];
    self.nameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.nameField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    self.feedbackField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.feedbackField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedbacks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedbackTableViewCell *cell = (FeedbackTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"feedBackCell"];
    cell.backgroundColor = [UIColor clearColor];
    
    Feedback *feedback = self.feedbacks[indexPath.row];
    
    cell.feedbackNameLabel.text = feedback.name;
    cell.feedbackTextLabel.text = feedback.text;
    [cell updateViewForRating:feedback.numberOfStars.intValue];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedbackTableViewCell *cell  = (FeedbackTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"feedBackCell"];
    
    Feedback *feedback = self.feedbacks[indexPath.row];
    
    cell.feedbackNameLabel.text = feedback.name;
    cell.feedbackTextLabel.text = feedback.text;
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

#pragma mark - Actions

- (IBAction)sendFeedback:(id)sender {
    Feedback *newFeedback = [[Feedback alloc] init];
    newFeedback.name = self.nameField.text;
    newFeedback.text = self.feedbackField.text;
    newFeedback.numberOfStars = [NSNumber numberWithInt:self.currentFeedbackRating];
    [self.feedbacks addObject:newFeedback];
    
    [self.feedbacksTableView reloadData];
    
    self.nameField.text = @"";
    self.feedbackField.text = @"";
    [self.nameField resignFirstResponder];
    [self.feedbackField resignFirstResponder];
}

- (IBAction)onOneStar:(id)sender {
    [self changeRatingFor:OneStarRating];
}

- (IBAction)onTwoStars:(id)sender {
    [self changeRatingFor:TwoStarsRating];
}

- (IBAction)onThreeStars:(id)sender {
    [self changeRatingFor:ThreeStarsRating];
}

- (IBAction)onFourStars:(id)sender {
    [self changeRatingFor:FourStarsRating];
}

- (IBAction)onFiveStars:(id)sender {
    [self changeRatingFor:FiveStarsRating];
}

#pragma mark - Private

- (void)changeRatingFor:(int)newRating {
    self.currentFeedbackRating = newRating;
    
    UIImage *starImage = [UIImage imageNamed:@"star_chosen"];
    UIImage *greyStarImage = [UIImage imageNamed:@"star_unchosen"];
    
    NSArray *arrayOfButtons = @[self.oneStarBtn,self.twoStarsBtn,self.threeStarsBtn,self.fourStarsBtn,self.fiveStarsBtn];
    
    for (int i = 0; i < newRating; i++) {
        UIButton *btn = arrayOfButtons[i];
        [btn setImage:starImage forState:UIControlStateNormal];
    }
    
    for (int i = newRating; i < arrayOfButtons.count; i++) {
        UIButton *btn = arrayOfButtons[i];
        [btn setImage:greyStarImage forState:UIControlStateNormal];
    }
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
