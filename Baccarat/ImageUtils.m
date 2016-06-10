//
//  ImageUtils.m
//  Baccarat
//
//  Created by chenran on 16/6/4.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "ImageUtils.h"

@implementation ImageUtils

+ (NSArray *) fiveDigitScoreToChips:(NSString *)score
{
    
    NSMutableString *mScore = [score mutableCopy];
    if (mScore != nil && mScore.length > 0) {
        NSInteger scoreInt = [mScore integerValue];
        NSMutableArray *imgs = [[NSMutableArray alloc] init];
        NSInteger number_10000 = scoreInt / 10000;
        for (int i=0; i<number_10000; i++) {
            [imgs addObject:[UIImage imageNamed:@"chip_10000"]];
        }
        [mScore deleteCharactersInRange:NSMakeRange(0, 0)];
        NSArray *other = [self fourDigitScoreToChips:[mScore copy]];
        for (int i=0; i<other.count; i++) {
            [imgs addObject:[other objectAtIndex:i]];
        }
        return [imgs copy];
    }
    return nil;
}

+ (NSArray *) fourDigitScoreToChips:(NSString *)score
{
    NSMutableString *mScore = [score mutableCopy];
    if (mScore != nil && mScore.length > 0) {
        NSInteger scoreInt = [mScore integerValue];
        NSMutableArray *imgs = [[NSMutableArray alloc] init];
        NSInteger number_1000 = scoreInt / 1000;
        if (number_1000 > 0 && number_1000 < 5) {
            for (int i=0; i<number_1000; i++) {
                [imgs addObject:[UIImage imageNamed:@"chip_1000"]];
            }
        } else if (number_1000 == 5) {
            [imgs addObject:[UIImage imageNamed:@"chip_5000"]];
        } else if (number_1000 >5 && number_1000 < 10) {
            [imgs addObject:[UIImage imageNamed:@"chip_5000"]];
            for (int i=0; i<number_1000-5; i++) {
                [imgs addObject:[UIImage imageNamed:@"chip_1000"]];
            }
        }
        [mScore deleteCharactersInRange:NSMakeRange(0, 1)];
        NSArray *other = [self threeDigitScoreToChips:[mScore copy]];
        for (int i=0; i<other.count; i++) {
            [imgs addObject:[other objectAtIndex:i]];
        }
        return [imgs copy];
    }
    return nil;
}

+ (NSArray *) threeDigitScoreToChips:(NSString *)score
{
    if (score != nil && score.length > 0) {
        NSInteger scoreInt = [score integerValue];
        NSMutableArray *imgs = [[NSMutableArray alloc] init];
        NSInteger number_100 = scoreInt / 100;
        if (number_100 > 0 && number_100 <5) {
            for (int i=0; i<number_100; i++) {
                [imgs addObject:[UIImage imageNamed:@"chip_100"]];
            }
        } else if (number_100 == 5) {
            [imgs addObject:[UIImage imageNamed:@"chip_500"]];
        } else if (number_100 > 5 && number_100 < 10) {
            [imgs addObject:[UIImage imageNamed:@"chip_500"]];
            for (int i=0; i<number_100-5; i++) {
                [imgs addObject:[UIImage imageNamed:@"chip_100"]];
            }
        }
        
        return [imgs copy];
    }
    return nil;
}

+ (UIImage *)scoreToChips:(NSInteger)intScore
{
    NSString *score = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:intScore]];
    NSMutableArray *imgs = [[NSMutableArray alloc]init];
    UIImage *chipImage = nil;
    if (score.length == 5) {
        imgs = [[self fiveDigitScoreToChips:score] mutableCopy];
    } else if (score.length == 4) {
        imgs = [[self fourDigitScoreToChips:score] mutableCopy];
    } else if (score.length == 3){
        imgs = [[self threeDigitScoreToChips:score] mutableCopy];
    }
    
    
    if (imgs != nil && imgs.count > 0) {
        chipImage = [imgs objectAtIndex:0];
        for (int i=1; i<imgs.count; i++) {
            UIImage *img = [imgs objectAtIndex:i];
            CGSize size = CGSizeMake(chipImage.size.width, chipImage.size.height + 6);
            UIGraphicsBeginImageContext(size);
            
            [chipImage drawInRect:CGRectMake(0,6,chipImage.size.width, chipImage.size.height)];
            [img drawInRect:CGRectMake(0,0,img.size.width,img.size.height)];
            
            chipImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
        }
        return chipImage;

    }
    
    return nil;
    
}

+ (UIImage *)scoreToImage:(NSString *)score
{
    UIImage *scroreImage = [UIImage new];
    int count = 0;
    long length = score.length - 1;
    for (long i = length; i >= 0; i--) {
        // imageName will be @"1", then @"3" and @"2"
//        count ++;
//        if (count == 4) {
//            UIImage *commaImage = [UIImage imageNamed:@"comma"];
//            scroreImage = [self concateImageOne:scroreImage withImageTwo:commaImage];
//            count = 0;
//        }
        
        NSString *imageName = [NSString stringWithFormat:@"number_%c",[score characterAtIndex:i]];
        UIImage *image = [UIImage imageNamed:imageName];
        
        //[images addObject:image];
        scroreImage = [self concateImageOne:scroreImage withImageTwo:image];
        
    }
    return scroreImage;
}

+(UIImage*)concateImageOne:(UIImage*)image1 withImageTwo:(UIImage*)image2
{
    CGSize size = CGSizeMake(image1.size.width + image2.size.width, image2.size.height);
    UIGraphicsBeginImageContext(size);
    [image1 drawInRect:CGRectMake(image2.size.width,0,image1.size.width, size.height)];
    [image2 drawInRect:CGRectMake(0,0,image2.size.width, size.height)];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}


@end
