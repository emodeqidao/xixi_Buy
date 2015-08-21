//
//  MyTabBar.m
//  xixi_buy
//
//  Created by wenjie.li on 15/7/29.
//  Copyright (c) 2015年 wenjie.li. All rights reserved.
//

#import "MyTabBar.h"
#import "AppDelegate.h"

@interface MyTabBar ()

@end

@implementation MyTabBar
@synthesize homeView;
@synthesize isSelected;
@synthesize isHide;

- (id)init {
    if (self = [super init]) {
        
        isSelected = YES;
        isHide = YES;
    
        homeView = [[HomeViewController alloc] init];
        homeView.view.backgroundColor = [UIColor redColor];
        
        UIViewController *weiDiaoView = [[UIViewController alloc] init];
        weiDiaoView.view.backgroundColor = [UIColor cyanColor];
        
        UIViewController *threeView   = [[UIViewController alloc] init];
        threeView.view.backgroundColor = [UIColor greenColor];
        
        UIViewController *fourView    = [[UIViewController alloc] init];
        fourView.view.backgroundColor = [UIColor purpleColor];
        
        UIViewController *myView      = [[UIViewController alloc] init];
        myView.view.backgroundColor = [UIColor blueColor];
        
        UINavigationController *homeNav    = [[UINavigationController alloc]
                                              initWithRootViewController:homeView];
        UINavigationController *weiDiaoNav = [[UINavigationController alloc]
                                              initWithRootViewController:weiDiaoView];
        UINavigationController *threeNav   = [[UINavigationController alloc]
                                              initWithRootViewController:threeView];
        UINavigationController *fourNav    = [[UINavigationController alloc]
                                              initWithRootViewController:fourView];
        UINavigationController *myNav      = [[UINavigationController alloc]
                                              initWithRootViewController:myView];
//        homeView.navigationController.navigationBarHidden     = YES;
//        weiDiaoView.navigationController.navigationBarHidden  = YES;
//        threeView.navigationController.navigationBarHidden    = YES;
//        fourView.navigationController.navigationBarHidden     = YES;
//        myView.navigationController.navigationBarHidden       = YES;
        
//        homeView.title = @"首页";
        weiDiaoView.title = @"附近";
        threeView.title = @"搜索";
        fourView.title = @"发现";
        myView.title = @"个人中心";
        
        
        
        self.viewControllers = @[homeNav, weiDiaoNav, threeNav, fourNav, myNav];
        
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.tabBar.backgroundImage = image;
        self.tabBar.shadowImage = image;
        
        self.tabBarView = [[UIView alloc] init];
        self.tabBarView.frame = CGRectMake(0, 0, CGRectGetWidth(self.tabBar.frame), CGRectGetHeight(self.tabBar.frame));
        self.tabBarView.backgroundColor = SetColor(GrayColor_f9f);
        [self.tabBar addSubview:self.tabBarView];
        
        UILabel *line = [[UILabel alloc] init];
        line.frame = CGRectMake(0, 0, CGRectGetWidth(self.tabBarView.frame), 0.5);
        line.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
        [self.tabBarView addSubview:line];
        

        // (0 0; 64 49)
        int w = 320/self.viewControllers.count;
        int h = self.tabBar.frame.size.height;
        float distance = ([[UIScreen mainScreen] bounds].size.width-w*5)/6;
        NSArray *defaultImageArr = @[@"home", @"hood", @"homeSearch", @"_found", @"_acc"];
        NSArray *seletedArr = @[@"home_s", @"hood_s", @"homeSearch", @"_found_s", @"_acc_s"];
        NSArray *textArr = @[@"首页", @"附近", @"  ", @"发现", @"我"];
        for (NSInteger i = 0; i < self.viewControllers.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (i==2)
            {
                //532 × 531     128,0,64,49
                btn.frame = CGRectMake(i*w+distance*(i+1), 0, w, h);
                btn.imageEdgeInsets = UIEdgeInsetsMake(7, 13, 4, 13);
                [self.view bringSubviewToFront:btn];
            }
            else
            {
                btn.frame = CGRectMake(i*w+distance*(i+1), 0, w, h);
                btn.imageEdgeInsets = UIEdgeInsetsMake(8, 22, 21, 22);
                btn.titleEdgeInsets = UIEdgeInsetsMake(22, -25, -5, 15);
            }
            
            NSLogRect(btn.frame);

            [btn setImage:[UIImage imageNamed:defaultImageArr[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:seletedArr[i]] forState:UIControlStateHighlighted];
            [btn setImage:[UIImage imageNamed:seletedArr[i]] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:textArr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [btn setTitleColor:SetColor(BlackColor_597) forState:UIControlStateNormal];
            [btn setTitleColor:SetColor(BlackColor_597) forState:UIControlStateHighlighted];
            [btn setTitleColor:SetColor(OrangerColor_f29) forState:UIControlStateSelected];
            [self.tabBarView addSubview:btn];
            btn.selected = i?NO:YES;
            btn.tag = i;
        }
    }
    return self;
}


- (void)btnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;

    
    for (UIButton *b in self.tabBarView.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            b.selected = NO;
        }
    }
    btn.selected = YES;
    self.selectedIndex = btn.tag;
    
    NSLog(@"%ld",btn.tag);
}

#pragma mark 隐藏TabBar
- (void)hidesTabBar:(BOOL)is
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    if (is&&self.isHide) {
        self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y+69, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
        self.isHide = false;
        
        LetSlideEnabled(NO);
    }
    else if (!is&&!self.isHide) {
        self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y-69, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
        self.isHide = true;
        
        LetSlideEnabled(YES);
    }
    [UIView commitAnimations];
}

@end
