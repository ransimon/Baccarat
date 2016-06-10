//
//  BaccaratTheme.h
//  Baccarat
//
//  Created by chenran on 16/6/6.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BaccaratTheme : NSObject
+ (instancetype)defaultTheme;

- (UIColor *)colorWithHexString:(NSString *)colorString alpha:(CGFloat)alpha;
@end
