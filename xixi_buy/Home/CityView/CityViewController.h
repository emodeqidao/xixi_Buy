//
//  CityViewController.h
//  xixi_buy
//
//  Created by wenjie.li on 15/7/30.
//  Copyright (c) 2015年 wenjie.li. All rights reserved.
//

#import "BaseViewController.h"
#import "CityDataInformation.h"

@interface CityViewController : BaseViewController
<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{

    UITableView *_tableView; /**< 数据列表 */
    UISearchBar *mySearchBar; /**< 搜索框 */
    UISearchDisplayController *searchDisplayController;
    
    NSMutableDictionary *dataDic;
    NSMutableArray *provinceArray; /**< 省份数据源 */
}

@property (nonatomic, copy) void (^cityViewBlock)(NSDictionary *returnCity);

@end
