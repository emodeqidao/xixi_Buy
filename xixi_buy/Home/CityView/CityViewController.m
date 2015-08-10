//
//  CityViewController.m
//  xixi_buy
//
//  Created by wenjie.li on 15/7/30.
//  Copyright (c) 2015年 wenjie.li. All rights reserved.
//

#import "CityViewController.h"

@interface CityViewController ()

@end

@implementation CityViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self hideNavBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self initSearhBar];
    [self initCityData];

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
- (void) initSearhBar
{
    mySearchBar = [[UISearchBar alloc]init];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"输入城市名称或拼音查询"];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;

    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, 320, CGRectGetHeight(self.view.frame));
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [_tableView setTableHeaderView:mySearchBar];
    
    if (is_IOS_7)
        //分割线的位置不带偏移
        _tableView.separatorInset = UIEdgeInsetsZero;

}

#pragma mark
/**< 初始化数据源 */
- (void)initCityData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    provinceArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@",provinceArray);
    
    for (NSDictionary *item in provinceArray)
    {
        NSLog(@"%@",item);
    }
    
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
    static NSString *cellId = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSArray *tempArr = provinceArray[indexPath.section][@"cities"];
    cell.textLabel.text = tempArr[indexPath.row];
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(5, 0, 200, 30);
    titleLabel.textColor = [UIColor purpleColor];
    titleLabel.text = provinceArray[section][@"state"];
    return titleLabel;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cityViewBlock) {
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
