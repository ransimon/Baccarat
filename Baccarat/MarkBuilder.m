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
    int currentMark1Colum;
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
    
    MarkPoint *lastMarkPoint1;
    ResultType currentResult1;
    BOOL isWheel1;
    MarkPoint *lastMarkPoint2;
    ResultType currentResult2;
    BOOL isWheel2;
    MarkPoint *lastMarkPoint3;
    ResultType currentResult3;
    BOOL isWheel3;
    MarkPoint *lastMarkPoint4;
    ResultType currentResult4;
    BOOL isWheel4;
    MarkPoint *lastMarkPoint5;
    ResultType currentResult5;
    BOOL isWheel5;
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
            point.aPointx = [NSNumber numberWithInteger:i];
            point.aPointY = [NSNumber numberWithInteger:j];
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
    if (lastMarkPoint1 == nil) {
        NSMutableArray *colum = [self.allMark1Points objectAtIndex:0];
        markPoint = [colum objectAtIndex:0];
        currentResult1 = result.resultType;
    } else {
        if (result.resultType == currentResult1 || result.resultType == ResultDrawnGame) {
            if (isWheel1 || lastMarkPoint1.aPointY.integerValue == 5) {
                NSMutableArray *newColum = [self.allMark1Points objectAtIndex:lastMarkPoint1.aPointx.integerValue + 1];
                markPoint = [newColum objectAtIndex:lastMarkPoint1.aPointY.integerValue];
                isWheel1 = YES;
            }else {
                NSMutableArray *currentColum = [self.allMark1Points objectAtIndex:lastMarkPoint1.aPointx.integerValue];
                MarkPoint *mp = [currentColum objectAtIndex:lastMarkPoint1.aPointY.integerValue+1];
                if (mp.isUsed) {
                    NSMutableArray *newColum = [self.allMark1Points objectAtIndex:lastMarkPoint1.aPointx.integerValue + 1];
                    markPoint = [newColum objectAtIndex:lastMarkPoint1.aPointY.integerValue];
                    isWheel1 = YES;
                } else {
                    markPoint = mp;
                }
            }
        } else {
            for (int i=0; i<self.allMark1Points.count; i++){
                NSMutableArray *colum = [self.allMark1Points objectAtIndex:i];
                MarkPoint *mp = [colum objectAtIndex:0];
                if (!mp.isUsed) {
                    markPoint = mp;
                    currentResult1 = result.resultType;
                    isWheel1 = NO;
                    break;
                }
            }
        }
    }
    markPoint.isUsed = YES;
    markPoint.result = result;
    lastMarkPoint1 = markPoint;
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
            point.aPointx = [NSNumber numberWithInteger:i];
            point.aPointY = [NSNumber numberWithInteger:j];
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
    if (lastMarkPoint2 == nil) {
        NSMutableArray *colum = [self.allMark2Points objectAtIndex:0];
        markPoint = [colum objectAtIndex:0];
        currentResult2 = resultType;
    } else {
        if (resultType == currentResult2 || resultType == ResultDrawnGame) {
            if (isWheel2 || lastMarkPoint2.aPointY.integerValue == 5) {
                NSMutableArray *newColum = [self.allMark2Points objectAtIndex:lastMarkPoint2.aPointx.integerValue + 1];
                markPoint = [newColum objectAtIndex:lastMarkPoint2.aPointY.integerValue];
                isWheel2 = YES;
            }else {
                NSMutableArray *currentColum = [self.allMark2Points objectAtIndex:lastMarkPoint2.aPointx.integerValue];
                MarkPoint *mp = [currentColum objectAtIndex:lastMarkPoint2.aPointY.integerValue+1];
                if (mp.isUsed) {
                    NSMutableArray *newColum = [self.allMark2Points objectAtIndex:lastMarkPoint2.aPointx.integerValue + 1];
                    markPoint = [newColum objectAtIndex:lastMarkPoint2.aPointY.integerValue];
                    isWheel2 = YES;
                } else {
                    markPoint = mp;
                }
            }
        } else {
            for (int i=0; i<self.allMark2Points.count; i++){
                NSMutableArray *colum = [self.allMark2Points objectAtIndex:i];
                MarkPoint *mp = [colum objectAtIndex:0];
                if (!mp.isUsed) {
                    markPoint = mp;
                    currentResult2 = resultType;
                    isWheel2 = NO;
                    break;
                }
            }
        }
    }
    markPoint.isUsed = YES;
    markPoint.resultType = resultType;
    lastMarkPoint2 = markPoint;
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
            point.aPointx = [NSNumber numberWithInteger:i];
            point.aPointY = [NSNumber numberWithInteger:j];
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
    if (lastMarkPoint3 == nil) {
        NSMutableArray *colum = [self.allMark3Points objectAtIndex:0];
        markPoint = [colum objectAtIndex:0];
        currentResult3 = resultType;
    } else {
        if (resultType == currentResult3 || resultType == ResultDrawnGame) {
            if (isWheel3 || lastMarkPoint3.aPointY.integerValue == 5) {
                NSMutableArray *newColum = [self.allMark3Points objectAtIndex:lastMarkPoint3.aPointx.integerValue + 1];
                markPoint = [newColum objectAtIndex:lastMarkPoint3.aPointY.integerValue];
                isWheel3 = YES;
            }else {
                NSMutableArray *currentColum = [self.allMark3Points objectAtIndex:lastMarkPoint3.aPointx.integerValue];
                MarkPoint *mp = [currentColum objectAtIndex:lastMarkPoint3.aPointY.integerValue+1];
                if (mp.isUsed) {
                    NSMutableArray *newColum = [self.allMark3Points objectAtIndex:lastMarkPoint3.aPointx.integerValue + 1];
                    markPoint = [newColum objectAtIndex:lastMarkPoint3.aPointY.integerValue];
                    isWheel3 = YES;
                } else {
                    markPoint = mp;
                }
            }
        } else {
            for (int i=0; i<self.allMark3Points.count; i++){
                NSMutableArray *colum = [self.allMark3Points objectAtIndex:i];
                MarkPoint *mp = [colum objectAtIndex:0];
                if (!mp.isUsed) {
                    markPoint = mp;
                    currentResult3 = resultType;
                    isWheel3 = NO;
                    break;
                }
            }
        }
    }
    markPoint.isUsed = YES;
    markPoint.resultType = resultType;
    lastMarkPoint3 = markPoint;
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
            point.aPointx = [NSNumber numberWithInteger:i];
            point.aPointY = [NSNumber numberWithInteger:j];
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
    if (lastMarkPoint4 == nil) {
        NSMutableArray *colum = [self.allMark4Points objectAtIndex:0];
        markPoint = [colum objectAtIndex:0];
        currentResult4 = resultType;
    } else {
        if (resultType == currentResult4 || resultType == ResultDrawnGame) {
            if (isWheel4 || lastMarkPoint4.aPointY.integerValue == 5) {
                NSMutableArray *newColum = [self.allMark4Points objectAtIndex:lastMarkPoint4.aPointx.integerValue + 1];
                markPoint = [newColum objectAtIndex:lastMarkPoint4.aPointY.integerValue];
                isWheel4 = YES;
            }else {
                NSMutableArray *currentColum = [self.allMark4Points objectAtIndex:lastMarkPoint4.aPointx.integerValue];
                MarkPoint *mp = [currentColum objectAtIndex:lastMarkPoint4.aPointY.integerValue+1];
                if (mp.isUsed) {
                    NSMutableArray *newColum = [self.allMark4Points objectAtIndex:lastMarkPoint4.aPointx.integerValue + 1];
                    markPoint = [newColum objectAtIndex:lastMarkPoint4.aPointY.integerValue];
                    isWheel4 = YES;
                } else {
                    markPoint = mp;
                }
            }
        } else {
            for (int i=0; i<self.allMark4Points.count; i++){
                NSMutableArray *colum = [self.allMark4Points objectAtIndex:i];
                MarkPoint *mp = [colum objectAtIndex:0];
                if (!mp.isUsed) {
                    markPoint = mp;
                    currentResult4 = resultType;
                    isWheel4 = NO;
                    break;
                }
            }
        }
    }
    markPoint.isUsed = YES;
    markPoint.resultType = resultType;
    lastMarkPoint4 = markPoint;
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
            point.aPointx = [NSNumber numberWithInteger:i];
            point.aPointY = [NSNumber numberWithInteger:j];
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
