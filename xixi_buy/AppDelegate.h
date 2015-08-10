//
//  AppDelegate.h
//  xixi_buy
//
//  Created by wenjie.li on 15/7/29.
//  Copyright (c) 2015年 wenjie.li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTabBar.h"
#import "LeftSlideViewController.h"
#import "LeftSortsViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MyTabBar *myTab;

@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;

@end

