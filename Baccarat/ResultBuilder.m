//
//  ResultBuilder.m
//  Baccarat
//
//  Created by chenran on 16/5/29.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "ResultBuilder.h"
#import "Result.h"

@implementation ResultBuilder


+ (instancetype)shareObject {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.results = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)resetResultByPoint:(NSNumber *)point
{
    // 取数据库中的结果
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:3]];
    [self.results addObject:[NSNumber numberWithInteger:1]];
    [self.results addObject:[NSNumber numberWithInteger:2]];
}

- (NSNumber *)getNextResult
{
    if (self.results.count > 0) {
        NSNumber *result =[self.results objectAtIndex:0];
        [self.results removeObjectAtIndex:0];
        return result;
    }
    return nil;
}

@end
