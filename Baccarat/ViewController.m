//
//  ViewController.m
//  Baccarat
//
//  Created by ; on 16/5/22.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "ViewController.h"
#import "CardsBuilder.h"
#import "ResultBuilder.h"
#import "UIGestureRecognizer+DraggingAdditions.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageUtils.h"
#import "BaccaratTheme.h"
#import "ChipBoardView.h"
#import "StitchingImage.h"
#import "Result.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ResultLargeSizeCell.h"
#import "MarkBuilder.h"
#import "MarkPoint.h"
#import "MLTableAlert.h"
#import "SettingViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIImageView *chip100Img;
@property (strong, nonatomic) UIImageView *chip500Img;
@property (strong, nonatomic) UIImageView *chip1000Img;
@property (strong, nonatomic) UIImageView *chip5000Img;
@property (strong, nonatomic) UIImageView *chip10000Img;

@property (strong, nonatomic) ChipBoardView *playerDoubleView;
@property (strong, nonatomic) ChipBoardView *sameView;
@property (strong, nonatomic) ChipBoardView *bankerDoubleView;
@property (strong, nonatomic) ChipBoardView *playerView;
@property (strong, nonatomic) ChipBoardView *bankerView;

@property (strong, nonatomic) UILabel *playerDoubleViewLabel;
@property (strong, nonatomic) UILabel *sameViewLabel;
@property (strong, nonatomic) UILabel *bankerDoubleViewLabel;
@property (strong, nonatomic) UILabel *playerViewLabel;
@property (strong, nonatomic) UILabel *bankerViewLabel;

//@property (weak, nonatomic) IBOutlet UIView *playerViewFlag;
//@property (weak, nonatomic) IBOutlet UIView *bankerViewFlag;

@property (strong, nonatomic) UIImageView *playerCard_1;
@property (strong, nonatomic) UIImageView *playerCard_2;
@property (strong, nonatomic) UIImageView *playerCard_3;
@property (strong, nonatomic) UIImageView *bankerCard_1;
@property (strong, nonatomic) UIImageView *bankerCard_2;
@property (strong, nonatomic) UIImageView *bankerCard_3;
@property (strong, nonatomic) UIImageView *playerPointView;
@property (strong, nonatomic) UIImageView *bankerPointView;

@property (weak, nonatomic) IBOutlet UIImageView *cardsBox;
@property (weak, nonatomic) IBOutlet UILabel *cardsNumber;

@property (weak, nonatomic) IBOutlet UIImageView *cardBg_1;
@property (weak, nonatomic) IBOutlet UIImageView *cardBg_2;
@property (weak, nonatomic) IBOutlet UIImageView *cardBg_3;
@property (weak, nonatomic) IBOutlet UIImageView *cardBg_4;
@property (weak, nonatomic) IBOutlet UIImageView *cardBg_5;
@property (weak, nonatomic) IBOutlet UIImageView *cardBg_6;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImage;
@property (weak, nonatomic) IBOutlet UIView *scoreImageBg;

@property (weak, nonatomic) IBOutlet UIView *whiteLineView;

@property (strong, nonatomic) UIButton *potBtn;
@property (strong, nonatomic) UIButton *recycelBtn;
@property (strong, nonatomic) UIButton *tipBtn;
@property (strong, nonatomic) UIButton *settingBtn;

@property (weak, nonatomic) IBOutlet UIView *cutCardsContainer;
@property (weak, nonatomic) IBOutlet UIImageView *cutPointView;

@property (strong, nonatomic) UIImageView *selectChipImg;

@property (strong, nonatomic) UIImageView *totalPlayerChipView;
@property (strong, nonatomic) UIImageView *totalBankerChipView;
@property (strong, nonatomic) UIImageView *totalPlayerDoubleChipView;
@property (strong, nonatomic) UIImageView *totalBankerDoubleChipView;
@property (strong, nonatomic) UIImageView *totalSameChipView;

@property (strong, nonatomic) UIImageView *winPlayerChipView;
@property (strong, nonatomic) UIImageView *winBankerChipView;
@property (strong, nonatomic) UIImageView *winPlayerDoubleChipView;
@property (strong, nonatomic) UIImageView *winBankerDoubleChipView;
@property (strong, nonatomic) UIImageView *winSameChipView;

@property (strong, nonatomic) UIImageView *cardsView;
@property (strong, nonatomic) UIImageView *cutCardsView;

@property (strong, nonatomic) UIImageView *cutCardsView1;
@property (strong, nonatomic) UIImageView *cutCardsView2;

@property (strong, nonatomic) UIView *burningCardContainer1;
@property (strong, nonatomic) UIView *burningCardContainer2;

@property (strong, nonatomic) UIView *markContainer;
@property (strong, nonatomic) UIImageView *markContainerBg;
@property (strong, nonatomic) UIScrollView *markView1;
@property (strong, nonatomic) UIScrollView *markView2;
@property (strong, nonatomic) UIScrollView *markView3;
@property (strong, nonatomic) UIScrollView *markView4;
@property (strong, nonatomic) UIScrollView *markView5;

@property (strong, nonatomic) UIImageView *markViewImage1;
@property (strong, nonatomic) UIImageView *markViewImage2;
@property (strong, nonatomic) UIImageView *markViewImage3;
@property (strong, nonatomic) UIImageView *markViewImage4;
@property (strong, nonatomic) UIImageView *markViewImage5;

@property (strong, nonatomic) UILabel *playerWinCountLabel;
@property (strong, nonatomic) UILabel *bankerWinCountLabel;
@property (strong, nonatomic) UILabel *bornCardCountLabel;
@property (strong, nonatomic) UILabel *drawnGameCountLabel;
@property (strong, nonatomic) UILabel *playerDoubelCountLabel;
@property (strong, nonatomic) UILabel *bankerDoubelCountLabel;

@property (nonatomic, strong) CardsBuilder *cardsBuilder;
@property (nonatomic, strong) ResultBuilder *resultBuilder;
@property (nonatomic, strong) MarkBuilder *markBuilder;

@property (nonatomic, strong) NSMutableArray *allResult;

@property (nonatomic, strong) Result *currentResult;

@property (nonatomic, strong) NSArray *evaluteViews;


@property (nonatomic, strong) NSNumber *playerPoint;
@property (nonatomic, strong) NSNumber *bankerPoint;


@property (nonatomic, strong) NSNumber *animationDuration;

//卡牌飞入动画
@property (nonatomic, strong) CABasicAnimation *anim1;
@property (nonatomic, strong) CABasicAnimation *anim2;
@property (nonatomic, strong) CABasicAnimation *anim3;
@property (nonatomic, strong) CABasicAnimation *anim4;
@property (nonatomic, strong) CABasicAnimation *anim5;
@property (nonatomic, strong) CABasicAnimation *anim6;

//卡牌平移动画
@property (nonatomic, strong) CABasicAnimation *animPlayerCard2;
@property (nonatomic, strong) CABasicAnimation *animBankerCard2;

@property (nonatomic, strong) NSMutableArray *chipFloatingViews;

@property (nonatomic, strong) MLTableAlert *alert;


@end

@implementation ViewController
{
    double cardBgX;
    double cardBgY;
    double playerCard_y;
    double bankerCard_y;
    double animationTime;
    
    CGFloat chipCenterX;
    CGFloat chipCenterY;
    NSInteger sameScore;
    NSInteger playerScore;
    NSInteger bankerScore;
    NSInteger playerDoubleScore;
    NSInteger bankerDoubleScore;
    NSInteger totalScore;
    NSInteger totalBetScore;
    NSInteger totalWinScore;
    CGFloat cutCardsView_X;
    CGFloat markOffset;
    BOOL isChanged;
    BOOL isOpenSound;
    BOOL isGameStart;
    BOOL isFirstTimeStart;
}

- (void)awakeFromNib
{
    NSLog(@"awakeFromNib------>");
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self!=nil) {
        NSLog(@"initWithCoder------>");
    }
    return self;
}


- (void)viewDidLoad {
    NSLog(@"viewDidLoad------>");
    [super viewDidLoad];
    markOffset = 10;
    [self initView];
    // Do any additional setup after loading the view, typically from a nib.
    self.chipFloatingViews = [[NSMutableArray alloc] init];
    self.allResult = [[NSMutableArray alloc] init];
    self.cardsBuilder = [CardsBuilder shareObject];
    self.resultBuilder = [ResultBuilder shareObject];
    self.markBuilder = [MarkBuilder shareObject];
    [self.resultBuilder resetResultByPoint:[NSNumber numberWithInteger:0]];
    self.evaluteViews = [[NSMutableArray alloc]init];
    cardBgX = self.cardBg_1.center.x;
    cardBgY = self.cardBg_1.center.y;
    playerCard_y = self.playerCard_1.center.y;
    bankerCard_y = self.bankerCard_1.center.y;
    animationTime = 0.6;
    totalScore = 10000;
    // 取
    totalScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"totalScore"];
    if (totalScore == 0) {
        totalScore = 10000;
        [[NSUserDefaults standardUserDefaults] setInteger:totalScore forKey:@"totalScore"];
    }
    isOpenSound = YES;
    isGameStart = YES;
    isFirstTimeStart = YES;
    self.animationDuration = [NSNumber numberWithInteger:1];
    [self initEvaluteViews];
    [self addFloatingChipViewByPoint:100];
    [self addFloatingChipViewByPoint:500];
    [self addFloatingChipViewByPoint:1000];
    [self addFloatingChipViewByPoint:5000];
    [self addFloatingChipViewByPoint:10000];
    if (self.view.frame.size.width > self.view.frame.size.height) {
        [self initLandscapeView];
    } else {
        [self initPortraitView];
    }
    [self configUi];
    [self updateScore];
    self.chip100Img.highlighted = YES;
    self.selectChipImg = self.chip100Img;
    chipCenterX = self.chip100Img.center.x;
    chipCenterY = self.chip100Img.center.y;
    [self playVoiceByFile:@"WelcomeToTheTable_cn"];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(cutCard) userInfo:nil repeats:NO];//切卡
}

- (void)dealloc
{
    NSLog(@"dealloc---->");
}

- (void) changeFloatingChipViewPosition
{
    if (self.chipFloatingViews != nil) {
        for (int i=0; i<self.chipFloatingViews.count; i++) {
            UIImageView* chipFloat = [self.chipFloatingViews objectAtIndex:i];
            NSInteger point = chipFloat.tag;
            if (point == 100) {
                chipFloat.center = CGPointMake(self.chip100Img.center.x, self.chip100Img.center.y);
            } else if (point == 500) {
                chipFloat.center = CGPointMake(self.chip500Img.center.x, self.chip500Img.center.y);
            } else if (point == 1000) {
                chipFloat.center = CGPointMake(self.chip1000Img.center.x, self.chip1000Img.center.y);
            } else if (point == 5000) {
                chipFloat.center = CGPointMake(self.chip5000Img.center.x, self.chip5000Img.center.y);
            } else if (point == 10000) {
                chipFloat.center = CGPointMake(self.chip10000Img.center.x, self.chip10000Img.center.y);
            }
        }
    }
}

- (void) addFloatingChipViewByPoint:(NSInteger)point
{
    UIImageView *chipFloat = [[UIImageView alloc] init];
    if (point == 100) {
        chipFloat.frame = CGRectMake(self.chip100Img.frame.origin.x, self.chip100Img.frame.origin.y, self.chip100Img.frame.size.width, self.chip100Img.frame.size.height);
        self.selectChipImg = self.chip100Img;
        [self.view insertSubview:chipFloat aboveSubview:self.chip100Img];
    } else if (point == 500) {
        chipFloat.frame = CGRectMake(self.chip500Img.frame.origin.x, self.chip500Img.frame.origin.y, self.chip500Img.frame.size.width, self.chip500Img.frame.size.height);
        self.selectChipImg = self.chip500Img;
        [self.view insertSubview:chipFloat aboveSubview:self.chip500Img];
    } else if (point == 1000) {
        chipFloat.frame = CGRectMake(self.chip1000Img.frame.origin.x, self.chip1000Img.frame.origin.y, self.chip1000Img.frame.size.width, self.chip1000Img.frame.size.height);
        self.selectChipImg = self.chip1000Img;
        [self.view insertSubview:chipFloat aboveSubview:self.chip1000Img];
    } else if (point == 5000) {
        chipFloat.frame = CGRectMake(self.chip5000Img.frame.origin.x, self.chip5000Img.frame.origin.y, self.chip5000Img.frame.size.width, self.chip5000Img.frame.size.height);
        self.selectChipImg = self.chip5000Img;
        [self.view insertSubview:chipFloat aboveSubview:self.chip5000Img];
    } else if (point == 10000) {
        chipFloat.frame = CGRectMake(self.chip10000Img.frame.origin.x, self.chip10000Img.frame.origin.y, self.chip10000Img.frame.size.width, self.chip10000Img.frame.size.height);
        self.selectChipImg = self.chip10000Img;
        [self.view insertSubview:chipFloat aboveSubview:self.chip10000Img];
    }
    
    chipFloat.image = [UIImage imageNamed:[NSString stringWithFormat:@"chip_%d", point]];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
    chipFloat.userInteractionEnabled = YES;
    chipFloat.tag = point;
    [chipFloat addGestureRecognizer:panRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChipTapRecognizer:)];
    [chipFloat addGestureRecognizer:tapRecognizer];
    [self.chipFloatingViews addObject:chipFloat];
}

- (UIImageView *) getChipFloatingViewByScore: (NSInteger)score
{
    for (int i=0; i<self.chipFloatingViews.count; i++) {
        UIImageView *chipFloat = [self.chipFloatingViews objectAtIndex:i];
        if (chipFloat.tag == score) {
            return chipFloat;
        }
    }
    return nil;
}


- (void) initAnim
{
    self.anim1 = [CABasicAnimation animation];
    self.anim1.keyPath = @"position";
    self.anim1.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
    self.anim1.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_1.center.x, self.playerCard_1.center.y)];
    self.anim1.removedOnCompletion=YES;
    self.anim1.fillMode = kCAFillModeRemoved;
    self.anim1.duration = animationTime;
    self.anim1.delegate = self;
    [self.anim1 setValue:@"anim1" forKey:@"anim"];
    
    self.anim2 = [CABasicAnimation animation];
    self.anim2.keyPath = @"position";
    self.anim2.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
    self.anim2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_1.center.x, self.bankerCard_1.center.y)];
    self.anim2.removedOnCompletion=YES;
    self.anim2.fillMode = kCAFillModeRemoved;
    self.anim2.duration = animationTime;
    self.anim2.beginTime = CACurrentMediaTime() + animationTime + 0.5;
    self.anim2.delegate = self;
    [self.anim2 setValue:@"anim2" forKey:@"anim"];
    
    self.anim3 = [CABasicAnimation animation];
    self.anim3.keyPath = @"position";
    self.anim3.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
    self.anim3.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x, self.playerCard_2.center.y)];
    self.anim3.removedOnCompletion=YES;
    self.anim3.fillMode = kCAFillModeRemoved;
    self.anim3.duration = animationTime;
    self.anim3.beginTime = CACurrentMediaTime() + animationTime*2 + 1;
    self.anim3.delegate = self;
    [self.anim3 setValue:@"anim3" forKey:@"anim"];
    
    
    self.anim4 = [CABasicAnimation animation];
    self.anim4.keyPath = @"position";
    self.anim4.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
    self.anim4.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x, self.bankerCard_2.center.y)];
    self.anim4.removedOnCompletion=YES;
    self.anim4.fillMode = kCAFillModeRemoved;
    self.anim4.duration = animationTime;
    self.anim4.beginTime = CACurrentMediaTime() + animationTime*3 + 1.5;
    self.anim4.delegate = self;
    [self.anim4 setValue:@"anim4" forKey:@"anim"];
    
    self.anim5 = [CABasicAnimation animation];
    self.anim5.keyPath = @"position";
    self.anim5.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
    self.anim5.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_3.center.x, self.playerCard_3.center.y)];
    self.anim5.removedOnCompletion=YES;
    self.anim5.fillMode = kCAFillModeRemoved;
    self.anim5.duration = animationTime;
    self.anim5.beginTime = CACurrentMediaTime() + animationTime*4 + 2;
    self.anim5.delegate = self;
    [self.anim5 setValue:@"anim5" forKey:@"anim"];
    
    self.anim6 = [CABasicAnimation animation];
    self.anim6.keyPath = @"position";
    self.anim6.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
    self.anim6.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_3.center.x, self.bankerCard_3.center.y)];
    self.anim6.removedOnCompletion=YES;
    self.anim6.fillMode = kCAFillModeRemoved;
    self.anim6.duration = animationTime;
    self.anim6.beginTime = CACurrentMediaTime() + animationTime*5 + 2.5;
    self.anim6.delegate = self;
    [self.anim6 setValue:@"anim6" forKey:@"anim"];
    
    self.animPlayerCard2 = [CABasicAnimation animation];
    self.animPlayerCard2.keyPath = @"position";
    self.animPlayerCard2.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x, self.playerCard_2.center.y)];
    self.animPlayerCard2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x-60, self.playerCard_2.center.y)];
    self.animPlayerCard2.removedOnCompletion=NO;
    self.animPlayerCard2.fillMode = kCAFillModeForwards;
    self.animPlayerCard2.duration = animationTime;
    self.animPlayerCard2.beginTime = CACurrentMediaTime() + animationTime*4 + 2;
    
    self.animBankerCard2 = [CABasicAnimation animation];
    self.animBankerCard2.keyPath = @"position";
    self.animBankerCard2.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x, self.bankerCard_2.center.y)];
    self.animBankerCard2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x - 60, self.bankerCard_2.center.y)];
    self.animBankerCard2.removedOnCompletion=NO;
    self.animBankerCard2.fillMode = kCAFillModeForwards;
    self.animBankerCard2.duration = animationTime;
    self.animBankerCard2.beginTime = CACurrentMediaTime() + animationTime*5 + 2.5;
}

- (NSString *) getVoiceNameByBumber:(NSNumber *)number
{
    if (number.integerValue == 8 || number.integerValue == 9) {
        return [NSString stringWithFormat:@"Natural_no_%d_cn", number.integerValue];
    }
    return [NSString stringWithFormat:@"no_%d_cn",number.intValue];
}

- (void) playVoiceByFileDelay:(NSTimer *)timer
{
    NSString *soundFile = [[timer userInfo] objectForKey:@"sound"];
    SystemSoundID soundID;
    NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:soundFile ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
    AudioServicesPlaySystemSound(soundID);
}

- (void) playVoiceByFile:(NSString *)fileName
{
    SystemSoundID soundID;
    NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
    AudioServicesPlaySystemSound(soundID);
}

- (void) playSoundByFile:(NSString *)fileName
{
    if (isOpenSound) {
        SystemSoundID soundID;
        NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
        AudioServicesPlaySystemSound(soundID);
    }
}

- (void) playSoundByFileDelay:(NSTimer *)timer
{
    if (isOpenSound) {
        NSString *soundFile = [[timer userInfo] objectForKey:@"sound"];
        SystemSoundID soundID;
        NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:soundFile ofType:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
        AudioServicesPlaySystemSound(soundID);
    }
}

- (void) initEvaluteViews
{
    self.evaluteViews = @[self.playerView, self.bankerView, self.playerDoubleView, self.bankerDoubleView, self.sameView];
    
}

- (void) initView
{
    self.chip100Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chip_100"]];
    self.chip500Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chip_500"]];
    self.chip1000Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chip_1000"]];
    self.chip5000Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chip_5000"]];
    self.chip10000Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chip_10000"]];
    
    self.tipBtn = [[UIButton alloc] init];
    self.settingBtn = [[UIButton alloc] init];
    self.potBtn = [[UIButton alloc] init];
    self.recycelBtn = [[UIButton alloc] init];
    
    [self.recycelBtn setImage:[UIImage imageNamed:@"recycle_btn"] forState:UIControlStateNormal];
    [self.recycelBtn setImage:[UIImage imageNamed:@"recycle_btn_s"] forState:UIControlStateHighlighted];
    self.recycelBtn.bounds = CGRectMake(0, 0, self.recycelBtn.currentImage.size.width, self.recycelBtn.currentImage.size.height);
    [self.potBtn setImage:[UIImage imageNamed:@"pot_btn"] forState:UIControlStateNormal];
    [self.potBtn setImage:[UIImage imageNamed:@"pot_btn_s"] forState:UIControlStateHighlighted];
    self.potBtn.bounds = CGRectMake(0, 0, self.potBtn.currentImage.size.width, self.potBtn.currentImage.size.height);
    
    [self.settingBtn setImage:[UIImage imageNamed:@"setting_btn"] forState:UIControlStateNormal];
    self.settingBtn.bounds = CGRectMake(0, 0, self.settingBtn.currentImage.size.width, self.settingBtn.currentImage.size.height);
    
    [self.tipBtn setImage:[UIImage imageNamed:@"system_btn"] forState:UIControlStateNormal];
    self.tipBtn.bounds = CGRectMake(0, 0, self.tipBtn.currentImage.size.width, self.tipBtn.currentImage.size.height);
    
    self.tipBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *recongnizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSystemAlert:)];
    [self.tipBtn addGestureRecognizer:recongnizer1];
    
    self.settingBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *recongnizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSettingBtnClicked:)];
    [self.settingBtn addGestureRecognizer:recongnizer2];
    
    self.scoreImageBg.userInteractionEnabled = YES;
    UITapGestureRecognizer *recongnizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBuyChipsAlert:)];
    [self.scoreImageBg addGestureRecognizer:recongnizer3];
    
    self.sameView = [[ChipBoardView alloc] init];
    self.playerDoubleView = [[ChipBoardView alloc] init];
    self.bankerDoubleView = [[ChipBoardView alloc] init];
    self.playerView = [[ChipBoardView alloc] init];
    self.bankerView = [[ChipBoardView alloc] init];
    
    self.sameViewLabel = [[UILabel alloc] init];
    self.playerDoubleViewLabel = [[UILabel alloc] init];
    self.bankerDoubleViewLabel = [[UILabel alloc] init];
    self.playerViewLabel = [[UILabel alloc] init];
    self.bankerViewLabel = [[UILabel alloc] init];
    
    self.sameViewLabel.bounds = CGRectMake(0, 0, 50, 21);
    self.playerDoubleViewLabel.bounds = CGRectMake(0, 0, 50, 21);
    self.bankerDoubleViewLabel.bounds = CGRectMake(0, 0, 50, 21);
    self.playerViewLabel.bounds = CGRectMake(0, 0, 50, 21);
    self.bankerViewLabel.bounds = CGRectMake(0, 0, 50, 21);
    
    self.sameViewLabel.font = [UIFont fontWithName:@"Regular" size:19];
    self.playerDoubleViewLabel.font = [UIFont fontWithName:@"Regular" size:19];
    self.bankerDoubleViewLabel.font = [UIFont fontWithName:@"Regular" size:19];
    self.playerViewLabel.font = [UIFont fontWithName:@"Regular" size:19];
    self.bankerViewLabel.font = [UIFont fontWithName:@"Regular" size:19];
    
    self.sameViewLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#FFFFFF" alpha:1];
    self.playerDoubleViewLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#FFFFFF" alpha:1];
    self.bankerDoubleViewLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#FFFFFF" alpha:1];
    self.playerViewLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#FFFFFF" alpha:1];
    self.bankerViewLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#FFFFFF" alpha:1];
    
    self.playerCard_1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fk_1"]];
    self.playerCard_2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fk_1"]];
    self.playerCard_3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fk_1"]];
    self.bankerCard_1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fk_1"]];
    self.bankerCard_2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fk_1"]];
    self.bankerCard_3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fk_1"]];
    
    self.playerPointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"point_player_0"]];
    self.bankerPointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"point_banker_0"]];
    
    [self.view addSubview:self.tipBtn];
    [self.view addSubview:self.settingBtn];
    [self.view addSubview:self.potBtn];
    [self.view addSubview:self.recycelBtn];
    
    [self.view addSubview:self.sameView];
    [self.view addSubview:self.playerDoubleView];
    [self.view addSubview:self.bankerDoubleView];
    [self.view addSubview:self.bankerView];
    [self.view addSubview:self.playerView];
    
    [self.view addSubview:self.sameViewLabel];
    [self.view addSubview:self.playerDoubleViewLabel];
    [self.view addSubview:self.bankerDoubleViewLabel];
    [self.view addSubview:self.bankerViewLabel];
    [self.view addSubview:self.playerViewLabel];
    
    [self.view addSubview:self.chip100Img];
    [self.view addSubview:self.chip500Img];
    [self.view addSubview:self.chip1000Img];
    [self.view addSubview:self.chip5000Img];
    [self.view addSubview:self.chip10000Img];
    
    [self.view addSubview:self.playerCard_1];
    [self.view addSubview:self.playerCard_2];
    [self.view addSubview:self.playerCard_3];
    [self.view addSubview:self.bankerCard_1];
    [self.view addSubview:self.bankerCard_2];
    [self.view addSubview:self.bankerCard_3];
    
    [self.view addSubview:self.playerPointView];
    [self.view addSubview:self.bankerPointView];
    
    self.markContainer = [[UIView alloc] init];
    self.markContainer.bounds = CGRectMake(0, -20, 640, 612);
    
    self.markContainerBg = [[UIImageView alloc] init];
    self.markContainerBg.frame = CGRectMake(0, 0, 640, 612);
    self.markContainerBg.contentMode = UIViewContentModeScaleToFill;
    self.markContainerBg.image = [UIImage imageNamed:@"tableview_bg"];
    
    [self.markContainer addSubview:self.markContainerBg];
    
    UIImage *mark1 = [UIImage imageNamed:@"marking_scroll_25"];
    UIImage *mark2 = [UIImage imageNamed:@"marking_scroll_50"];
    UIImage *mark3 = [UIImage imageNamed:@"marking_scroll_50"];
    UIImage *mark4 = [UIImage imageNamed:@"marking_scroll_50"];
    UIImage *mark5 = [UIImage imageNamed:@"marking_scroll_25"];
    
    self.markView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset, markOffset, mark1.size.width, mark1.size.height)];
    self.markView1.scrollEnabled = YES;
    self.markView1.contentSize =  CGSizeMake(mark1.size.width*4, 0);
    self.markViewImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark1.size.width, mark1.size.height)];
    self.markViewImage1.image = mark1;
    [self.markView1 addSubview:self.markViewImage1];
    
    self.markView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset, markOffset+mark1.size.height+1, mark2.size.width, mark2.size.height*2)];
    self.markView2.scrollEnabled = YES;
    self.markView2.contentSize =  CGSizeMake(mark2.size.width*2, 0);
    self.markViewImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark2.size.width*2, mark2.size.height*2)];
    self.markViewImage2.image = mark2;
    [self.markView2 addSubview:self.markViewImage2];
    
    self.markView3 = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset, markOffset+mark1.size.height*1.5+2, mark3.size.width, mark3.size.height*2)];
    self.markView3.scrollEnabled = YES;
    self.markView3.contentSize =  CGSizeMake(mark3.size.width*2, 0);
    self.markViewImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark3.size.width*2, mark3.size.height*2)];
    self.markViewImage3.image = mark3;
    [self.markView3 addSubview:self.markViewImage3];
    
    self.markView4 = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset, markOffset+mark1.size.height*2+3, mark4.size.width, mark4.size.height*2)];
    self.markView4.scrollEnabled = YES;
    self.markView4.contentSize =  CGSizeMake(mark4.size.width*2, 0);
    self.markViewImage4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark4.size.width*2, mark4.size.height*2)];
    self.markViewImage4.image = mark4;
    [self.markView4 addSubview:self.markViewImage4];
    
    self.markView5 = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset, markOffset+mark1.size.height*2.5+3, mark5.size.width, mark5.size.height*2)];
    self.markView5.scrollEnabled = YES;
    self.markView5.contentSize =  CGSizeMake(mark5.size.width*2, 0);
    self.markViewImage5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark5.size.width*2, mark5.size.height*2)];
    self.markViewImage5.image = mark5;
    [self.markView5 addSubview:self.markViewImage5];
    
    UIImageView *playerLabelImg =[[UIImageView alloc] init];
    UIImageView *bankerLabelImg =[[UIImageView alloc] init];
    playerLabelImg.bounds = CGRectMake(0, 0, 23, 23);
    bankerLabelImg.bounds = CGRectMake(0, 0, 23, 23);
    
    playerLabelImg.image = [UIImage imageNamed:@"player_flag"];
    bankerLabelImg.image = [UIImage imageNamed:@"banker_flag"];
    
    playerLabelImg.center = CGPointMake(580, 30);
    bankerLabelImg.center = CGPointMake(610, 30);
    
    UIImageView *playerEmpty =[[UIImageView alloc] init];
    UIImageView *bankerEmpty =[[UIImageView alloc] init];
    
    playerEmpty.bounds = CGRectMake(0, 0, 21, 21);
    bankerEmpty.bounds = CGRectMake(0, 0, 21, 21);
    
    playerEmpty.image = [UIImage imageNamed:@"banker_win_empty"];
    bankerEmpty.image = [UIImage imageNamed:@"player_win_empty"];
    
    playerEmpty.center = CGPointMake(580, 70);
    bankerEmpty.center = CGPointMake(610, 70);
    
    UIImageView *playerFill =[[UIImageView alloc] init];
    UIImageView *bankerFill =[[UIImageView alloc] init];
    
    playerFill.bounds = CGRectMake(0, 0, 21, 21);
    bankerFill.bounds = CGRectMake(0, 0, 21, 21);
    
    playerFill.image = [UIImage imageNamed:@"banker_win_fill"];
    bankerFill.image = [UIImage imageNamed:@"player_win_fill"];
    
    playerFill.center = CGPointMake(580, 110);
    bankerFill.center = CGPointMake(610, 110);
    
    UIImageView *playerStripe =[[UIImageView alloc] init];
    UIImageView *bankerStripe =[[UIImageView alloc] init];
    
    playerStripe.bounds = CGRectMake(0, 0, 21, 21);
    bankerStripe.bounds = CGRectMake(0, 0, 21, 21);
    
    playerStripe.image = [UIImage imageNamed:@"banker_win_stripe"];
    bankerStripe.image = [UIImage imageNamed:@"player_win_stripe"];
    
    playerStripe.center = CGPointMake(580, 150);
    bankerStripe.center = CGPointMake(610, 150);
    
    UIImageView *wordT =[[UIImageView alloc] init];
    UIImageView *wordA =[[UIImageView alloc] init];
    
    wordT.bounds = CGRectMake(0, 0, 48, 48);
    wordA.bounds = CGRectMake(0, 0, 48, 48);
    
    wordT.image = [UIImage imageNamed:@"word_t"];
    wordA.image = [UIImage imageNamed:@"word_a"];
    
    wordT.center = CGPointMake(595, 210);
    wordA.center = CGPointMake(595, 280);
    
    UILabel *playerLittleLabelImg = [[UILabel alloc] init];
    playerLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    playerLittleLabelImg.center = CGPointMake(585, 340);
    playerLittleLabelImg.font = [UIFont fontWithName:@"Regular" size:19];
    playerLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    playerLittleLabelImg.text = @"闲";
    
    self.playerWinCountLabel = [[UILabel alloc] init];
    self.playerWinCountLabel.bounds = CGRectMake(0, 0, 30, 21);
    self.playerWinCountLabel.center = CGPointMake(625, 340);
    self.playerWinCountLabel.font = [UIFont fontWithName:@"Regular" size:19];
    self.playerWinCountLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    self.playerWinCountLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    UILabel* bankerLittleLabelImg = [[UILabel alloc] init];
    bankerLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    bankerLittleLabelImg.center = CGPointMake(585, 370);
    bankerLittleLabelImg.font = [UIFont fontWithName:@"Regular" size:19];
    bankerLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    bankerLittleLabelImg.text = @"庄";
    
    self.bankerWinCountLabel = [[UILabel alloc] init];
    self.bankerWinCountLabel.bounds = CGRectMake(0, 0, 30, 21);
    self.bankerWinCountLabel.center = CGPointMake(625, 370);
    self.bankerWinCountLabel.font = [UIFont fontWithName:@"Regular" size:19];
    self.bankerWinCountLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    self.bankerWinCountLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    UILabel *drawnGameLittleLabelImg = [[UILabel alloc] init];
    drawnGameLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    drawnGameLittleLabelImg.center = CGPointMake(585, 400);
    drawnGameLittleLabelImg.font = [UIFont fontWithName:@"Regular" size:19];
    drawnGameLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#187E1F" alpha:1];
    drawnGameLittleLabelImg.text = @"和";
    
    self.drawnGameCountLabel = [[UILabel alloc] init];
    self.drawnGameCountLabel.bounds = CGRectMake(0, 0, 30, 21);
    self.drawnGameCountLabel.center = CGPointMake(625, 400);
    self.drawnGameCountLabel.font = [UIFont fontWithName:@"Regular" size:19];
    self.drawnGameCountLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#187E1F" alpha:1];
    self.drawnGameCountLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    UILabel *bornCardLittleLabelImg = [[UILabel alloc] init];
    bornCardLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    bornCardLittleLabelImg.center = CGPointMake(585, 430);
    bornCardLittleLabelImg.font = [UIFont fontWithName:@"Regular" size:19];
    bornCardLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#FCBE2D" alpha:1];
    bornCardLittleLabelImg.text = @"天牌";
    
    self.bornCardCountLabel = [[UILabel alloc] init];
    self.bornCardCountLabel.bounds = CGRectMake(0, 0, 30, 21);
    self.bornCardCountLabel.center = CGPointMake(625, 430);
    self.bornCardCountLabel.font = [UIFont fontWithName:@"Regular" size:19];
    self.bornCardCountLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#FCBE2D" alpha:1];
    self.bornCardCountLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    
    UILabel *playerDoubelLittleLabelImg = [[UILabel alloc] init];
    playerDoubelLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    playerDoubelLittleLabelImg.center = CGPointMake(585, 460);
    playerDoubelLittleLabelImg.font = [UIFont fontWithName:@"Regular" size:19];
    playerDoubelLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    playerDoubelLittleLabelImg.text = @"闲对";
    
    self.playerDoubelCountLabel = [[UILabel alloc] init];
    self.playerDoubelCountLabel.bounds = CGRectMake(0, 0, 30, 21);
    self.playerDoubelCountLabel.center = CGPointMake(625, 460);
    self.playerDoubelCountLabel.font = [UIFont fontWithName:@"Regular" size:19];
    self.playerDoubelCountLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    self.playerDoubelCountLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    UILabel *bankerDoubelLittleLabelImg = [[UILabel alloc] init];
    bankerDoubelLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    bankerDoubelLittleLabelImg.center = CGPointMake(585, 490);
    bankerDoubelLittleLabelImg.font = [UIFont fontWithName:@"Regular" size:19];
    bankerDoubelLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    bankerDoubelLittleLabelImg.text = @"庄对";
    
    self.bankerDoubelCountLabel = [[UILabel alloc] init];
    self.bankerDoubelCountLabel.bounds = CGRectMake(0, 0, 30, 21);
    self.bankerDoubelCountLabel.center = CGPointMake(625, 490);
    self.bankerDoubelCountLabel.font = [UIFont fontWithName:@"Regular" size:19];
    self.bankerDoubelCountLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    self.bankerDoubelCountLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    [self.markContainer addSubview:self.markView1];
    [self.markContainer addSubview:self.markView2];
    [self.markContainer addSubview:self.markView3];
    [self.markContainer addSubview:self.markView4];
    [self.markContainer addSubview:self.markView5];
    [self.markContainer addSubview:playerLabelImg];
    [self.markContainer addSubview:bankerLabelImg];
    [self.markContainer addSubview:playerEmpty];
    [self.markContainer addSubview:bankerEmpty];
    [self.markContainer addSubview:playerFill];
    [self.markContainer addSubview:bankerFill];
    [self.markContainer addSubview:playerStripe];
    [self.markContainer addSubview:bankerStripe];
    [self.markContainer addSubview:wordT];
    [self.markContainer addSubview:wordA];
    [self.markContainer addSubview:self.playerWinCountLabel];
    [self.markContainer addSubview:playerLittleLabelImg];
    [self.markContainer addSubview:self.bankerWinCountLabel];
    [self.markContainer addSubview:bankerLittleLabelImg];
    [self.markContainer addSubview:self.drawnGameCountLabel];
    [self.markContainer addSubview:drawnGameLittleLabelImg];
    [self.markContainer addSubview:self.playerDoubelCountLabel];
    [self.markContainer addSubview:playerDoubelLittleLabelImg];
    [self.markContainer addSubview:self.bankerDoubelCountLabel];
    [self.markContainer addSubview:bankerDoubelLittleLabelImg];
    [self.markContainer addSubview:self.bornCardCountLabel];
    [self.markContainer addSubview:bornCardLittleLabelImg];
    
    UIView *dismissContainer = [[UIView alloc] initWithFrame:CGRectMake(self.markContainer.frame.size.width - 70, self.markContainer.frame.size.height - 70, 42, 42)];
    dismissContainer.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOrHideMarkContainer:)];
    [dismissContainer addGestureRecognizer:recongnizer];
    [self.markContainer addSubview:dismissContainer];
    
    
    
    [self.view addSubview:self.markContainer];
    self.markContainer.hidden = YES;
}

- (void) initCardsPosition
{
    self.playerCard_1.center = CGPointMake(self.whiteLineView.center.x - self.playerCard_1.image.size.width*1.5 - 20,self.whiteLineView.center.y);
    self.playerCard_2.center = CGPointMake(self.whiteLineView.center.x - self.playerCard_2.image.size.width*0.5 - 10,self.whiteLineView.center.y);
    self.playerCard_3.center = CGPointMake(self.whiteLineView.center.x - self.playerCard_3.image.size.width*0.5 - 10,self.whiteLineView.center.y);
    
    self.bankerCard_1.center = CGPointMake(self.whiteLineView.center.x + self.bankerCard_1.image.size.width*0.5 + 10,self.whiteLineView.center.y);
    self.bankerCard_2.center = CGPointMake(self.whiteLineView.center.x + self.bankerCard_2.image.size.width*1.5 + 20,self.whiteLineView.center.y);
    self.bankerCard_3.center = CGPointMake(self.whiteLineView.center.x + self.bankerCard_3.image.size.width*1.5 + 20,self.whiteLineView.center.y);
    
    self.playerPointView.center = CGPointMake(self.playerCard_1.center.x - 100, self.playerCard_1.center.y);
    self.bankerPointView.center = CGPointMake(self.bankerCard_2.center.x + 100, self.bankerCard_3.center.y);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval) duration {
    
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        [self initPortraitView];
    } else {
        [self initLandscapeView];
    }
}

- (void) initLandscapeView
{
    [self initCardsPosition];
    self.markContainer.center = CGPointMake(self.view.center.x, 306);
    self.tipBtn.center = CGPointMake(self.scoreImageBg.center.x - self.scoreImageBg.frame.size.width / 2 - 50, self.scoreImageBg.center.y);
    self.settingBtn.center = CGPointMake(self.scoreImageBg.center.x + self.scoreImageBg.frame.size.width / 2 + 50, self.scoreImageBg.center.y);
    
    self.chip1000Img.center = CGPointMake(self.view.center.x, self.scoreImageBg.center.y - 120);
    self.chip500Img.center = CGPointMake(self.chip1000Img.center.x - 105, self.chip1000Img.center.y);
    self.chip5000Img.center = CGPointMake(self.chip1000Img.center.x + 105, self.chip1000Img.center.y);
    self.chip100Img.center = CGPointMake(self.chip1000Img.center.x - 210, self.chip1000Img.center.y);
    self.chip10000Img.center = CGPointMake(self.chip1000Img.center.x + 210, self.chip1000Img.center.y);
    [self changeFloatingChipViewPosition];
    self.recycelBtn.center = CGPointMake(self.chip100Img.center.x - 160, self.chip100Img.center.y);
    self.potBtn.center = CGPointMake(self.chip10000Img.center.x + 160, self.chip10000Img.center.y);
    
    
    self.sameView.bounds = CGRectMake(0, 0, self.view.frame.size.width/5, 120);
    self.playerDoubleView.bounds = CGRectMake(0, 0, self.view.frame.size.width/5, 120);
    self.bankerDoubleView.bounds = CGRectMake(0, 0, self.view.frame.size.width/5, 120);
    self.playerView.bounds = CGRectMake(0,0,self.view.frame.size.width/5,120);
    self.bankerView.bounds = CGRectMake(0,0,self.view.frame.size.width/5,120);
    
    self.sameView.center = CGPointMake(self.view.center.x, self.whiteLineView.center.y + 150);
    self.playerView.center = CGPointMake(self.view.frame.size.width  * 0.3, self.sameView.center.y);
    self.playerDoubleView.center = CGPointMake(self.view.frame.size.width * 0.1, self.sameView.center.y);
    self.bankerView.center = CGPointMake(self.view.frame.size.width * 0.7, self.sameView.center.y);
    self.bankerDoubleView.center = CGPointMake(self.view.frame.size.width * 0.9, self.sameView.center.y);
    
    [self updateLabelPosition];
    
    if (self.sameView.chipView != nil) {
        self.sameView.chipView.center = CGPointMake(self.sameView.center.x, self.sameView.center.y);
    }
    
    if (self.playerView.chipView != nil) {
        self.playerView.chipView.center = CGPointMake(self.playerView.center.x, self.playerView.center.y);
    }
    
    if (self.playerDoubleView.chipView != nil) {
        self.playerDoubleView.chipView.center = CGPointMake(self.playerDoubleView.center.x, self.playerDoubleView.center.y);
    }
    
    if (self.bankerView.chipView != nil) {
        self.bankerView.chipView.center = CGPointMake(self.bankerView.center.x, self.bankerView.center.y);
    }
    
    if (self.bankerDoubleView.chipView != nil) {
        self.bankerDoubleView.chipView.center = CGPointMake(self.bankerDoubleView.center.x, self.bankerDoubleView.center.y);
    }
    
    UIImageView *playerDoubleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player_double_flag"]];
    playerDoubleImg.center = CGPointMake(self.playerDoubleView.frame.size.width/2, self.playerDoubleView.frame.size.height/2);
    UIImageView *bankerDoubleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banker_double_flag"]];
    bankerDoubleImg.center = CGPointMake(self.bankerDoubleView.frame.size.width/2, self.bankerDoubleView.frame.size.height/2);
    UIImageView *sameImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"same_flag"]];
    sameImg.center = CGPointMake(self.sameView.frame.size.width/2, self.sameView.frame.size.height/2);
    UIImageView *playerImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player_flag"]];
    playerImg.center = CGPointMake(self.playerView.frame.size.width/2, self.playerView.frame.size.height/2);
    UIImageView *bankerImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banker_flag"]];
    bankerImg.center = CGPointMake(self.bankerView.frame.size.width/2, self.bankerView.frame.size.height/2);
    
    if (self.sameView.subviews != nil && self.sameView.subviews.count > 0) {
        UIView* view= [self.sameView.subviews objectAtIndex:0];
        [view removeFromSuperview];
        view= [self.playerDoubleView.subviews objectAtIndex:0];
        [view removeFromSuperview];
        view= [self.bankerDoubleView.subviews objectAtIndex:0];
        [view removeFromSuperview];
        view= [self.playerView.subviews objectAtIndex:0];
        [view removeFromSuperview];
        view= [self.bankerView.subviews objectAtIndex:0];
        [view removeFromSuperview];
    }
    
    self.sameView.layer.sublayers = nil;
    self.playerDoubleView.layer.sublayers = nil;
    self.bankerDoubleView.layer.sublayers = nil;
    self.playerView.layer.sublayers = nil;
    self.bankerView.layer.sublayers = nil;

    [self.sameView addSubview:sameImg];
    [self.playerDoubleView addSubview:playerDoubleImg];
    [self.bankerDoubleView addSubview:bankerDoubleImg];
    [self.playerView addSubview:playerImg];
    [self.bankerView addSubview:bankerImg];
    
    
    
    //和的边界
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, self.sameView.frame.size.width, 4.0f);
    topBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.sameView.layer addSublayer:topBorder];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.sameView.frame.size.height - 4, self.sameView.frame.size.width, 4.0f);
    bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.sameView.layer addSublayer:bottomBorder];
    
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0.0f, 0.0f, 4.0f, self.sameView.frame.size.height);
    leftBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.sameView.layer addSublayer:leftBorder];
    
    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake(self.sameView.frame.size.width-4.0f, 0.0f, 4.0f, self.sameView.frame.size.height);
    rightBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.sameView.layer addSublayer:rightBorder];
    
    //闲的边界
    CALayer *pdTopBorder = [CALayer layer];
    pdTopBorder.frame = CGRectMake(0.0f, 0.0f, self.playerView.frame.size.width, 4.0f);
    pdTopBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.playerView.layer addSublayer:pdTopBorder];
    
    CALayer *pdBottomBorder = [CALayer layer];
    pdBottomBorder.frame = CGRectMake(0.0f, self.playerView.frame.size.height - 4, self.playerView.frame.size.width, 4.0f);
    pdBottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.playerView.layer addSublayer:pdBottomBorder];
    
    CALayer *pdLeftBorder = [CALayer layer];
    pdLeftBorder.frame = CGRectMake(0.0f, 0.0f, 4.0f, self.playerView.frame.size.height);
    pdLeftBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.playerView.layer addSublayer:pdLeftBorder];

    
    //闲对的边界
    CALayer *pTopBorder = [CALayer layer];
    pTopBorder.frame = CGRectMake(0.0f, 0.0f, self.playerDoubleView.frame.size.width, 4.0f);
    pTopBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.playerDoubleView.layer addSublayer:pTopBorder];
    
    CALayer *pBottomBorder = [CALayer layer];
    pBottomBorder.frame = CGRectMake(0.0f, self.playerDoubleView.frame.size.height - 4, self.playerDoubleView.frame.size.width, 4.0f);
    pBottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.playerDoubleView.layer addSublayer:pBottomBorder];
    
    //庄的边界
    CALayer *bankerTop = [CALayer layer];
    bankerTop.frame = CGRectMake(0.0f, 0.0f, self.bankerView.frame.size.width, 4.0f);
    bankerTop.backgroundColor = [UIColor whiteColor].CGColor;
    [self.bankerView.layer addSublayer:bankerTop];
    
    CALayer *bankerBottom = [CALayer layer];
    bankerBottom.frame = CGRectMake(0.0f, self.bankerView.frame.size.height - 4, self.bankerView.frame.size.width, 4.0f);
    bankerBottom.backgroundColor = [UIColor whiteColor].CGColor;
    [self.bankerView.layer addSublayer:bankerBottom];
    
    CALayer *bankerRight = [CALayer layer];
    bankerRight.frame = CGRectMake(self.bankerView.frame.size.width-4.0f, 0.0f, 4.0f, self.bankerView.frame.size.height);
    bankerRight.backgroundColor = [UIColor whiteColor].CGColor;
    [self.bankerView.layer addSublayer:bankerRight];
    
    //庄对的边界
    CALayer *bTopBorder = [CALayer layer];
    bTopBorder.frame = CGRectMake(0.0f, 0.0f, self.bankerDoubleView.frame.size.width, 4.0f);
    bTopBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.bankerDoubleView.layer addSublayer:bTopBorder];
    
    CALayer *bBottomBorder = [CALayer layer];
    bBottomBorder.frame = CGRectMake(0.0f, self.bankerDoubleView.frame.size.height - 4, self.bankerDoubleView.frame.size.width, 4.0f);
    bBottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.bankerDoubleView.layer addSublayer:bBottomBorder];
}

- (void) initPortraitView
{
    [self initCardsPosition];
    self.markContainer.center = CGPointMake(self.view.center.x, 306);
    self.recycelBtn.center = CGPointMake(self.scoreImageBg.center.x - 110, self.scoreImageBg.center.y - 110);
    self.potBtn.center = CGPointMake(self.scoreImageBg.center.x + 110, self.scoreImageBg.center.y - 110);
    self.tipBtn.center = CGPointMake(self.recycelBtn.center.x - 165, self.recycelBtn.center.y);
    self.settingBtn.center = CGPointMake(self.potBtn.center.x + 165, self.potBtn.center.y);
    
    self.chip1000Img.center = CGPointMake(self.view.center.x, self.potBtn.center.y - 120);
    self.chip500Img.center = CGPointMake(self.chip1000Img.center.x - 145, self.chip1000Img.center.y);
    self.chip5000Img.center = CGPointMake(self.chip1000Img.center.x + 145, self.chip1000Img.center.y);
    self.chip100Img.center = CGPointMake(self.chip1000Img.center.x - 290, self.chip1000Img.center.y);
    self.chip10000Img.center = CGPointMake(self.chip1000Img.center.x + 290, self.chip1000Img.center.y);
    [self changeFloatingChipViewPosition];
    
    self.sameView.bounds = CGRectMake(0, 0, self.view.frame.size.width/3, 120);
    self.playerDoubleView.bounds = CGRectMake(0, 0, self.view.frame.size.width/3, 120);
    self.bankerDoubleView.bounds = CGRectMake(0, 0, self.view.frame.size.width/3, 120);
    self.playerView.bounds = CGRectMake(0,0,self.view.frame.size.width,120);
    self.bankerView.bounds = CGRectMake(0,0,self.view.frame.size.width,120);
    
    self.sameView.center = CGPointMake(self.view.center.x, self.whiteLineView.center.y + 130);
    self.playerDoubleView.center = CGPointMake(self.view.frame.size.width / 3 / 2, self.sameView.center.y);
    self.bankerDoubleView.center = CGPointMake(self.view.frame.size.width / 6 * 5, self.sameView.center.y);
    self.bankerView.center = CGPointMake(self.view.center.x, self.sameView.center.y + 120);
    self.playerView.center = CGPointMake(self.view.center.x, self.sameView.center.y + 240);
    
    [self updateLabelPosition];
    
    if (self.sameView.chipView != nil) {
        self.sameView.chipView.center = CGPointMake(self.view.center.x, self.whiteLineView.center.y + 150);
    }
    
    if (self.playerView.chipView != nil) {
        self.playerView.chipView.center = CGPointMake(self.view.frame.size.width  * 0.3, self.sameView.center.y);
    }
    
    if (self.playerDoubleView.chipView != nil) {
        self.playerDoubleView.chipView.center = CGPointMake(self.view.frame.size.width * 0.1, self.sameView.center.y);
    }
    
    if (self.bankerView.chipView != nil) {
        self.bankerView.chipView.center = CGPointMake(self.view.frame.size.width * 0.7, self.sameView.center.y);
    }
    
    if (self.bankerDoubleView.chipView != nil) {
        self.bankerDoubleView.chipView.center = CGPointMake(self.view.frame.size.width * 0.9, self.sameView.center.y);
    }

    
    UIImageView *playerDoubleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player_double_flag"]];
    playerDoubleImg.center = CGPointMake(self.playerDoubleView.frame.size.width/2, self.playerDoubleView.frame.size.height/2);
    UIImageView *bankerDoubleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banker_double_flag"]];
    bankerDoubleImg.center = CGPointMake(self.bankerDoubleView.frame.size.width/2, self.bankerDoubleView.frame.size.height/2);
    UIImageView *sameImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"same_flag"]];
    sameImg.center = CGPointMake(self.sameView.frame.size.width/2, self.sameView.frame.size.height/2);
    UIImageView *playerImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player_flag"]];
    playerImg.center = CGPointMake(self.playerView.frame.size.width/2, self.playerView.frame.size.height/2);
    UIImageView *bankerImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banker_flag"]];
    bankerImg.center = CGPointMake(self.bankerView.frame.size.width/2, self.bankerView.frame.size.height/2);
    
    if (self.sameView.subviews != nil && self.sameView.subviews.count > 0) {
        UIView* view= [self.sameView.subviews objectAtIndex:0];
        [view removeFromSuperview];
        view= [self.playerDoubleView.subviews objectAtIndex:0];
        [view removeFromSuperview];
        view= [self.bankerDoubleView.subviews objectAtIndex:0];
        [view removeFromSuperview];
        view= [self.playerView.subviews objectAtIndex:0];
        [view removeFromSuperview];
        view= [self.bankerView.subviews objectAtIndex:0];
        [view removeFromSuperview];
    }
    
    self.sameView.layer.sublayers = nil;
    self.playerDoubleView.layer.sublayers = nil;
    self.bankerDoubleView.layer.sublayers = nil;
    self.playerView.layer.sublayers = nil;
    self.bankerView.layer.sublayers = nil;
    
    [self.sameView addSubview:sameImg];
    [self.playerDoubleView addSubview:playerDoubleImg];
    [self.bankerDoubleView addSubview:bankerDoubleImg];
    [self.playerView addSubview:playerImg];
    [self.bankerView addSubview:bankerImg];
    
    
    
    //和的边界
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, self.sameView.frame.size.width, 4.0f);
    topBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.sameView.layer addSublayer:topBorder];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.sameView.frame.size.height - 4, self.sameView.frame.size.width, 4.0f);
    bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.sameView.layer addSublayer:bottomBorder];
    
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0.0f, 0.0f, 4.0f, self.sameView.frame.size.height);
    leftBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.sameView.layer addSublayer:leftBorder];
    
    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake(self.sameView.frame.size.width-4.0f, 0.0f, 4.0f, self.sameView.frame.size.height);
    rightBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.sameView.layer addSublayer:rightBorder];
    
    //闲对的边界
    CALayer *pTopBorder = [CALayer layer];
    pTopBorder.frame = CGRectMake(0.0f, 0.0f, self.playerDoubleView.frame.size.width, 4.0f);
    pTopBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.playerDoubleView.layer addSublayer:pTopBorder];
    
    CALayer *pBottomBorder = [CALayer layer];
    pBottomBorder.frame = CGRectMake(0.0f, self.playerDoubleView.frame.size.height - 4, self.playerDoubleView.frame.size.width, 4.0f);
    pBottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.playerDoubleView.layer addSublayer:pBottomBorder];
    
    //庄对的边界
    CALayer *bTopBorder = [CALayer layer];
    bTopBorder.frame = CGRectMake(0.0f, 0.0f, self.bankerDoubleView.frame.size.width, 4.0f);
    bTopBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.bankerDoubleView.layer addSublayer:bTopBorder];
    
    CALayer *bBottomBorder = [CALayer layer];
    bBottomBorder.frame = CGRectMake(0.0f, self.bankerDoubleView.frame.size.height - 4, self.bankerDoubleView.frame.size.width, 4.0f);
    bBottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.bankerDoubleView.layer addSublayer:bBottomBorder];
    
    //庄的边界
    CALayer *bankerBottom = [CALayer layer];
    bankerBottom.frame = CGRectMake(0.0f, self.bankerView.frame.size.height - 4, self.bankerView.frame.size.width, 4.0f);
    bankerBottom.backgroundColor = [UIColor whiteColor].CGColor;
    [self.bankerView.layer addSublayer:bankerBottom];
    
}

- (void) updateLabelPosition
{
    self.sameViewLabel.center = CGPointMake(self.sameView.center.x - 60, self.sameView.center.y + 45);
    self.playerDoubleViewLabel.center = CGPointMake(self.playerDoubleView.center.x - 60, self.playerDoubleView.center.y + 45);
    self.bankerDoubleViewLabel.center = CGPointMake(self.bankerDoubleView.center.x - 60, self.bankerDoubleView.center.y + 45);
    self.playerViewLabel.center = CGPointMake(self.playerView.center.x - 60, self.playerView.center.y + 45);
    self.bankerViewLabel.center = CGPointMake(self.bankerView.center.x - 60, self.bankerView.center.y + 45);
}

- (IBAction)showOrHideMarkContainer:(id)sender
{
    if (self.markContainer.hidden) {
        self.markContainer.hidden = NO;
    } else {
        self.markContainer.hidden = YES;
    }
}

- (void) configUi
{
    self.chip100Img.tag = 100;
    self.chip500Img.tag = 500;
    self.chip1000Img.tag = 1000;
    self.chip5000Img.tag = 5000;
    self.chip10000Img.tag = 10000;
    
    self.cardsNumber.text = [NSString stringWithFormat:@"Cards:%d", self.cardsBuilder.cards.count];
    
    self.cardsBox.userInteractionEnabled = YES;
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOrHideMarkContainer:)];
    [self.cardsBox addGestureRecognizer:rec];
    
    self.cutPointView.hidden = YES;
    self.potBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPotBtnClicked:)];
    [self.potBtn addGestureRecognizer:recongnizer];
    
    self.recycelBtn.userInteractionEnabled = YES;
    recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onRecycelBtnClicked:)];
    [self.recycelBtn addGestureRecognizer:recongnizer];
    
    self.playerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recongnizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onChipTableViewClicked:)];
    [self.playerView addGestureRecognizer:recongnizer1];
    
    self.playerDoubleView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recongnizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onChipTableViewClicked:)];
    [self.playerDoubleView addGestureRecognizer:recongnizer2];
    
    self.bankerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recongnizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onChipTableViewClicked:)];
    [self.bankerView addGestureRecognizer:recongnizer3];
    
    self.bankerDoubleView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recongnizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onChipTableViewClicked:)];
    [self.bankerDoubleView addGestureRecognizer:recongnizer4];
    
    self.sameView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recongnizer5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onChipTableViewClicked:)];
    [self.sameView addGestureRecognizer:recongnizer5];
    
    [self hideAllCard];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView == self.tableView5) {
        NSString *cellIdentify = @"cell";
        ResultLargeSizeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            cell = [[ResultLargeSizeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            
        }
        return cell;
//    }
//    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (void) showChipErrorAlert
{
    NSString *title = @"百家乐";
    NSString *message = @"抱歉。您只可以下注于一方";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) updateChipLabel:(ChipBoardView *)target number:(NSInteger )number
{
    CGFloat f = number;
    NSString *strNumber;
    if (f == 0) {
        strNumber = @"";
    } else if (f > 0 && f < 1000) {
        strNumber = [NSString stringWithFormat:@"%d", number];
    } else if (f >= 1000 && f < 10000) {
        strNumber = [NSString stringWithFormat:@"%.2f千", f / 1000];
    } else if (f >= 10000) {
        strNumber = [NSString stringWithFormat:@"%.2f万", f / 10000];
    }
    
    if (target == self.sameView) {
        self.sameViewLabel.text =  strNumber;
    } else if (target == self.playerDoubleView) {
        self.playerDoubleViewLabel.text =  strNumber;
    } else if (target == self.bankerDoubleView) {
        self.bankerDoubleViewLabel.text =  strNumber;
    } else if (target == self.playerView) {
        self.playerViewLabel.text =  strNumber;
    } else if (target == self.bankerView) {
        self.bankerViewLabel.text =  strNumber;
    }
}

- (void) cutCard
{
    [self playVoiceByFile:@"CutTheDeckPlease_cn"];
    UIImage *cards = [UIImage imageNamed:@"cards_flag"];
    UIImage *cutCards = [UIImage imageNamed:@"cut_cards_flag"];
    
    self.cardsView = [[UIImageView alloc] initWithImage:cards];
    self.cutCardsView = [[UIImageView alloc] initWithImage:cutCards];
    
    self.cardsView.center = CGPointMake(self.view.center.x, self.view.center.y);
    self.cardsView.bounds = CGRectMake(0.0f, 0.0f, cards.size.width, cards.size.height);
    
    self.cutCardsView.center = CGPointMake(self.view.center.x, self.view.center.y+30);
    self.cutCardsView.bounds = CGRectMake(0.0f, 0.0f, cutCards.size.width, cutCards.size.height);
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlerCudCardPanRecongnizer:)];
    self.cutCardsView.userInteractionEnabled = YES;
    [self.cutCardsView addGestureRecognizer:panRecognizer];
    
    [self.view addSubview:self.cardsView];
    [self.view addSubview:self.cutCardsView];
    
    cutCardsView_X = self.view.center.x;
}

- (void) handlerCutCardAnim:(CGFloat)pointX
{
    
    UIImage *image = self.cardsView.image;
    
    CGFloat top = 60; // 顶端盖高度
    CGFloat bottom = 60 ; // 底端盖高度
    CGFloat left = 60;// 左端盖宽度
    CGFloat right = 60; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    UIImageView *cutCardsView1 = [[UIImageView alloc] initWithImage:image];
    UIImageView *cutCardsView2 = [[UIImageView alloc] initWithImage:image];
    self.cutCardsView1 = cutCardsView1;
    self.cutCardsView2 = cutCardsView2;
    cutCardsView1.frame = CGRectMake(self.cardsView.frame.origin.x, self.cardsView.frame.origin.y, pointX - self.cardsView.frame.origin.x, image.size.height);
    cutCardsView2.frame = CGRectMake(pointX-25, self.cardsView.frame.origin.y, image.size.width - (pointX - self.cardsView.frame.origin.x), image.size.height);
    
    [self.cardsView removeFromSuperview];
    [self.cutCardsView removeFromSuperview];
    [self.view addSubview:cutCardsView2];
    [self.view addSubview:cutCardsView1];
    
    CGFloat cutCardsView1CenterY = cutCardsView1.center.y;
    CGFloat cutCardsView1CenterX = cutCardsView1.center.x;
    
    CGFloat cutCardsView2CenterY = cutCardsView2.center.y;
    CGFloat cutCardsView2CenterX = cutCardsView2.center.x;
    
    CABasicAnimation *anim1 = [CABasicAnimation animation];
    anim1.keyPath = @"position";
    anim1.fromValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView1CenterX, cutCardsView1CenterY)];
    anim1.toValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView1CenterX,cutCardsView1CenterY + 140)];
    anim1.removedOnCompletion=NO;
    anim1.fillMode = kCAFillModeForwards;
    anim1.duration = 1;
    [cutCardsView1.layer addAnimation:anim1 forKey:nil];
    
    CABasicAnimation *anim2 = [CABasicAnimation animation];
    anim2.keyPath = @"position";
    anim2.fromValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView1.center.x, cutCardsView1CenterY + 140)];
    anim2.toValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView2.center.x,cutCardsView1CenterY + 140)];
    anim2.removedOnCompletion=NO;
    anim2.fillMode = kCAFillModeForwards;
    anim2.beginTime = CACurrentMediaTime() + 1;
    anim2.duration = 1;
    [cutCardsView1.layer addAnimation:anim2 forKey:nil];
    
    CABasicAnimation *anim3 = [CABasicAnimation animation];
    anim3.keyPath = @"position";
    anim3.fromValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView2.center.x, cutCardsView2.center.y)];
    anim3.toValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView1CenterX,cutCardsView2.center.y)];
    anim3.removedOnCompletion=NO;
    anim3.fillMode = kCAFillModeForwards;
    anim3.beginTime = CACurrentMediaTime() + 1;
    anim3.duration = 1;
    [cutCardsView2.layer addAnimation:anim3 forKey:nil];

    CABasicAnimation *anim4 = [CABasicAnimation animation];
    anim4.keyPath = @"position";
    anim4.fromValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView2CenterX, cutCardsView2CenterY + 140)];
    anim4.toValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView2CenterX,cutCardsView2CenterY)];
    anim4.removedOnCompletion=NO;
    anim4.fillMode = kCAFillModeForwards;
    anim4.beginTime = CACurrentMediaTime() + 2;
    anim4.duration = 1;
    [cutCardsView1.layer addAnimation:anim4 forKey:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(removeCardsView) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(burningCards) userInfo:nil repeats:NO];
}

- (void) removeCardsView
{
    [self.cutCardsView1 removeFromSuperview];
    [self.cutCardsView2 removeFromSuperview];
}

- (void) burningCards
{
    [self playVoiceByFile:@"BurningCards_cn"];
    Card *card = [[CardsBuilder shareObject] getNextCard];
    NSMutableArray *imageViews = [[NSMutableArray alloc] init];
    self.cutPointView.hidden = NO;
    self.cutPointView.image = [UIImage imageNamed:card.resId];
    if (card.validPoint.integerValue == 0) {
        for (int i=0; i<10; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.cardBg_1.frame.size.width, self.cardBg_1.frame.size.height)];
            imageView.image = [UIImage imageNamed:@"card_bg"];
            [imageViews addObject:imageView];
        }
    } else {
        for (int i=0; i<card.validPoint.intValue; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.cardBg_1.frame.size.width, self.cardBg_1.frame.size.height)];
            imageView.image = [UIImage imageNamed:@"card_bg"];
            [imageViews addObject:imageView];
        }
    }
    
    [self arrangeBurningCardsView:[imageViews copy]];
    self.cardsNumber.text = [NSString stringWithFormat:@"Cards:%d", self.cardsBuilder.cards.count];
}

- (void) arrangeBurningCardsView:(NSArray *)cards
{
//    CGFloat containerHeight = self.cutCardsContainer.frame.size.height;
//    CGFloat containerWidth = self.cutCardsContainer.frame.size.width;
    
    CGFloat cardHeight = self.cardBg_1.frame.size.height;
    CGFloat cardWidth = self.cardBg_1.frame.size.width;
    NSLog(@"count-->%d", cards.count);
    if (cards.count <= 5) {
        UIView *subView = [[UIView alloc] init];
        subView.center = CGPointMake(self.cutCardsContainer.center.x, self.cutCardsContainer.center.y);
        subView.bounds = CGRectMake(0.0f, 0.0f, cardWidth*cards.count + 20 * (cards.count - 1), cardHeight);
        self.burningCardContainer1 = subView;
        [self.view addSubview:subView];
        
        for (int i=0; i<cards.count; i++) {
            UIImageView *card = [cards objectAtIndex:i];
            if (i == 0) {
                card.frame = CGRectMake(0.0f, 0.0f, cardWidth, cardHeight);
            } else {
                card.frame = CGRectMake(i*(cardWidth + 20), 0.0f, cardWidth, cardHeight);
            }
            [subView addSubview:card];
        }
    } else {
        UIView *subView = [[UIView alloc] init];
        subView.center = CGPointMake(self.cutCardsContainer.center.x, self.cutCardsContainer.center.y - (cardHeight / 2 + 10));
        subView.bounds = CGRectMake(0.0f, 0.0f, cardWidth*5 + 80, cardHeight);
        self.burningCardContainer1 = subView;
        [self.view addSubview:subView];
        
        for (int i=0; i<5; i++) {
            UIImageView *card = [cards objectAtIndex:i];
            if (i == 0) {
                card.frame = CGRectMake(0.0f, 0.0f, cardWidth, cardHeight);
            } else {
                card.frame = CGRectMake(i*(cardWidth + 20), 0.0f, cardWidth, cardHeight);
            }
            [subView addSubview:card];
        }
        
        UIView *subView2 = [[UIView alloc] init];
        subView2.center = CGPointMake(self.cutCardsContainer.center.x, self.cutCardsContainer.center.y + (cardHeight / 2 + 10));
        subView2.bounds = CGRectMake(0.0f, 0.0f, cardWidth*(cards.count - 5) + 20 * (cards.count - 5 - 1), cardHeight);
        self.burningCardContainer2 = subView2;
        [self.view addSubview:subView2];
        
        for (int i=0; i<cards.count - 5; i++) {
            UIImageView *card = [cards objectAtIndex:i+5];
            if (i == 0) {
                card.frame = CGRectMake(0.0f, 0.0f, cardWidth, cardHeight);
            } else {
                card.frame = CGRectMake(i*(cardWidth + 20), 0.0f, cardWidth, cardHeight);
            }
            [subView2 addSubview:card];
        }
    }
    
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(removeBurningCardsView) userInfo:nil repeats:NO];
}

- (void) removeBurningCardsView
{
    [self.burningCardContainer1 removeFromSuperview];
    [self.burningCardContainer2 removeFromSuperview];
    [self.cutPointView removeFromSuperview];
    [self.cutCardsContainer removeFromSuperview];
    [self playVoiceByFile:@"c_place_cn"];
    isGameStart = NO;
}

- (void) hideAllCard
{
    self.playerCard_1.hidden = YES;
    self.playerCard_2.hidden = YES;
    self.playerCard_3.hidden = YES;
    self.bankerCard_1.hidden = YES;
    self.bankerCard_2.hidden = YES;
    self.bankerCard_3.hidden = YES;
    self.playerPointView.hidden = YES;
    self.bankerPointView.hidden = YES;
}

- (void) updateScore
{
    NSString *score = [NSString stringWithFormat:@"%d", totalScore];
    [self.scoreImage setImage:[ImageUtils scoreToImage:score]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handlerCudCardPanRecongnizer:(id)sender
{
    UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;
    CGPoint curPoint = [recongizer locationInView:self.view];
    if (curPoint.x - self.view.center.x < 100 && curPoint.x - self.view.center.x > -55) {
        [recongizer.view setCenter:CGPointMake(curPoint.x, recongizer.view.center.y)];
    }
    
    if (recongizer.state == UIGestureRecognizerStateEnded) {
        [self handlerCutCardAnim:recongizer.view.center.x];
    }
}

- (IBAction)handleTotalChipPanRecognizer:(id)sender
{
    if (isGameStart) {
        return;
    }
    
    UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;
    if ([recongizer state] == UIGestureRecognizerStateBegan) {
        isChanged = NO;
        [self playSoundByFile:@"ce_chip"];
    }
    NSArray *views = self.evaluteViews;
    static void (^overlappingBlock)(UIView *overlappingView);
    overlappingBlock = ^(UIView *overlappingView) {
        if (!isChanged && overlappingView != nil) {
            ChipBoardView *boardView =  (ChipBoardView *)overlappingView;
            boardView.chipView = nil;
            isChanged = YES;
        }
    };
    
    static void (^completionBlock)(UIView *overlappingView);
    completionBlock = ^(UIView *overlappingView) {
        if (overlappingView != nil) {
            [UIView animateWithDuration:0.3f animations:^{
                recongizer.view.center = CGPointMake(overlappingView.center.x, overlappingView.center.y);
            } completion:^(BOOL finished) {
                
                ChipBoardView *boardView = (ChipBoardView *)overlappingView;
                UIImageView *chipView = (UIImageView *)recongizer.view;
                
                if (boardView.chipView != nil) {
                    chipView.tag += boardView.chipView.tag;
                    [boardView.chipView removeFromSuperview];
                    
                }
                UIImage* chipImage =[ImageUtils scoreToChips:chipView.tag];
                chipView.center = CGPointMake(overlappingView.center.x, overlappingView.center.y);
                chipView.bounds = CGRectMake(0, 0, chipImage.size.width, chipImage.size.height);
                chipView.image = chipImage;
                boardView.chipView = chipView;
                [self updateChipLabel:boardView number:chipView.tag];
                
            }];
            
        } else {
            totalScore += recongizer.view.tag;
            totalBetScore -= recongizer.view.tag;
            [recongizer.view removeFromSuperview];
            
            [self updateScore];
        }
        
    };
    
    
    [recongizer dragViewWithinView:[self view]
           evaluateViewsForOverlap:views
   containedByOverlappingViewBlock:overlappingBlock
                        completion:completionBlock];
    
}

- (IBAction)handleChipTapRecognizer:(id)sender
{
    UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;
    UIView *view = recongizer.view;
    if (view.tag == 100) {
        chipCenterX = self.chip100Img.center.x;
        chipCenterY = self.chip100Img.center.y;
        self.chip100Img.highlighted = YES;
        self.chip500Img.highlighted = NO;
        self.chip1000Img.highlighted = NO;
        self.chip5000Img.highlighted = NO;
        self.chip10000Img.highlighted = NO;
        self.selectChipImg = self.chip100Img;
    } else if (view.tag == 500) {
        chipCenterX = self.chip500Img.center.x;
        chipCenterY = self.chip500Img.center.y;
        self.chip100Img.highlighted = NO;
        self.chip500Img.highlighted = YES;
        self.chip1000Img.highlighted = NO;
        self.chip5000Img.highlighted = NO;
        self.chip10000Img.highlighted = NO;
        self.selectChipImg = self.chip500Img;
    } else if (view.tag == 1000) {
        chipCenterX = self.chip1000Img.center.x;
        chipCenterY = self.chip1000Img.center.y;
        self.chip100Img.highlighted = NO;
        self.chip500Img.highlighted = NO;
        self.chip1000Img.highlighted = YES;
        self.chip5000Img.highlighted = NO;
        self.chip10000Img.highlighted = NO;
        self.selectChipImg = self.chip1000Img;
    } else if (view.tag == 5000) {
        chipCenterX = self.chip5000Img.center.x;
        chipCenterY = self.chip5000Img.center.y;
        self.chip100Img.highlighted = NO;
        self.chip500Img.highlighted = NO;
        self.chip1000Img.highlighted = NO;
        self.chip5000Img.highlighted = YES;
        self.chip10000Img.highlighted = NO;
        self.selectChipImg = self.chip5000Img;
    } else if (view.tag == 10000) {
        chipCenterX = self.chip10000Img.center.x;
        chipCenterY = self.chip10000Img.center.y;
        self.chip100Img.highlighted = NO;
        self.chip500Img.highlighted = NO;
        self.chip1000Img.highlighted = NO;
        self.chip5000Img.highlighted = NO;
        self.chip10000Img.highlighted = YES;
        self.selectChipImg = self.chip10000Img;
    }
    [self playSoundByFile:@"ce_chip"];
}

- (UIImageView *) createChipFloatView
{
    UIImageView *chipView =[[UIImageView alloc] init];
    [self.view insertSubview:chipView aboveSubview:self.chip100Img];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleTotalChipPanRecognizer:)];
    chipView.userInteractionEnabled = YES;
    [chipView addGestureRecognizer:panRecognizer];
    return chipView;
}

- (IBAction)handlePanRecognizer:(id)sender
{
    if (isGameStart) {
        return;
    }
    UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;
    if ([recongizer state] == UIGestureRecognizerStateBegan)
    {
        [self clearLastGameBet];
        sameScore = 0;
        UIView *view = recongizer.view;
        if (view.tag == 100) {
            chipCenterX = self.chip100Img.center.x;
            chipCenterY = self.chip100Img.center.y;
            self.chip100Img.highlighted = YES;
            self.chip500Img.highlighted = NO;
            self.chip1000Img.highlighted = NO;
            self.chip5000Img.highlighted = NO;
            self.chip10000Img.highlighted = NO;
        } else if (view.tag == 500) {
            chipCenterX = self.chip500Img.center.x;
            chipCenterY = self.chip500Img.center.y;
            self.chip100Img.highlighted = NO;
            self.chip500Img.highlighted = YES;
            self.chip1000Img.highlighted = NO;
            self.chip5000Img.highlighted = NO;
            self.chip10000Img.highlighted = NO;
        } else if (view.tag == 1000) {
            chipCenterX = self.chip1000Img.center.x;
            chipCenterY = self.chip1000Img.center.y;
            self.chip100Img.highlighted = NO;
            self.chip500Img.highlighted = NO;
            self.chip1000Img.highlighted = YES;
            self.chip5000Img.highlighted = NO;
            self.chip10000Img.highlighted = NO;
        } else if (view.tag == 5000) {
            chipCenterX = self.chip5000Img.center.x;
            chipCenterY = self.chip5000Img.center.y;
            self.chip100Img.highlighted = NO;
            self.chip500Img.highlighted = NO;
            self.chip1000Img.highlighted = NO;
            self.chip5000Img.highlighted = YES;
            self.chip10000Img.highlighted = NO;
        } else if (view.tag == 10000) {
            chipCenterX = self.chip10000Img.center.x;
            chipCenterY = self.chip10000Img.center.y;
            self.chip100Img.highlighted = NO;
            self.chip500Img.highlighted = NO;
            self.chip1000Img.highlighted = NO;
            self.chip5000Img.highlighted = NO;
            self.chip10000Img.highlighted = YES;
        }
        [self addFloatingChipViewByPoint:view.tag];
        [self playSoundByFile:@"ce_chip"];
    }
    
    NSArray *views = self.evaluteViews;
    //    __block UILabel *label = [self completionLabel];
    
    // Block to execute when our dragged view is contained by one of our evaluation views.
    static void (^overlappingBlock)(UIView *overlappingView);
    overlappingBlock = ^(UIView *overlappingView) {
    };
    
    // Block to execute when gesture ends.
    static void (^completionBlock)(UIView *overlappingView);
    completionBlock = ^(UIView *overlappingView) {
        NSInteger score = recongizer.view.tag;
        [UIView animateWithDuration:0.3f animations:^{
            if (overlappingView == self.playerView &&self.bankerView.chipView != nil) {
                [self showChipErrorAlert];
                recongizer.view.center = CGPointMake(chipCenterX, chipCenterY);
            } else if (overlappingView == self.bankerView && self.playerView.chipView != nil){
                [self showChipErrorAlert];
                recongizer.view.center = CGPointMake(chipCenterX, chipCenterY);
            } else {
                if (overlappingView != nil && score < totalScore) {
                    recongizer.view.center = CGPointMake(overlappingView.center.x, overlappingView.center.y);
                } else {
                    recongizer.view.center = CGPointMake(chipCenterX, chipCenterY);
                }
            }
        } completion:^(BOOL finished) {
            
            if (overlappingView != nil) {
                if (overlappingView == self.playerView &&self.bankerView.chipView != nil) {
                    [self showChipErrorAlert];
                    [self playSoundByFile:@"ce_chipwarn"];
                } else if (overlappingView == self.bankerView && self.playerView.chipView != nil){
                    [self showChipErrorAlert];
                    [self playSoundByFile:@"ce_chipwarn"];
                } else {
                    if (score <= totalScore) {
                        UIImageView *totalChipView = nil;
                        UIImage *totalChipImage = nil;
                        
                        ChipBoardView *boadView = (ChipBoardView *)overlappingView;
                        if (boadView.chipView == nil) {
                            totalChipView = [self createChipFloatView];
                            boadView.chipView = totalChipView;
                            totalChipView.tag += score;
                        } else {
                            totalChipView = boadView.chipView;
                            totalChipView.tag += score;
                        }
                        totalChipImage =[ImageUtils scoreToChips:totalChipView.tag];
                        totalChipView.center = CGPointMake(overlappingView.center.x, overlappingView.center.y);
                        totalChipView.bounds = CGRectMake(0, 0, totalChipImage.size.width, totalChipImage.size.height);
                        totalChipView.image = totalChipImage;
                        totalBetScore += score;
                        totalScore -= score;
                        [self updateScore];
                        [self updateChipLabel:boadView number:totalChipView.tag];
                    } else {
                        [self playSoundByFile:@"ce_chipwarn"];
                    }
                }
                
            }
            [self.chipFloatingViews removeObject:recongizer.view];
            [recongizer.view removeFromSuperview];
        }];
        
        
    };
    
    
    [recongizer dragViewWithinView:[self view]
           evaluateViewsForOverlap:views
   containedByOverlappingViewBlock:overlappingBlock
                        completion:completionBlock];
    
}

- (IBAction)onPotBtnClicked:(id)sender
{
    if (isGameStart) {
        return;
    }
    
    if (playerScore != 0) {
        
    }
    
    if (playerScore != 0 || playerDoubleScore != 0 || bankerScore != 0 || bankerDoubleScore != 0 ||sameScore != 0) {
        UIImageView *totalChipView =nil;
        UIImage *totalChipImage =nil;
        
        if (playerScore != 0) {
            totalChipView = [self createChipFloatView];
            totalChipImage = [ImageUtils scoreToChips:playerScore];
            self.playerView.chipView = totalChipView;
            totalChipView.tag = playerScore;
            totalChipView.center = CGPointMake(self.playerView.center.x, self.playerView.center.y);
            totalChipView.bounds = CGRectMake(0, 0, totalChipImage.size.width, totalChipImage.size.height);
            totalChipView.image = totalChipImage;
            totalBetScore += playerScore;
            totalScore -= playerScore;
            [self updateChipLabel:self.playerView number:totalChipView.tag];
        }
        
        if (playerDoubleScore != 0) {
            totalChipView = [self createChipFloatView];
            totalChipImage =[ImageUtils scoreToChips:playerDoubleScore];
            self.playerDoubleView.chipView = totalChipView;
            totalChipView.tag = playerDoubleScore;
            totalChipView.center = CGPointMake(self.playerDoubleView.center.x, self.playerDoubleView.center.y);
            totalChipView.bounds = CGRectMake(0, 0, totalChipImage.size.width, totalChipImage.size.height);
            totalChipView.image = totalChipImage;
            totalBetScore += playerDoubleScore;
            totalScore -= playerDoubleScore;
            [self updateChipLabel:self.playerDoubleView number:totalChipView.tag];
        }
        
        if (bankerScore != 0) {
            totalChipView = [self createChipFloatView];
            totalChipImage =[ImageUtils scoreToChips:bankerScore];
            self.bankerView.chipView = totalChipView;
            totalChipView.tag = bankerScore;
            totalChipView.center = CGPointMake(self.bankerView.center.x, self.bankerView.center.y);
            totalChipView.bounds = CGRectMake(0, 0, totalChipImage.size.width, totalChipImage.size.height);
            totalChipView.image = totalChipImage;
            totalBetScore += bankerScore;
            totalScore -= bankerScore;
            [self updateChipLabel:self.bankerView number:totalChipView.tag];
        }
        
        if (bankerDoubleScore != 0) {
            totalChipView = [self createChipFloatView];
            totalChipImage =[ImageUtils scoreToChips:bankerDoubleScore];
            self.bankerDoubleView.chipView = totalChipView;
            totalChipView.tag = bankerDoubleScore;
            totalChipView.center = CGPointMake(self.bankerDoubleView.center.x, self.bankerDoubleView.center.y);
            totalChipView.bounds = CGRectMake(0, 0, totalChipImage.size.width, totalChipImage.size.height);
            totalChipView.image = totalChipImage;
            totalBetScore += bankerDoubleScore;
            totalScore -= bankerDoubleScore;
            [self updateChipLabel:self.bankerDoubleView number:totalChipView.tag];
        }
        
        if (sameScore != 0) {
            totalChipView = [self createChipFloatView];
            totalChipImage =[ImageUtils scoreToChips:sameScore];
            self.sameView.chipView = totalChipView;
            totalChipView.tag = sameScore;
            totalChipView.center = CGPointMake(self.sameView.center.x, self.sameView.center.y);
            totalChipView.bounds = CGRectMake(0, 0, totalChipImage.size.width, totalChipImage.size.height);
            totalChipView.image = totalChipImage;
            totalBetScore += sameScore;
            totalScore -= sameScore;
            [self updateChipLabel:self.sameView number:totalChipView.tag];
        }
        
        [self clearLastGameBet];
        [self updateScore];
    } else {
        if (totalBetScore != 0) {
            [self startGame];
        } else {
            [self playSoundByFile:@"ce_chipwarn"];
        }
    }
    
}

- (void) clearLastGameBet
{
    playerScore = 0;
    playerDoubleScore = 0;
    bankerScore = 0;
    bankerDoubleScore = 0;
    sameScore = 0;
    [self.potBtn setImage:[UIImage imageNamed:@"pot_btn"] forState:UIControlStateNormal];
    [self.potBtn setImage:[UIImage imageNamed:@"pot_btn_s"] forState:UIControlStateHighlighted];
}

- (IBAction)onRecycelBtnClicked:(id)sender
{
    if (isGameStart) {
        return;
    }
    if (totalBetScore != 0) {
        totalScore += totalBetScore;
        totalBetScore = 0;
        
        [self.playerView.chipView removeFromSuperview];
        [self.playerDoubleView.chipView removeFromSuperview];
        [self.bankerView.chipView removeFromSuperview];
        [self.bankerDoubleView.chipView removeFromSuperview];
        [self.sameView.chipView removeFromSuperview];
        
        self.playerView.chipView = nil;
        self.playerDoubleView.chipView = nil;
        self.bankerView.chipView = nil;
        self.bankerDoubleView.chipView = nil;
        self.sameView.chipView = nil;
        
        [self playSoundByFile:@"mouse_move"];
        [self updateScore];
        self.sameViewLabel.text = @"";
        self.playerDoubleViewLabel.text = @"";
        self.bankerDoubleViewLabel.text = @"";
        self.playerViewLabel.text = @"";
        self.bankerViewLabel.text = @"";
    }
}

- (IBAction)onChipTableViewClicked:(id)sender
{
    if (isGameStart) {
        return;
    }
    [self clearLastGameBet];
    UITapGestureRecognizer *recongnizer = (UITapGestureRecognizer *)sender;
    ChipBoardView * boadView = (ChipBoardView *)recongnizer.view;
    if (boadView == self.playerView) {
        if (self.bankerView.chipView != nil) {
            [self showChipErrorAlert];
            return;
        }
    } else if (boadView == self.bankerView){
        if (self.playerView.chipView != nil) {
            [self showChipErrorAlert];
            return;
        }
    }
    
    NSInteger score = self.selectChipImg.tag;
    if (score > totalScore) {
        [self playSoundByFile:@"ce_chipwarn"];
        return;
    }
    
    [self playSoundByFile:@"ce_chip"];
    [self addFloatingChipViewByPoint:score];
    UIImageView *chipFloat = [self getChipFloatingViewByScore:score];
    [UIView animateWithDuration:0.3f animations:^{
        chipFloat.center = CGPointMake(boadView.center.x, boadView.center.y);
    } completion:^(BOOL finished) {
        UIImageView *totalChipView = nil;
        UIImage *totalChipImage = nil;
        
        if(boadView.chipView == nil) {
            totalChipView = [self createChipFloatView];
            boadView.chipView = totalChipView;
            totalChipView.tag += score;
        } else {
            totalChipView = boadView.chipView;
            totalChipView.tag += score;
        }
        totalChipImage =[ImageUtils scoreToChips:totalChipView.tag];
        totalChipView.center = CGPointMake(boadView.center.x, boadView.center.y);
        totalChipView.bounds = CGRectMake(0, 0, totalChipImage.size.width, totalChipImage.size.height);
        totalChipView.image = totalChipImage;
        totalBetScore += score;
        totalScore -= score;
        [self updateScore];
        [self updateChipLabel:boadView number:totalChipView.tag];
        [self.chipFloatingViews removeObject:chipFloat];
        [chipFloat removeFromSuperview];
    }];
}

- (void) startGame
{
    isGameStart = YES;
    
    self.tipBtn.hidden = YES;
    self.potBtn.hidden = YES;
    self.recycelBtn.hidden = YES;
    self.settingBtn.hidden = YES;
    
    self.chip100Img.hidden = YES;
    self.chip500Img.hidden = YES;
    self.chip1000Img.hidden = YES;
    self.chip5000Img.hidden = YES;
    self.chip10000Img.hidden = YES;

    for (UIImageView *chipFloat in self.chipFloatingViews) {
        chipFloat.hidden = YES;
    }
    
    [self takeCard];
    [self dealCard];
}

- (void) takeCard
{
    Result *result = [self.cardsBuilder getCardsByResult:[self.resultBuilder getNextResult]];
    if (result != nil) {
        self.currentResult = result;
        [self.allResult addObject:result];
    }
    
}

- (void) dealCard
{
    if (self.currentResult != nil) {
        [self initAnim];
        [self.cardBg_1.layer addAnimation:self.anim1 forKey:@"anim1"];
        [self.cardBg_2.layer addAnimation:self.anim2 forKey:@"anim2"];
        [self.cardBg_3.layer addAnimation:self.anim3 forKey:@"anim3"];
        [self.cardBg_4.layer addAnimation:self.anim4 forKey:@"anim4"];
        
        if (self.currentResult.allCards.count >= 5) {
            [self.cardBg_5.layer addAnimation:self.anim5 forKey:@"anim5"];
            [self.playerCard_2.layer addAnimation:self.animPlayerCard2 forKey:nil];
        }
        if (self.currentResult.allCards.count >= 6) {
            [self.cardBg_6.layer addAnimation:self.anim6 forKey:@"anim6"];
            [self.bankerCard_2.layer addAnimation:self.animBankerCard2 forKey:nil];
        }
    }
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString *value = [anim valueForKey:@"anim"];
    if ([value isEqual:@"anim1"]) {
        Card *card = [self.currentResult.playerCards objectAtIndex:0];
        [self playVoiceByFile:@"Players_cn"];
        self.playerCard_1.hidden = NO;
        self.playerCard_1.image = [UIImage imageNamed:card.resId];
        self.playerPointView.hidden = NO;
        self.playerPointView.image = [UIImage imageNamed:[NSString stringWithFormat:@"point_player_%d", card.validPoint.integerValue]];
    } else if ([value isEqual:@"anim2"]) {
        [self playVoiceByFile:@"Bankers_cn"];
        Card *card = [self.currentResult.bankerCards objectAtIndex:0];
        self.bankerCard_1.hidden = NO;
        self.bankerCard_1.image = [UIImage imageNamed:card.resId];
        self.bankerPointView.hidden = NO;
        self.bankerPointView.image = [UIImage imageNamed:[NSString stringWithFormat:@"point_banker_%d", card.validPoint.integerValue]];
    }else if ([value isEqual:@"anim3"]) {
        [self playVoiceByFile:@"Players_cn"];
        Card *card = [self.currentResult.playerCards objectAtIndex:1];
        self.playerCard_2.hidden = NO;
        self.playerCard_2.image = [UIImage imageNamed:card.resId];
        
        Card *card1 = [self.currentResult.playerCards objectAtIndex:0];
        NSNumber *pointCard1 = card1.validPoint;
        NSNumber *pointCard2 = card.validPoint;
        self.playerPointView.image = [UIImage imageNamed:[NSString stringWithFormat:@"point_player_%d", [self add:pointCard1 and:pointCard2].integerValue]];
    }else if ([value isEqual:@"anim4"]) {
        [self playVoiceByFile:@"Bankers_cn"];
        Card *card = [self.currentResult.bankerCards objectAtIndex:1];
        self.bankerCard_2.hidden = NO;
        self.bankerCard_2.image = [UIImage imageNamed:card.resId];
        Card *card1 = [self.currentResult.bankerCards objectAtIndex:0];
        NSNumber *pointCard1 = card1.validPoint;
        NSNumber *pointCard2 = card.validPoint;
        self.bankerPointView.image = [UIImage imageNamed:[NSString stringWithFormat:@"point_player_%d", [self add:pointCard1 and:pointCard2].integerValue]];
        if (self.currentResult.allCards.count == 4) {
            [self gameFinish];
        }
    }else if ([value isEqual:@"anim5"]) {
        [self playVoiceByFile:@"ba_1c2p_cn"];
        Card *card = [self.currentResult.playerCards objectAtIndex:2];
        self.playerCard_3.hidden = NO;
        self.playerCard_3.image = [UIImage imageNamed:card.resId];
        
        Card *card1 = [self.currentResult.playerCards objectAtIndex:0];
        Card *card2 = [self.currentResult.playerCards objectAtIndex:1];
        NSNumber *pointCard1 = card1.validPoint;
        NSNumber *pointCard2 = card2.validPoint;
        NSNumber *pointCard3 = card.validPoint;
        NSNumber *result = [self add:pointCard1 and:pointCard2];
        result = [self add:result and:pointCard3];
        self.playerPointView.image = [UIImage imageNamed:[NSString stringWithFormat:@"point_player_%d", result.integerValue]];
        
        if (self.currentResult.allCards.count == 5) {
            [self gameFinish];
        }
    }else if ([value isEqual:@"anim6"]) {
        [self playVoiceByFile:@"ba_1c2b_cn"];
        Card *card = [self.currentResult.bankerCards objectAtIndex:2];
        self.bankerCard_3.hidden = NO;
        self.bankerCard_3.image = [UIImage imageNamed:card.resId];
        
        Card *card1 = [self.currentResult.bankerCards objectAtIndex:0];
        Card *card2 = [self.currentResult.bankerCards objectAtIndex:1];
        NSNumber *pointCard1 = card1.validPoint;
        NSNumber *pointCard2 = card2.validPoint;
        NSNumber *pointCard3 = card.validPoint;
        NSNumber *result = [self add:pointCard1 and:pointCard2];
        result = [self add:result and:pointCard3];
        self.bankerPointView.image = [UIImage imageNamed:[NSString stringWithFormat:@"point_player_%d", result.integerValue]];
        
        if (self.currentResult.allCards.count == 6) {
            [self gameFinish];
        }
    }
}
- (void) gameFinish
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"Players_cn" forKey:@"sound"];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic repeats:NO];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:[self getVoiceNameByBumber:self.currentResult.playerPoint] forKey:@"sound"];
    [NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic1 repeats:NO];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:@"Bankers_cn" forKey:@"sound"];
    [NSTimer scheduledTimerWithTimeInterval:3.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic2 repeats:NO];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:[self getVoiceNameByBumber:self.currentResult.bankerPoint] forKey:@"sound"];
    [NSTimer scheduledTimerWithTimeInterval:4.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic3 repeats:NO];
    
    if (self.currentResult.resultType == ResultPlayerWin) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"c_playerwin_cn" forKey:@"sound"];
        [NSTimer scheduledTimerWithTimeInterval:5.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic repeats:NO];
        
        NSLog(@"result--->2");
        CABasicAnimation *anim =[CABasicAnimation animation];
        anim.keyPath = @"position";
        anim.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_1.center.x, self.playerCard_1.center.y)];
        anim.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_1.center.x, self.playerCard_1.center.y + 30)];
        anim.removedOnCompletion=NO;
        anim.fillMode = kCAFillModeForwards;
        anim.duration = 0.4;
        anim.delegate = self;
        anim.beginTime = CACurrentMediaTime() + 5.5f;
        [self.playerCard_1.layer addAnimation:anim forKey:nil];
        
        CABasicAnimation *anim1 =[CABasicAnimation animation];
        anim1.keyPath = @"position";
        anim1.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x, self.playerCard_2.center.y)];
        anim1.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x, self.playerCard_2.center.y + 30)];
        anim1.removedOnCompletion=NO;
        anim1.fillMode = kCAFillModeForwards;
        anim1.duration = 0.4;
        anim1.delegate = self;
        anim1.beginTime = CACurrentMediaTime() + 5.5f;
        [self.playerCard_2.layer addAnimation:anim1 forKey:nil];
        
        CABasicAnimation *anim2 =[CABasicAnimation animation];
        anim2.keyPath = @"position";
        anim2.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_3.center.x, self.playerCard_3.center.y)];
        anim2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_3.center.x, self.playerCard_3.center.y + 30)];
        anim2.removedOnCompletion=NO;
        anim2.fillMode = kCAFillModeForwards;
        anim2.duration = 0.4;
        anim2.delegate = self;
        anim2.beginTime = CACurrentMediaTime() + 5.5f;
        [self.playerCard_3.layer addAnimation:anim2 forKey:nil];
        
        [NSTimer scheduledTimerWithTimeInterval:5.5f target:self selector:@selector(addPlayerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:6.0f target:self selector:@selector(removePlayerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:6.5f target:self selector:@selector(addPlayerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:7.0f target:self selector:@selector(removePlayerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:7.5f target:self selector:@selector(addPlayerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:8.0f target:self selector:@selector(removePlayerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:9.5f target:self selector:@selector(balance) userInfo:nil repeats:NO];
    } else if (self.currentResult.resultType == ResultBankerWin){
        NSLog(@"result--->1");
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"ba_bwin_cn" forKey:@"sound"];
        [NSTimer scheduledTimerWithTimeInterval:5.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic repeats:NO];
        
        CABasicAnimation *anim =[CABasicAnimation animation];
        anim.keyPath = @"position";
        anim.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_1.center.x, self.bankerCard_1.center.y)];
        anim.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_1.center.x, self.bankerCard_1.center.y + 30)];
        anim.removedOnCompletion=NO;
        anim.fillMode = kCAFillModeForwards;
        anim.duration = 0.4;
        anim.delegate = self;
        anim.beginTime = CACurrentMediaTime() + 5.5;
        [self.bankerCard_1.layer addAnimation:anim forKey:nil];
        
        CABasicAnimation *anim1 =[CABasicAnimation animation];
        anim1.keyPath = @"position";
        anim1.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x, self.bankerCard_2.center.y)];
        anim1.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x, self.bankerCard_2.center.y + 30)];
        anim1.removedOnCompletion=NO;
        anim1.fillMode = kCAFillModeForwards;
        anim1.duration = 0.4;
        anim1.delegate = self;
        anim1.beginTime = CACurrentMediaTime() + 5.5;
        [self.bankerCard_2.layer addAnimation:anim1 forKey:nil];
        
        CABasicAnimation *anim2 =[CABasicAnimation animation];
        anim2.keyPath = @"position";
        anim2.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_3.center.x, self.bankerCard_3.center.y)];
        anim2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_3.center.x, self.bankerCard_3.center.y + 30)];
        anim2.removedOnCompletion=NO;
        anim2.fillMode = kCAFillModeForwards;
        anim2.duration = 0.4;
        anim2.delegate = self;
        anim2.beginTime = CACurrentMediaTime() + 5.5;
        [self.bankerCard_3.layer addAnimation:anim2 forKey:nil];
        
        [NSTimer scheduledTimerWithTimeInterval:5.5f target:self selector:@selector(addBankerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:6.0f target:self selector:@selector(removeBankerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:6.5f target:self selector:@selector(addBankerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:7.0f target:self selector:@selector(removeBankerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:7.5f target:self selector:@selector(addBankerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:8.0f target:self selector:@selector(removeBankerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:9.5f target:self selector:@selector(balance) userInfo:nil repeats:NO];
    } else {
        NSLog(@"result--->3");
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"ba_tiwin_cn" forKey:@"sound"];
        [NSTimer scheduledTimerWithTimeInterval:5.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic repeats:NO];
    
        [NSTimer scheduledTimerWithTimeInterval:5.5f target:self selector:@selector(addSameViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:6.0f target:self selector:@selector(removeSameViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:6.5f target:self selector:@selector(addSameViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:7.0f target:self selector:@selector(removeSameViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:7.5f target:self selector:@selector(addSameViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:8.0f target:self selector:@selector(removeSameViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:9.5f target:self selector:@selector(balance) userInfo:nil repeats:NO];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:5.5f target:self selector:@selector(drawWinChip) userInfo:nil repeats:NO];
}
//赢得筹码绘制以及飞出动画
- (void) drawWinChip
{
    if ((self.currentResult.resultType == ResultBankerWin && self.bankerView.chipView != nil) || (self.currentResult.resultType == ResultPlayerWin  && self.playerView.chipView != nil) || (self.currentResult.resultType == ResultDrawnGame && self.sameView.chipView != nil) || (self.currentResult.isPlayerDouble && self.playerDoubleView.chipView != nil) || (self.currentResult.isBankerDouble && self.bankerDoubleView.chipView != nil)) {
        [self playSoundByFile:@"pwin_money"];
    } else {
        [self playSoundByFile:@"plose_money"];
    }
    
    if (self.currentResult.resultType == ResultBankerWin && self.bankerView.chipView != nil) {
        self.winBankerChipView =[[UIImageView alloc] init];
        UIImage *totalChipImage = [ImageUtils scoreToChips:self.bankerView.chipView.tag];
        self.winBankerChipView.tag = self.bankerView.chipView.tag;
        self.winBankerChipView.center = CGPointMake(self.bankerView.chipView.center.x + 80, self.bankerView.chipView.center.y);
        self.winBankerChipView.bounds = CGRectMake(0.0f, 0.0f, totalChipImage.size.width, totalChipImage.size.height);
        self.winBankerChipView.image = totalChipImage;
        [self.view addSubview:self.winBankerChipView];
        
    } else if (self.currentResult.resultType == ResultPlayerWin && self.playerView.chipView != nil) {
        self.winPlayerChipView =[[UIImageView alloc] init];
        UIImage *totalChipImage = [ImageUtils scoreToChips:self.playerView.chipView.tag];
        self.winPlayerChipView.tag =self.playerView.chipView.tag;
        self.winPlayerChipView.center = CGPointMake(self.playerView.chipView.center.x + 80, self.playerView.chipView.center.y);
        self.winPlayerChipView.bounds = CGRectMake(0.0f, 0.0f, totalChipImage.size.width, totalChipImage.size.height);
        self.winPlayerChipView.image = totalChipImage;
        [self.view addSubview:self.winPlayerChipView];
    } else if (self.currentResult.resultType == ResultDrawnGame && self.sameView.chipView != nil){
        self.winSameChipView =[[UIImageView alloc] init];
        UIImage *totalChipImage = [ImageUtils scoreToChips:self.sameView.chipView.tag * 8];
        self.winSameChipView.tag =self.sameView.chipView.tag * 8;
        self.winSameChipView.center = CGPointMake(self.sameView.chipView.center.x + 80, self.sameView.chipView.center.y);
        self.winSameChipView.bounds = CGRectMake(0.0f, 0.0f, totalChipImage.size.width, totalChipImage.size.height);
        self.winSameChipView.image = totalChipImage;
        [self.view addSubview:self.winSameChipView];
        
    }
    
    if (self.currentResult.isPlayerDouble) {
        if (self.playerDoubleView != nil) {
            self.winPlayerDoubleChipView =[[UIImageView alloc] init];
            UIImage *totalChipImage = [ImageUtils scoreToChips:self.playerDoubleView.chipView.tag * 11];
            self.winPlayerDoubleChipView.tag =self.playerDoubleView.chipView.tag * 11;
            self.winPlayerDoubleChipView.center = CGPointMake(self.playerDoubleView.chipView.center.x + 80, self.playerDoubleView.chipView.center.y);
            self.winPlayerDoubleChipView.bounds = CGRectMake(0.0f, 0.0f, totalChipImage.size.width, totalChipImage.size.height);
            self.winPlayerDoubleChipView.image = totalChipImage;
            [self.view addSubview:self.winPlayerDoubleChipView];
        }
    }
    
    if (self.currentResult.isBankerDouble) {
        if (self.bankerDoubleView != nil) {
            self.winBankerDoubleChipView =[[UIImageView alloc] init];
            UIImage *totalChipImage = [ImageUtils scoreToChips:self.bankerDoubleView.chipView.tag * 11];
            self.winBankerDoubleChipView.tag = self.bankerDoubleView.chipView.tag * 11;
            self.winBankerDoubleChipView.center = CGPointMake(self.bankerDoubleView.chipView.center.x - 80, self.bankerDoubleView.chipView.center.y);
            self.winBankerDoubleChipView.bounds = CGRectMake(0.0f, 0.0f, totalChipImage.size.width, totalChipImage.size.height);
            self.winBankerDoubleChipView.image = totalChipImage;
            [self.view addSubview:self.winBankerDoubleChipView];
        }
    }
}

- (void) addPlayerViewBg
{
    UIColor *bgColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#ffffff" alpha:0.4];
    self.playerView.backgroundColor = bgColor;
}

- (void) removePlayerViewBg
{
    self.playerView.backgroundColor = nil;
}

- (void) addBankerViewBg
{
    UIColor *bgColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#ffffff" alpha:0.4];
    self.bankerView.backgroundColor = bgColor;
}

- (void) removeBankerViewBg
{
    self.bankerView.backgroundColor = nil;
}

- (void) addSameViewBg
{
    UIColor *bgColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#ffffff" alpha:0.4];
    self.sameView.backgroundColor = bgColor;
}

- (void) removeSameViewBg
{
    self.sameView.backgroundColor = nil;
}

- (void) balance
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        if (self.winPlayerChipView != nil) {
            totalWinScore += self.winPlayerChipView.tag;
            totalWinScore += self.playerView.chipView.tag;
            self.winPlayerChipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
            self.playerView.chipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
        } else {
            self.playerView.chipView.center = CGPointMake(self.view.center.x, -100);
        }
        
        if (self.winPlayerDoubleChipView != nil) {
            totalWinScore += self.winPlayerDoubleChipView.tag;
            totalWinScore += self.playerDoubleView.chipView.tag;
            self.winPlayerDoubleChipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
            self.playerDoubleView.chipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
        }else {
            self.playerDoubleView.chipView.center = CGPointMake(self.view.center.x, -100);
        }
        
        if (self.winBankerChipView != nil) {
            totalWinScore += self.winBankerChipView.tag;
            totalWinScore += self.bankerView.chipView.tag;
            self.winBankerChipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
            self.bankerView.chipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
        }else {
            self.bankerView.chipView.center = CGPointMake(self.view.center.x, -100);
        }
        
        if (self.winBankerDoubleChipView != nil) {
            totalWinScore += self.winBankerDoubleChipView.tag;
            totalWinScore += self.bankerDoubleView.chipView.tag;
            self.winBankerDoubleChipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
            self.bankerDoubleView.chipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
        } else {
            self.bankerDoubleView.chipView.center = CGPointMake(self.view.center.x, -100);
        }
        
        if (self.winSameChipView != nil) {
            totalWinScore += self.winSameChipView.tag;
            totalWinScore += self.sameView.chipView.tag;
            self.winSameChipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
            self.sameView.chipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
        } else {
            self.sameView.chipView.center = CGPointMake(self.view.center.x, -100);
        }
        
    } completion:^(BOOL finished) {
        
        isGameStart = NO;
        //删除动画
        [self.playerCard_1.layer removeAllAnimations];
        [self.playerCard_2.layer removeAllAnimations];
        [self.playerCard_3.layer removeAllAnimations];
        [self.bankerCard_1.layer removeAllAnimations];
        [self.bankerCard_2.layer removeAllAnimations];
        [self.bankerCard_3.layer removeAllAnimations];
        
        //隐藏所有卡牌
        [self hideAllCard];
        
        //显示底部
        self.tipBtn.hidden = NO;
        self.potBtn.hidden = NO;
        self.recycelBtn.hidden = NO;
        self.settingBtn.hidden = NO;
        
        self.chip100Img.hidden = NO;
        self.chip500Img.hidden = NO;
        self.chip1000Img.hidden = NO;
        self.chip5000Img.hidden = NO;
        self.chip10000Img.hidden = NO;
        
        for (UIImageView *chipFloat in self.chipFloatingViews) {
            chipFloat.hidden = NO;
        }
        
        //更新总筹码
        totalScore += totalWinScore;
        [self updateScore];
        
        //押注筹码重置
        totalBetScore = 0;
        totalWinScore = 0;
        playerScore = self.playerView.chipView.tag;
        bankerScore = self.bankerView.chipView.tag;
        playerDoubleScore = self.playerDoubleView.chipView.tag;
        bankerDoubleScore = self.bankerDoubleView.chipView.tag;
        sameScore = self.sameView.chipView.tag;
        
        //移除筹码
        [self.playerView.chipView removeFromSuperview];
        [self.bankerView.chipView removeFromSuperview];
        [self.playerDoubleView.chipView removeFromSuperview];
        [self.bankerDoubleView.chipView removeFromSuperview];
        [self.sameView.chipView removeFromSuperview];
        
        [self.winPlayerChipView removeFromSuperview];
        [self.winPlayerDoubleChipView removeFromSuperview];
        [self.winBankerChipView removeFromSuperview];
        [self.winBankerDoubleChipView removeFromSuperview];
        [self.winSameChipView removeFromSuperview];
        
        //置空
        self.playerView.chipView = nil;
        self.bankerView.chipView = nil;
        self.playerDoubleView.chipView = nil;
        self.bankerDoubleView.chipView = nil;
        self.sameView.chipView = nil;
        
        self.winPlayerChipView = nil;
        self.winPlayerDoubleChipView = nil;
        self.winBankerChipView = nil;
        self.winBankerDoubleChipView = nil;
        self.winSameChipView = nil;
        
        [self updateChipLabel:self.sameView number:0];
        [self updateChipLabel:self.playerDoubleView number:0];
        [self updateChipLabel:self.bankerDoubleView number:0];
        [self updateChipLabel:self.playerView number:0];
        [self updateChipLabel:self.bankerView number:0];
        
//        self.potBtn.imageView.image = [UIImage imageNamed:@"last_pot_btn"];
        [self.potBtn setImage:[UIImage imageNamed:@"last_pot_btn_s"] forState:UIControlStateNormal];
        [self.potBtn setImage:[UIImage imageNamed:@"last_pot_btn"] forState:UIControlStateHighlighted];
        
        if (totalScore <= 100) {
            totalScore += totalScore;
            [[NSUserDefaults standardUserDefaults] setInteger:totalScore forKey:@"totalScore"];
        }
        
        //请下注
        [self playVoiceByFile:@"c_place_cn"];
        
        [self drawMark];
        
        self.cardsNumber.text = [NSString stringWithFormat:@"Cards:%d", self.cardsBuilder.cards.count];
    }];
}

- (void) drawMark
{
    [self drawResult1Mark];
    [self drawResult2Mark];
    [self drawResult3Mark];
    [self drawResult4Mark];
    [self drawResult5Mark];
    [self updateResultCount];
    
    if (isFirstTimeStart) {
        isFirstTimeStart = NO;
        self.markContainer.hidden = NO;
    }
}

- (void) updateResultCount
{
    NSInteger playerWinCount = [self.playerWinCountLabel.text integerValue];
    NSInteger bankerWinCount = [self.bankerWinCountLabel.text integerValue];
    NSInteger drawnGameCount = [self.drawnGameCountLabel.text integerValue];
    NSInteger bornCardCount = [self.bornCardCountLabel.text integerValue];
    NSInteger playerDoubleCount = [self.playerDoubleViewLabel.text integerValue];
    NSInteger bankerDoubleCount = [self.bankerDoubelCountLabel.text integerValue];
    if (self.currentResult != nil) {
        if (self.currentResult.resultType == ResultPlayerWin) {
            playerWinCount++;
        } else if (self.currentResult.resultType == ResultBankerWin) {
            bankerWinCount++;
        } else {
            drawnGameCount++;
        }
        if (self.currentResult.isPlayerBornCard || self.currentResult.isBankerBornCard) {
            bornCardCount++;
        }
        
        if (self.currentResult.isPlayerDouble) {
            playerDoubleCount++;
        }
        if (self.currentResult.isBankerDouble) {
            bankerDoubleCount++;
        }
        self.playerWinCountLabel.text =[NSString stringWithFormat:@"%d", playerWinCount];
        self.bankerWinCountLabel.text =[NSString stringWithFormat:@"%d", bankerWinCount];
        self.drawnGameCountLabel.text =[NSString stringWithFormat:@"%d", drawnGameCount];
        self.bornCardCountLabel.text =[NSString stringWithFormat:@"%d", bornCardCount];
        self.playerDoubleViewLabel.text =[NSString stringWithFormat:@"%d", playerDoubleCount];
        self.bankerDoubelCountLabel.text =[NSString stringWithFormat:@"%d", bankerDoubleCount];
    }
}

- (void) drawResult1Mark
{
    NSString *imageName = nil;
    if (self.currentResult.resultType == ResultPlayerWin) {
        if (self.currentResult.isPlayerBornCard) {
            imageName = @"player_win_fill";
        } else {
            imageName = @"player_win_empty";
        }
    } else if (self.currentResult.resultType == ResultBankerWin) {
        if (self.currentResult.isBankerBornCard) {
            imageName = @"banker_win_fill";
        } else {
            imageName = @"banker_win_empty";
        }
    } else {
        if (self.currentResult.isPlayerBornCard) {
            imageName = @"drawn_game_fill";
        } else {
            imageName = @"drawn_game_empty";
        }
    }
    MarkPoint *point = [self.markBuilder getNextMark1PointByResult:self.currentResult];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.pointX.floatValue, point.pointY.floatValue, 21, 21)];
    point.isUsed = YES;
    imageView.image = [UIImage imageNamed:imageName];
    [self.markView1 addSubview:imageView];
    
}
- (void) drawResult2Mark
{
    MarkPoint *point = [self.markBuilder getNextMark2PointByResult:self.currentResult];
    if (point == nil) {
        return;
    }
    NSString *imageName = nil;
    if (point.resultType == ResultPlayerWin) {
        imageName = @"player_win_empty";
    } else if (point.resultType == ResultBankerWin) {
        imageName = @"banker_win_empty";
    } else {
        imageName = @"drawn_game_empty";
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.pointX.floatValue, point.pointY.floatValue, 10.5, 10.5)];
    point.isUsed = YES;
    imageView.image = [UIImage imageNamed:imageName];
    [self.markView2 addSubview:imageView];
}

- (void) drawResult3Mark
{
    MarkPoint *point = [self.markBuilder getNextMark3PointByResult:self.currentResult];
    if (point == nil) {
        return;
    }
    NSString *imageName = nil;
    if (point.resultType == ResultPlayerWin) {
        imageName = @"player_win_fill";
    } else if (point.resultType == ResultBankerWin) {
        imageName = @"banker_win_fill";
    } else {
        imageName = @"drawn_game_fill";
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.pointX.floatValue, point.pointY.floatValue, 10.5, 10.5)];
    point.isUsed = YES;
    imageView.image = [UIImage imageNamed:imageName];
    [self.markView3 addSubview:imageView];
}

- (void) drawResult4Mark
{
    MarkPoint *point = [self.markBuilder getNextMark4PointByResult:self.currentResult];
    if (point == nil) {
        return;
    }
    NSString *imageName = nil;
    if (point.resultType == ResultPlayerWin) {
        imageName = @"player_win_stripe";
    } else {
        imageName = @"banker_win_stripe";
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.pointX.floatValue, point.pointY.floatValue, 10.5, 10.5)];
    point.isUsed = YES;
    imageView.image = [UIImage imageNamed:imageName];
    [self.markView4 addSubview:imageView];
}

- (void) drawResult5Mark
{
    NSString *imageName = nil;
    NSString *nameLable = nil;
    if (self.currentResult.resultType == ResultPlayerWin) {
        if (self.currentResult.isPlayerDouble && self.currentResult.isBankerDouble) {
            imageName = @"player_win_all_double";
        } else if (!self.currentResult.isPlayerDouble && self.currentResult.isBankerDouble) {
            imageName = @"player_win_banker_double";
        } else if (self.currentResult.isPlayerDouble && !self.currentResult.isBankerDouble) {
            imageName = @"player_win_player_double";
        } else {
            imageName = @"player_win";
        }
        nameLable = @"闲";
    } else if (self.currentResult.resultType == ResultBankerWin) {
        if (self.currentResult.isPlayerDouble && self.currentResult.isBankerDouble) {
            imageName = @"banker_win_all_double";
        } else if (!self.currentResult.isPlayerDouble && self.currentResult.isBankerDouble) {
            imageName = @"banker_win_banker_double";
        } else if (self.currentResult.isPlayerDouble && !self.currentResult.isBankerDouble) {
            imageName = @"banker_win_player_double";
        } else {
            imageName = @"banker_win";
        }
        nameLable = @"庄";
    } else {
        if (self.currentResult.isPlayerDouble && self.currentResult.isBankerDouble) {
            imageName = @"drawn_game_all_double";
        } else if (!self.currentResult.isPlayerDouble && self.currentResult.isBankerDouble) {
            imageName = @"drawn_game_banker_double";
        } else if (self.currentResult.isPlayerDouble && !self.currentResult.isBankerDouble) {
            imageName = @"drawn_game_player_double";
        } else {
            imageName = @"drawn_game";
        }
        nameLable = @"和";
    }
    MarkPoint *point = [self.markBuilder getNextUnusedMark5Point];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.pointX.floatValue, point.pointY.floatValue, 42, 42)];
    point.isUsed = YES;
    imageView.image = [UIImage imageNamed:imageName];
    [self.markView5 addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(point.pointX.floatValue, point.pointY.floatValue, 42, 42)];
    label.text = nameLable;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica" size:25];
    [self.markView5 addSubview:label];
}

-(NSNumber*)add:(NSNumber *)one and:(NSNumber *)anotherNumber
{
    NSNumber *result =[NSNumber numberWithInteger:[one integerValue] + [anotherNumber integerValue]];
    result = [NSNumber numberWithInteger:result.integerValue % 10];
    return result;
}

-(IBAction)showSystemAlert:(id)sender
{
    if (isGameStart) {
        return;
    }

    [self playSoundByFile:@"mouse_move"];
    // create the alert
    self.alert = [MLTableAlert tableAlertWithTitle:@"主菜单" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return 7;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      cell.textLabel.textAlignment = UITextAlignmentCenter;
                      if (indexPath.row == 0) {
                          cell.textLabel.text = @"在线玩游戏";
                      } else if (indexPath.row == 1) {
                          cell.textLabel.text = @"换桌";
                      } else if (indexPath.row == 2) {
                          cell.textLabel.text = @"增添筹码";
                      } else if (indexPath.row == 3) {
                          cell.textLabel.text = @"游戏记录";
                      } else if (indexPath.row == 4) {
                          cell.textLabel.text = @"设置";
                      } else if (indexPath.row == 5) {
                          cell.textLabel.text = @"客户服务";
                      } else if (indexPath.row == 6) {
                          cell.textLabel.text = @"其它游戏";
                      }
                      
                      return cell;
                  }];
    
    // Setting custom alert height
    self.alert.height = 400;
    
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex){
        //        self.resultLabel.text = [NSString stringWithFormat:@"Selected Index\nSection: %d Row: %d", selectedIndex.section, selectedIndex.row];
    } andCompletionBlock:^{
        //        self.resultLabel.text = @"Cancel Button Pressed\nNo Cells Selected";
    }];
    
    // show the alert
    [self.alert show];
}

-(void)showChipListAlert
{
    // create the alert
    self.alert = [MLTableAlert tableAlertWithTitle:@"购买筹码" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return 7;
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      cell.textLabel.textAlignment = UITextAlignmentCenter;
                      if (indexPath.row == 0) {
                          cell.textLabel.text = @"10万筹码:$0.99";
                      } else if (indexPath.row == 1) {
                          cell.textLabel.text = @"60万筹码:$4.99";
                      } else if (indexPath.row == 2) {
                          cell.textLabel.text = @"150万筹码:$9.99";
                      } else if (indexPath.row == 3) {
                          cell.textLabel.text = @"10万筹码:$19.99";
                      } else if (indexPath.row == 4) {
                          cell.textLabel.text = @"10万筹码:$29.99";
                      } else if (indexPath.row == 5) {
                          cell.textLabel.text = @"10万筹码:$49.99";
                      } else if (indexPath.row == 6) {
                          cell.textLabel.text = @"10万筹码:$99.99";
                      }
                      
                      return cell;
                  }];
    
    // Setting custom alert height
    self.alert.height = 400;
    
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex){
        //        self.resultLabel.text = [NSString stringWithFormat:@"Selected Index\nSection: %d Row: %d", selectedIndex.section, selectedIndex.row];
        [self showTransactionFailureAlert];
    } andCompletionBlock:^{
        //        self.resultLabel.text = @"Cancel Button Pressed\nNo Cells Selected";
        
    }];
    
    // show the alert
    [self.alert show];
}

- (void) showTransactionFailureAlert
{
    NSString *title = @"交易失败";
    NSString *message = @"现在无法购买筹码，请稍后再试。";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction) showBuyChipsAlert:(id)sender
{
    if (isGameStart) {
        return;
    }

    [self playSoundByFile:@"mouse_move"];
    NSString *title = @"百家乐";
    NSString *message = @"在您首次购买筹码时，将100%的获得与您购买金额相当的额外筹码。";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showChipListAlert];
    }];
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)onSettingBtnClicked:(id)sender
{
//    if (YES) {
//        return;
//    }
    SettingViewController *control=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SettingViewController"];
    [self presentViewController:control animated:YES completion:^{
        
    }];
    
//    [self.navigationController pushViewController:control animated:YES];
}

@end
