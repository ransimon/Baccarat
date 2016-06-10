//
//  ImageUtils.h
//  Baccarat
//
//  Created by chenran on 16/6/4.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageUtils : NSObject
+ (UIImage *) scoreToImage:(NSString *)score;
+ (UIImage *) scoreToChips:(NSInteger)intScore;
@end
