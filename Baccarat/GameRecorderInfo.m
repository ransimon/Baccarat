//
//  GameRecorderInfo.m
//  Baccarat
//
//  Created by chenran on 16/6/30.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "GameRecorderInfo.h"

@implementation GameRecorderInfo


-(void)encodeWithCoder:(NSCoder *)aCoder{
    //encode properties/values
    [aCoder encodeObject:self.score forKey:@"score"];
    [aCoder encodeObject:self.time  forKey:@"time"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super init])) {
        //decode properties/values
        self.score = [aDecoder decodeObjectForKey:@"score"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
    }
    
    return self;
}
@end
