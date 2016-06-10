//
//  Card.h
//  Baccarat
//
//  Created by chenran on 16/5/22.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CardColorHT = 0,
    CardColorHX,
    CardColorMH,
    CardColorFK
}CardColor;

@interface Card : NSObject

@property (nonatomic, strong) NSString * resId;
@property (nonatomic, strong) NSNumber * validPoint;
@property (nonatomic, strong) NSNumber *cardNumber;
@property (nonatomic) CardColor cardColor;

@end
