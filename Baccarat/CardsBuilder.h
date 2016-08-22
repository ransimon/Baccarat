//
//  CardsBuilder.h
//  Baccarat
//
//  Created by chenran on 16/5/22.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Result.h"
@interface CardsBuilder : NSObject

+ (instancetype)shareObject;
- (Result *)getNextResult:(BOOL) needBurningCard;

- (NSArray *)getNextCards:(NSNumber *)count;
-(Card *)getNextCard;

@property (nonatomic, strong) NSMutableArray *cards;

@property (nonatomic) BOOL isLastGame;


@end
