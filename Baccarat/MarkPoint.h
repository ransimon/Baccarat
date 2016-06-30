//
//  MarkPoint.h
//  Baccarat
//
//  Created by chenran on 16/6/25.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Result.h"
@interface MarkPoint : NSObject
@property (strong, nonatomic) Result *result;
@property (strong, nonatomic) NSNumber *pointX;
@property (strong, nonatomic) NSNumber *pointY;
@property (nonatomic) BOOL isUsed;
@property (nonatomic) ResultType resultType;

@end
