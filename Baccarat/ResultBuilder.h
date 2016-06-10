//
//  ResultBuilder.h
//  Baccarat
//
//  Created by chenran on 16/5/29.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultBuilder : NSObject

+ (instancetype)shareObject;

- (NSNumber *) getNextResult;

- (void) resetResultByPoint:(NSNumber *)point;

@property (nonatomic, strong) NSMutableArray *results;
@end
