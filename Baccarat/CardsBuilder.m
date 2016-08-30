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
{
    int playerCount;
    int bankerCount;
    int totalDrawnGame;
    ResultType lastResultType;
}
@property (nonatomic, strong) NSMutableArray *drawnCards;

@end

@implementation CardsBuilder

+ (instancetype)shareObject {
    id instance = [[self alloc] init];
    return instance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.cards = [[NSMutableArray alloc] init];
        [self buildAllCards];
        [self shuffleCards];
        playerCount = 0;
        bankerCount = 0;
        self.isLastGame = NO;
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

- (Card *)getAssignPositionCard:(NSNumber *) position
{
    if (self.cards.count > 0) {
        Card *card = [self.cards objectAtIndex:position.integerValue];
        return card;
    }
    return nil;
}

-(Card *)getNextCardWithOutBurning
{
    
    if (self.cards.count > 0) {
        Card *card = [self.cards objectAtIndex:0];
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

- (NSArray *)getNextCardsWithOutBurning:(NSNumber *)count
{
    
    if (self.cards.count > [count integerValue]) {
        NSRange range = NSMakeRange(0, [count integerValue]);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        NSArray *cards = [self.cards objectsAtIndexes:indexSet];
        return cards;
    }
    return nil;
}

- (Result *)getNextResult:(BOOL) needBurningCard;
{
    NSArray *cards = nil;
    if (needBurningCard) {
        cards =[self getNextCards:[NSNumber numberWithInteger:4]];
    } else {
        cards =[self getNextCardsWithOutBurning:[NSNumber numberWithInteger:4]];
    }
    
    if (cards == nil) {
        return nil;
    }
    
    Card *card1 = [cards objectAtIndex:0];
    Card *card2 = [cards objectAtIndex:1];
    Card *card3 = [cards objectAtIndex:2];
    Card *card4 = [cards objectAtIndex:3];
    Card *card5 = nil;
    Card *card6 = nil;
    
    NSNumber *point1 = [self add:card1.validPoint and:card3.validPoint];
    NSNumber *point2 = [self add:card2.validPoint and:card4.validPoint];
    
    BOOL needCard6 = NO;
    if (!(point2.integerValue == 8 || point2.integerValue == 9) && !(point1.integerValue == 8 || point1.integerValue == 9)) {
        if (point1.integerValue <= 5 && point1.integerValue >= 0) {
            if (needBurningCard) {
                card5 = [self getNextCard];
            } else {
                card5 = [self getAssignPositionCard:[NSNumber numberWithInteger:4]];
            }
            
            if (point2.integerValue <=2 && point2.integerValue >=0) {
                needCard6 = YES;
            } else if (point2.integerValue == 3) {
                if (card5.validPoint.integerValue != 8) {
                    needCard6 = YES;
                }
            } else if (point2.integerValue == 4) {
                if (card5.validPoint.integerValue != 0 && card5.validPoint.integerValue != 1
                    && card5.validPoint.integerValue != 8 && card5.validPoint.integerValue != 9) {
                    needCard6 = YES;
                }
            } else if (point2.integerValue == 5) {
                if (card5.validPoint.integerValue != 0 && card5.validPoint.integerValue != 1
                    && card5.validPoint.integerValue != 2 && card5.validPoint.integerValue != 3&& card5.validPoint.integerValue != 8) {
                    needCard6 = YES;
                }
                
            } else if (point2.integerValue == 6) {
                if (card5.validPoint.integerValue != 0 && card5.validPoint.integerValue != 1
                    && card5.validPoint.integerValue != 2 && card5.validPoint.integerValue != 3&& card5.validPoint.integerValue != 4 && card5.validPoint.integerValue != 5 && card5.validPoint.integerValue != 8 && card5.validPoint.integerValue != 9) {
                    needCard6 = YES;
                }
            } else {
                needCard6 = NO;
            }
            
            if (needCard6) {
                if (needBurningCard) {
                    card6 = [self getNextCard];
                } else {
                    card6 = [self getAssignPositionCard:[NSNumber numberWithInteger:5]];
                }
            }
        }
        
        if (card5 == nil && (point2.integerValue == 0 || point2.integerValue == 1 || point2.integerValue == 2)) {
            Card *card = [[Card alloc] init];
            card.resId = @"";
            card.cardNumber = [NSNumber numberWithInt:0];
            card.validPoint = [NSNumber numberWithInt:0];
            card5 = card;
            if (needBurningCard) {
                card6 = [self getNextCard];
            } else {
                card6 = [self getAssignPositionCard:[NSNumber numberWithInteger:4]];
            }
        } else if (card5 == nil && (point1.integerValue == 6 || point1.integerValue == 7) && (point2.integerValue >= 0 && point2.integerValue <= 5)) {
            Card *card = [[Card alloc] init];
            card.resId = @"";
            card.cardNumber = [NSNumber numberWithInt:0];
            card.validPoint = [NSNumber numberWithInt:0];
            card5 = card;
            if (needBurningCard) {
                card6 = [self getNextCard];
            } else {
                card6 = [self getAssignPositionCard:[NSNumber numberWithInteger:4]];
            }
        }

    }
    
    
    NSMutableArray *finalCards = [NSMutableArray arrayWithArray:cards];
    if (card5 != nil) {
        [finalCards addObject:card5];
    }
    
    if (card6 != nil) {
        [finalCards addObject:card6];
    }
    Result *finalResult = [[Result alloc] initWithCards:finalCards.copy];
    
//    if (finalResult.resultType == ResultDrawnGame && lastResultType == ResultDrawnGame) {
//        if (needBurningCard) {
//            [self insertCardsAtRandomIndex:finalCards];
//        } else {
//            [self repositionCardsAtRandomIndex:finalCards];
//        }
//        return [self getNextResult:needBurningCard];
//    }
//    
//    if (card1.cardNumber.integerValue != card3.cardNumber.integerValue) {
//        if (needBurningCard) {
//            [self insertCardsAtRandomIndex:finalCards];
//        } else {
//            [self repositionCardsAtRandomIndex:finalCards];
//        }
//        return [self getNextResult:needBurningCard];
//    }
    
//    if (finalResult.resultType == ResultDrawnGame) {
//        totalDrawnGame ++;
//        if (totalDrawnGame > 5) {
//            if (needBurningCard) {
//                [self insertCardsAtRandomIndex:finalCards];
//            } else {
//                [self repositionCardsAtRandomIndex:finalCards];
//            }
//            return [self getNextResult:needBurningCard];
//        }
//    }
    
//    if (card5 == nil || ![card5.resId isEqualToString:@""]) {
//        if (needBurningCard) {
//            [self insertCardsAtRandomIndex:finalCards];
//        } else {
//            [self repositionCardsAtRandomIndex:finalCards];
//        }
//        return [self getNextResult:needBurningCard];
//    }
    
//    if (playerCount < 3 && finalResult.resultType != ResultDrawnGame) {
//        NSLog(@"出和---->");
////        [self insertCardsAtRandomIndex:finalCards];
//        if (needBurningCard) {
//            [self insertCardsAtRandomIndex:finalCards];
//        } else {
//            [self repositionCardsAtRandomIndex:finalCards];
//        }
//        return [self getNextResult:needBurningCard];
//    } else {
//        playerCount++;
//    }
//
//    if (bankerCount < 7 && needBurningCard && finalResult.resultType != ResultPlayerWin) {
//        bankerCount++;
//        if (bankerCount == 7) {
//            playerCount = 0;
//        }
//        [self insertCardsAtRandomIndex:finalCards];
//        return [self getNextResult:needBurningCard];
//    }
    lastResultType = finalResult.resultType;
    
    if (self.cards.count < 100) {
        self.isLastGame = YES;
    }
    return finalResult;
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

- (void)repositionCardsAtRandomIndex:(NSArray *)cards
{
    if (cards != nil &&cards.count > 0) {
        for (Card *card in cards) {
            if ([self.cards containsObject:card]) {
                [self.cards removeObject:card];
                [self.cards insertObject:card atIndex:arc4random() % self.cards.count];
            }
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
    for(int i=0; i<8; i++) {
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
