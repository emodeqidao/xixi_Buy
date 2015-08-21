//
//  CityDataInformation.h
//  xixi_buy
//
//  获取城市数据
//
//
//  Created by xixi_wen on 15/8/21.
//  Copyright (c) 2015年 wenjie.li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityDataInformation : NSObject

+ (CityDataInformation *)getInstance;

/**< 初始化数据源 */
-(NSMutableArray *) getCityData;

@end
