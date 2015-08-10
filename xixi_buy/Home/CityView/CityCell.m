//
//  CityCell.m
//  xixi_buy
//
//  Created by xixi_wen on 15/8/10.
//  Copyright (c) 2015年 wenjie.li. All rights reserved.
//

#import "CityCell.h"

@implementation CityCell
@synthesize cityLabel;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        cityLabel = [[UILabel alloc] init];
        cityLabel.frame = CGRectMake(10, 0, 150, 30);
        cityLabel.text = @"哈哈";
        cityLabel.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:cityLabel];
        
    }
    
    return self;
}

@end
