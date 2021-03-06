//
//  HomeViewController.m
//  xixi_buy
//
//  Created by wenjie.li on 15/7/29.
//  Copyright (c) 2015年 wenjie.li. All rights reserved.
//

#import "HomeViewController.h"
#import "CityViewController.h"
#import "otherViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    [self initNav];
    
    [self initView];
}

/**< 初始化nav */
- (void)initNav
{
    self.backButton.hidden = YES;
    
    cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cityBtn setTitle:@"选择城市" forState:UIControlStateNormal];
    cityBtn.frame = CGRectMake(0, 0, 100, 44);
    cityBtn.backgroundColor = [UIColor purpleColor];
    [cityBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cityBtn];
}

- (void)buttonAction:(id)sender
{
    CityViewController *cityView = [[CityViewController alloc] init];
    cityView.cityViewBlock = ^(NSDictionary *returnCity)
    {
        [self reSetCityLabel:returnCity];
    };
    [TABBAR hidesTabBar:YES];
//    cityView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cityView animated:YES];
}

- (void)reSetCityLabel:(NSDictionary *)dicArg
{
    [cityBtn setTitle:[NSString stringWithFormat:@"选择城市-%@",dicArg[@"cityName"]] forState:UIControlStateNormal];
}


-(void) initView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 70, 100, 30);
    [button setTitle:@"to other" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(toOhter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void) toOhter
{
    otherViewController *oh = [[otherViewController alloc] init];
    oh.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:oh animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
