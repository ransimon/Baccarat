//
//  CardsBuilder.h
//  Baccarat
//
//  Created by chenran on 16/5/22.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface CardsBuilder : NSObject

+ (instancetype)shareObject;
- (NSArray *)getCardsByResult:(NSNumber *)result;

- (NSArray *)getNextCards:(NSNumber *)count;
-(Card *)getNextCard;

@property (nonatomic, strong) NSMutableArray *cards;


@end
