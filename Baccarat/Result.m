//
//  Result.m
//  Baccarat
//
//  Created by chenran on 16/6/19.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "Result.h"
#import "Card.h"

@implementation Result

-(instancetype)initWithCards:(NSArray *)cards
{
    self = [[Result alloc] init];
    if (self && cards != nil && cards.count >= 4) {
        NSMutableArray *playerCards = [NSMutableArray array];
        NSMutableArray *bankerCards = [NSMutableArray array];
        Card *card1 = [cards objectAtIndex:0];
        Card *card2 = [cards objectAtIndex:1];
        Card *card3 = [cards objectAtIndex:2];
        Card *card4 = [cards objectAtIndex:3];
        Card *card5 = nil;
        Card *card6 = nil;
        
        NSNumber *playerPoint = [self add:card1.validPoint and:card3.validPoint];
        NSNumber *bankerPoint = [self add:card2.validPoint and:card4.validPoint];
        
        [playerCards addObject:card1];
        [playerCards addObject:card3];
        
        [bankerCards addObject:card2];
        [bankerCards addObject:card4];
        
        if (playerPoint.integerValue >= 8) {
            self.isPlayerBornCard = YES;
        } else {
            self.isPlayerBornCard = NO;
        }
        
        if (bankerPoint.integerValue >= 8) {
            self.isBankerBornCard = YES;
        } else {
            self.isBankerBornCard = NO;
        }
        
        if (cards.count >= 5) {
            card5 = [cards objectAtIndex:4];
            playerPoint = [self add:playerPoint and:card5.validPoint];
            [playerCards addObject:card5];
        }
        
        if (cards.count >= 6) {
            card6 = [cards objectAtIndex:5];
            bankerPoint = [self add:bankerPoint and:card6.validPoint];
            [bankerCards addObject:card6];
        }
        
        if (card1.cardNumber.integerValue == card3.cardNumber.integerValue) {
            self.isPlayerDouble = YES;
        } else {
            self.isPlayerDouble = NO;
        }
        
        if (card2.cardNumber.integerValue == card4.cardNumber.integerValue) {
            self.isBankerDouble = YES;
        } else {
            self.isBankerDouble = NO;
        }
        
        
        if (playerPoint.integerValue > bankerPoint.integerValue) {
            self.resultType = ResultPlayerWin;
        } else if (playerPoint.integerValue < bankerPoint.integerValue) {
            self.resultType = ResultBankerWin;
        } else {
            self.resultType = ResultDrawnGame;
        }
        
        self.playerPoint = playerPoint;
        self.bankerPoint = bankerPoint;
        
        self.playerCards = playerCards;
        self.bankerCards = bankerCards;
        self.allCards = cards;
    }
    
    return self;
}

-(NSNumber*)add:(NSNumber *)one and:(NSNumber *)anotherNumber
{
    NSNumber *result =[NSNumber numberWithInteger:[one integerValue] + [anotherNumber integerValue]];
    result = [NSNumber numberWithInteger:result.integerValue % 10];
    return result;
}

@end
