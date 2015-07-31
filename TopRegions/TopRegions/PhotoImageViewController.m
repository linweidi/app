	//
//  PhotoImageViewController.m
//  TopPlacesProject
//
//  Created by Linwei Ding on 7/10/15.
//  Copyright (c) 2015 Linwei Ding. All rights reserved.
//

#import "FlickrFetcher.h"
#import "PhotoImageViewController.h"

@interface PhotoImageViewController () <UIScrollViewDelegate, UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PhotoImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initScrollViewZoom {
    // next three lines are necessary for zooming
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.delegate = self;
}

#pragma mark -- Properties
-(void)setPhoto:(Photo *)photo {
    _photo   = photo;
    
    [self fetchPhotoImage];
    
    [self initScrollViewZoom];
}

-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    
    return _imageView;
}

-(UIImage *)image {
    return self.imageView.image;
}

-(void)setScrollView:(UIScrollView *)scrollView {
       _scrollView = scrollView;
    
    self.scrollView.zoomScale = 1.0;
    
    [self initScrollViewZoom];
    
    self.imageView.frame = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
    
    [self.scrollView addSubview:self.imageView];
    
    self.scrollView.contentSize = self.image.size;
    
    
    //control the scale
    float widthScale = self.image.size.width/self.scrollView.bounds.size.width;
    float heightScale =self.image.size.height/self.scrollView.bounds.size.height;
    
    
    //if (self.image.size.width> self.scrollView.bounds.size.width && self.imageView.frame.size.height>self.scrollView.bounds.size.height) {
            self.scrollView.zoomScale = (widthScale<heightScale)?1/widthScale:1/heightScale;
    //}

}

-(void)setImage:(UIImage *)image {
    
        self.scrollView.zoomScale = 1.0;
    
    self.imageView.image = image;
    
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    [self.scrollView addSubview:self.imageView];
    
    self.scrollView.contentSize = self.image.size;
    
    
    //control the scale
    float widthScale = self.image.size.width/self.scrollView.bounds.size.width;
    float heightScale =self.image.size.height/self.scrollView.bounds.size.height;
    
    
    //if (self.imageView.frame.size.width > self.scrollView.bounds.size.width && self.imageView.frame.size.height>self.scrollView.bounds.size.height) {
        self.scrollView.zoomScale = (widthScale<heightScale)?1/widthScale:1/heightScale;
    //}
}

#pragma mark -- Functions
- (void) fetchPhotoImage {
    NSAssert(self.photo, @"photo id is nil or empty");
    
    [self.activityIndicator startAnimating];
    
    NSURL *urlPhoto = [NSURL URLWithString:self.photo.imageURL];
    

    
    NSAssert(urlPhoto, @"url access fails!!\n");

    
    if (urlPhoto) {
        
        NSURLRequest *request = [NSURLRequest requestWithURL:urlPhoto];
       
        
        // another configuration option is backgroundSessionConfiguration (multitasking API required though)
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        
        // create the session without specifying a queue to run completion handler on (thus, not main queue)
        // we also don't specify a delegate (since completion handler is all we need)
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
        completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
            // this handler is not executing on the main queue, so we can't do UI directly here
            if (!error) {
                if ([request.URL isEqual:urlPhoto]) {
                    // UIImage is an exception to the "can't do UI here"
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                    // but calling "self.image =" is definitely not an exception to that!
                    // so we must dispatch this back to the main queue
                    dispatch_async(dispatch_get_main_queue(), ^{ self.image = image;
                        [self.activityIndicator stopAnimating];
                    
                    });
                }
            }
        }];
        [task resume]; // don't forget that all NSURLSession tasks start out suspended!
         ////////////////////////////////////////////////////////////////////////////////
        ////////////////////Use download by URL directly/////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
//        dispatch_queue_t downloadQueue = dispatch_queue_create("download queue", NULL);
//        
//        dispatch_async(downloadQueue, ^{
//            NSData * dataPhoto = [NSData dataWithContentsOfURL:urlPhoto];
//            NSAssert(dataPhoto, @"download of image fails!!\n");
//            
//            
//            if (dataPhoto) {
//
//                
//
//                dispatch_async(dispatch_get_main_queue(), ^{
////                    NSAssert([self.scrollView.subviews count]==1, @"scroll view account is called twice, count is %d",  [self.scrollView.subviews count]);
//                    NSLog(@"the view coutn is %d",  [self.scrollView.subviews count]);
//                    UIImage *image = [UIImage imageWithData:dataPhoto];
//                    
//                    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//                    
//                    [imageView sizeToFit];
//                    
//                    [self.scrollView addSubview:imageView];
//                    
//                    self.scrollView.contentSize = imageView.frame.size;
//                    
//                    [self.activityIndicator stopAnimating];
//                });
//            }
//        });
        
    }
}


#pragma mark -- Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)awakeFromNib
{
    self.splitViewController.delegate = self;
}

- (BOOL)splitViewController:(UISplitViewController *)svc
   shouldHideViewController:(UIViewController *)vc
              inOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
}

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = aViewController.title;
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.leftBarButtonItem = nil;
}

@end
