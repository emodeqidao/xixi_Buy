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
        cityLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:cityLabel];
        
        //虚线
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cityLabel.frame), CGRectGetWidth(self.frame), 1)];
        imageView1.alpha = 0.5;
        [self.contentView addSubview:imageView1];
        
        UIGraphicsBeginImageContext(imageView1.frame.size);   //开始画线
        [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width, imageView1.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
        CGFloat lengths[] = {1,3};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, [UIColor redColor].CGColor);
        
        CGContextSetLineDash(line, 0, lengths, 1);  //画虚线
        CGContextMoveToPoint(line, 0.0, 1.0);    //开始画线
        CGContextAddLineToPoint(line, CGRectGetWidth(self.frame), 1);
        CGContextStrokePath(line);
        imageView1.image = UIGraphicsGetImageFromCurrentImageContext();

        
    }
    
    return self;
}

@end
