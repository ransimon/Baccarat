//
//  YYBaseViewControllerFactory.h
//  YYMobile
//
//  Created by wuwei on 14/6/20.
//  Copyright (c) 2014年 YY.inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StoryboardViewControllerFactory : NSObject

@property (nonatomic, strong, readonly) UIStoryboard *storyboard;

/**
 *  The designated initializer
 *
 *  @param storyboard 创建此Factory的storyboard, 不能为nil
 *
 *  @return 初始化完成的`YYStoryboardViewControllerFactory`实例
 */
- (instancetype)initWithStoryboard:(UIStoryboard *)storyboard;

+ (instancetype)sharedFactory;

- (UIViewController *)instantiateSettingViewController;

@end
