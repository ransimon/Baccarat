//
//  ResultLargeSizeCell.m
//  Baccarat
//
//  Created by chenran on 16/6/19.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "ResultLargeSizeCell.h"

@implementation ResultLargeSizeCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self createViews];
    }
    return self;
}

- (void) createViews
{
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22, 22*6)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    imageView.layer.borderColor = [UIColor colorWithRed:0.01 green:0.01 blue:0.01 alpha:0.3].CGColor;
    imageView.layer.borderWidth = 0.5;
    [self.mainView addSubview:imageView];
}

@end
