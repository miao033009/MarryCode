//
//  MasterViewController.m
//  APParallaxHeaderDemo
//
//  Created by Mathias Amnell on 2013-04-12.
//  Copyright (c) 2013 Apping AB. All rights reserved.
//

#import "MasterViewController.h"
#import "UIScrollView+APParallaxHeader.h"
#import "CardView.h"

@interface MasterViewController () <APParallaxViewDelegate> {
    BOOL parallaxWithView;
    CardView *cardView,*cardView1;
        
    CGFloat contentOffsetY;
        
    CGFloat oldContentOffsetY;
        
    CGFloat newContentOffsetY;
}
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"with view" style:UIBarButtonItemStylePlain target:self action:@selector(toggle:)];
//    [self.navigationItem setRightBarButtonItem:barButton];
    [self.navigationController setNavigationBarHidden:YES];
    _cellArray = [NSMutableArray array];
    [self toggle:nil];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CardView" owner:self options:nil];
    cardView1 = [nib objectAtIndex:0];
    //        CardView *cardView = [[CardView alloc] init];
    [cardView1 setFrame:CGRectMake(0,400,0,0)];
    //    [cardView1 setCenter:CGPointMake(0,0)];
    [self.view addSubview:cardView1];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDragging");
    contentOffsetY = scrollView.contentOffset.y;
    [UIView animateWithDuration:0.5 animations:^{
        self.tabBarController.tabBar.frame = CGRectMake(self.tabBarController.tabBar.frame.origin.x, self.tabBarController.tabBar.frame.origin.y+self.tabBarController.tabBar.frame.size.height, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
    } ];
}

// 滚动时调用此方法(手指离开屏幕后)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    
    //NSLog(@"scrollView.contentOffset:%f, %f", scrollView.contentOffset.x, scrollView.contentOffset.y);
    
    newContentOffsetY = scrollView.contentOffset.y;
    
    
    
    if (newContentOffsetY > oldContentOffsetY && oldContentOffsetY > contentOffsetY) {  // 向上滚动
        
        
        
        NSLog(@"up");
        
        
        
    } else if (newContentOffsetY < oldContentOffsetY && oldContentOffsetY < contentOffsetY) { // 向下滚动
        
        
        
        NSLog(@"down");
        
    } else {
        
        
        
        NSLog(@"dragging");
        
    }
    
    
    
    if (scrollView.dragging) {  // 拖拽
        
        
        
        NSLog(@"scrollView.dragging");
        
        
        
        NSLog(@"contentOffsetY: %f", contentOffsetY);
        
        NSLog(@"newContentOffsetY: %f", scrollView.contentOffset.y);
        
        
        
        if ((scrollView.contentOffset.y - contentOffsetY) > 5.0f) {  // 向上拖拽
            
            
            
            // 隐藏导航栏和选项栏
            
            // [self layoutView];
            
//            [self.navigationController setNavigationBarHidden:YES animated:YES];
            
            //[_viewController.navigationController setToolbarHidden:!hidden animated:YES];
            
//            self.tabBarController.tabBar.hidden = YES;
            
            
            
            
        } else if ((contentOffsetY - scrollView.contentOffset.y) > 5.0f) {   // 向下拖拽
            
            
            
            // 显示导航栏和选项栏
            
            //[self layoutView];
            
            
            
//            [self.navigationController setNavigationBarHidden:NO animated:YES];
            
            //[_viewController.navigationController setToolbarHidden:NO animated:YES];
            
            
            
            
            
            
        } else {
            
            
            
        }
        
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    NSLog(@"scrollViewDidEndDragging");
//    oldContentOffsetY = scrollView.contentOffset.y;
    if (!decelerate) {
    [UIView animateWithDuration:0.3 animations:^{
        self.tabBarController.tabBar.frame = CGRectMake(self.tabBarController.tabBar.frame.origin.x, self.tabBarController.tabBar.frame.origin.y-self.tabBarController.tabBar.frame.size.height, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
    } ];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.tabBarController.tabBar.frame = CGRectMake(self.tabBarController.tabBar.frame.origin.x, self.tabBarController.tabBar.frame.origin.y-self.tabBarController.tabBar.frame.size.height, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
    } ];
}

- (void)toggle:(id)sender {
    /**
     *  For demo purposes this view controller either adds a parallaxView with a custom view
     *  or a parallaxView with an image.
     */
    if(parallaxWithView == NO) {
        // add parallax with view
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Rover.jpg"]];
//        [imageView setFrame:CGRectMake(0, 0, 320, 160)];
//        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CardView"owner:self options:nil];
        cardView = [nib objectAtIndex:0];
//        CardView *cardView = [[CardView alloc] init];
        [cardView setFrame:CGRectMake(0,0,320,160)];
        
        [self.tableView addParallaxWithView:cardView andHeight:160 andShadow:NO];
        parallaxWithView = YES;
        
        // Update the toggle button
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"with image" style:UIBarButtonItemStylePlain target:self action:@selector(toggle:)];
        [self.navigationItem setRightBarButtonItem:barButton];
    }
    else {
        // add parallax with image
        [self.tableView addParallaxWithImage:[UIImage imageNamed:@"ParallaxImage.jpg"] andHeight:160 andShadow:YES];
        parallaxWithView = NO;
        
        // Update the toggle button
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"with view" style:UIBarButtonItemStylePlain target:self action:@selector(toggle:)];
        [self.navigationItem setRightBarButtonItem:barButton];
    }
    
    /**
     *  Setting a delegate for the parallaxView will allow you to get callbacks for when the
     *  frame of the parallaxView changes.
     *  Totally optional thou.
     */
    self.tableView.parallaxView.delegate = self;
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellArray.count;
//    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"Row %i", indexPath.row+1];
    return cell;
}

#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview before its frame changes
//    NSLog(@"parallaxView:willChangeFrame: %@", NSStringFromCGRect(frame));
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
//    NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
    [self applyTransparentBackgroundToTheNavigationBar:(180-frame.size.height)/180];
    if (frame.size.height<=64) {
        cardView.cardLabel.hidden = YES;
        self.topLabel.hidden = NO;
        [self.topLabel setTextColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:(180-frame.size.height)/180]];
    }else{
        self.topLabel.hidden = YES;
        cardView.cardLabel.hidden = NO;
    }
//    [self.navigationController.navigationBar setFrame:CGRectMake(0,-self.navigationController.navigationBar.frame.size.height*frame.size.height/224+20*(224-frame.size.height)/224,self.navigationController.navigationBar.frame.size.width,self.navigationController.navigationBar.frame.size.height)];
    
//    [self.navigationController.navigationBar setFrame:CGRectMake(0,-44,self.navigationController.navigationBar.frame.size.width,self.navigationController.navigationBar.frame.size.height)];
}

//| ----------------------------------------------------------------------------
//! Configures the navigation bar to use a transparent background (see-through
//! but without any blur).
//
- (void)applyTransparentBackgroundToTheNavigationBar:(CGFloat)opacity
{
    UIImage *transparentBackground;
    
    // The background of a navigation bar switches from being translucent
    // to transparent when a background image is applied.  The intensity of
    // the background image's alpha channel is inversely related to the
    // transparency of the bar.  That is, a smaller alpha channel intensity
    // results in a more transparent bar and vis-versa.
    //
    // Below, a background image is dynamically generated with the desired
    // opacity.
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, self.navigationController.navigationBar.layer.contentsScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 248.0/255.0, 141.0/255.0, 185.0/255.0, opacity);
    UIRectFill(CGRectMake(0, 0, 1, 1));
    transparentBackground = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // You should use the appearance proxy to customize the appearance of
    // UIKit elements.  However changes made to an element's appearance
    // proxy do not effect any existing instances of that element currently
    // in the view hierarchy.  Normally this is not an issue because you
    // will likely be performing your appearance customizations in
    // -application:didFinishLaunchingWithOptions:.  However, this example
    // allows you to toggle between appearances at runtime which necessitates
    // applying appearance customizations directly to the navigation bar.
    /* id navigationBarAppearance = [UINavigationBar appearanceWhenContainedIn:[NavigationController class], nil]; */
//    id navigationBarAppearance = self.navigationController.navigationBar;
    [self.topView setImage:transparentBackground];
}

- (IBAction)insertCell:(id)sender {
//    [self.tableView beginUpdates];
//    [self.cellArray addObject:@"New Cell"];
//    NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPathOfNewItem]
//                          withRowAnimation:UITableViewRowAnimationTop];
//    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.2 animations:^{
        if (cardView1.frame.size.height==200) {
//            cardView1.center = CGPointMake(0,cardView1.frame.size.height/2);
            [cardView1 setFrame:CGRectMake(0,500,0,0)];
        }else
        {
            
            [cardView1 setFrame:CGRectMake(0,400,375,200)];
        }
    }];
}
@end
