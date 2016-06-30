//
//  Result.h
//  Baccarat
//
//  Created by chenran on 16/6/19.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ResultBankerWin = 1,
    ResultPlayerWin = 2,
    ResultDrawnGame = 3,
}ResultType;
@interface Result : NSObject

@property (nonatomic) ResultType resultType;
@property (nonatomic, strong)NSNumber* bankerPoint;
@property (nonatomic, strong)NSNumber* playerPoint;
@property (nonatomic, strong)NSArray* bankerCards;
@property (nonatomic, strong)NSArray* playerCards;
@property (nonatomic, strong)NSArray* allCards;
@property (nonatomic) BOOL isBankerBornCard;
@property (nonatomic) BOOL isPlayerBornCard;
@property (nonatomic) BOOL isBankerDouble;
@property (nonatomic) BOOL isPlayerDouble;

-(instancetype) initWithCards:(NSArray *)cards;

@end
