//
//  MarkBuilder.h
//  Baccarat
//
//  Created by chenran on 16/6/25.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarkPoint.h"
@interface MarkBuilder : NSObject

@property(strong, nonatomic) NSMutableArray *allMark1Points;
@property(strong, nonatomic) NSMutableArray *allMark2Points;
@property(strong, nonatomic) NSMutableArray *allMark3Points;
@property(strong, nonatomic) NSMutableArray *allMark4Points;
@property(strong, nonatomic) NSMutableArray *allMark5Points;
+ (instancetype)shareObject;

- (MarkPoint *)getNextMark1PointByResult:(Result *)result;
- (MarkPoint *)getNextMark2PointByResult:(Result *)result;
- (MarkPoint *)getNextMark3PointByResult:(Result *)result;
- (MarkPoint *)getNextMark4PointByResult:(Result *)result;
- (MarkPoint *)getNextUnusedMark5Point;
@end
