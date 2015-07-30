//
//  VerticallyAlignedLabel.h
//  TestLabel
//
//  Created by wenjie.li on 15/7/24.
//  Copyright (c) 2015年 wenjie.li. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;



@interface VerticallyAlignedLabel : UILabel

@property (nonatomic, assign) VerticalAlignment verticalAlignment;



@end
