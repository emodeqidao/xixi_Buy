//
//  MyTabBar.h
//  xixi_buy
//
//  Created by wenjie.li on 15/7/29.
//  Copyright (c) 2015年 wenjie.li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"


@interface MyTabBar : UITabBarController

@property (nonatomic, strong) UIView *tabBarView;

@property (nonatomic, assign) BOOL isSelected;  //是否选中
@property (nonatomic, assign) BOOL isHide;   //是否隐藏tabar

@property (nonatomic, strong) HomeViewController *homeView;

- (void)hidesTabBar:(BOOL)is;

@end
