//
//  ReservationView.m
//  MyApp
//
//  Created by Linwei Ding on 11/22/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "ReservationView.h"

#import "ReservationLocationTableViewCell.h"
#import "NumberOfGuestsTableViewCell.h"
#import "PhoneNumberTableViewCell.h"
#import "MakeReservationTableViewCell.h"

@interface ReservationView ()

@end

typedef enum {
    ReservationCellLocation = 0,
    ReservationCellNumberOfGuests,
    ReservationCellPhone,
    ReservationCellMakeReservation,
    ReservationCellCount
}ReservationCell;

@implementation ReservationView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ReservationCellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case ReservationCellLocation: {
            ReservationLocationTableViewCell *cell = (ReservationLocationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"reservationCell"];
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
        case ReservationCellNumberOfGuests: {
            NumberOfGuestsTableViewCell *cell = (NumberOfGuestsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"numberOfGuestsCell"];
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
        case ReservationCellPhone: {
            PhoneNumberTableViewCell *cell = (PhoneNumberTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"phoneNumberCell"];
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
        case ReservationCellMakeReservation: {
            MakeReservationTableViewCell *cell = (MakeReservationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"makeReservationCell"];
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == ReservationCellMakeReservation) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank You" message:@"You have booked table. Thanks for your reservation." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case ReservationCellLocation: {
            return 228.0f;
        }
        case ReservationCellNumberOfGuests: {
            return 140.0f;
        }
        case ReservationCellPhone: {
            return 140.0f;
        }
        case ReservationCellMakeReservation: {
            return 98.0f;
        }
    }
    
    return 0.0f;

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
