//
//  YYBaseViewControllerFactory.m
//  YYMobile
//
//  Created by wuwei on 14/6/20.
//  Copyright (c) 2014年 YY.inc. All rights reserved.
//

#import "StoryboardViewControllerFactory.h"

@implementation StoryboardViewControllerFactory

- (instancetype)initWithStoryboard:(UIStoryboard *)storyboard
{
    NSParameterAssert(storyboard);
    
    self = [super init];
    if (self) {
        _storyboard = storyboard;
    }
    return self;
}

+ (instancetype)sharedFactory
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithStoryboard:[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]];
    });
    return instance;
}

- (UIViewController *)instantiateSettingViewController
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    return vc;
}

@end
