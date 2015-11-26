//
//  PlacePropertyView.m
//  MyApp
//
//  Created by Linwei Ding on 11/22/15.
//  Copyright © 2015 Linweiding. All rights reserved.
//

#import "Place+Util.h"
#import "TwoLabelTVCell.h"
#import "ConverterUtil.h"
#import <MapKit/MapKit.h>
#import "PlacePropertyView.h"

#define PLACE_PROPERTY_VIEW_SECTION_MAP_INDEX 0
#define PLACE_PROPERTY_VIEW_SECTION_PHOTOS_INDEX 1
#define PLACE_PROPERTY_VIEW_SECTION_OTHERS_INDEX 2
#define PLACE_PROPERTY_VIEW_SECTION_REVIEWS_INDEX 3

@interface PlacePropertyView  () <MKMapViewDelegate>
//@property (strong, nonatomic) IBOutlet UITableViewCell *mapCell;
//@property (strong, nonatomic) IBOutlet UITableViewCell *reviewCell;
//@property (strong, nonatomic) IBOutlet UITableViewCell *photoButtonCell;
//@property (strong, nonatomic) IBOutlet UIView *headerView;
//
//@property (strong, nonatomic) UITableViewCell * locationCell;
//@property (strong, nonatomic) TwoLabelTVCell * priceCell;
//@property (strong, nonatomic) TwoLabelTVCell * parkingCell;
//@property (strong, nonatomic) TwoLabelTVCell * photoCell;
//
//@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
//@property (strong, nonatomic) IBOutlet UILabel *starLabel;
//@property (strong, nonatomic) IBOutlet UILabel *hourLabel;
//@property (strong, nonatomic) IBOutlet UILabel *reviewNumLabel;
//@property (strong, nonatomic) IBOutlet UILabel *likesLabel;
//@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
//@property (strong, nonatomic) IBOutlet UILabel *statusLabel;


@property (strong, nonatomic) UITableViewCell *mapCell;
@property (strong, nonatomic) UITableViewCell *reviewCell;
@property (strong, nonatomic) UITableViewCell *photoButtonCell;
@property (strong, nonatomic) UIView *headerView;

@property (strong, nonatomic) UITableViewCell * locationCell;
@property (strong, nonatomic) UITableViewCell * priceCell;
@property (strong, nonatomic) UITableViewCell * parkingCell;
@property (strong, nonatomic) UITableViewCell * photoCell;

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *starLabel;
@property (strong, nonatomic) UILabel *hourLabel;
@property (strong, nonatomic) UILabel *reviewNumLabel;
@property (strong, nonatomic) UILabel *likesLabel;
@property (strong, nonatomic) UILabel *distanceLabel;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) Place * place;

@end

@implementation PlacePropertyView

- (instancetype)initWithPlace:(Place *)place
{
    self = [super init];
    if (self) {
        self.place = place;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateCellContents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateCellContents {
    ConverterUtil *converter = [ConverterUtil sharedUtil];
    self.nameLabel.text = self.place.name;
    self.starLabel.text = self.place.name;
    self.hourLabel.text = [NSString stringWithFormat:@"Hours: %@ ~ %@", [converter stringFromDateTimeShort:self.place.openTime], [converter stringFromDateTimeShort:self.place.closeTime]];
    //self.reviewNumLabel.text = self.place.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger ret = 0;

    
    switch (section) {
        case PLACE_PROPERTY_VIEW_SECTION_MAP_INDEX:
            ret = 2;
            break;
        case PLACE_PROPERTY_VIEW_SECTION_PHOTOS_INDEX:
            ret = 2;
            break;
        case PLACE_PROPERTY_VIEW_SECTION_OTHERS_INDEX:
            ret = 2;
            break;
        case PLACE_PROPERTY_VIEW_SECTION_REVIEWS_INDEX:
            ret = 1;
            break;
        default:
            break;
    }
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    //[tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil) {
        switch (indexPath.section) {
            case PLACE_PROPERTY_VIEW_SECTION_MAP_INDEX:
                if (indexPath.row == 0) {
                    // location
                    cell = self.locationCell;
                }
                if (indexPath.row == 1) {
                    //map
                    cell = self.mapCell;
                }
                break;
            case PLACE_PROPERTY_VIEW_SECTION_PHOTOS_INDEX:
                if (indexPath.row == 0) {
                    //photo cell
                    cell = self.photoCell;
                    
                }
                if (indexPath.row == 1) {
                    cell = self.photoButtonCell;
                }
                break;
            case PLACE_PROPERTY_VIEW_SECTION_OTHERS_INDEX:
                if (indexPath.row == 0) {
                    cell = self.priceCell;
                }
                if (indexPath.row == 1) {
                    cell = self.parkingCell;
                }
                break;
            case PLACE_PROPERTY_VIEW_SECTION_REVIEWS_INDEX:
                if (indexPath.row == 0) {
                    cell = self.reviewCell;
                }
                break;
            default:
                break;
        }
    }
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	if (section == 1) return @"Members";
//	return nil;
//}

#pragma mark - Table view delegate


//#define PLACE_PROPERTY_VIEW_SECTION_MAP_INDEX 0
//#define PLACE_PROPERTY_VIEW_SECTION_PHOTOS_INDEX 1
//#define PLACE_PROPERTY_VIEW_SECTION_OTHERS_INDEX 2
//#define PLACE_PROPERTY_VIEW_SECTION_REVIEWS_INDEX 3
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case PLACE_PROPERTY_VIEW_SECTION_MAP_INDEX:
            if (indexPath.row == 1) {
                //cell = self.categoryCell;
                [self actionMap];
            }
            break;
        case PLACE_PROPERTY_VIEW_SECTION_PHOTOS_INDEX:
            if (indexPath.row == 1) {
                //ell = self.endTime;
                [self actionPhotos];
            }
            break;
        case PLACE_PROPERTY_VIEW_SECTION_OTHERS_INDEX:
            break;
        case PLACE_PROPERTY_VIEW_SECTION_REVIEWS_INDEX:
            if (indexPath.row == 0) {
                //cell = self.membersCell;
                [self actionReviews];
            }
            break;
        default:
            break;
    }
}

- (void) actionMap {
    UIViewController * mapVC = [[UIViewController alloc] init];
    MKMapView * mapView = [[MKMapView alloc] initWithFrame:mapVC.view.bounds];
    [mapVC.view addSubview:mapView];
    
    [mapView addAnnotation:self.place];
    [mapView showAnnotations:@[self.place] animated:YES];
    mapView.showsUserLocation = YES;
}

- (void) actionPhotos {
    
}

- (void) actionReviews {
    
}

#pragma mark -- map delegate
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString * reuserID = @"CompanyMarkAnnotation";
    MKAnnotationView * annotView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuserID];
    if (!annotView) {
        annotView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuserID];
        annotView.canShowCallout = YES;
        annotView.image = [UIImage imageNamed:@"tab_recent"];
    }
    
    return annotView;
}



#pragma mark -- cell view
//@property (strong, nonatomic) UITableViewCell *mapCell;
//@property (strong, nonatomic) UITableViewCell * locationCell;
//@property (strong, nonatomic) UITableViewCell *reviewCell;
//@property (strong, nonatomic) UITableViewCell *photoButtonCell;
//@property (strong, nonatomic) UIView *headerView;
//

//@property (strong, nonatomic) UITableViewCell * priceCell;
//@property (strong, nonatomic) UITableViewCell * parkingCell;
//@property (strong, nonatomic) UITableViewCell * photoCell;
- (UITableViewCell *)mapCell {
    if (!_mapCell) {
        _mapCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        UIButton * button = [[UIButton alloc] initWithFrame:_mapCell.contentView.bounds];
//        [button setTitle:@"Map" forState:UIControlStateNormal];
//        [_mapCell.contentView addSubview:button];
        _mapCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _mapCell.textLabel.text = @"Map";
    }
    return _mapCell;
}

- (UITableViewCell *)locationCell {
    if (!_locationCell) {
        _locationCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        _locationCell.textLabel.textAlignment = NSTextAlignmentCenter;
        _locationCell.textLabel.text = @"address/location here";
    }
    return _locationCell;
}

- (UITableViewCell *)priceCell {
    if (!_priceCell) {
        _priceCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _priceCell.textLabel.text = @"Price";
        _priceCell.detailTextLabel.text = [[ConverterUtil sharedUtil] starString:0];
    }
    return _priceCell;
}

- (UITableViewCell *)parkingCell {
    if (!_parkingCell) {
        _parkingCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _parkingCell.textLabel.text = @"Parking";
        _parkingCell.detailTextLabel.text = [[ConverterUtil sharedUtil] starString:0];
    }
    return _parkingCell;
}

- (UITableViewCell *)photoButtonCell {
    if (!_photoButtonCell) {
        _photoButtonCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        UIButton * button = [[UIButton alloc] initWithFrame:_parkingCell.contentView.bounds];
//        [button setTitle:@"Photo" forState:UIControlStateNormal];
//        [_parkingCell.contentView addSubview:button];
        _photoButtonCell.textLabel.text = @"Photo";
        _photoButtonCell.textLabel.textAlignment = NSTextAlignmentCenter;
        _photoButtonCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return _parkingCell;
}

- (UITableViewCell *)photoCell {
    if (!_photoCell) {
        _photoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        _photoCell.textLabel.text = @"Photo";
        _photoCell.detailTextLabel.text = @"0 counts";
    }
    return _photoCell;
}

-(UITableViewCell *)reviewCell {
    if (!_reviewCell) {
        _reviewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        UIButton * button = [[UIButton alloc] initWithFrame:_parkingCell.contentView.bounds];
//        [button setTitle:@"Photo" forState:UIControlStateNormal];
//        [_parkingCell.contentView addSubview:button];
        _reviewCell.textLabel.text = @"Review";
        _reviewCell.textLabel.textAlignment = NSTextAlignmentCenter;
        _reviewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return _reviewCell;
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
