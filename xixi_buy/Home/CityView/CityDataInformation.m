//
//  CityDataInformation.m
//  xixi_buy
//
//  Created by xixi_wen on 15/8/21.
//  Copyright (c) 2015年 wenjie.li. All rights reserved.
//

#import "CityDataInformation.h"

@implementation CityDataInformation

+ (CityDataInformation *)getInstance
{
    static CityDataInformation *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance=[[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**< 初始化数据源 */
-(NSMutableArray *) getCityData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSMutableArray *tempProvinceArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];

    return tempProvinceArray;
}


@end
