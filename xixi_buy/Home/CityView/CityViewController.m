//
//  CityViewController.m
//  xixi_buy
//
//  Created by wenjie.li on 15/7/30.
//  Copyright (c) 2015年 wenjie.li. All rights reserved.
//

#import "CityViewController.h"
#import "CityCell.h"

@interface CityViewController ()

@end

@implementation CityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self initView];
    [self initCityData];

    
    self.view.backgroundColor = [UIColor brownColor];
    // 获取系统自带滑动手势的target对象
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = (id)self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

-(void) handleNavigationTransition :(UIGestureRecognizer *)gestureRecognizer
{
    [self popBack:nil];
}


#pragma mark
-(void) initNav
{
    [super initNav];
    self.title = @"选择城市";
    [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
}

- (void)popBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [TABBAR hidesTabBar:NO];
}

#pragma mark
- (void) initView
{
    //初始化 搜索
    mySearchBar = [[UISearchBar alloc]init];
    mySearchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44);
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"输入城市名称或拼音查询"];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
    //初始化列表
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [_tableView setTableHeaderView:mySearchBar];
}

-(void)viewWillLayoutSubviews
{
    if(self.searchDisplayController.isActive)
    {
        [UIView animateWithDuration:0.001 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }completion:nil];
    }
    [super viewWillLayoutSubviews];
}



#pragma mark
/**< 初始化数据源 */
- (void)initCityData
{
    provinceArray = [[CityDataInformation getInstance] getCityData];
    [_tableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return provinceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tempArr = provinceArray[section][@"cities"];
    return tempArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cityCell_id";
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil)
    {
        cell = [[CityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSArray *tempArr = provinceArray[indexPath.section][@"cities"];
    cell.cityLabel.text = tempArr[indexPath.row];
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"cityHeaderSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    if (headerView == nil)
    {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(5, 0, 200, 30);
        titleLabel.textColor = [UIColor purpleColor];
        titleLabel.tag = 100;
        [headerView addSubview:titleLabel];
    }
    
    UILabel *titleLabel = (UILabel *)[headerView viewWithTag:100];
    titleLabel.text = provinceArray[section][@"state"];

    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cityViewBlock)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",indexPath.row],@"cityName",nil];
        self.cityViewBlock(dic);
    }
    
    [self popBack:nil];
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
