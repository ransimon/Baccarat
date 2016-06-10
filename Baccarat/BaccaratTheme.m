//
//  BaccaratTheme.m
//  Baccarat
//
//  Created by chenran on 16/6/6.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "BaccaratTheme.h"

@implementation BaccaratTheme

#define R_VALUE(argb) ((argb >> 16) & 0x000000FF)
#define G_VALUE(argb) ((argb >> 8) & 0x000000FF)
#define B_VALUE(argb) (argb & 0x000000FF)

+ (instancetype)defaultTheme
{
    static id defaultTheme;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultTheme = [[BaccaratTheme alloc] init];
    });
    return defaultTheme;
}

- (UIColor *)colorWithHexString:(NSString *)colorString alpha:(CGFloat)alpha
{
    const char *cStr = [colorString cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr + 1, NULL, 16);
    
    UIColor *color =  [UIColor colorWithRed:(float)R_VALUE(x) / 255.0f green:(float)G_VALUE(x) / 255.0f blue:(float)B_VALUE(x) / 255.0f alpha:alpha];
    
    return color;
}

@end
