//
//  PlaceMapView.m
//  MyApp
//
//  Created by Linwei Ding on 11/22/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "PlaceMapView.h"

@interface PlaceMapView ()

@end

@implementation PlaceMapView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPreviosLocation:(id)sender {
    NSLog(@"Previous location");
    
    self.distanceLabel.text = @"2,5 Mi";
    self.locationLabel.text = @"21th St & Silent Rd\n(345)123-0987\nPhoenix,AZ 42200";
}

- (IBAction)onNextLocation:(id)sender {
    NSLog(@"Next location");
    
    self.locationLabel.text = @"21th St & Silent Rd\n(345)123-0987\nPhoenix,AZ 42200";
    self.distanceLabel.text = @"2,5 Mi";
}

- (IBAction)onMakeReservation:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank You" message:@"You have booked table. Thanks for your reservation." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
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
