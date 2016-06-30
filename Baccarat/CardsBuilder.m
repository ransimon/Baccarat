//
//  CardsBuilder.m
//  Baccarat
//
//  Created by chenran on 16/5/22.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "CardsBuilder.h"
#import "Result.h"

@interface CardsBuilder ()

@property (nonatomic, strong) NSMutableArray *drawnCards;

@end

@implementation CardsBuilder

+ (instancetype)shareObject {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.cards = [[NSMutableArray alloc] init];
        [self buildAllCards];
        [self shuffleCards];
    }
    return self;
}

-(Card *)getNextCard
{
    
    if (self.cards.count > 0) {
        Card *card = [self.cards objectAtIndex:0];
        [self.cards removeObjectAtIndex:0];
        return card;
    }
    return nil;
}

- (NSArray *)getNextCards:(NSNumber *)count
{
    
    if (self.cards.count > [count integerValue]) {
        NSRange range = NSMakeRange(0, [count integerValue]);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        NSArray *cards = [self.cards objectsAtIndexes:indexSet];
        [self.cards removeObjectsAtIndexes:indexSet];
        return cards;
    }
    return nil;
}

- (Result *)getCardsByResult:(NSNumber *)result
{
    NSLog(@"requestResult--->%ld", (long)result.longValue);
    NSMutableArray *finalCards =nil;
    
    if (result.integerValue != 3) {
        NSArray *cards =[self getNextCards:[NSNumber numberWithInteger:4]];
        NSMutableArray * newCards = [[NSMutableArray alloc] init];
        finalCards = [[NSMutableArray alloc] init];
        if (cards != nil) {
            Card *card1 = [cards objectAtIndex:0];
            Card *card2 = [cards objectAtIndex:1];
            Card *card3 = [cards objectAtIndex:2];
            Card *card4 = [cards objectAtIndex:3];
            
            NSNumber *point1 = [self add:card1.validPoint and:card2.validPoint];
            NSNumber *point2 = [self add:card3.validPoint and:card4.validPoint];
            
            if (point1 == point2) {
                point1 = [self add:card1.validPoint and:card3.validPoint];
                point2 = [self add:card2.validPoint and:card4.validPoint];
                
                if (point1 == point2) {
                    point1 = [self add:card2.validPoint and:card3.validPoint];
                    point2 = [self add:card1.validPoint and:card4.validPoint];
                    
                    if (point1 == point2) {
                        [self insertCardsAtRandomIndex:cards];
                        return [self getCardsByResult:result];
                    } else {
                        [newCards addObject:card2];
                        [newCards addObject:card1];
                        [newCards addObject:card3];
                        [newCards addObject:card4];
                    }
                    
                } else {
                    [newCards addObject:card1];
                    [newCards addObject:card2];
                    [newCards addObject:card3];
                    [newCards addObject:card4];
                }
            } else {
                [newCards addObject:card1];
                [newCards addObject:card3];
                [newCards addObject:card2];
                [newCards addObject:card4];
            }
            
            card1 = [newCards objectAtIndex:0];
            card2 = [newCards objectAtIndex:1];
            card3 = [newCards objectAtIndex:2];
            card4 = [newCards objectAtIndex:3];
            
            point1 = [self add:card1.validPoint and:card3.validPoint];
            point2 = [self add:card2.validPoint and:card4.validPoint];
            
            if (result.integerValue == 1) {
                if (point1.integerValue > point2.integerValue) {
                    [finalCards addObject:card2];
                    [finalCards addObject:card1];
                    [finalCards addObject:card4];
                    [finalCards addObject:card3];
                } else {
                    [finalCards addObject:card1];
                    [finalCards addObject:card2];
                    [finalCards addObject:card3];
                    [finalCards addObject:card4];
                }
            } else if (result.integerValue == 2) {
                if (point1.integerValue > point2.integerValue) {
                    [finalCards addObject:card1];
                    [finalCards addObject:card2];
                    [finalCards addObject:card3];
                    [finalCards addObject:card4];
                } else {
                    [finalCards addObject:card2];
                    [finalCards addObject:card1];
                    [finalCards addObject:card4];
                    [finalCards addObject:card3];
                }
            }
            
            card1 = [finalCards objectAtIndex:0];
            card2 = [finalCards objectAtIndex:1];
            card3 = [finalCards objectAtIndex:2];
            card4 = [finalCards objectAtIndex:3];
            Card* card5 = nil;
            Card* card6 = nil;
            
            point1 = [self add:card1.validPoint and:card3.validPoint];
            point2 = [self add:card2.validPoint and:card4.validPoint];
            
            if (point1.integerValue <= 5 && point1.integerValue >= 0) {
                card5 = [self getPlayerMoreCardByResult:result cards:finalCards];
                [finalCards addObject:card5];
                if (point2.integerValue <=2 && point2.integerValue >=0) {
                    card6 = [self getBankerMoreCardByResult:result cards:finalCards];
                } else if (point2.integerValue == 3) {
                    if (card5.validPoint.integerValue != 8) {
                        card6 = [self getBankerMoreCardByResult:result cards:finalCards];
                    }
                } else if (point2.integerValue == 4) {
                    if (card5.validPoint.integerValue != 0 && card5.validPoint.integerValue != 1
                        && card5.validPoint.integerValue != 8 && card5.validPoint.integerValue != 9) {
                        card6 = [self getBankerMoreCardByResult:result cards:finalCards];
                    }
                } else if (point2.integerValue == 5) {
                    if (card5.validPoint.integerValue != 0 && card5.validPoint.integerValue != 1
                        && card5.validPoint.integerValue != 2 && card5.validPoint.integerValue != 3&& card5.validPoint.integerValue != 8) {
                        card6 = [self getBankerMoreCardByResult:result cards:finalCards];
                    }
                    
                } else if (point2.integerValue == 6) {
                    if (card5.validPoint.integerValue != 0 && card5.validPoint.integerValue != 1
                        && card5.validPoint.integerValue != 2 && card5.validPoint.integerValue != 3&& card5.validPoint.integerValue != 4 && card5.validPoint.integerValue != 5 && card5.validPoint.integerValue != 8 && card5.validPoint.integerValue != 9) {
                        card6 = [self getBankerMoreCardByResult:result cards:finalCards];
                    }
                } else {
                    
                }
            }
            
            if (card6 != nil) {
                [finalCards addObject:card6];
            }
        }
    } else {
        finalCards = [[self getDrawnCardsByPoint:[NSNumber numberWithInteger:6]] mutableCopy];
    }
    
    Result *finalResult = [[Result alloc] initWithCards:finalCards.copy];
    
    return finalResult;
}

- (Card *)getPlayerMoreCardByResult: (NSNumber *)result cards:(NSArray *)cards
{
    if (cards != nil && cards.count == 4) {
        Card *card1 = [cards objectAtIndex:0];
        Card *card2 = [cards objectAtIndex:1];
        Card *card3 = [cards objectAtIndex:2];
        Card *card4 = [cards objectAtIndex:3];
        Card *card5 = nil;
        
        NSNumber *player = [self add:card1.validPoint and:card3.validPoint];
        NSNumber *banker = [self add:card2.validPoint and:card4.validPoint];
        
        
        NSUInteger total = self.cards.count;
        for (int i=0; i < total; i++) {
            card5 = [self getNextCard];
            NSNumber *tempPlayer = [self add:player and:card5.validPoint];
            
            if (result.integerValue == 1) {
                if (banker.integerValue > tempPlayer.integerValue) {
                    break;
                } else {
                    [self insertCardsAtRandomIndex:@[card5]];
                }
            } else if (result.integerValue == 2) {
                if (banker.integerValue < tempPlayer.integerValue) {
                    break;
                } else {
                    [self insertCardsAtRandomIndex:@[card5]];
                }
            }
        }
        
        return  card5;
    }
    
    return nil;
}

- (Card *)getBankerMoreCardByResult: (NSNumber *)result cards:(NSArray*)cards
{
    if (cards != nil && cards.count == 5) {
        Card *card1 = [cards objectAtIndex:0];
        Card *card2 = [cards objectAtIndex:1];
        Card *card3 = [cards objectAtIndex:2];
        Card *card4 = [cards objectAtIndex:3];
        Card *card5 = [cards objectAtIndex:4];
        Card *card6 = nil;
        NSNumber *player = [self add:card1.validPoint and:card3.validPoint];
        player = [self add:player and:card5.validPoint];
        NSNumber *banker = [self add:card2.validPoint and:card4.validPoint];
        
        NSUInteger total = self.cards.count;
        for (int i=0; i < total; i++) {
            card6 = [self getNextCard];
            NSNumber* tempBanker = [self add:banker and:card6.validPoint];
            
            if (result.integerValue == 1) {
                if (tempBanker.integerValue > player.integerValue) {
                    break;
                } else {
                    [self insertCardsAtRandomIndex:@[card6]];
                }
            } else if (result.integerValue == 2) {
                if (tempBanker.integerValue < player.integerValue) {
                    break;
                } else {
                    [self insertCardsAtRandomIndex:@[card6]];
                }
            }
        }
        
        return  card6;
    }
    
    return nil;
}

-(NSNumber*)add:(NSNumber *)one and:(NSNumber *)anotherNumber
{
    NSNumber *result =[NSNumber numberWithInteger:[one integerValue] + [anotherNumber integerValue]];
    result = [NSNumber numberWithInteger:result.integerValue % 10];
    return result;
}

- (void)insertCardsAtRandomIndex:(NSArray *)cards
{
    
    if (cards != nil && cards.count > 0) {
        for (Card *card in cards) {
            [self.cards insertObject:card atIndex:arc4random() % self.cards.count];
        }
    }
}

- (NSArray *)getDrawnCardsByPoint:(NSNumber *)point
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    Card *card1 = [self getNextCard];
    Card *card2 = [self getNextCard];
    Card *card3 = nil;
    Card *card4 = nil;
    
    
    for (int i=0; i<self.cards.count; i++) {
        Card *card = [self.cards objectAtIndex:i];
        if ([[self add:card1.validPoint and:card.validPoint] isEqual:point] && card3 == nil) {
            card3 = card;
        }
        
        if ([[self add:card2.validPoint and:card.validPoint] isEqual:point] && ![card isEqual:card3] && card4 == nil) {
            card4 = card;
        }
        
        if (card3 != nil && card4 != nil) {
            [result addObject:card1];
            [result addObject:card2];
            [result addObject:card3];
            [result addObject:card4];
            break;
        }
    }
    
    [self.cards removeObject:card3];
    [self.cards removeObject:card4];
    return [result copy];
}


- (void) shuffleCards
{
    int count = [[NSNumber numberWithInteger:self.cards.count] intValue];
    for(int i=0; i<3; i++) {
        for(int n=count; n>=0; n--){
            int rand = arc4random() % count;
            NSNumber *pokeMoveToEnd = [self.cards objectAtIndex:rand];
            [self.cards removeObjectAtIndex:rand];
            [self.cards addObject:pokeMoveToEnd];
        }
    }
}

- (void) buildAllCards
{
    for(int i=0; i<10; i++) {
        //黑桃
        for (int j=1; j<=13; j++) {
            Card *card = [[Card alloc] init];
            card.resId = [NSString stringWithFormat:@"ht_%d", j];
            card.cardNumber = [NSNumber numberWithInt:j];
            card.cardColor = CardColorHT;
            if (j < 10) {
                card.validPoint = [NSNumber numberWithInt:j];
            } else {
                card.validPoint = [NSNumber numberWithInt:0];
            }
            [self.cards addObject:card];
        }
        //红心
        for (int j=1; j<=13; j++) {
            Card *card = [[Card alloc] init];
            card.resId = [NSString stringWithFormat:@"hx_%d", j];
            card.cardNumber = [NSNumber numberWithInt:j];
            card.cardColor = CardColorHX;
            if (j < 10) {
                card.validPoint = [NSNumber numberWithInt:j];
            } else {
                card.validPoint = [NSNumber numberWithInt:0];
            }
            [self.cards addObject:card];
        }
        //梅花
        for (int j=1; j<=13; j++) {
            Card *card = [[Card alloc] init];
            card.resId = [NSString stringWithFormat:@"mh_%d", j];
            card.cardNumber = [NSNumber numberWithInt:j];
            card.cardColor = CardColorMH;
            if (j < 10) {
                card.validPoint = [NSNumber numberWithInt:j];
            } else {
                card.validPoint = [NSNumber numberWithInt:0];
            }
            [self.cards addObject:card];
        }
        //方块
        for (int j=1; j<=13; j++) {
            Card *card = [[Card alloc] init];
            card.resId = [NSString stringWithFormat:@"fk_%d", j];
            card.cardNumber = [NSNumber numberWithInt:j];
            card.cardColor = CardColorFK;
            if (j < 10) {
                card.validPoint = [NSNumber numberWithInt:j];
            } else {
                card.validPoint = [NSNumber numberWithInt:0];
            }
            [self.cards addObject:card];
        }
    }
}
@end
