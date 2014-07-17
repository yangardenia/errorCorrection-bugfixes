//
//  MainTabBarController.m
//  BaiKe
//
//  Created by yons on 13-7-29.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "PhoneViewController.h"
#import "SettingViewController.h"
#import "UserCenterViewController.h"
#import "BaseViewController.h"
@interface ViewController ()

@end

@implementation ViewController

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
    self.delegate = self;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    HomeViewController *view1 = [[HomeViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:view1];
    nav1.navigationBar.translucent = NO;
    PhoneViewController *view2 = [[PhoneViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:view2];
    nav2.navigationBar.translucent = NO;
    UserCenterViewController *view4 = [[UserCenterViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:view4];
    nav4.navigationBar.translucent = NO;
    SettingViewController *view3 = [[SettingViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:view3];
    nav3.navigationBar.translucent = NO;

    [tempArray addObject:nav1];
    [tempArray addObject:nav2];
    [tempArray addObject:nav3];
    [tempArray addObject:nav4];
    self.viewControllers = tempArray;
    
}

//- (void) buttonClick:(id)sender {
//    int tag = [sender tag] - 1;
//    BaseViewController *viewController = (BaseViewController *)[self.viewControllers objectAtIndex:tag];
//    if (self.selectedIndex == tag) {
//        [viewController reloadNetwork];
//        return;
//    }
//    if ([self tabBarController:self shouldSelectViewController:viewController]) {
//        self.selectedIndex = tag;
//    }
//}


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL) shouldAutorotate {
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
