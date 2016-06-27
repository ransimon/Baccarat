//
//  MarkBuilder.m
//  Baccarat
//
//  Created by chenran on 16/6/25.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "MarkBuilder.h"
#import "MarkPoint.h"
#import "Result.h"

@implementation MarkBuilder
{
    NSInteger mark1Width;
    NSInteger mark1Height;
    CGFloat mark2Width;
    CGFloat mark2Height;
    NSInteger mark5Width;
    NSInteger mark5Height;
    NSInteger currentMark1Colum;
    NSInteger currentMark2Colum;
    NSInteger currentMark3Colum;
    NSInteger currentMark4Colum;
    ResultType currentMark1ColumResult;
    ResultType currentMark2ColumResult;
    ResultType currentMark3ColumResult;
    ResultType currentMark4ColumResult;
    NSInteger mark2StartPosition;
    NSInteger mark3StartPosition;
    NSInteger mark4StartPosition;
    NSInteger currentMark2StartPosition;
    NSInteger currentMark3StartPosition;
    NSInteger currentMark4StartPosition;
}
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
        self.allMark1Points = [NSMutableArray array];
        self.allMark2Points = [NSMutableArray array];
        self.allMark3Points = [NSMutableArray array];
        self.allMark4Points = [NSMutableArray array];
        self.allMark5Points = [NSMutableArray array];
        mark2StartPosition =arc4random() % 10;
        mark3StartPosition =arc4random() % 10;
        mark4StartPosition =arc4random() % 10;
        mark5Width = 42;
        mark5Height = 42;
        mark1Width = 21;
        mark1Height = 21;
        mark2Width = 21 / 2;
        mark2Height = 21 / 2;
        [self createAllMark1Point];
        [self createAllMark2Point];
        [self createAllMark3Point];
        [self createAllMark4Point];
        [self createAllMark5Point];
        
        
    }
    return self;

}

- (void)createAllMark1Point
{

    NSInteger currentColumsX = 0;
    NSInteger currentColumsY = 0;
    for (int i=0; i<100; i++) {
        
        NSMutableArray *column = [NSMutableArray array];
        for (int j=0; j<6; j++) {
            
            MarkPoint *point = [[MarkPoint alloc] init];
            point.pointX = [NSNumber numberWithInteger:currentColumsX];
            point.pointY = [NSNumber numberWithInteger:currentColumsY];
            point.isUsed = NO;
            currentColumsY+=22;
            [column addObject:point];
        }
        currentColumsX+=22;
        currentColumsY = 0;
        [self.allMark1Points addObject:column];
    }
}

- (MarkPoint *)getNextMark1PointByResult:(Result *)result
{
    MarkPoint *markPoint = nil;
    MarkPoint *temp = nil;
    for (int i=currentMark1Colum; i<self.allMark1Points.count; i++) {
        NSMutableArray *colum = [self.allMark1Points objectAtIndex:i];
        for (int j=0; j<colum.count; j++) {
            markPoint = [colum objectAtIndex:j];
            if (!markPoint.isUsed) {
                if (currentMark1ColumResult == result.resultType || result.resultType == ResultDrawnGame) {
                    if (j == 0) {
                        
                        currentMark1Colum = i+1;
                        markPoint = [colum objectAtIndex:colum.count - 1];
                    }
                    markPoint.result = result;
                    markPoint.isUsed = YES;
                    
                    return markPoint;
                } else {
                    if (temp == nil) {
                        currentMark1Colum = i;
                        markPoint.result = result;
                        markPoint.isUsed = YES;
                        currentMark1ColumResult = result.resultType;
                        return markPoint;
                    }
                    currentMark1Colum = i+1;
                    currentMark1ColumResult = result.resultType;
                    NSMutableArray *newColum = [self.allMark1Points objectAtIndex:i+1];
                    markPoint =[newColum objectAtIndex:0];
                    markPoint.result = result;
                    markPoint.isUsed = YES;
                    return markPoint;
                }
            } else {
                temp = markPoint;
            }
        }
    }
    return markPoint;
}

- (void)createAllMark2Point
{
    NSInteger currentColumsX = 0;
    NSInteger currentColumsY = 0;
    for (int i=0; i<100; i++) {
        
        NSMutableArray *column = [NSMutableArray array];
        for (int j=0; j<6; j++) {
            
            MarkPoint *point = [[MarkPoint alloc] init];
            point.pointX = [NSNumber numberWithInteger:currentColumsX];
            point.pointY = [NSNumber numberWithInteger:currentColumsY];
            point.isUsed = NO;
            currentColumsY+=11;
            [column addObject:point];
        }
        currentColumsX+=11;
        currentColumsY = 0;
        [self.allMark2Points addObject:column];
    }
}

- (MarkPoint *)getNextMark2PointByResult:(Result *)result
{
    currentMark2StartPosition++;
    if (currentMark2StartPosition < mark2StartPosition) {
        return nil;
    }
    
    NSInteger randomResult = arc4random() % 2;
    ResultType resultType;
    if (randomResult == 0) {
        resultType = ResultBankerWin;
    } else if (randomResult == 1) {
        resultType = ResultPlayerWin;
    } else {
        resultType = ResultDrawnGame;
    }
    
    MarkPoint *markPoint = nil;
    MarkPoint *temp = nil;
    for (int i=currentMark2Colum; i<self.allMark2Points.count; i++) {
        NSMutableArray *colum = [self.allMark2Points objectAtIndex:i];
        for (int j=0; j<colum.count; j++) {
            markPoint = [colum objectAtIndex:j];
            if (!markPoint.isUsed) {
                if (currentMark2ColumResult == resultType || resultType == ResultDrawnGame) {
                    if (j == 0) {
                        
                        currentMark2Colum = i+1;
                        markPoint = [colum objectAtIndex:colum.count - 1];
                    }
                    markPoint.result = result;
                    markPoint.resultType = resultType;
                    markPoint.isUsed = YES;
                    
                    return markPoint;
                } else {
                    if (temp == nil) {
                        currentMark2Colum = i;
                        markPoint.result = result;
                        markPoint.resultType = resultType;
                        markPoint.isUsed = YES;
                        currentMark2ColumResult = resultType;
                        return markPoint;
                    }
                    currentMark2Colum = i+1;
                    currentMark2ColumResult = resultType;
                    NSMutableArray *newColum = [self.allMark2Points objectAtIndex:i+1];
                    markPoint =[newColum objectAtIndex:0];
                    markPoint.result = result;
                    markPoint.resultType = resultType;
                    markPoint.isUsed = YES;
                    return markPoint;
                }
            } else {
                temp = markPoint;
            }
        }
    }
    return markPoint;
}

- (void)createAllMark3Point
{
    NSInteger currentColumsX = 0;
    NSInteger currentColumsY = 0;
    for (int i=0; i<100; i++) {
        
        NSMutableArray *column = [NSMutableArray array];
        for (int j=0; j<6; j++) {
            
            MarkPoint *point = [[MarkPoint alloc] init];
            point.pointX = [NSNumber numberWithInteger:currentColumsX];
            point.pointY = [NSNumber numberWithInteger:currentColumsY];
            point.isUsed = NO;
            currentColumsY+=11;
            [column addObject:point];
        }
        currentColumsX+=11;
        currentColumsY = 0;
        [self.allMark3Points addObject:column];
    }
}

- (MarkPoint *)getNextMark3PointByResult:(Result *)result
{
    currentMark3StartPosition++;
    if (currentMark3StartPosition < mark3StartPosition) {
        return nil;
    }
    
    NSInteger randomResult = arc4random() % 2;
    ResultType resultType;
    if (randomResult == 0) {
        resultType = ResultBankerWin;
    } else if (randomResult == 1) {
        resultType = ResultPlayerWin;
    } else {
        resultType = ResultDrawnGame;
    }

    MarkPoint *markPoint = nil;
    MarkPoint *temp = nil;
    for (int i=currentMark3Colum; i<self.allMark3Points.count; i++) {
        NSMutableArray *colum = [self.allMark3Points objectAtIndex:i];
        for (int j=0; j<colum.count; j++) {
            markPoint = [colum objectAtIndex:j];
            if (!markPoint.isUsed) {
                if (currentMark3ColumResult == resultType || resultType == ResultDrawnGame) {
                    if (j == 0) {
                        
                        currentMark3Colum = i+1;
                        markPoint = [colum objectAtIndex:colum.count - 1];
                    }
                    markPoint.result = result;
                    markPoint.resultType = resultType;
                    markPoint.isUsed = YES;
                    
                    return markPoint;
                } else {
                    if (temp == nil) {
                        currentMark3Colum = i;
                        markPoint.result = result;
                        markPoint.resultType = resultType;
                        markPoint.isUsed = YES;
                        currentMark3ColumResult = resultType;
                        return markPoint;
                    }
                    currentMark3Colum = i+1;
                    currentMark3ColumResult = resultType;
                    NSMutableArray *newColum = [self.allMark3Points objectAtIndex:i+1];
                    markPoint =[newColum objectAtIndex:0];
                    markPoint.result = result;
                    markPoint.resultType = resultType;
                    markPoint.isUsed = YES;
                    return markPoint;
                }
            } else {
                temp = markPoint;
            }
        }
    }
    return markPoint;
}

- (void)createAllMark4Point
{
    NSInteger currentColumsX = 0;
    NSInteger currentColumsY = 0;
    for (int i=0; i<100; i++) {
        
        NSMutableArray *column = [NSMutableArray array];
        for (int j=0; j<6; j++) {
            
            MarkPoint *point = [[MarkPoint alloc] init];
            point.pointX = [NSNumber numberWithInteger:currentColumsX];
            point.pointY = [NSNumber numberWithInteger:currentColumsY];
            point.isUsed = NO;
            currentColumsY+=11;
            [column addObject:point];
        }
        currentColumsX+=11;
        currentColumsY = 0;
        [self.allMark4Points addObject:column];
    }
}

- (MarkPoint *)getNextMark4PointByResult:(Result *)result
{
    currentMark4StartPosition++;
    if (currentMark4StartPosition < mark4StartPosition) {
        return nil;
    }
    
    NSInteger randomResult = arc4random() % 2;
    ResultType resultType;
    if (randomResult == 0) {
        resultType = ResultBankerWin;
    } else if (randomResult == 1) {
        resultType = ResultPlayerWin;
    } else {
        resultType = ResultDrawnGame;
    }

    MarkPoint *markPoint = nil;
    MarkPoint *temp = nil;
    for (int i=currentMark4Colum; i<self.allMark4Points.count; i++) {
        NSMutableArray *colum = [self.allMark4Points objectAtIndex:i];
        for (int j=0; j<colum.count; j++) {
            markPoint = [colum objectAtIndex:j];
            if (!markPoint.isUsed) {
                if (currentMark4ColumResult == resultType || resultType == ResultDrawnGame) {
                    if (j == 0) {
                        
                        currentMark4Colum = i+1;
                        markPoint = [colum objectAtIndex:colum.count - 1];
                    }
                    markPoint.result = result;
                    markPoint.resultType = resultType;
                    markPoint.isUsed = YES;
                    
                    return markPoint;
                } else {
                    if (temp == nil) {
                        currentMark4Colum = i;
                        markPoint.result = result;
                        markPoint.resultType = resultType;
                        markPoint.isUsed = YES;
                        currentMark4ColumResult = resultType;
                        return markPoint;
                    }
                    currentMark4Colum = i+1;
                    currentMark4ColumResult = resultType;
                    NSMutableArray *newColum = [self.allMark4Points objectAtIndex:i+1];
                    markPoint =[newColum objectAtIndex:0];
                    markPoint.result = result;
                    markPoint.resultType = resultType;
                    markPoint.isUsed = YES;
                    return markPoint;
                }
            } else {
                temp = markPoint;
            }
        }
    }
    return markPoint;
}

- (void)createAllMark5Point
{
    NSInteger currentColumsX = 0;
    NSInteger currentColumsY = 0;
    for (int i=0; i<25; i++) {
        
        NSMutableArray *column = [NSMutableArray array];
        for (int j=0; j<6; j++) {
            
            MarkPoint *point = [[MarkPoint alloc] init];
            point.pointX = [NSNumber numberWithInteger:currentColumsX];
            point.pointY = [NSNumber numberWithInteger:currentColumsY];
            point.isUsed = NO;
            currentColumsY+=44;
            [column addObject:point];
        }
        currentColumsX+=44;
        currentColumsY = 0;
        [self.allMark5Points addObject:column];
    }
}

- (MarkPoint *)getNextUnusedMark5Point
{
    MarkPoint *markPoint = nil;
    for (int i=0; i<self.allMark5Points.count; i++) {
        NSMutableArray *colum = [self.allMark5Points objectAtIndex:i];
        for (int j=0; j<colum.count; j++) {
            markPoint = [colum objectAtIndex:j];
            if (!markPoint.isUsed) {
                markPoint.isUsed = YES;
                return markPoint;
            }
        }
    }
    return markPoint;
}

@end
