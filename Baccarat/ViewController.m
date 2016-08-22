//
//  ViewController.m
//  Baccarat
//
//  Created by ; on 16/5/22.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "ViewController.h"
#import "CardsBuilder.h"
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
#import "GameRecorderInfo.h"
#import "GameRecordViewController.h"
#import "AdvertisementViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate>
@property (strong, nonatomic) UIImageView *chip100Img;
@property (strong, nonatomic) UIImageView *chip500Img;
@property (strong, nonatomic) UIImageView *chip1000Img;
@property (strong, nonatomic) UIImageView *chip5000Img;
@property (strong, nonatomic) UIImageView *chip10000Img;
@property (strong, nonatomic) UIImageView *chipSelect;

@property (strong, nonatomic) ChipBoardView *playerDoubleView;
@property (strong, nonatomic) ChipBoardView *sameView;
@property (strong, nonatomic) ChipBoardView *bankerDoubleView;
@property (strong, nonatomic) ChipBoardView *playerView;
@property (strong, nonatomic) ChipBoardView *bankerView;

@property (strong, nonatomic) ChipBoardView *totalChipFromView;

@property (strong, nonatomic) UILabel *playerDoubleViewLabel;
@property (strong, nonatomic) UILabel *sameViewLabel;
@property (strong, nonatomic) UILabel *bankerDoubleViewLabel;
@property (strong, nonatomic) UILabel *playerViewLabel;
@property (strong, nonatomic) UILabel *bankerViewLabel;

//@property (weak, nonatomic) IBOutlet UIView *playerViewFlag;
//@property (weak, nonatomic) IBOutlet UIView *bankerViewFlag;

@property (strong, nonatomic) UIImageView *gg_imageview;
@property (strong, nonatomic) UIImageView *gg_imageview_hd;

@property (strong, nonatomic) UIImageView *playerCard_1;
@property (strong, nonatomic) UIImageView *playerCard_2;
@property (strong, nonatomic) UIImageView *playerCard_3;
@property (strong, nonatomic) UIImageView *bankerCard_1;
@property (strong, nonatomic) UIImageView *bankerCard_2;
@property (strong, nonatomic) UIImageView *bankerCard_3;
@property (strong, nonatomic) UIImageView *playerPointView;
@property (strong, nonatomic) UIImageView *bankerPointView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

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
@property (weak, nonatomic) IBOutlet UIImageView *tableChangeImage;

@property (weak, nonatomic) IBOutlet UIView *whiteLineView;
@property (weak, nonatomic) IBOutlet UILabel *resultTipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topChipImageView;

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

@property (strong, nonatomic) UIImageView *congratulationsImage;

@property (strong, nonatomic) UIImageView *cardsView;
@property (strong, nonatomic) UIImageView *cutCardsView;

@property (strong, nonatomic) UIImageView *cutCardsView1;
@property (strong, nonatomic) UIImageView *cutCardsView2;

@property (strong, nonatomic) UIView *burningCardContainer1;
@property (strong, nonatomic) UIView *burningCardContainer2;

@property (strong, nonatomic) UIView *currentMarkContainer;

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

@property (strong, nonatomic) UIImageView *wordT;
@property (strong, nonatomic) UIImageView *wordA;

@property (strong, nonatomic) UIView *markContainer_hd;
@property (strong, nonatomic) UIImageView *markContainerBg_hd;
@property (strong, nonatomic) UIScrollView *markView1_hd;
@property (strong, nonatomic) UIScrollView *markView2_hd;
@property (strong, nonatomic) UIScrollView *markView3_hd;
@property (strong, nonatomic) UIScrollView *markView4_hd;
@property (strong, nonatomic) UIScrollView *markView5_hd;
@property (strong, nonatomic) UIView *markView6_hd;
@property (strong, nonatomic) UIView *markView7_hd;

@property (strong, nonatomic) UIImageView *markViewImage1_hd;
@property (strong, nonatomic) UIImageView *markViewImage2_hd;
@property (strong, nonatomic) UIImageView *markViewImage3_hd;
@property (strong, nonatomic) UIImageView *markViewImage4_hd;
@property (strong, nonatomic) UIImageView *markViewImage5_hd;

@property (strong, nonatomic) UIImageView *wordT_hd;
@property (strong, nonatomic) UIImageView *wordA_hd;

@property (strong, nonatomic) UILabel *playerWinCountLabel;
@property (strong, nonatomic) UILabel *bankerWinCountLabel;
@property (strong, nonatomic) UILabel *bornCardCountLabel;
@property (strong, nonatomic) UILabel *drawnGameCountLabel;
@property (strong, nonatomic) UILabel *playerDoubelCountLabel;
@property (strong, nonatomic) UILabel *bankerDoubelCountLabel;

@property (strong, nonatomic) UILabel *playerWinCountLabel_hd;
@property (strong, nonatomic) UILabel *bankerWinCountLabel_hd;
@property (strong, nonatomic) UILabel *bornCardCountLabel_hd;
@property (strong, nonatomic) UILabel *drawnGameCountLabel_hd;
@property (strong, nonatomic) UILabel *playerDoubelCountLabel_hd;
@property (strong, nonatomic) UILabel *bankerDoubelCountLabel_hd;

@property (strong, nonatomic) UIImageView *redCard;

@property (nonatomic, strong) CardsBuilder *cardsBuilder;
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
@property (nonatomic, strong) CABasicAnimation *anim7;

//卡牌平移动画
@property (nonatomic, strong) CABasicAnimation *animPlayerCard2;
@property (nonatomic, strong) CABasicAnimation *animBankerCard2;

@property (nonatomic, strong) NSMutableArray *chipFloatingViews;

@property (nonatomic, strong) MLTableAlert *alert;
@property (nonatomic, strong) NSMutableArray *players;

@property (nonatomic, strong) NSMutableArray *markPoint1Images;
@property (nonatomic, strong) NSMutableArray *markPoint2Images;
@property (nonatomic, strong) NSMutableArray *markPoint3Images;
@property (nonatomic, strong) NSMutableArray *markPoint4Images;
@property (nonatomic, strong) NSMutableArray *markPoint5Images;

@property (nonatomic, strong) NSMutableArray *markPoint1Images_hd;
@property (nonatomic, strong) NSMutableArray *markPoint2Images_hd;
@property (nonatomic, strong) NSMutableArray *markPoint3Images_hd;
@property (nonatomic, strong) NSMutableArray *markPoint4Images_hd;
@property (nonatomic, strong) NSMutableArray *markPoint5Images_hd;

@end

@implementation ViewController
{
    double cardBgX;
    double cardBgY;
    double playerCard_y;
    double bankerCard_y;
    double animationTime;
    double animationDelayTime;
    
    CGFloat chipCenterX;
    CGFloat chipCenterY;
    NSInteger sameScore;
    NSInteger playerScore;
    NSInteger bankerScore;
    NSInteger playerDoubleScore;
    NSInteger bankerDoubleScore;
    NSInteger totalScore;
    NSInteger totalBetScore;
    
    NSInteger sameCacheScore;
    NSInteger playerCacheScore;
    NSInteger bankerCacheScore;
    NSInteger bankerDoubleCacheScore;
    NSInteger playerDoubleCacheScore;
    NSInteger totalBetCacheScore;
    
    NSInteger totalWinScore;
    NSInteger totalPlayerDoubleWinScore;
    NSInteger totalBankerDoubleWinScore;
    NSInteger startTotalScore;
    NSInteger currentGameBalance;
    NSInteger continuousWinCount;
    
    CGFloat delayTime;
    
    CGFloat cutCardsView_X;
    CGFloat markOffset;
    CGFloat markOffset_hd;
    BOOL isChanged;
    BOOL isOpenSound;
    BOOL isOpenVoice;
    BOOL isGameStart;
    BOOL isFirstTimeStart;
    BOOL isNeedCardOutVoice;
    BOOL isNeedCardResultVoice;
    BOOL isOverTotalChip;
    BOOL wordTSelected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(volumeChanged:)                                             name:@"AVSystemController_SystemVolumeDidChangeNotification"
//                                               object:nil];
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    self.players = [NSMutableArray array];
    self.markPoint1Images = [NSMutableArray array];
    self.markPoint2Images = [NSMutableArray array];
    self.markPoint3Images = [NSMutableArray array];
    self.markPoint4Images = [NSMutableArray array];
    self.markPoint5Images = [NSMutableArray array];
    
    self.markPoint1Images_hd = [NSMutableArray array];
    self.markPoint2Images_hd = [NSMutableArray array];
    self.markPoint3Images_hd = [NSMutableArray array];
    self.markPoint4Images_hd = [NSMutableArray array];
    self.markPoint5Images_hd = [NSMutableArray array];
    [self registNotification];
    [self initArguement];
    markOffset = 10;
    markOffset_hd = 2;
    [self initView];
    // Do any additional setup after loading the view, typically from a nib.
    self.chipFloatingViews = [[NSMutableArray alloc] init];
    self.allResult = [[NSMutableArray alloc] init];
    self.cardsBuilder = [CardsBuilder shareObject];
    self.markBuilder = [MarkBuilder shareObject];
    self.evaluteViews = [[NSMutableArray alloc]init];
    cardBgX = self.cardBg_1.center.x;
    cardBgY = self.cardBg_1.center.y;
    playerCard_y = self.playerCard_1.center.y;
    bankerCard_y = self.bankerCard_1.center.y;
    
    totalScore = 10000;
    // 取
    totalScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"totalScore"];
    if (totalScore == 0) {
        totalScore = 10000;
        [[NSUserDefaults standardUserDefaults] setInteger:totalScore forKey:@"totalScore"];
    }
    startTotalScore = totalScore;
    isGameStart = YES;
    isFirstTimeStart = YES;
    self.animationDuration = [NSNumber numberWithInteger:1];
    [self initEvaluteViews];
    [self addFloatingChipViewByPoint:100];
    [self addFloatingChipViewByPoint:500];
    [self addFloatingChipViewByPoint:1000];
    [self addFloatingChipViewByPoint:5000];
    [self addFloatingChipViewByPoint:10000];
    
//    if (self.view.frame.size.width > self.view.frame.size.height) {
//        [self initLandscapeView];
//    } else {
//        [self initPortraitView];
//    }
    
    [self configUi];
    [self updateScore];
    self.selectChipImg = self.chip100Img;
    [self playVoiceByFile:@"WelcomeToTheTable_cn"];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(cutCard) userInfo:nil repeats:NO];//切卡
}

-(void)_orientationDidChange:(NSNotification*)notify

{
    [self _shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
}

-(void)_shouldRotateToOrientation:(UIDeviceOrientation)orientation {
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(changeOrientationDelay) userInfo:nil repeats:NO];
    
//    if (orientation == UIDeviceOrientationPortrait ||orientation == UIDeviceOrientationPortraitUpsideDown) {
//        NSLog(@"竖屏--->");
//        // 竖屏
//        [self initPortraitView];
//    }
//    else {
//        NSLog(@"横屏--->");
//        // 横屏
//        [self initLandscapeView];
//    }
//    chipCenterX = self.chip100Img.center.x;
//    chipCenterY = self.chip100Img.center.y;
}

- (void) changeOrientationDelay
{
    if (self.view.frame.size.width > self.view.frame.size.height) {
        [self initLandscapeView];
    } else {
        [self initPortraitView];
    }
    chipCenterX = self.chip100Img.center.x;
    chipCenterY = self.chip100Img.center.y;

}

- (void)viewWillLayoutSubviews
{
//        if (self.view.frame.size.width > self.view.frame.size.height) {
//            [self initLandscapeView];
//        } else {
//            [self initPortraitView];
//        }
//    chipCenterX = self.chip100Img.center.x;
//    chipCenterY = self.chip100Img.center.y;
//    NSLog(@"viewWillLayoutSubviews--->");
}

-(void)volumeChanged:(NSNotification *)noti

{
    
    float volume =
    
    [[[noti userInfo]
      
      objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"]
     
     floatValue];
    
    NSLog(@"volumn is %f", volume);
    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) registNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(onValueChanged)
                                                   name:@"onValueChanged"
                                                 object:nil];
}

- (void) onValueChanged
{
    [self initArguement];
}

- (void) initArguement
{
    NSInteger voiceSwitch = [[NSUserDefaults standardUserDefaults] integerForKey:@"voiceSwitch"];
    NSInteger soundSwitch = [[NSUserDefaults standardUserDefaults] integerForKey:@"soundSwitch"];
    NSInteger gameSpeedValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"gameSpeed"];
    
    if (voiceSwitch == 0) {
        isOpenVoice = YES;
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"voiceSwitch"];
    } else if (voiceSwitch == 1) {
        isOpenVoice = YES;
    } else {
        isOpenVoice = NO;
    }
    
    if (soundSwitch == 0) {
        isOpenSound = YES;
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"soundSwitch"];
    } else if (soundSwitch == 1) {
        isOpenSound = YES;
    } else {
        isOpenSound = NO;
    }
    
    if (gameSpeedValue == 0) {
        animationTime = 0.5;
        animationDelayTime = 0.5;
        isNeedCardOutVoice = YES;
        isNeedCardResultVoice = YES;
        delayTime = 5.5;
    } else if (gameSpeedValue == 1) {
        animationTime = 0.1;
        animationDelayTime = 0.3;
        isNeedCardOutVoice = NO;
        isNeedCardResultVoice = YES;
        delayTime = 5.5;
    } else {
        animationTime = 0.05;
        animationDelayTime = 0.1;
        isNeedCardOutVoice = NO;
        isNeedCardResultVoice = NO;
        delayTime = 1;
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return  UIStatusBarStyleLightContent;
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
    
//    self.anim2 = [CABasicAnimation animation];
//    self.anim2.keyPath = @"position";
//    self.anim2.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
//    self.anim2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_1.center.x, self.bankerCard_1.center.y)];
//    self.anim2.removedOnCompletion=YES;
//    self.anim2.fillMode = kCAFillModeRemoved;
//    self.anim2.duration = animationTime;
//    self.anim2.beginTime = CACurrentMediaTime() + animationDelayTime;
//    self.anim2.delegate = self;
//    [self.anim2 setValue:@"anim2" forKey:@"anim"];
    
//    self.anim3 = [CABasicAnimation animation];
//    self.anim3.keyPath = @"position";
//    self.anim3.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
//    self.anim3.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x, self.playerCard_2.center.y)];
//    self.anim3.removedOnCompletion=YES;
//    self.anim3.fillMode = kCAFillModeRemoved;
//    self.anim3.duration = animationTime;
//    self.anim3.beginTime = CACurrentMediaTime() + animationDelayTime*2;
//    self.anim3.delegate = self;
//    [self.anim3 setValue:@"anim3" forKey:@"anim"];
//    
//    self.anim4 = [CABasicAnimation animation];
//    self.anim4.keyPath = @"position";
//    self.anim4.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
//    self.anim4.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x, self.bankerCard_2.center.y)];
//    self.anim4.removedOnCompletion=YES;
//    self.anim4.fillMode = kCAFillModeRemoved;
//    self.anim4.duration = animationTime;
//    self.anim4.beginTime = CACurrentMediaTime() + animationDelayTime*3;
//    self.anim4.delegate = self;
//    [self.anim4 setValue:@"anim4" forKey:@"anim"];
//    
//    self.anim5 = [CABasicAnimation animation];
//    self.anim5.keyPath = @"position";
//    self.anim5.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
//    self.anim5.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_3.center.x, self.playerCard_3.center.y)];
//    self.anim5.removedOnCompletion=YES;
//    self.anim5.fillMode = kCAFillModeRemoved;
//    self.anim5.duration = animationTime;
//    self.anim5.beginTime = CACurrentMediaTime() + animationDelayTime*4+0.5;
//    self.anim5.delegate = self;
//    [self.anim5 setValue:@"anim5" forKey:@"anim"];
//    
//    self.anim6 = [CABasicAnimation animation];
//    self.anim6.keyPath = @"position";
//    self.anim6.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
//    self.anim6.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_3.center.x, self.bankerCard_3.center.y)];
//    self.anim6.removedOnCompletion=YES;
//    self.anim6.fillMode = kCAFillModeRemoved;
//    self.anim6.duration = animationTime;
//    self.anim6.beginTime = CACurrentMediaTime() + animationDelayTime*5+1;
//    self.anim6.delegate = self;
//    [self.anim6 setValue:@"anim6" forKey:@"anim"];
    
    self.anim7 = [CABasicAnimation animation];
    self.anim7.keyPath = @"position";
    self.anim7.fromValue =[NSValue valueWithCGPoint:CGPointMake(self.whiteLineView.center.x, self.whiteLineView.center.y + 100)];
    self.anim7.toValue=[NSValue valueWithCGPoint:CGPointMake(self.whiteLineView.center.x, self.whiteLineView.center.y)];
    self.anim7.removedOnCompletion=NO;
    self.anim7.fillMode = kCAFillModeForwards;
    self.anim7.duration = 1.5;
    self.anim7.delegate = self;
    [self.anim7 setValue:@"anim7" forKey:@"anim"];
    
//    self.animPlayerCard2 = [CABasicAnimation animation];
//    self.animPlayerCard2.keyPath = @"position";
//    self.animPlayerCard2.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x, self.playerCard_2.center.y)];
//    self.animPlayerCard2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x-60, self.playerCard_2.center.y)];
//    self.animPlayerCard2.removedOnCompletion=NO;
//    self.animPlayerCard2.fillMode = kCAFillModeForwards;
//    self.animPlayerCard2.beginTime = CACurrentMediaTime() + animationDelayTime*4+0.5;
//    self.animPlayerCard2.duration = animationTime;
//    self.animPlayerCard2.beginTime = CACurrentMediaTime() + animationTime*4 + 2;
    
//    self.animBankerCard2 = [CABasicAnimation animation];
//    self.animBankerCard2.keyPath = @"position";
//    self.animBankerCard2.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x, self.bankerCard_2.center.y)];
//    self.animBankerCard2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x - 60, self.bankerCard_2.center.y)];
//    self.animBankerCard2.beginTime = CACurrentMediaTime() + animationDelayTime*5+1;
//    self.animBankerCard2.removedOnCompletion=NO;
//    self.animBankerCard2.fillMode = kCAFillModeForwards;
//    self.animBankerCard2.duration = animationTime;
//    self.animBankerCard2.beginTime = CACurrentMediaTime() + animationTime*5 + 2.5;
}

- (NSString *) getVoiceNameByBumber:(NSNumber *)number isBornCard:(BOOL) isBornCard
{
    if (isBornCard) {
        return [NSString stringWithFormat:@"Natural_no_%d_cn", number.integerValue];
    }
    return [NSString stringWithFormat:@"no_%d_cn",number.intValue];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if ([self.players containsObject:player]) {
        [self.players removeObject:player];
    }
}

- (void) playVoiceByFileDelay:(NSTimer *)timer
{
    if (isOpenVoice) {
        NSString *soundFile = [[timer userInfo] objectForKey:@"sound"];
//        SystemSoundID soundID;
//        NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:soundFile ofType:@"wav"];
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
//        AudioServicesPlaySystemSound(soundID);
//        NSString *string = [[NSBundle mainBundle] pathForResource:soundFile ofType:@"wav"];
//        //把音频文件转换成url格式
//        NSURL *url = [NSURL fileURLWithPath:string];
//        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//        player.volume = 10;
//        [player prepareToPlay];
//        [player play];
        
        
        NSString *tempmusicstr = [NSString stringWithFormat:@"%@.wav", soundFile];
        NSData *sound1 = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:tempmusicstr]];
        NSError *error = nil;
        AVAudioPlayer *player =[[AVAudioPlayer alloc] initWithData:sound1 error:&error];
        [player prepareToPlay];
        player.volume = 1.0;
        player.numberOfLoops = 0;
        player.delegate = self;
        [player play];
        [self.players addObject:player];
    }
}

- (void) playVoiceByFile:(NSString *)fileName
{
    if (isOpenVoice) {
//        SystemSoundID soundID;
//        NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
//        AudioServicesPlaySystemSound(soundID);
//        NSString *string = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
//        //把音频文件转换成url格式
//        NSURL *url = [NSURL fileURLWithPath:string];
//        NSError *err=nil;
//        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
//        player.volume = 1.0;
//        [player prepareToPlay];
//        [player play];
//        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        
        NSString *tempmusicstr = [NSString stringWithFormat:@"%@.wav", fileName];
        NSData *sound1 = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:tempmusicstr]];
        NSError *error = nil;
        AVAudioPlayer *player =[[AVAudioPlayer alloc] initWithData:sound1 error:&error];
        [player prepareToPlay];
        player.volume = 1.0;
        player.numberOfLoops = 0;
        player.delegate = self;
        [player play];
        [self.players addObject:player];
        
    }
}

- (void) playSoundByFile:(NSString *)fileName
{
    if (isOpenSound) {
//        SystemSoundID soundID;
//        NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
//                AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
//                AudioServicesPlaySystemSound(soundID);
//        NSString *string = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
//        //把音频文件转换成url格式
//        NSURL *url = [NSURL fileURLWithPath:string];
//        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//        [player prepareToPlay];
//        [player play];
        
        
        NSString *tempmusicstr = [NSString stringWithFormat:@"%@.wav", fileName];
        NSData *sound1 = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:tempmusicstr]];
        NSError *error = nil;
        AVAudioPlayer *player =[[AVAudioPlayer alloc] initWithData:sound1 error:&error];
        [player prepareToPlay];
        player.volume = 1.0;
        player.numberOfLoops = 0;
        player.delegate = self;
        [player play];
        [self.players addObject:player];
    }
}

- (void) playSoundByFileDelay:(NSTimer *)timer
{
    if (isOpenSound) {
        NSString *soundFile = [[timer userInfo] objectForKey:@"sound"];
//        SystemSoundID soundID;
//        NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:soundFile ofType:@"wav"];
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
//        AudioServicesPlaySystemSound(soundID);
//        NSString *string = [[NSBundle mainBundle] pathForResource:soundFile ofType:@"wav"];
//        //把音频文件转换成url格式
//        NSURL *url = [NSURL fileURLWithPath:string];
//        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//        [player prepareToPlay];
//        [player play];
        
        
        NSString *tempmusicstr = [NSString stringWithFormat:@"%@.wav", soundFile];
        NSData *sound1 = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:tempmusicstr]];
        NSError *error = nil;
        AVAudioPlayer *player =[[AVAudioPlayer alloc] initWithData:sound1 error:&error];
        [player prepareToPlay];
        player.volume = 1.0;
        player.numberOfLoops = 0;
        player.delegate = self;
        [player play];
        [self.players addObject:player];
    }
}

- (void) initEvaluteViews
{
    self.evaluteViews = @[self.playerView, self.bankerView, self.playerDoubleView, self.bankerDoubleView, self.sameView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
//    AdvertisementViewController *control=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AdvertisementViewController"];
//    [self presentViewController:control animated:YES completion:^{
//        
//    }];
}

- (void) initView
{
    self.chip100Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chip_100"]];
    self.chip500Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chip_500"]];
    self.chip1000Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chip_1000"]];
    self.chip5000Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chip_5000"]];
    self.chip10000Img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chip_10000"]];
    self.chipSelect = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chip_select"]];
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
    
    self.topChipImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recongnizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onGGImageClicked:)];
    [self.topChipImageView addGestureRecognizer:recongnizer4];
    
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
    
    self.sameViewLabel.bounds = CGRectMake(0, 0, 80, 30);
    self.playerDoubleViewLabel.bounds = CGRectMake(0, 0, 80, 30);
    self.bankerDoubleViewLabel.bounds = CGRectMake(0, 0, 80, 30);
    self.playerViewLabel.bounds = CGRectMake(0, 0, 80, 30);
    self.bankerViewLabel.bounds = CGRectMake(0, 0, 80, 30);
    
    self.sameViewLabel.font = [UIFont fontWithName:@"Helvetica" size:26];
    self.playerDoubleViewLabel.font = [UIFont fontWithName:@"Helvetica" size:26];
    self.bankerDoubleViewLabel.font = [UIFont fontWithName:@"Helvetica" size:26];
    self.playerViewLabel.font = [UIFont fontWithName:@"Helvetica" size:26];
    self.bankerViewLabel.font = [UIFont fontWithName:@"Helvetica" size:26];
    
    self.sameViewLabel.textAlignment = UITextAlignmentCenter;
    self.playerDoubleViewLabel.textAlignment = UITextAlignmentCenter;
    self.bankerDoubleViewLabel.textAlignment = UITextAlignmentCenter;
    self.playerViewLabel.textAlignment = UITextAlignmentCenter;
    self.bankerViewLabel.textAlignment = UITextAlignmentCenter;
    
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
    
    [self.view addSubview:self.chipSelect];
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
    
    [self initMarkView];
    [self initMarkHDView];
}

- (void) initMarkHDView
{
    self.markContainer_hd = [[UIView alloc] init];
    self.markContainer_hd.bounds = CGRectMake(0, -40, 960, 448);
    
    self.markContainerBg_hd = [[UIImageView alloc] init];
    self.markContainerBg_hd.frame = CGRectMake(0, 0, 960, 398);
    self.markContainerBg_hd.contentMode = UIViewContentModeScaleToFill;
    self.markContainerBg_hd.image = [UIImage imageNamed:@"tableview_bg_hd"];
    
    [self.markContainer_hd addSubview:self.markContainerBg_hd];
    
    UIImage *mark1 = [UIImage imageNamed:@"marking_scroll_100"];
    UIImage *mark2 = [UIImage imageNamed:@"marking_scroll_50"];
    UIImage *mark3 = [UIImage imageNamed:@"marking_scroll_50"];
    UIImage *mark4 = [UIImage imageNamed:@"marking_scroll_50"];
    UIImage *mark5 = [UIImage imageNamed:@"marking_scroll_25"];
    
    self.markView1_hd = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset_hd, markOffset_hd, mark1.size.width/1.25, mark1.size.height*2)];
    self.markView1_hd.scrollEnabled = YES;
    self.markView1_hd.contentSize =  CGSizeMake(mark1.size.width*2, 0);
    self.markViewImage1_hd = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark1.size.width*2, mark1.size.height*2)];
    self.markViewImage1_hd.image = mark1;
    [self.markView1_hd addSubview:self.markViewImage1_hd];
    
    self.markView2_hd = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset_hd, markOffset_hd+self.markView1_hd.frame.size.height+1.5, mark2.size.width*0.8, mark2.size.height*2)];
    self.markView2_hd.scrollEnabled = YES;
    self.markView2_hd.contentSize =  CGSizeMake(mark2.size.width*2, 0);
    self.markViewImage2_hd = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark2.size.width*2, mark2.size.height*2)];
    self.markViewImage2_hd.image = mark2;
    [self.markView2_hd addSubview:self.markViewImage2_hd];
    
    self.markView3_hd = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset_hd, markOffset_hd+self.markView1_hd.frame.size.height+ self.markView2_hd.frame.size.height+4, mark3.size.width*0.8, mark3.size.height*2)];
    self.markView3_hd.scrollEnabled = YES;
    self.markView3_hd.contentSize =  CGSizeMake(mark3.size.width*2, 0);
    self.markViewImage3_hd = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark3.size.width*2, mark3.size.height*2)];
    self.markViewImage3_hd.image = mark3;
    [self.markView3_hd addSubview:self.markViewImage3_hd];
    
    self.markView4_hd = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset_hd, markOffset_hd+self.markView1_hd.frame.size.height+ self.markView2_hd.frame.size.height + self.markView3_hd.frame.size.height+5.5, mark4.size.width*0.8, mark4.size.height*2)];
    self.markView4_hd.scrollEnabled = YES;
    self.markView4_hd.contentSize =  CGSizeMake(mark4.size.width*2, 0);
    self.markViewImage4_hd = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark4.size.width*2, mark4.size.height*2)];
    self.markViewImage4_hd.image = mark4;
    [self.markView4_hd addSubview:self.markViewImage4_hd];
    
    self.markView5_hd = [[UIScrollView alloc] initWithFrame:CGRectMake(self.markView2_hd.frame.origin.x + self.markView2_hd.frame.size.width + markOffset_hd/2, self.markView2_hd.frame.origin.y, mark2.size.width*0.8, mark5.size.height*2)];
    self.markView5_hd.scrollEnabled = YES;
    self.markView5_hd.contentSize =  CGSizeMake(mark5.size.width*2, 0);
    self.markViewImage5_hd = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark5.size.width*2, mark5.size.height*2)];
    self.markViewImage5_hd.image = mark5;
    [self.markView5_hd addSubview:self.markViewImage5_hd];
    
    self.markView6_hd = [[UIView alloc] initWithFrame:CGRectMake(markOffset_hd, markOffset_hd+self.markView1_hd.frame.size.height+ self.markView2_hd.frame.size.height + self.markView3_hd.frame.size.height + self.markView4_hd.frame.size.height + 7, mark4.size.width*0.8, mark4.size.height*2)];
    
    UILabel *playerLabelImg =[[UILabel alloc] init];
    playerLabelImg.bounds = CGRectMake(0, 0, 23, 23);
    playerLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    playerLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    playerLabelImg.text = @"閒";
    playerLabelImg.center = CGPointMake(60, self.markView6_hd.frame.size.height/2);
    
    UILabel *playerLabel_ =[[UILabel alloc] init];
    playerLabel_.bounds = CGRectMake(0, 0, 23, 23);
    playerLabel_.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    playerLabel_.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    playerLabel_.text = @"-";
    playerLabel_.center = CGPointMake(playerLabelImg.center.x + 45, self.markView6_hd.frame.size.height/2);
    
    UIImageView *playerEmpty =[[UIImageView alloc] init];
    playerEmpty.bounds = CGRectMake(0, 0, 21, 21);
    playerEmpty.image = [UIImage imageNamed:@"player_win_empty"];
    playerEmpty.center = CGPointMake(playerLabel_.center.x + 30, self.markView6_hd.frame.size.height/2);
    
    UIImageView *playerFill =[[UIImageView alloc] init];
    playerFill.bounds = CGRectMake(0, 0, 21, 21);
    playerFill.image = [UIImage imageNamed:@"player_win_fill"];
    playerFill.center = CGPointMake(playerEmpty.center.x + 30, self.markView6_hd.frame.size.height/2);
    
    UIImageView *playerStripe =[[UIImageView alloc] init];
    playerStripe.bounds = CGRectMake(0, 0, 21, 21);
    playerStripe.image = [UIImage imageNamed:@"player_win_stripe"];
    playerStripe.center = CGPointMake(playerFill.center.x + 30, self.markView6_hd.frame.size.height/2);
    
    UILabel *bankerLabelImg =[[UILabel alloc] init];
    bankerLabelImg.bounds = CGRectMake(0, 0, 23, 23);
    bankerLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    bankerLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    bankerLabelImg.text = @"庄";
    bankerLabelImg.center = CGPointMake(playerStripe.center.x + 45, self.markView6_hd.frame.size.height/2);
    
    UILabel *bankerLabel_ =[[UILabel alloc] init];
    bankerLabel_.bounds = CGRectMake(0, 0, 23, 23);
    bankerLabel_.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    bankerLabel_.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    bankerLabel_.text = @"-";
    bankerLabel_.center = CGPointMake(bankerLabelImg.center.x + 45, self.markView6_hd.frame.size.height/2);
    
    UIImageView *bankerEmpty =[[UIImageView alloc] init];
    bankerEmpty.bounds = CGRectMake(0, 0, 21, 21);
    bankerEmpty.image = [UIImage imageNamed:@"banker_win_empty"];
    bankerEmpty.center = CGPointMake(bankerLabel_.center.x + 30, self.markView6_hd.frame.size.height/2);
    
    UIImageView *bankerFill =[[UIImageView alloc] init];
    bankerFill.bounds = CGRectMake(0, 0, 21, 21);
    bankerFill.image = [UIImage imageNamed:@"banker_win_fill"];
    bankerFill.center = CGPointMake(bankerEmpty.center.x + 30, self.markView6_hd.frame.size.height/2);
    
    UIImageView *bankerStripe =[[UIImageView alloc] init];
    bankerStripe.bounds = CGRectMake(0, 0, 21, 21);
    bankerStripe.image = [UIImage imageNamed:@"banker_win_stripe"];
    bankerStripe.center = CGPointMake(bankerFill.center.x + 30, self.markView6_hd.frame.size.height/2);
    
    [self.markView6_hd addSubview:playerLabelImg];
    [self.markView6_hd addSubview:playerLabel_];
    [self.markView6_hd addSubview:playerEmpty];
    [self.markView6_hd addSubview:playerFill];
    [self.markView6_hd addSubview:playerStripe];
    [self.markView6_hd addSubview:bankerLabelImg];
    [self.markView6_hd addSubview:bankerLabel_];
    [self.markView6_hd addSubview:bankerEmpty];
    [self.markView6_hd addSubview:bankerFill];
    [self.markView6_hd addSubview:bankerStripe];
    
    
    self.markView7_hd = [[UIView alloc] initWithFrame:CGRectMake(self.markView1_hd.frame.origin.x + self.markView1_hd.frame.size.width, markOffset_hd, self.markContainer_hd.frame.size.width - (self.markView1_hd.frame.origin.x + self.markView1_hd.frame.size.width + markOffset_hd*2), self.markContainer_hd.frame.size.height)];
    
    self.wordT_hd =[[UIImageView alloc] init];
    self.wordA_hd =[[UIImageView alloc] init];
    
    self.wordT_hd.bounds = CGRectMake(0, 0, 48, 48);
    self.wordA_hd.bounds = CGRectMake(0, 0, 48, 48);
    
    self.wordT_hd.image = [UIImage imageNamed:@"word_t"];
    self.wordA_hd.image = [UIImage imageNamed:@"word_a"];
    
    UITapGestureRecognizer *tapT = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onWordTClicked:)];
    
    UITapGestureRecognizer *tapA = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onWordAClicked:)];
    
    self.wordA_hd.userInteractionEnabled = YES;
    self.wordT_hd.userInteractionEnabled = YES;
    
    self.wordA_hd.tag = 0;
    self.wordT_hd.tag = 0;
    
    wordTSelected = NO;
    
    [self.wordA_hd addGestureRecognizer:tapA];
    [self.wordT_hd addGestureRecognizer:tapT];
    
    self.wordT_hd.center = CGPointMake(self.markView7_hd.frame.size.width/2, 40);
    self.wordA_hd.center = CGPointMake(self.markView7_hd.frame.size.width/2, self.wordT_hd.center.y + 65);
    
    UILabel *playerLittleLabelImg = [[UILabel alloc] init];
    playerLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    playerLittleLabelImg.center = CGPointMake(30, self.wordA_hd.center.y + 45);
    playerLittleLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    playerLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    playerLittleLabelImg.text = @"閒";
    
    self.playerWinCountLabel_hd = [[UILabel alloc] init];
    self.playerWinCountLabel_hd.bounds = CGRectMake(0, 0, 30, 21);
    self.playerWinCountLabel_hd.center = CGPointMake(70, self.wordA_hd.center.y + 45);
    self.playerWinCountLabel_hd.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.playerWinCountLabel_hd.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    self.playerWinCountLabel_hd.text = [NSString stringWithFormat:@"%d", 0];
    
    UILabel* bankerLittleLabelImg = [[UILabel alloc] init];
    bankerLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    bankerLittleLabelImg.center = CGPointMake(30, playerLittleLabelImg.center.y + 30);
    bankerLittleLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    bankerLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    bankerLittleLabelImg.text = @"庄";
    
    self.bankerWinCountLabel_hd = [[UILabel alloc] init];
    self.bankerWinCountLabel_hd.bounds = CGRectMake(0, 0, 30, 21);
    self.bankerWinCountLabel_hd.center = CGPointMake(70, playerLittleLabelImg.center.y + 30);
    self.bankerWinCountLabel_hd.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.bankerWinCountLabel_hd.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    self.bankerWinCountLabel_hd.text = [NSString stringWithFormat:@"%d", 0];
    
    UILabel *drawnGameLittleLabelImg = [[UILabel alloc] init];
    drawnGameLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    drawnGameLittleLabelImg.center = CGPointMake(30, bankerLittleLabelImg.center.y + 30);
    drawnGameLittleLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    drawnGameLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#187E1F" alpha:1];
    drawnGameLittleLabelImg.text = @"和";
    
    self.drawnGameCountLabel_hd = [[UILabel alloc] init];
    self.drawnGameCountLabel_hd.bounds = CGRectMake(0, 0, 30, 21);
    self.drawnGameCountLabel_hd.center = CGPointMake(70, bankerLittleLabelImg.center.y + 30);
    self.drawnGameCountLabel_hd.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.drawnGameCountLabel_hd.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#187E1F" alpha:1];
    self.drawnGameCountLabel_hd.text = [NSString stringWithFormat:@"%d", 0];
    
    UILabel *bornCardLittleLabelImg = [[UILabel alloc] init];
    bornCardLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    bornCardLittleLabelImg.center = CGPointMake(30, drawnGameLittleLabelImg.center.y + 30);
    bornCardLittleLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    bornCardLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#FCBE2D" alpha:1];
    bornCardLittleLabelImg.text = @"天牌";
    
    self.bornCardCountLabel_hd = [[UILabel alloc] init];
    self.bornCardCountLabel_hd.bounds = CGRectMake(0, 0, 30, 21);
    self.bornCardCountLabel_hd.center = CGPointMake(70, drawnGameLittleLabelImg.center.y + 30);
    self.bornCardCountLabel_hd.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.bornCardCountLabel_hd.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#FCBE2D" alpha:1];
    self.bornCardCountLabel_hd.text = [NSString stringWithFormat:@"%d", 0];
    
    
    UILabel *playerDoubelLittleLabelImg = [[UILabel alloc] init];
    playerDoubelLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    playerDoubelLittleLabelImg.center = CGPointMake(30, bornCardLittleLabelImg.center.y + 30);
    playerDoubelLittleLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    playerDoubelLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    playerDoubelLittleLabelImg.text = @"閒對";
    
    self.playerDoubelCountLabel_hd = [[UILabel alloc] init];
    self.playerDoubelCountLabel_hd.bounds = CGRectMake(0, 0, 30, 21);
    self.playerDoubelCountLabel_hd.center = CGPointMake(70, bornCardLittleLabelImg.center.y + 30);
    self.playerDoubelCountLabel_hd.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.playerDoubelCountLabel_hd.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    self.playerDoubelCountLabel_hd.text = [NSString stringWithFormat:@"%d", 0];
    
    UILabel *bankerDoubelLittleLabelImg = [[UILabel alloc] init];
    bankerDoubelLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    bankerDoubelLittleLabelImg.center = CGPointMake(30, playerDoubelLittleLabelImg.center.y + 30);
    bankerDoubelLittleLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    bankerDoubelLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    bankerDoubelLittleLabelImg.text = @"庄對";
    
    self.bankerDoubelCountLabel_hd = [[UILabel alloc] init];
    self.bankerDoubelCountLabel_hd.bounds = CGRectMake(0, 0, 30, 21);
    self.bankerDoubelCountLabel_hd.center = CGPointMake(70, playerDoubelLittleLabelImg.center.y + 30);
    self.bankerDoubelCountLabel_hd.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.bankerDoubelCountLabel_hd.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    self.bankerDoubelCountLabel_hd.text = [NSString stringWithFormat:@"%d", 0];
    
    [self.markView7_hd addSubview:self.wordT_hd];
    [self.markView7_hd addSubview:self.wordA_hd];
    [self.markView7_hd addSubview:playerLittleLabelImg];
    [self.markView7_hd addSubview:self.playerWinCountLabel_hd];
    [self.markView7_hd addSubview:bankerLittleLabelImg];
    [self.markView7_hd addSubview:self.bankerWinCountLabel_hd];
    [self.markView7_hd addSubview:drawnGameLittleLabelImg];
    [self.markView7_hd addSubview:self.drawnGameCountLabel_hd];
    [self.markView7_hd addSubview:bornCardLittleLabelImg];
    [self.markView7_hd addSubview:self.bornCardCountLabel_hd];
    [self.markView7_hd addSubview:playerDoubelLittleLabelImg];
    [self.markView7_hd addSubview:self.playerDoubelCountLabel_hd];
    [self.markView7_hd addSubview:bankerDoubelLittleLabelImg];
    [self.markView7_hd addSubview:self.bankerDoubelCountLabel_hd];
    
    self.gg_imageview_hd = [[UIImageView alloc] init];
    self.gg_imageview_hd.frame = CGRectMake(0, 398, self.markContainer_hd.frame.size.width, 50);
    self.gg_imageview_hd.userInteractionEnabled = YES;
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onGGImageClicked:)];
    [self.gg_imageview_hd addGestureRecognizer:rec];
    
    UIView *dismissContainer = [[UIView alloc] initWithFrame:CGRectMake(self.markContainer_hd.frame.size.width - 70, self.markContainer_hd.frame.size.height - 120, 42, 42)];
    dismissContainer.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOrHideMarkContainer:)];
    [dismissContainer addGestureRecognizer:recongnizer];
    
    
    [self.markContainer_hd addSubview:self.markView1_hd];
    [self.markContainer_hd addSubview:self.markView2_hd];
    [self.markContainer_hd addSubview:self.markView3_hd];
    [self.markContainer_hd addSubview:self.markView4_hd];
    [self.markContainer_hd addSubview:self.markView5_hd];
    [self.markContainer_hd addSubview:self.markView6_hd];
    [self.markContainer_hd addSubview:self.markView7_hd];
    [self.markContainer_hd addSubview:dismissContainer];
    [self.markContainer_hd addSubview:self.gg_imageview_hd];
    [self.view addSubview:self.markContainer_hd];
    self.markContainer_hd.hidden = YES;
}

- (void) initMarkView
{
    self.markContainer = [[UIView alloc] init];
    self.markContainer.bounds = CGRectMake(0, -40, 640, 662);
    
    self.markContainerBg = [[UIImageView alloc] init];
    self.markContainerBg.frame = CGRectMake(0, 0, 640, 612);
    self.markContainerBg.contentMode = UIViewContentModeScaleToFill;
    self.markContainerBg.image = [UIImage imageNamed:@"tableview_bg"];
    
    [self.markContainer addSubview:self.markContainerBg];
    
    UIImage *mark1 = [UIImage imageNamed:@"marking_scroll_100"];
    UIImage *mark2 = [UIImage imageNamed:@"marking_scroll_50"];
    UIImage *mark3 = [UIImage imageNamed:@"marking_scroll_50"];
    UIImage *mark4 = [UIImage imageNamed:@"marking_scroll_50"];
    UIImage *mark5 = [UIImage imageNamed:@"marking_scroll_25"];
    
    self.markView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset, markOffset, mark1.size.width/2, mark1.size.height*2)];
    self.markView1.scrollEnabled = YES;
    self.markView1.contentSize =  CGSizeMake(mark1.size.width*2, 0);
    self.markViewImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark1.size.width*2, mark1.size.height*2)];
    self.markViewImage1.image = mark1;
    [self.markView1 addSubview:self.markViewImage1];
    
    self.markView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset, markOffset+self.markView1.frame.size.height+1, mark2.size.width, mark2.size.height*2)];
    self.markView2.scrollEnabled = YES;
    self.markView2.contentSize =  CGSizeMake(mark2.size.width*2, 0);
    self.markViewImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark2.size.width*2, mark2.size.height*2)];
    self.markViewImage2.image = mark2;
    [self.markView2 addSubview:self.markViewImage2];
    
    self.markView3 = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset, markOffset+self.markView1.frame.size.height+ self.markView2.frame.size.height+3, mark3.size.width, mark3.size.height*2)];
    self.markView3.scrollEnabled = YES;
    self.markView3.contentSize =  CGSizeMake(mark3.size.width*2, 0);
    self.markViewImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark3.size.width*2, mark3.size.height*2)];
    self.markViewImage3.image = mark3;
    [self.markView3 addSubview:self.markViewImage3];
    
    self.markView4 = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset, markOffset+self.markView1.frame.size.height+ self.markView2.frame.size.height + self.markView3.frame.size.height+4.5, mark4.size.width, mark4.size.height*2)];
    self.markView4.scrollEnabled = YES;
    self.markView4.contentSize =  CGSizeMake(mark4.size.width*2, 0);
    self.markViewImage4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark4.size.width*2, mark4.size.height*2)];
    self.markViewImage4.image = mark4;
    [self.markView4 addSubview:self.markViewImage4];
    
    self.markView5 = [[UIScrollView alloc] initWithFrame:CGRectMake(markOffset, markOffset+self.markView1.frame.size.height+ self.markView2.frame.size.height + self.markView3.frame.size.height + self.markView4.frame.size.height + 7, mark5.size.width, mark5.size.height*2)];
    self.markView5.scrollEnabled = YES;
    self.markView5.contentSize =  CGSizeMake(mark5.size.width*2, 0);
    self.markViewImage5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mark5.size.width*2, mark5.size.height*2)];
    self.markViewImage5.image = mark5;
    [self.markView5 addSubview:self.markViewImage5];
    
    UILabel *playerLabelImg =[[UILabel alloc] init];
    UILabel *bankerLabelImg =[[UILabel alloc] init];
    playerLabelImg.bounds = CGRectMake(0, 0, 23, 23);
    bankerLabelImg.bounds = CGRectMake(0, 0, 23, 23);
    
    playerLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    playerLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    playerLabelImg.text = @"閒";
    
    bankerLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    bankerLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    bankerLabelImg.text = @"庄";
    
    playerLabelImg.center = CGPointMake(580, 30);
    bankerLabelImg.center = CGPointMake(610, 30);
    
    UIImageView *playerEmpty =[[UIImageView alloc] init];
    UIImageView *bankerEmpty =[[UIImageView alloc] init];
    
    playerEmpty.bounds = CGRectMake(0, 0, 21, 21);
    bankerEmpty.bounds = CGRectMake(0, 0, 21, 21);
    
    playerEmpty.image = [UIImage imageNamed:@"player_win_empty"];
    bankerEmpty.image = [UIImage imageNamed:@"banker_win_empty"];
    
    playerEmpty.center = CGPointMake(580, 70);
    bankerEmpty.center = CGPointMake(610, 70);
    
    UIImageView *playerFill =[[UIImageView alloc] init];
    UIImageView *bankerFill =[[UIImageView alloc] init];
    
    playerFill.bounds = CGRectMake(0, 0, 21, 21);
    bankerFill.bounds = CGRectMake(0, 0, 21, 21);
    
    playerFill.image = [UIImage imageNamed:@"player_win_fill"];
    bankerFill.image = [UIImage imageNamed:@"banker_win_fill"];
    
    playerFill.center = CGPointMake(580, 110);
    bankerFill.center = CGPointMake(610, 110);
    
    UIImageView *playerStripe =[[UIImageView alloc] init];
    UIImageView *bankerStripe =[[UIImageView alloc] init];
    
    playerStripe.bounds = CGRectMake(0, 0, 21, 21);
    bankerStripe.bounds = CGRectMake(0, 0, 21, 21);
    
    playerStripe.image = [UIImage imageNamed:@"player_win_stripe"];
    bankerStripe.image = [UIImage imageNamed:@"banker_win_stripe"];
    
    playerStripe.center = CGPointMake(580, 150);
    bankerStripe.center = CGPointMake(610, 150);
    
    self.wordT =[[UIImageView alloc] init];
    self.wordA =[[UIImageView alloc] init];
    
    self.wordT.bounds = CGRectMake(0, 0, 48, 48);
    self.wordA.bounds = CGRectMake(0, 0, 48, 48);
    
    self.wordT.image = [UIImage imageNamed:@"word_t"];
    self.wordA.image = [UIImage imageNamed:@"word_a"];
    
    UITapGestureRecognizer *tapT = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onWordTClicked:)];
    
    UITapGestureRecognizer *tapA = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onWordAClicked:)];
    
    self.wordA.userInteractionEnabled = YES;
    self.wordT.userInteractionEnabled = YES;
    
    self.wordA.tag = 0;
    self.wordT.tag = 0;
    
    wordTSelected = NO;
    
    [self.wordA addGestureRecognizer:tapA];
    [self.wordT addGestureRecognizer:tapT];
    
    self.wordT.center = CGPointMake(595, 210);
    self.wordA.center = CGPointMake(595, 280);
    
    UILabel *playerLittleLabelImg = [[UILabel alloc] init];
    playerLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    playerLittleLabelImg.center = CGPointMake(585, 340);
    playerLittleLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    playerLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    playerLittleLabelImg.text = @"閒";
    
    self.playerWinCountLabel = [[UILabel alloc] init];
    self.playerWinCountLabel.bounds = CGRectMake(0, 0, 30, 21);
    self.playerWinCountLabel.center = CGPointMake(625, 340);
    self.playerWinCountLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.playerWinCountLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    self.playerWinCountLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    UILabel* bankerLittleLabelImg = [[UILabel alloc] init];
    bankerLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    bankerLittleLabelImg.center = CGPointMake(585, 370);
    bankerLittleLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    bankerLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    bankerLittleLabelImg.text = @"庄";
    
    self.bankerWinCountLabel = [[UILabel alloc] init];
    self.bankerWinCountLabel.bounds = CGRectMake(0, 0, 30, 21);
    self.bankerWinCountLabel.center = CGPointMake(625, 370);
    self.bankerWinCountLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.bankerWinCountLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    self.bankerWinCountLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    UILabel *drawnGameLittleLabelImg = [[UILabel alloc] init];
    drawnGameLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    drawnGameLittleLabelImg.center = CGPointMake(585, 400);
    drawnGameLittleLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    drawnGameLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#187E1F" alpha:1];
    drawnGameLittleLabelImg.text = @"和";
    
    self.drawnGameCountLabel = [[UILabel alloc] init];
    self.drawnGameCountLabel.bounds = CGRectMake(0, 0, 30, 21);
    self.drawnGameCountLabel.center = CGPointMake(625, 400);
    self.drawnGameCountLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.drawnGameCountLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#187E1F" alpha:1];
    self.drawnGameCountLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    UILabel *bornCardLittleLabelImg = [[UILabel alloc] init];
    bornCardLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    bornCardLittleLabelImg.center = CGPointMake(585, 430);
    bornCardLittleLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    bornCardLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#FCBE2D" alpha:1];
    bornCardLittleLabelImg.text = @"天牌";
    
    self.bornCardCountLabel = [[UILabel alloc] init];
    self.bornCardCountLabel.bounds = CGRectMake(0, 0, 30, 21);
    self.bornCardCountLabel.center = CGPointMake(625, 430);
    self.bornCardCountLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.bornCardCountLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#FCBE2D" alpha:1];
    self.bornCardCountLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    
    UILabel *playerDoubelLittleLabelImg = [[UILabel alloc] init];
    playerDoubelLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    playerDoubelLittleLabelImg.center = CGPointMake(585, 460);
    playerDoubelLittleLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    playerDoubelLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    playerDoubelLittleLabelImg.text = @"閒對";
    
    self.playerDoubelCountLabel = [[UILabel alloc] init];
    self.playerDoubelCountLabel.bounds = CGRectMake(0, 0, 30, 21);
    self.playerDoubelCountLabel.center = CGPointMake(625, 460);
    self.playerDoubelCountLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.playerDoubelCountLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#1428F4" alpha:1];
    self.playerDoubelCountLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    UILabel *bankerDoubelLittleLabelImg = [[UILabel alloc] init];
    bankerDoubelLittleLabelImg.bounds = CGRectMake(0, 0, 42, 21);
    bankerDoubelLittleLabelImg.center = CGPointMake(585, 490);
    bankerDoubelLittleLabelImg.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    bankerDoubelLittleLabelImg.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    bankerDoubelLittleLabelImg.text = @"庄對";
    
    self.bankerDoubelCountLabel = [[UILabel alloc] init];
    self.bankerDoubelCountLabel.bounds = CGRectMake(0, 0, 30, 21);
    self.bankerDoubelCountLabel.center = CGPointMake(625, 490);
    self.bankerDoubelCountLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.bankerDoubelCountLabel.textColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#dc1820" alpha:1];
    self.bankerDoubelCountLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    
    self.gg_imageview = [[UIImageView alloc] init];
    self.gg_imageview.frame = CGRectMake(0, 612, self.markContainer.frame.size.width, 50);
    self.gg_imageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onGGImageClicked:)];
    [self.gg_imageview addGestureRecognizer:rec];
    
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
    [self.markContainer addSubview:self.wordT];
    [self.markContainer addSubview:self.wordA];
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
    [self.markContainer addSubview:self.gg_imageview];
    
    UIView *dismissContainer = [[UIView alloc] initWithFrame:CGRectMake(self.markContainer.frame.size.width - 70, self.markContainer.frame.size.height - 120, 42, 42)];
    dismissContainer.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOrHideMarkContainer:)];
    [dismissContainer addGestureRecognizer:recongnizer];
    [self.markContainer addSubview:dismissContainer];
    
    
    
    [self.view addSubview:self.markContainer];
    self.markContainer.hidden = YES;
    self.markContainer_hd.hidden = YES;
}

- (IBAction) onWordTClicked:(id)sender
{
    NSInteger tag = self.wordT.tag;
    if (tag == 0) {
        wordTSelected = YES;
        self.wordT.tag = 1;
        self.wordT_hd.tag = 1;
        self.wordT.image = [UIImage imageNamed:@"word_t_s"];
        self.wordT_hd.image = [UIImage imageNamed:@"word_t_s"];
    } else {
        wordTSelected = NO;
        self.wordT.tag = 0;
        self.wordT_hd.tag = 0;
        self.wordT.image = [UIImage imageNamed:@"word_t"];
        self.wordT_hd.image = [UIImage imageNamed:@"word_t"];
    }
    [self drawAllResult1Mark:wordTSelected];
}

- (IBAction) onWordAClicked:(id)sender
{

    NSInteger tag = self.wordA.tag;
    if (tag == 0) {
        self.wordA.tag = 1;
        self.wordA_hd.tag = 1;
        self.wordA.image = [UIImage imageNamed:@"word_a_s"];
        self.wordA_hd.image = [UIImage imageNamed:@"word_a_s"];
    } else {
        self.wordA.tag = 0;
        self.wordA_hd.tag = 0;
        self.wordA.image = [UIImage imageNamed:@"word_a"];
        self.wordA_hd.image = [UIImage imageNamed:@"word_a"];
    }
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

//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval) duration {
//    
//    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
//        [self initPortraitView];
//    } else {
//        [self initLandscapeView];
//    }
//}

- (void)viewDidLayoutSubviews
{
//    self.backgroundImageView.image = [UIImage imageNamed:@"background_hd.jpg"];
}

- (void) initLandscapeView
{
    if (!self.markContainer.hidden) {
        self.markContainer.hidden = YES;
        self.markContainer_hd.hidden = NO;
    }
    self.currentMarkContainer = self.markContainer_hd;
    self.backgroundImageView.image = [UIImage imageNamed:@"background_hd.jpg"];
    [self initCardsPosition];
    self.markContainer.center = CGPointMake(self.view.center.x, 306);
    self.markContainer_hd.center = CGPointMake(self.view.center.x, 199);
    self.tipBtn.center = CGPointMake(self.scoreImageBg.center.x - self.scoreImageBg.frame.size.width / 2 - 50, self.scoreImageBg.center.y);
    self.settingBtn.center = CGPointMake(self.scoreImageBg.center.x + self.scoreImageBg.frame.size.width / 2 + 50, self.scoreImageBg.center.y);
    
    self.chip1000Img.center = CGPointMake(self.view.center.x, self.scoreImageBg.center.y - 120);
    self.chip500Img.center = CGPointMake(self.chip1000Img.center.x - 105, self.chip1000Img.center.y);
    self.chip5000Img.center = CGPointMake(self.chip1000Img.center.x + 105, self.chip1000Img.center.y);
    self.chip100Img.center = CGPointMake(self.chip1000Img.center.x - 210, self.chip1000Img.center.y);
    self.chip10000Img.center = CGPointMake(self.chip1000Img.center.x + 210, self.chip1000Img.center.y);
    self.chipSelect.center = CGPointMake(self.selectChipImg.center.x, self.selectChipImg.center.y);
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
    
    [self updateLandLabelPosition];
    
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
    if (!self.markContainer_hd.hidden) {
        self.markContainer_hd.hidden = YES;
        self.markContainer.hidden = NO;
    }
    self.currentMarkContainer = self.markContainer;
    self.backgroundImageView.image = [UIImage imageNamed:@"background.jpg"];
    [self initCardsPosition];
    self.markContainer.center = CGPointMake(self.view.center.x, 306);
    self.markContainer_hd.center = CGPointMake(self.view.center.x, 199);
    self.recycelBtn.center = CGPointMake(self.scoreImageBg.center.x - 110, self.scoreImageBg.center.y - 110);
    self.potBtn.center = CGPointMake(self.scoreImageBg.center.x + 110, self.scoreImageBg.center.y - 110);
    self.tipBtn.center = CGPointMake(self.recycelBtn.center.x - 165, self.recycelBtn.center.y);
    self.settingBtn.center = CGPointMake(self.potBtn.center.x + 165, self.potBtn.center.y);
    
    self.chip1000Img.center = CGPointMake(self.view.center.x, self.potBtn.center.y - 120);
    self.chip500Img.center = CGPointMake(self.chip1000Img.center.x - 145, self.chip1000Img.center.y);
    self.chip5000Img.center = CGPointMake(self.chip1000Img.center.x + 145, self.chip1000Img.center.y);
    self.chip100Img.center = CGPointMake(self.chip1000Img.center.x - 290, self.chip1000Img.center.y);
    self.chip10000Img.center = CGPointMake(self.chip1000Img.center.x + 290, self.chip1000Img.center.y);
    self.chipSelect.center = CGPointMake(self.selectChipImg.center.x, self.selectChipImg.center.y);
    [self changeFloatingChipViewPosition];
    
    self.sameView.bounds = CGRectMake(0, 0, self.view.frame.size.width/3, 120);
    self.playerDoubleView.bounds = CGRectMake(0, 0, self.view.frame.size.width/3, 120);
    self.bankerDoubleView.bounds = CGRectMake(0, 0, self.view.frame.size.width/3, 120);
    self.playerView.bounds = CGRectMake(0,0,self.view.frame.size.width,120);
    self.bankerView.bounds = CGRectMake(0,0,self.view.frame.size.width,120);
    
    self.sameView.center = CGPointMake(self.view.center.x, self.whiteLineView.center.y + 145);
    self.playerDoubleView.center = CGPointMake(self.view.frame.size.width / 3 / 2, self.sameView.center.y);
    self.bankerDoubleView.center = CGPointMake(self.view.frame.size.width / 6 * 5, self.sameView.center.y);
    self.bankerView.center = CGPointMake(self.view.center.x, self.sameView.center.y + 120);
    self.playerView.center = CGPointMake(self.view.center.x, self.sameView.center.y + 240);
    
    [self updatePortraitLabelPosition];
    
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

- (void) updatePortraitLabelPosition
{
    self.sameViewLabel.center = CGPointMake(self.sameView.center.x - 80, self.sameView.center.y + 40);
    self.playerDoubleViewLabel.center = CGPointMake(self.playerDoubleView.center.x - 80, self.playerDoubleView.center.y + 40);
    self.bankerDoubleViewLabel.center = CGPointMake(self.bankerDoubleView.center.x + 80, self.bankerDoubleView.center.y + 40);
    self.playerViewLabel.center = CGPointMake(self.playerView.center.x - 80, self.playerView.center.y + 40);
    self.bankerViewLabel.center = CGPointMake(self.bankerView.center.x - 80, self.bankerView.center.y + 40);
}

- (void) updateLandLabelPosition
{
    self.sameViewLabel.center = CGPointMake(self.sameView.center.x, self.sameView.center.y + 80);
    self.playerDoubleViewLabel.center = CGPointMake(self.playerDoubleView.center.x, self.playerDoubleView.center.y + 80);
    self.bankerDoubleViewLabel.center = CGPointMake(self.bankerDoubleView.center.x, self.bankerDoubleView.center.y + 80);
    self.playerViewLabel.center = CGPointMake(self.playerView.center.x, self.playerView.center.y + 80);
    self.bankerViewLabel.center = CGPointMake(self.bankerView.center.x, self.bankerView.center.y + 80);
}

- (IBAction)onGGImageClicked:(id)sender
{
    AdvertisementViewController *control=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AdvertisementViewController"];
    [self presentViewController:control animated:YES completion:^{
        
    }];
}

- (IBAction)showOrHideMarkContainer:(id)sender
{
    if (self.currentMarkContainer == self.markContainer) {
        if (self.markContainer.hidden) {
            [self playSoundByFile:@"mouse_move"];
            NSInteger randomResult = arc4random() % 2;
            self.gg_imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"gg_%d", randomResult]];
            self.markContainer.hidden = NO;
        } else {
            self.markContainer.hidden = YES;
        }
    } else {
        if (self.markContainer_hd.hidden) {
            [self playSoundByFile:@"mouse_move"];
            NSInteger randomResult = arc4random() % 2;
            self.gg_imageview_hd.image = [UIImage imageNamed:[NSString stringWithFormat:@"gg_%d", randomResult]];
            self.markContainer_hd.hidden = NO;
        } else {
            self.markContainer_hd.hidden = YES;
        }
    }
}

- (void) configUi
{
    self.tableChangeImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *r = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTableChangeClicked:)];
    [self.tableChangeImage addGestureRecognizer:r];
    
    self.resultTipLabel.text = @"";
    self.chip100Img.tag = 100;
    self.chip500Img.tag = 500;
    self.chip1000Img.tag = 1000;
    self.chip5000Img.tag = 5000;
    self.chip10000Img.tag = 10000;
    
    self.cardsNumber.hidden = YES;
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

- (NSString *)getScoreStrByScore:(NSInteger )number
{
    CGFloat f = number;
    NSString *strNumber;
    if (f == 0) {
        strNumber = @"";
    } else if (f > 0 && f < 1000) {
        strNumber = [NSString stringWithFormat:@"%d", number];
    } else if (f >= 1000 && f < 10000) {
        if (number % 1000 > 0) {
            NSInteger n = number % 1000;
            if (n % 100 > 0) {
                strNumber = [NSString stringWithFormat:@"%.2f千", f / 1000];
            } else {
                strNumber = [NSString stringWithFormat:@"%.1f千", f / 1000];
            }
            
        } else {
            strNumber = [NSString stringWithFormat:@"%d千", number / 1000];
        }
    } else if (f >= 10000) {
        if (number % 10000 > 0) {
            NSInteger n = number % 10000;
            if (n % 1000 > 0) {
                strNumber = [NSString stringWithFormat:@"%.2f万", f / 10000];
            } else {
                strNumber = [NSString stringWithFormat:@"%.1f万", f / 10000];
            }
        } else {
            strNumber = [NSString stringWithFormat:@"%d万", number / 10000];
        }
    }
    return strNumber;
}

- (void) updateChipLabel:(NSInteger) score
{
    NSString *scoreStr = [self getScoreStrByScore:self.sameView.chipView.tag];
    self.sameViewLabel.text =  scoreStr;
    
    scoreStr = [self getScoreStrByScore:self.playerDoubleView.chipView.tag];
    self.playerDoubleViewLabel.text =  scoreStr;
    
    scoreStr = [self getScoreStrByScore:self.bankerDoubleView.chipView.tag];
    self.bankerDoubleViewLabel.text =  scoreStr;
    
    scoreStr = [self getScoreStrByScore:self.playerView.chipView.tag];
    self.playerViewLabel.text =  scoreStr;
    
    scoreStr = [self getScoreStrByScore:self.bankerView.chipView.tag];
    self.bankerViewLabel.text =  scoreStr;
}

- (void) updateChipLabel
{
    
    NSString *scoreStr = [self getScoreStrByScore:self.sameView.chipView.tag];
    self.sameViewLabel.text =  scoreStr;
    
    scoreStr = [self getScoreStrByScore:self.playerDoubleView.chipView.tag];
    self.playerDoubleViewLabel.text =  scoreStr;
    
    scoreStr = [self getScoreStrByScore:self.bankerDoubleView.chipView.tag];
    self.bankerDoubleViewLabel.text =  scoreStr;
    
    scoreStr = [self getScoreStrByScore:self.playerView.chipView.tag];
    self.playerViewLabel.text =  scoreStr;
    
    scoreStr = [self getScoreStrByScore:self.bankerView.chipView.tag];
    self.bankerViewLabel.text =  scoreStr;
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
    
//    [self.view addSubview:self.cardsView];
//    [self.view addSubview:self.cutCardsView];
    [self.view insertSubview:self.cardsView belowSubview:self.markContainer];
    [self.view insertSubview:self.cutCardsView belowSubview:self.markContainer];
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
    cutCardsView2.frame = CGRectMake(pointX-60, self.cardsView.frame.origin.y, image.size.width - (pointX - self.cardsView.frame.origin.x)+70, image.size.height);
    
    [self.cardsView removeFromSuperview];
    [self.cutCardsView removeFromSuperview];
    [self.view insertSubview:cutCardsView2 belowSubview:self.markContainer];
    [self.view insertSubview:cutCardsView1 belowSubview:self.markContainer];
    
    CGFloat cutCardsView1CenterY = cutCardsView1.center.y;
    CGFloat cutCardsView1CenterX = cutCardsView1.center.x;
    
    CGFloat cutCardsView2CenterY = cutCardsView2.center.y;
    CGFloat cutCardsView2CenterX = cutCardsView2.center.x;
    
    CABasicAnimation *anim1 = [CABasicAnimation animation];
    anim1.keyPath = @"position";
    anim1.fromValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView1CenterX, cutCardsView1CenterY)];
    anim1.toValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView1CenterX,cutCardsView1CenterY + 200)];
    anim1.removedOnCompletion=NO;
    anim1.fillMode = kCAFillModeForwards;
    anim1.duration = 0.5;
    [cutCardsView1.layer addAnimation:anim1 forKey:nil];
    
    CABasicAnimation *anim2 = [CABasicAnimation animation];
    anim2.keyPath = @"position";
    anim2.fromValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView1.center.x, cutCardsView1CenterY + 200)];
    anim2.toValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView2.center.x,cutCardsView1CenterY + 200)];
    anim2.removedOnCompletion=NO;
    anim2.fillMode = kCAFillModeForwards;
    anim2.beginTime = CACurrentMediaTime() + 0.5;
    anim2.duration = 0.5;
    anim2.delegate = self;
    [anim2 setValue:@"cutAnim2" forKey:@"anim"];
    [cutCardsView1.layer addAnimation:anim2 forKey:nil];
    
    CABasicAnimation *anim3 = [CABasicAnimation animation];
    anim3.keyPath = @"position";
    anim3.fromValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView2.center.x, cutCardsView2.center.y)];
    anim3.toValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView1CenterX+5,cutCardsView2.center.y)];
    anim3.removedOnCompletion=NO;
    anim3.fillMode = kCAFillModeForwards;
    anim3.beginTime = CACurrentMediaTime() + 0.5;
    anim3.duration = 0.5;
    [cutCardsView2.layer addAnimation:anim3 forKey:nil];

    CABasicAnimation *anim4 = [CABasicAnimation animation];
    anim4.keyPath = @"position";
    anim4.fromValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView2CenterX, cutCardsView2CenterY + 200)];
    anim4.toValue=[NSValue valueWithCGPoint:CGPointMake(cutCardsView2CenterX,cutCardsView2CenterY)];
    anim4.removedOnCompletion=NO;
    anim4.fillMode = kCAFillModeForwards;
    anim4.beginTime = CACurrentMediaTime() + 1;
    anim4.duration = 0.5;
    [cutCardsView1.layer addAnimation:anim4 forKey:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(removeCardsView) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(burningCards) userInfo:nil repeats:NO];
}

- (void) removeCardsView
{
    [self.cutCardsView1 removeFromSuperview];
    [self.cutCardsView2 removeFromSuperview];
}

- (void) burningCards
{
    [self playVoiceByFile:@"BurningCards_cn"];
    Card *card = [self.cardsBuilder getNextCard];
    [self.cardsBuilder getNextCards:card.validPoint];
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
    self.cardsNumber.hidden = NO;
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
        [self.view insertSubview:subView belowSubview:self.markContainer];
        
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
        [self.view insertSubview:subView belowSubview:self.markContainer];
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
        [self.view insertSubview:subView2 belowSubview:self.markContainer];
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
    self.bankerWinCountLabel.text = @"0";
    self.playerWinCountLabel.text = @"0";
    self.bornCardCountLabel.text = @"0";
    self.drawnGameCountLabel.text = @"0";
    self.playerDoubelCountLabel.text = @"0";
    self.bankerDoubelCountLabel.text = @"0";
    self.bankerWinCountLabel_hd.text = @"0";
    self.playerWinCountLabel_hd.text = @"0";
    self.bornCardCountLabel_hd.text = @"0";
    self.drawnGameCountLabel_hd.text = @"0";
    self.playerDoubelCountLabel_hd.text = @"0";
    self.bankerDoubelCountLabel_hd.text = @"0";
    [self.burningCardContainer1 removeFromSuperview];
    [self.burningCardContainer2 removeFromSuperview];
//    [self.cutCardsContainer removeFromSuperview];
    self.cutPointView.hidden = YES;
    [self playVoiceByFile:@"c_place_cn"];
    
    Result *result = [self.cardsBuilder getNextResult:NO];
    if (result.resultType == ResultBankerWin) {
        self.resultTipLabel.text = @"下把出庄";
    } else if (result.resultType == ResultPlayerWin) {
        self.resultTipLabel.text = @"下把出闲";
    } else {
        self.resultTipLabel.text = @"下把出和";
    }

    
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
//        isChanged = NO;
        if (recongizer.view == self.playerView.chipView) {
            self.playerView.chipView = nil;
            self.totalChipFromView = self.playerView;
        } else if (recongizer.view == self.bankerView.chipView) {
            self.bankerView.chipView = nil;
            self.totalChipFromView = self.bankerView;
        } else if (recongizer.view == self.playerDoubleView.chipView) {
            self.playerDoubleView.chipView = nil;
            self.totalChipFromView = self.playerDoubleView;
        } else if (recongizer.view == self.bankerDoubleView.chipView) {
            self.bankerDoubleView.chipView = nil;
            self.totalChipFromView = self.bankerDoubleView;
        } else {
            self.sameView.chipView = nil;
            self.totalChipFromView = self.sameView;
        }
        [self playSoundByFile:@"ce_chip"];
    }
    NSArray *views = self.evaluteViews;
    static void (^overlappingBlock)(UIView *overlappingView);
    overlappingBlock = ^(UIView *overlappingView) {
//        if (!isChanged && overlappingView != nil) {
//            ChipBoardView *boardView =  (ChipBoardView *)overlappingView;
//            boardView.chipView = nil;
//            isChanged = YES;
//        }
    };
    
    static void (^completionBlock)(UIView *overlappingView);
    completionBlock = ^(UIView *overlappingView) {
        if (overlappingView != nil) {
            NSInteger score = recongizer.view.tag;
            NSInteger boardScore = ((ChipBoardView *)overlappingView).chipView.tag;
            NSInteger totalChipScore = score + boardScore;
            [UIView animateWithDuration:0.3f animations:^{
                
                if (overlappingView == self.playerView){
                    NSInteger bankerBet = self.bankerView.chipView.tag;
                    if (bankerBet + totalChipScore > 10000) {
                        recongizer.view.center = CGPointMake(self.totalChipFromView.center.x, self.totalChipFromView.center.y);
                    }
                } else if (overlappingView == self.bankerView) {
                    NSInteger playerBet = self.playerView.chipView.tag;
                    if (playerBet + totalChipScore > 10000) {
                        recongizer.view.center = CGPointMake(self.totalChipFromView.center.x, self.totalChipFromView.center.y);
                    }
                } else if ((overlappingView == self.playerDoubleView || overlappingView == self.bankerDoubleView || overlappingView == self.sameView) && totalChipScore > 1000) {
                    recongizer.view.center = CGPointMake(self.totalChipFromView.center.x, self.totalChipFromView.center.y);
                } else {
                    recongizer.view.center = CGPointMake(overlappingView.center.x, overlappingView.center.y);
                }
                
                [self playSoundByFile:@"ce_chip"];
            } completion:^(BOOL finished) {
                
                ChipBoardView *boardView = (ChipBoardView *)overlappingView;
                UIImageView *chipView = (UIImageView *)recongizer.view;
                
                if (overlappingView == self.playerView){
                    NSInteger bankerBet = self.bankerView.chipView.tag;
                    if (bankerBet + totalChipScore > 10000) {
                        boardView = self.totalChipFromView;
                    } else if (totalChipScore == 10000) {
                        [self playSoundByFile:@"AllIn"];
                        [self shakeScreen];
                    }
                } else if (overlappingView == self.bankerView) {
                    NSInteger playerBet = self.playerView.chipView.tag;
                    if (playerBet + totalChipScore > 10000) {
                        boardView = self.totalChipFromView;
                    } else if (totalChipScore == 10000) {
                        [self playSoundByFile:@"AllIn"];
                        [self shakeScreen];
                    }
                } else if ((overlappingView == self.playerDoubleView || overlappingView == self.bankerDoubleView || overlappingView == self.sameView) && totalChipScore > 1000) {
                    boardView = self.totalChipFromView;
                }
                
                if (boardView.chipView != nil) {
                    chipView.tag += boardView.chipView.tag;
                    [boardView.chipView removeFromSuperview];
                    
                }
                
                if (boardView == self.playerView && self.bankerView.chipView != nil) {
                    chipView.tag += self.bankerView.chipView.tag;
                    [self.bankerView.chipView removeFromSuperview];
                    self.bankerView.chipView = nil;
                }
                
                if (boardView == self.bankerView && self.playerView.chipView != nil) {
                    chipView.tag += self.playerView.chipView.tag;
                    [self.playerView.chipView removeFromSuperview];
                    self.playerView.chipView = nil;
                }
                
                UIImage* chipImage =[ImageUtils scoreToChips:chipView.tag];
                chipView.center = CGPointMake(boardView.center.x, boardView.center.y);
                chipView.bounds = CGRectMake(0, 0, chipImage.size.width, chipImage.size.height);
                chipView.image = chipImage;
                boardView.chipView = chipView;
                [self updateChipLabel];
            }];
            
        } else {
            totalScore += recongizer.view.tag;
            totalBetScore -= recongizer.view.tag;
            [recongizer.view removeFromSuperview];
            [self updateScore];
            [self updateChipLabel];
            
            if (totalBetCacheScore > 0) {
                if (self.playerView.chipView == nil && self.bankerView.chipView == nil && self.playerDoubleView.chipView == nil && self.bankerDoubleView.chipView == nil && self.sameView.chipView == nil) {
                    [self.potBtn setImage:[UIImage imageNamed:@"last_pot_btn"] forState:UIControlStateNormal];
                    [self.potBtn setImage:[UIImage imageNamed:@"last_pot_btn_s"] forState:UIControlStateHighlighted];
                }
            }
        }
        
    };
    
    
    [recongizer dragViewWithinView:[self view]
           evaluateViewsForOverlap:views
   containedByOverlappingViewBlock:overlappingBlock
                        completion:completionBlock];
    
}

- (IBAction)handleChipTapRecognizer:(id)sender
{
    self.markContainer.hidden = YES;
    self.markContainer_hd.hidden = YES;
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
    self.chipSelect.center = CGPointMake(self.selectChipImg.center.x, self.selectChipImg.center.y);
    [self playSoundByFile:@"ce_chip"];
}

- (UIImageView *) createChipFloatView
{
    UIImageView *chipView =[[UIImageView alloc] init];
    [self.view insertSubview:chipView aboveSubview:self.chip100Img];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleTotalChipPanRecognizer:)];
    chipView.userInteractionEnabled = YES;
    [chipView addGestureRecognizer:panRecognizer];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onChipTableViewChipClicked:)];
    [chipView addGestureRecognizer:tapRecognizer];
    return chipView;
}

- (IBAction)handlePanRecognizer:(id)sender
{
    if (isGameStart) {
        return;
    }
    self.markContainer.hidden = YES;
    self.markContainer_hd.hidden = YES;
    UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;
    if ([recongizer state] == UIGestureRecognizerStateBegan)
    {
        sameScore = 0;
        UIView *view = recongizer.view;
        if (view.tag == 100) {
            chipCenterX = self.chip100Img.center.x;
            chipCenterY = self.chip100Img.center.y;
            self.selectChipImg = self.chip100Img;
        } else if (view.tag == 500) {
            chipCenterX = self.chip500Img.center.x;
            chipCenterY = self.chip500Img.center.y;
            self.selectChipImg = self.chip500Img;
        } else if (view.tag == 1000) {
            chipCenterX = self.chip1000Img.center.x;
            chipCenterY = self.chip1000Img.center.y;
            self.selectChipImg = self.chip1000Img;
        } else if (view.tag == 5000) {
            chipCenterX = self.chip5000Img.center.x;
            chipCenterY = self.chip5000Img.center.y;
            self.selectChipImg = self.chip5000Img;
        } else if (view.tag == 10000) {
            chipCenterX = self.chip10000Img.center.x;
            chipCenterY = self.chip10000Img.center.y;
            self.selectChipImg = self.chip10000Img;
        }
        self.chipSelect.center = CGPointMake(self.selectChipImg.center.x, self.selectChipImg.center.y);
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
        NSInteger boardScore = ((ChipBoardView *)overlappingView).chipView.tag;
        NSInteger totalChipScore = score + boardScore;

        [UIView animateWithDuration:0.3f animations:^{
            
            if ((overlappingView == self.playerView || overlappingView == self.bankerView) && totalChipScore > 10000) {
                recongizer.view.center = CGPointMake(chipCenterX, chipCenterY);
            } else if ((overlappingView == self.playerDoubleView || overlappingView == self.bankerDoubleView || overlappingView == self.sameView) && totalChipScore > 1000) {
                recongizer.view.center = CGPointMake(chipCenterX, chipCenterY);
            } else if (overlappingView == self.playerView &&self.bankerView.chipView != nil) {
                [self showChipErrorAlert];
                recongizer.view.center = CGPointMake(chipCenterX, chipCenterY);
            } else if (overlappingView == self.bankerView && self.playerView.chipView != nil){
                [self showChipErrorAlert];
                recongizer.view.center = CGPointMake(chipCenterX, chipCenterY);
            } else {
                if (overlappingView != nil && score < totalScore) {
                    recongizer.view.center = CGPointMake(overlappingView.center.x, overlappingView.center.y);
                    [self playSoundByFile:@"ce_chip"];
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
                } else if ((overlappingView == self.playerView || overlappingView == self.bankerView) && totalChipScore > 10000) {
                    [self playSoundByFile:@"ce_chipwarn"];
                } else if ((overlappingView == self.playerDoubleView || overlappingView == self.bankerDoubleView || overlappingView == self.sameView) && totalChipScore > 1000) {
                    [self playSoundByFile:@"ce_chipwarn"];
                } else {
                    if (score <= totalScore) {
                        if (totalBetScore == 0) {
                            [self clearLastGameBet];
                        }
                        
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
                        if (score == 10000) {
                            [self playSoundByFile:@"AllIn"];
                            [self shakeScreen];
                        }
                    } else {
                        [self playSoundByFile:@"ce_chipwarn"];
                    }
                }
                
            }
            [self.chipFloatingViews removeObject:recongizer.view];
            [recongizer.view removeFromSuperview];
            [self updateChipLabel];
        }];
        
        
    };
    
    
    [recongizer dragViewWithinView:[self view]
           evaluateViewsForOverlap:views
   containedByOverlappingViewBlock:overlappingBlock
                        completion:completionBlock];
    
}

- (void)shakeScreen
{
    CGFloat centerX = self.backgroundImageView.center.x;
    CGFloat centerY = self.backgroundImageView.center.y;
    CGFloat centerXCardBox = self.cardsBox.center.x;
    CGFloat centerYCardBox = self.cardsBox.center.y;
    CGFloat centerXTopChip = self.topChipImageView.center.x;
    CGFloat centerYTopChip = self.topChipImageView.center.y;
    CGFloat centerXTableChange = self.tableChangeImage.center.x;
    CGFloat centerYTableChange = self.tableChangeImage.center.y;
    CGFloat centerXScoreImage = self.scoreImageBg.center.x;
    CGFloat centerYScoreImage = self.scoreImageBg.center.y;
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundImageView.center = CGPointMake(centerX, centerY - 8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.backgroundImageView.center = CGPointMake(centerX, centerY + 16);
        } completion:^(BOOL finished) {
            self.backgroundImageView.center = CGPointMake(centerX, centerY);
        }];
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.cardsBox.center = CGPointMake(centerXCardBox, centerYCardBox - 8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.cardsBox.center = CGPointMake(centerXCardBox, centerYCardBox + 16);
        } completion:^(BOOL finished) {
            self.cardsBox.center = CGPointMake(centerXCardBox, centerYCardBox);
        }];
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.topChipImageView.center = CGPointMake(centerXTopChip, centerYTopChip - 8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.topChipImageView.center = CGPointMake(centerXTopChip, centerYTopChip + 16);
        } completion:^(BOOL finished) {
            self.topChipImageView.center = CGPointMake(centerXTopChip, centerYTopChip);
        }];
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.tableChangeImage.center = CGPointMake(centerXTableChange, centerYTableChange - 8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.tableChangeImage.center = CGPointMake(centerXTableChange, centerYTableChange + 16);
        } completion:^(BOOL finished) {
            self.tableChangeImage.center = CGPointMake(centerXTableChange, centerYTableChange);
        }];
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.scoreImageBg.center = CGPointMake(centerXScoreImage, centerYScoreImage - 8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.scoreImageBg.center = CGPointMake(centerXScoreImage, centerYScoreImage + 16);
        } completion:^(BOOL finished) {
            self.scoreImageBg.center = CGPointMake(centerXScoreImage, centerYScoreImage);
        }];
    }];
}

- (IBAction)onPotBtnClicked:(id)sender
{
    if (isGameStart) {
        return;
    }
    
    if (totalBetScore != 0) {
        
        if (self.sameView.chipView.tag > 0 || self.playerView.chipView.tag > 0 || self.bankerView.chipView.tag > 0) {
            [self startGame];
        } else {
            [self playSoundByFile:@"ce_chipwarn"];
        }
        
    } else if (totalBetCacheScore != 0) {
        UIImageView *totalChipView =nil;
        UIImage *totalChipImage =nil;
        if (totalBetCacheScore > totalScore) {
            [self showChipNotEnoughAlert];
            [self playSoundByFile:@"ce_chipwarn"];
            return;
        }
        if (playerCacheScore != 0) {
            playerScore = playerCacheScore;
            totalChipView = [self createChipFloatView];
            totalChipImage = [ImageUtils scoreToChips:playerScore];
            self.playerView.chipView = totalChipView;
            totalChipView.tag = playerScore;
            totalChipView.center = CGPointMake(self.playerView.center.x, self.playerView.center.y);
            totalChipView.bounds = CGRectMake(0, 0, totalChipImage.size.width, totalChipImage.size.height);
            totalChipView.image = totalChipImage;
            totalBetScore += playerScore;
            totalScore -= playerScore;
        }
        
        if (playerDoubleCacheScore != 0) {
            playerDoubleScore = playerDoubleCacheScore;
            totalChipView = [self createChipFloatView];
            totalChipImage =[ImageUtils scoreToChips:playerDoubleScore];
            self.playerDoubleView.chipView = totalChipView;
            totalChipView.tag = playerDoubleScore;
            totalChipView.center = CGPointMake(self.playerDoubleView.center.x, self.playerDoubleView.center.y);
            totalChipView.bounds = CGRectMake(0, 0, totalChipImage.size.width, totalChipImage.size.height);
            totalChipView.image = totalChipImage;
            totalBetScore += playerDoubleScore;
            totalScore -= playerDoubleScore;
            
        }
        
        if (bankerCacheScore != 0) {
            bankerScore = bankerCacheScore;
            totalChipView = [self createChipFloatView];
            totalChipImage =[ImageUtils scoreToChips:bankerScore];
            self.bankerView.chipView = totalChipView;
            totalChipView.tag = bankerScore;
            totalChipView.center = CGPointMake(self.bankerView.center.x, self.bankerView.center.y);
            totalChipView.bounds = CGRectMake(0, 0, totalChipImage.size.width, totalChipImage.size.height);
            totalChipView.image = totalChipImage;
            totalBetScore += bankerScore;
            totalScore -= bankerScore;
            [self updateChipLabel];
        }
        
        if (bankerDoubleCacheScore != 0) {
            bankerDoubleScore = bankerDoubleCacheScore;
            totalChipView = [self createChipFloatView];
            totalChipImage =[ImageUtils scoreToChips:bankerDoubleScore];
            self.bankerDoubleView.chipView = totalChipView;
            totalChipView.tag = bankerDoubleScore;
            totalChipView.center = CGPointMake(self.bankerDoubleView.center.x, self.bankerDoubleView.center.y);
            totalChipView.bounds = CGRectMake(0, 0, totalChipImage.size.width, totalChipImage.size.height);
            totalChipView.image = totalChipImage;
            totalBetScore += bankerDoubleScore;
            totalScore -= bankerDoubleScore;
            
        }
        
        if (sameCacheScore != 0) {
            sameScore = sameCacheScore;
            totalChipView = [self createChipFloatView];
            totalChipImage =[ImageUtils scoreToChips:sameScore];
            self.sameView.chipView = totalChipView;
            totalChipView.tag = sameScore;
            totalChipView.center = CGPointMake(self.sameView.center.x, self.sameView.center.y);
            totalChipView.bounds = CGRectMake(0, 0, totalChipImage.size.width, totalChipImage.size.height);
            totalChipView.image = totalChipImage;
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onChipTableViewClicked:)];
            totalBetScore += sameScore;
            totalScore -= sameScore;
        }
        [self playSoundByFile:@"mouse_move"];
        [self.potBtn setImage:[UIImage imageNamed:@"pot_btn"] forState:UIControlStateNormal];
        [self.potBtn setImage:[UIImage imageNamed:@"pot_btn_s"] forState:UIControlStateHighlighted];
        [self updateScore];
        [self updateChipLabel];
    } else{
        [self playSoundByFile:@"ce_chipwarn"];
    }
    self.markContainer.hidden = YES;
    self.markContainer_hd.hidden = YES;
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
    self.markContainer.hidden = YES;
    self.markContainer_hd.hidden = YES;
    if (isGameStart) {
        return;
    }
    if (totalBetScore != 0) {
        totalScore += totalBetScore;
        totalBetScore = 0;
        playerScore = 0;
        playerDoubleScore = 0;
        bankerScore = 0;
        bankerDoubleScore = 0;
        sameScore = 0;
        
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
        
        if (totalBetCacheScore > 0) {
            [self.potBtn setImage:[UIImage imageNamed:@"last_pot_btn"] forState:UIControlStateNormal];
            [self.potBtn setImage:[UIImage imageNamed:@"last_pot_btn_s"] forState:UIControlStateHighlighted];
        }
    }
}

- (IBAction)onChipTableViewChipClicked:(id)sender
{
    if (isGameStart) {
        return;
    }
    
    UITapGestureRecognizer *recongnizer = (UITapGestureRecognizer *)sender;
    UIImageView * img = (UIImageView *)recongnizer.view;
    ChipBoardView * boadView = nil;
    if (img.center.x == self.playerView.center.x && img.center.y == self.playerView.center.y) {
        boadView = self.playerView;
    } else if (img.center.x == self.bankerView.center.x && img.center.y == self.bankerView.center.y) {
        boadView = self.bankerView;
    } else if (img.center.x == self.playerDoubleView.center.x && img.center.y == self.playerDoubleView.center.y){
        boadView = self.playerDoubleView;
    } else if (img.center.x == self.bankerDoubleView.center.x && img.center.y == self.bankerDoubleView.center.y) {
        boadView = self.bankerDoubleView;
    } else {
        boadView = self.sameView;
    }
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
    NSInteger totalChipScore = score + boadView.chipView.tag;
    if (score > totalScore) {
        [self playSoundByFile:@"ce_chipwarn"];
        return;
    }
    
    if ((boadView == self.playerView || boadView == self.bankerView) && totalChipScore > 10000) {
        [self playSoundByFile:@"ce_chipwarn"];
        return;
    } else if ((boadView == self.playerDoubleView || boadView == self.bankerDoubleView || boadView == self.sameView) && totalChipScore > 1000) {
        [self playSoundByFile:@"ce_chipwarn"];
        return;
    }
    
    [self playSoundByFile:@"ce_chip"];
    [self addFloatingChipViewByPoint:score];
    UIImageView *chipFloat = [self getChipFloatingViewByScore:score];
    [UIView animateWithDuration:0.3f animations:^{
        if (totalBetScore == 0) {
            [self clearLastGameBet];
        }
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
        if (score == 10000) {
            [self playSoundByFile:@"AllIn"];
            [self shakeScreen];
        }
        [self updateScore];
        [self updateChipLabel];
        [self.chipFloatingViews removeObject:chipFloat];
        [chipFloat removeFromSuperview];
    }];
}

- (IBAction)onChipTableViewClicked:(id)sender
{
    if (isGameStart) {
        return;
    }
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
    NSInteger totalChipScore = score + boadView.chipView.tag;
    if (score > totalScore) {
        [self playSoundByFile:@"ce_chipwarn"];
        return;
    }
    
    if ((boadView == self.playerView || boadView == self.bankerView) && totalChipScore > 10000) {
        [self playSoundByFile:@"ce_chipwarn"];
        return;
    } else if ((boadView == self.playerDoubleView || boadView == self.bankerDoubleView || boadView == self.sameView) && totalChipScore > 1000) {
        [self playSoundByFile:@"ce_chipwarn"];
        return;
    }
    
    [self playSoundByFile:@"ce_chip"];
    [self addFloatingChipViewByPoint:score];
    UIImageView *chipFloat = [self getChipFloatingViewByScore:score];
    [UIView animateWithDuration:0.3f animations:^{
        if (totalBetScore == 0) {
            [self clearLastGameBet];
        }
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
        if (score == 10000) {
            [self playSoundByFile:@"AllIn"];
            [self shakeScreen];
        }
        [self updateScore];
        [self updateChipLabel];
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
    self.chipSelect.hidden = YES;

    for (UIImageView *chipFloat in self.chipFloatingViews) {
        chipFloat.hidden = YES;
    }
    
    if (totalBetScore >= 10000) {
        [self playVoiceByFile:@"goodluck_cn"];
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(startGameDelay) userInfo:nil repeats:NO];
    } else {
        [self takeCard];
        [self dealCard];
    }
    
}

- (void) startGameDelay
{
    [self takeCard];
    [self dealCard];
}

- (void) takeCard
{
    Result *result = [self.cardsBuilder getNextResult:YES];
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
    }
    
}

- (void) animationDidStart:(CAAnimation *)anim
{
   NSString *value = [anim valueForKey:@"anim"];
    if ([value isEqual:@"anim1"]) {
        NSInteger number = self.cardsBuilder.cards.count+self.currentResult.allCards.count-1;
        self.cardsNumber.text = [NSString stringWithFormat:@"Cards:%d", number];
        [self playSoundByFile:@"ce_cardout"];
    } else if ([value isEqual:@"anim2"]) {
        NSInteger number = self.cardsBuilder.cards.count+self.currentResult.allCards.count-2;
        self.cardsNumber.text = [NSString stringWithFormat:@"Cards:%d", number];
        [self playSoundByFile:@"ce_cardout"];
        
    } else if ([value isEqual:@"anim3"]) {
        NSInteger number = self.cardsBuilder.cards.count+self.currentResult.allCards.count-3;
        self.cardsNumber.text = [NSString stringWithFormat:@"Cards:%d", number];
        [self playSoundByFile:@"ce_cardout"];
    } else if ([value isEqual:@"anim4"]) {
        NSInteger number = self.cardsBuilder.cards.count+self.currentResult.allCards.count-4;
        self.cardsNumber.text = [NSString stringWithFormat:@"Cards:%d", number];
        [self playSoundByFile:@"ce_cardout"];
    } else if ([value isEqual:@"anim5"]) {
        NSInteger number = self.cardsBuilder.cards.count+self.currentResult.allCards.count-5;
        self.cardsNumber.text = [NSString stringWithFormat:@"Cards:%d", number];
        [self playSoundByFile:@"ce_cardout"];
    } else if ([value isEqual:@"anim6"]) {
        NSInteger number = self.cardsBuilder.cards.count+self.currentResult.allCards.count-6;
        self.cardsNumber.text = [NSString stringWithFormat:@"Cards:%d", number];
        [self playSoundByFile:@"ce_cardout"];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString *value = [anim valueForKey:@"anim"];
    if ([value isEqual:@"anim1"]) {
        if (isNeedCardOutVoice) {
            [self playVoiceByFile:@"Players_cn"];
        }
        Card *card = [self.currentResult.playerCards objectAtIndex:0];
        self.playerCard_1.hidden = NO;
        self.playerCard_1.image = [UIImage imageNamed:card.resId];
        self.playerPointView.hidden = NO;
        self.playerPointView.image = [UIImage imageNamed:[NSString stringWithFormat:@"point_player_%d", card.validPoint.integerValue]];

        self.anim2 = [CABasicAnimation animation];
        self.anim2.keyPath = @"position";
        self.anim2.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
        self.anim2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_1.center.x, self.bankerCard_1.center.y)];
        self.anim2.removedOnCompletion=YES;
        self.anim2.fillMode = kCAFillModeRemoved;
        self.anim2.duration = animationTime;
        self.anim2.beginTime = CACurrentMediaTime() + animationDelayTime;
        self.anim2.delegate = self;
        [self.anim2 setValue:@"anim2" forKey:@"anim"];
        [self.cardBg_2.layer addAnimation:self.anim2 forKey:@"anim2"];
    } else if ([value isEqual:@"anim2"]) {
        if (isNeedCardOutVoice) {
            [self playVoiceByFile:@"Bankers_cn"];
        }
        Card *card = [self.currentResult.bankerCards objectAtIndex:0];
        self.bankerCard_1.hidden = NO;
        self.bankerCard_1.image = [UIImage imageNamed:card.resId];
        self.bankerPointView.hidden = NO;
        self.bankerPointView.image = [UIImage imageNamed:[NSString stringWithFormat:@"point_banker_%d", card.validPoint.integerValue]];
        
        if (self.cardsBuilder.isLastGame) {
            self.redCard = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red_card"]];
            self.redCard.center = CGPointMake(self.view.frame.size.width + self.redCard.frame.size.width/2, -self.redCard.frame.size.height/2);
            [self.view addSubview:self.redCard];
            
            CABasicAnimation *anim = [CABasicAnimation animation];
            anim.keyPath = @"position";
            anim.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width + self.redCard.frame.size.width/2, -self.redCard.frame.size.height/2)];
            anim.toValue=[NSValue valueWithCGPoint:CGPointMake(self.sameView.center.x, self.sameView.center.y - 20)];
            anim.removedOnCompletion=NO;
            anim.fillMode = kCAFillModeForwards;
            anim.duration = 1;
            anim.beginTime = CACurrentMediaTime() + 0.5;
            
            CABasicAnimation *anim1 = [CABasicAnimation animation];
            anim1.keyPath = @"position";
            anim1.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.sameView.center.x, self.sameView.center.y - 20)];
            anim1.toValue=[NSValue valueWithCGPoint:CGPointMake(-self.redCard.frame.size.width/2,-self.redCard.frame.size.height/2)];
            anim1.removedOnCompletion=NO;
            anim1.fillMode = kCAFillModeForwards;
            anim1.duration = 1;
            anim1.beginTime = CACurrentMediaTime() + 3;
            
            [self.redCard.layer addAnimation:anim forKey:nil];
            [self.redCard.layer addAnimation:anim1 forKey:nil];
            
            [NSTimer scheduledTimerWithTimeInterval:4.5f target:self selector:@selector(startCard3Animation) userInfo:nil repeats:NO];
        } else {
            [self startCard3Animation];
        }
        

    }else if ([value isEqual:@"anim3"]) {
        if (isNeedCardOutVoice) {
            [self playVoiceByFile:@"Players_cn"];
        }
        Card *card = [self.currentResult.playerCards objectAtIndex:1];
        self.playerCard_2.hidden = NO;
        self.playerCard_2.image = [UIImage imageNamed:card.resId];
        
        Card *card1 = [self.currentResult.playerCards objectAtIndex:0];
        NSNumber *pointCard1 = card1.validPoint;
        NSNumber *pointCard2 = card.validPoint;
        self.playerPointView.image = [UIImage imageNamed:[NSString stringWithFormat:@"point_player_%d", [self add:pointCard1 and:pointCard2].integerValue]];
        
        self.anim4 = [CABasicAnimation animation];
        self.anim4.keyPath = @"position";
        self.anim4.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
        self.anim4.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x, self.bankerCard_2.center.y)];
        self.anim4.removedOnCompletion=YES;
        self.anim4.fillMode = kCAFillModeRemoved;
        self.anim4.duration = animationTime;
        self.anim4.beginTime = CACurrentMediaTime() + animationDelayTime;
        self.anim4.delegate = self;
        [self.anim4 setValue:@"anim4" forKey:@"anim"];
        [self.cardBg_4.layer addAnimation:self.anim4 forKey:@"anim4"];
    }else if ([value isEqual:@"anim4"]) {
        if (isNeedCardOutVoice) {
            [self playVoiceByFile:@"Bankers_cn"];
        }
        Card *card = [self.currentResult.bankerCards objectAtIndex:1];
        self.bankerCard_2.hidden = NO;
        self.bankerCard_2.image = [UIImage imageNamed:card.resId];
        Card *card1 = [self.currentResult.bankerCards objectAtIndex:0];
        NSNumber *pointCard1 = card1.validPoint;
        NSNumber *pointCard2 = card.validPoint;
        self.bankerPointView.image = [UIImage imageNamed:[NSString stringWithFormat:@"point_player_%d", [self add:pointCard1 and:pointCard2].integerValue]];
        [self dealDoubleResult];
    }else if ([value isEqual:@"anim5"]) {
        if (isNeedCardOutVoice) {
            [self playVoiceByFile:@"ba_1c2p_cn"];
        }
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
        } else {
            
            self.anim6 = [CABasicAnimation animation];
            self.anim6.keyPath = @"position";
            self.anim6.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
            self.anim6.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_3.center.x, self.bankerCard_3.center.y)];
            self.anim6.removedOnCompletion=YES;
            self.anim6.fillMode = kCAFillModeRemoved;
            self.anim6.duration = animationTime;
            self.anim6.beginTime = CACurrentMediaTime() + animationDelayTime;
            self.anim6.delegate = self;
            [self.anim6 setValue:@"anim6" forKey:@"anim"];
            [self.cardBg_6.layer addAnimation:self.anim6 forKey:@"anim6"];
            
            self.animBankerCard2 = [CABasicAnimation animation];
            self.animBankerCard2.keyPath = @"position";
            self.animBankerCard2.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x, self.bankerCard_2.center.y)];
            self.animBankerCard2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x - 60, self.bankerCard_2.center.y)];
            self.animBankerCard2.beginTime = CACurrentMediaTime() + animationDelayTime;
            self.animBankerCard2.removedOnCompletion=NO;
            self.animBankerCard2.fillMode = kCAFillModeForwards;
            self.animBankerCard2.duration = animationTime;
            [self.bankerCard_2.layer addAnimation:self.animBankerCard2 forKey:nil];
        }
    }else if ([value isEqual:@"anim6"]) {
        if (isNeedCardOutVoice) {
            [self playVoiceByFile:@"ba_1c2b_cn"];
        }
        
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
    } else if ([value isEqual:@"anim7"]) {
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(removeCongratulationsImage) userInfo:nil repeats:NO];
        
    } else if ([value isEqual:@"cutAnim2"]) {
        [self.view bringSubviewToFront:self.cutCardsView2];
    }
}

- (void) startCard3Animation
{
    if (self.redCard != nil) {
        [self.redCard removeFromSuperview];
        self.redCard = nil;
    }
    
    self.anim3 = [CABasicAnimation animation];
    self.anim3.keyPath = @"position";
    self.anim3.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
    self.anim3.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x, self.playerCard_2.center.y)];
    self.anim3.removedOnCompletion=YES;
    self.anim3.fillMode = kCAFillModeRemoved;
    self.anim3.duration = animationTime;
    self.anim3.beginTime = CACurrentMediaTime() + animationDelayTime;
    self.anim3.delegate = self;
    [self.anim3 setValue:@"anim3" forKey:@"anim"];
    [self.cardBg_3.layer addAnimation:self.anim3 forKey:@"anim3"];
}

- (void) dealDoubleResult
{
    if (self.bankerDoubleView.chipView != nil || self.playerDoubleView.chipView != nil || self.currentResult.isPlayerDouble || self.currentResult.isBankerDouble) {
        if (self.currentResult.isPlayerDouble) {
            if (self.playerDoubleView.chipView != nil) {
                [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(drawPlayerDoubleWinChip) userInfo:nil repeats:NO];
            }
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addPlayerDoubleViewBg) userInfo:nil repeats:NO];
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(removePlayerDoubleViewBg) userInfo:nil repeats:NO];
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(addPlayerDoubleViewBg) userInfo:nil repeats:NO];
            [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(removePlayerDoubleViewBg) userInfo:nil repeats:NO];
            [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(balancePlayerDouble) userInfo:nil repeats:NO];
            
        } else {
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(balancePlayerDouble) userInfo:nil repeats:NO];
        }
        
        if (self.currentResult.isBankerDouble) {
            if (self.bankerDoubleView.chipView != nil) {
                [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(drawBankerDoubleWinChip) userInfo:nil repeats:NO];
            }
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addBankerDoubleViewBg) userInfo:nil repeats:NO];
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(removeBankerDoubleViewBg) userInfo:nil repeats:NO];
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(addBankerDoubleViewBg) userInfo:nil repeats:NO];
            [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(removeBankerDoubleViewBg) userInfo:nil repeats:NO];
            [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(balanceBankerDouble) userInfo:nil repeats:NO];
        } else {
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(balanceBankerDouble) userInfo:nil repeats:NO];
        }
        
        if (self.currentResult.isPlayerDouble || self.currentResult.isBankerDouble) {
            [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(continueGame) userInfo:nil repeats:NO];
        } else {
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(continueGame) userInfo:nil repeats:NO];
        }
    } else {
        [self continueGame];
    }
}

- (void) drawBankerDoubleWinChip
{
    self.winBankerDoubleChipView =[[UIImageView alloc] init];
    UIImage *totalChipImage = [ImageUtils scoreToChips:self.bankerDoubleView.chipView.tag * 11];
    self.winBankerDoubleChipView.tag = self.bankerDoubleView.chipView.tag * 11;
    self.winBankerDoubleChipView.center = CGPointMake(self.bankerDoubleView.chipView.center.x - 100, self.bankerDoubleView.chipView.center.y);
    self.winBankerDoubleChipView.bounds = CGRectMake(0.0f, 0.0f, totalChipImage.size.width, totalChipImage.size.height);
    self.winBankerDoubleChipView.image = totalChipImage;
    [self.view addSubview:self.winBankerDoubleChipView];
    NSString *scoreStr = [self getScoreStrByScore:self.bankerDoubleView.chipView.tag + self.winBankerDoubleChipView.tag];
    self.bankerDoubleViewLabel.text =  scoreStr;
}

- (void) drawPlayerDoubleWinChip
{
    self.winPlayerDoubleChipView =[[UIImageView alloc] init];
    UIImage *totalChipImage = [ImageUtils scoreToChips:self.playerDoubleView.chipView.tag * 11];
    self.winPlayerDoubleChipView.tag =self.playerDoubleView.chipView.tag * 11;
    self.winPlayerDoubleChipView.center = CGPointMake(self.playerDoubleView.chipView.center.x + 100, self.playerDoubleView.chipView.center.y);
    self.winPlayerDoubleChipView.bounds = CGRectMake(0.0f, 0.0f, totalChipImage.size.width, totalChipImage.size.height);
    self.winPlayerDoubleChipView.image = totalChipImage;
    [self.view addSubview:self.winPlayerDoubleChipView];
    NSString *scoreStr = [self getScoreStrByScore:self.playerDoubleView.chipView.tag + self.winPlayerDoubleChipView.tag];
    self.playerDoubleViewLabel.text =  scoreStr;
}

- (void) continueGame
{
    if (self.currentResult.allCards.count == 4) {
        [self gameFinish];
    } else {
        Card *card5 = [self.currentResult.playerCards objectAtIndex:2];
        if (!(card5.cardNumber.integerValue == 0)) {
            self.anim5 = [CABasicAnimation animation];
            self.anim5.keyPath = @"position";
            self.anim5.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
            self.anim5.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_3.center.x, self.playerCard_3.center.y)];
            self.anim5.removedOnCompletion=YES;
            self.anim5.fillMode = kCAFillModeRemoved;
            self.anim5.duration = animationTime;
            self.anim5.beginTime = CACurrentMediaTime() + animationDelayTime+0.5;
            self.anim5.delegate = self;
            [self.anim5 setValue:@"anim5" forKey:@"anim"];
            [self.cardBg_5.layer addAnimation:self.anim5 forKey:@"anim5"];
            
            self.animPlayerCard2 = [CABasicAnimation animation];
            self.animPlayerCard2.keyPath = @"position";
            self.animPlayerCard2.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x, self.playerCard_2.center.y)];
            self.animPlayerCard2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x-60, self.playerCard_2.center.y)];
            self.animPlayerCard2.removedOnCompletion=NO;
            self.animPlayerCard2.fillMode = kCAFillModeForwards;
            self.animPlayerCard2.beginTime = CACurrentMediaTime() + animationDelayTime+0.5;
            self.animPlayerCard2.duration = animationTime;
            [self.playerCard_2.layer addAnimation:self.animPlayerCard2 forKey:nil];
        } else {
//            [self.cardBg_6.layer addAnimation:self.anim6 forKey:@"anim6"];
//            [self.bankerCard_2.layer addAnimation:self.animBankerCard2 forKey:nil];
            self.anim6 = [CABasicAnimation animation];
            self.anim6.keyPath = @"position";
            self.anim6.fromValue=[NSValue valueWithCGPoint:CGPointMake(cardBgX, cardBgY)];
            self.anim6.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_3.center.x, self.bankerCard_3.center.y)];
            self.anim6.removedOnCompletion=YES;
            self.anim6.fillMode = kCAFillModeRemoved;
            self.anim6.duration = animationTime;
            self.anim6.beginTime = CACurrentMediaTime() + animationDelayTime;
            self.anim6.delegate = self;
            [self.anim6 setValue:@"anim6" forKey:@"anim"];
            [self.cardBg_6.layer addAnimation:self.anim6 forKey:@"anim6"];
            
            self.animBankerCard2 = [CABasicAnimation animation];
            self.animBankerCard2.keyPath = @"position";
            self.animBankerCard2.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x, self.bankerCard_2.center.y)];
            self.animBankerCard2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x - 60, self.bankerCard_2.center.y)];
            self.animBankerCard2.beginTime = CACurrentMediaTime() + animationDelayTime;
            self.animBankerCard2.removedOnCompletion=NO;
            self.animBankerCard2.fillMode = kCAFillModeForwards;
            self.animBankerCard2.duration = animationTime;
            [self.bankerCard_2.layer addAnimation:self.animBankerCard2 forKey:nil];
        }
    }

}

//- (void) executeAnim5
//{
//    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(removeCongratulationsImage) userInfo:nil repeats:NO];
//}
//
//- (void) executeAnim6
//{
//    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(removeCongratulationsImage) userInfo:nil repeats:NO];
//}

- (void) removeCongratulationsImage
{
    self.congratulationsImage.hidden = YES;
    [self.congratulationsImage removeFromSuperview];
    self.congratulationsImage = nil;
}

- (void) gameFinish
{
    if (isNeedCardResultVoice) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"Players_cn" forKey:@"sound"];
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic repeats:NO];
        
        NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
        if (self.currentResult.isPlayerBornCard) {
            [dic1 setObject:[self getVoiceNameByBumber:self.currentResult.playerPoint isBornCard:YES] forKey:@"sound"];
        } else {
            [dic1 setObject:[self getVoiceNameByBumber:self.currentResult.playerPoint isBornCard:NO] forKey:@"sound"];
        }
        
        [NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic1 repeats:NO];
        
        NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
        [dic2 setObject:@"Bankers_cn" forKey:@"sound"];
        [NSTimer scheduledTimerWithTimeInterval:3.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic2 repeats:NO];
        
        NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
        
        if (self.currentResult.isBankerBornCard) {
            [dic3 setObject:[self getVoiceNameByBumber:self.currentResult.bankerPoint isBornCard:YES] forKey:@"sound"];
        } else {
            [dic3 setObject:[self getVoiceNameByBumber:self.currentResult.bankerPoint isBornCard:NO] forKey:@"sound"];
        }
        
        [NSTimer scheduledTimerWithTimeInterval:4.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic3 repeats:NO];
    }
    
    if (self.currentResult.resultType == ResultPlayerWin) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"c_playerwin_cn" forKey:@"sound"];
        [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic repeats:NO];
        
        NSLog(@"result--->2");
        CABasicAnimation *anim =[CABasicAnimation animation];
        anim.keyPath = @"position";
        anim.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_1.center.x, self.playerCard_1.center.y)];
        anim.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_1.center.x, self.playerCard_1.center.y + 30)];
        anim.removedOnCompletion=NO;
        anim.fillMode = kCAFillModeForwards;
        anim.duration = 0.4;
        anim.delegate = self;
        anim.beginTime = CACurrentMediaTime() + delayTime;
        [self.playerCard_1.layer addAnimation:anim forKey:nil];
        
        CABasicAnimation *anim1 =[CABasicAnimation animation];
        anim1.keyPath = @"position";
        
        if (self.currentResult.playerCards.count == 3)  {
            Card* card = [self.currentResult.playerCards objectAtIndex:2];
            if (card.cardNumber.integerValue != 0) {
                anim1.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x - 60, self.playerCard_2.center.y)];
                anim1.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x - 60, self.playerCard_2.center.y + 30)];
            } else {
                anim1.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x, self.playerCard_2.center.y)];
                anim1.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x, self.playerCard_2.center.y + 30)];
            }
        } else {
            anim1.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x, self.playerCard_2.center.y)];
            anim1.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_2.center.x, self.playerCard_2.center.y + 30)];
        }
        anim1.removedOnCompletion=NO;
        anim1.fillMode = kCAFillModeForwards;
        anim1.duration = 0.4;
        anim1.delegate = self;
        anim1.beginTime = CACurrentMediaTime() + delayTime;
        [self.playerCard_2.layer addAnimation:anim1 forKey:nil];
        
        CABasicAnimation *anim2 =[CABasicAnimation animation];
        anim2.keyPath = @"position";
        anim2.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_3.center.x, self.playerCard_3.center.y)];
        anim2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_3.center.x, self.playerCard_3.center.y + 30)];
        anim2.removedOnCompletion=NO;
        anim2.fillMode = kCAFillModeForwards;
        anim2.duration = 0.4;
        anim2.delegate = self;
        anim2.beginTime = CACurrentMediaTime() + delayTime;
        [self.playerCard_3.layer addAnimation:anim2 forKey:nil];
        
        CABasicAnimation *anim3 =[CABasicAnimation animation];
        anim2.keyPath = @"position";
        anim2.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_3.center.x, self.playerCard_3.center.y)];
        anim2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.playerCard_3.center.x, self.playerCard_3.center.y + 30)];
        anim2.removedOnCompletion=NO;
        anim2.fillMode = kCAFillModeForwards;
        anim2.duration = 0.4;
        anim2.delegate = self;
        anim2.beginTime = CACurrentMediaTime() + delayTime;
        [self.playerCard_3.layer addAnimation:anim2 forKey:nil];
        
        [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(addPlayerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+0.5 target:self selector:@selector(removePlayerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+1 target:self selector:@selector(addPlayerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+1.5 target:self selector:@selector(removePlayerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+2 target:self selector:@selector(addPlayerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime + 2.5 target:self selector:@selector(removePlayerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime + 4 target:self selector:@selector(balance) userInfo:nil repeats:NO];
    } else if (self.currentResult.resultType == ResultBankerWin){
        NSLog(@"result--->1");
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"ba_bwin_cn" forKey:@"sound"];
        [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic repeats:NO];
        
        CABasicAnimation *anim =[CABasicAnimation animation];
        anim.keyPath = @"position";
        anim.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_1.center.x, self.bankerCard_1.center.y)];
        anim.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_1.center.x, self.bankerCard_1.center.y + 30)];
        anim.removedOnCompletion=NO;
        anim.fillMode = kCAFillModeForwards;
        anim.duration = 0.4;
        anim.delegate = self;
        anim.beginTime = CACurrentMediaTime() + delayTime;
        [self.bankerCard_1.layer addAnimation:anim forKey:nil];
        
        CABasicAnimation *anim1 =[CABasicAnimation animation];
        anim1.keyPath = @"position";
        
        if (self.currentResult.bankerCards.count == 3)  {
            anim1.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x - 60, self.bankerCard_2.center.y)];
            anim1.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x - 60, self.bankerCard_2.center.y + 30)];
        } else {
            anim1.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x, self.bankerCard_2.center.y)];
            anim1.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_2.center.x, self.bankerCard_2.center.y + 30)];
        }
        anim1.removedOnCompletion=NO;
        anim1.fillMode = kCAFillModeForwards;
        anim1.duration = 0.4;
        anim1.delegate = self;
        anim1.beginTime = CACurrentMediaTime() + delayTime;
        [self.bankerCard_2.layer addAnimation:anim1 forKey:nil];
        
        CABasicAnimation *anim2 =[CABasicAnimation animation];
        anim2.keyPath = @"position";
        anim2.fromValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_3.center.x, self.bankerCard_3.center.y)];
        anim2.toValue=[NSValue valueWithCGPoint:CGPointMake(self.bankerCard_3.center.x, self.bankerCard_3.center.y + 30)];
        anim2.removedOnCompletion=NO;
        anim2.fillMode = kCAFillModeForwards;
        anim2.duration = 0.4;
        anim2.delegate = self;
        anim2.beginTime = CACurrentMediaTime() + delayTime;
        [self.bankerCard_3.layer addAnimation:anim2 forKey:nil];
        
        [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(addBankerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+0.5 target:self selector:@selector(removeBankerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+1 target:self selector:@selector(addBankerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+1.5 target:self selector:@selector(removeBankerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+2 target:self selector:@selector(addBankerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+2.5 target:self selector:@selector(removeBankerViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+4 target:self selector:@selector(balance) userInfo:nil repeats:NO];
    } else {
        NSLog(@"result--->3");
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"ba_tiwin_cn" forKey:@"sound"];
        [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic repeats:NO];
    
        [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(addSameViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+0.5 target:self selector:@selector(removeSameViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+1 target:self selector:@selector(addSameViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+1.5 target:self selector:@selector(removeSameViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+2 target:self selector:@selector(addSameViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+2.5 target:self selector:@selector(removeSameViewBg) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:delayTime+4 target:self selector:@selector(balance) userInfo:nil repeats:NO];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(drawWinChip) userInfo:nil repeats:NO];
}
//赢得筹码绘制以及飞出动画
- (void) drawWinChip
{
    if ((self.currentResult.resultType == ResultBankerWin && self.bankerView.chipView != nil) || (self.currentResult.resultType == ResultPlayerWin  && self.playerView.chipView != nil) || (self.currentResult.resultType == ResultDrawnGame && self.sameView.chipView != nil) || (self.currentResult.isPlayerDouble && self.playerDoubleView.chipView != nil) || (self.currentResult.isBankerDouble && self.bankerDoubleView.chipView != nil)) {
        
        [self playSoundByFile:@"pwin_money"];
        self.congratulationsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"congratulations"]];
        self.congratulationsImage.center = CGPointMake(self.whiteLineView.center.x, self.whiteLineView.center.y + 100);
        [self.view addSubview:self.congratulationsImage];
        [self.congratulationsImage.layer addAnimation:self.anim7 forKey:@"anim7"];
        continuousWinCount++;
    } else {
        if (self.currentResult.resultType == ResultDrawnGame) {
            [self playSoundByFile:@"bac_push"];
        } else {
            [self playSoundByFile:@"plose_money"];
        }
        continuousWinCount = 0;
        
    }
    
    if (self.currentResult.resultType == ResultBankerWin && self.bankerView.chipView != nil) {
        self.winBankerChipView =[[UIImageView alloc] init];
        UIImage *totalChipImage = [ImageUtils scoreToChips:self.bankerView.chipView.tag*0.95];
        self.winBankerChipView.tag = self.bankerView.chipView.tag * 0.95;
        self.winBankerChipView.center = CGPointMake(self.bankerView.chipView.center.x + 100, self.bankerView.chipView.center.y);
        self.winBankerChipView.bounds = CGRectMake(0.0f, 0.0f, totalChipImage.size.width, totalChipImage.size.height);
        self.winBankerChipView.image = totalChipImage;
        [self.view addSubview:self.winBankerChipView];
        NSString *scoreStr = [self getScoreStrByScore:self.bankerView.chipView.tag + self.winBankerChipView.tag];
        self.bankerViewLabel.text =  scoreStr;
        
    } else if (self.currentResult.resultType == ResultPlayerWin && self.playerView.chipView != nil) {
        self.winPlayerChipView =[[UIImageView alloc] init];
        UIImage *totalChipImage = [ImageUtils scoreToChips:self.playerView.chipView.tag];
        self.winPlayerChipView.tag =self.playerView.chipView.tag;
        self.winPlayerChipView.center = CGPointMake(self.playerView.chipView.center.x + 100, self.playerView.chipView.center.y);
        self.winPlayerChipView.bounds = CGRectMake(0.0f, 0.0f, totalChipImage.size.width, totalChipImage.size.height);
        self.winPlayerChipView.image = totalChipImage;
        [self.view addSubview:self.winPlayerChipView];
        NSString *scoreStr = [self getScoreStrByScore:self.playerView.chipView.tag + self.winPlayerChipView.tag];
        self.playerViewLabel.text =  scoreStr;
    } else if (self.currentResult.resultType == ResultDrawnGame && self.sameView.chipView != nil){
        self.winSameChipView =[[UIImageView alloc] init];
        UIImage *totalChipImage = [ImageUtils scoreToChips:self.sameView.chipView.tag * 8];
        self.winSameChipView.tag =self.sameView.chipView.tag * 8;
        self.winSameChipView.center = CGPointMake(self.sameView.chipView.center.x + 100, self.sameView.chipView.center.y);
        self.winSameChipView.bounds = CGRectMake(0.0f, 0.0f, totalChipImage.size.width, totalChipImage.size.height);
        self.winSameChipView.image = totalChipImage;
        [self.view addSubview:self.winSameChipView];
        NSString *scoreStr = [self getScoreStrByScore:self.sameView.chipView.tag + self.winSameChipView.tag];
        self.sameViewLabel.text =  scoreStr;
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

- (void) addPlayerDoubleViewBg
{
    UIColor *bgColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#ffffff" alpha:0.4];
    self.playerDoubleView.backgroundColor = bgColor;
}

- (void) removePlayerDoubleViewBg
{
    self.playerDoubleView.backgroundColor = nil;
}

- (void) addBankerDoubleViewBg
{
    UIColor *bgColor = [[BaccaratTheme defaultTheme] colorWithHexString:@"#ffffff" alpha:0.4];
    self.bankerDoubleView.backgroundColor = bgColor;
}

- (void) removeBankerDoubleViewBg
{
    self.bankerDoubleView.backgroundColor = nil;
}

- (void) balancePlayerDouble
{
    [UIView animateWithDuration:0.5 animations:^{
        if (self.winPlayerDoubleChipView != nil) {
            totalPlayerDoubleWinScore += self.winPlayerDoubleChipView.tag;
            totalPlayerDoubleWinScore += self.playerDoubleView.chipView.tag;
            self.winPlayerDoubleChipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
            self.playerDoubleView.chipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
        }else {
            self.playerDoubleView.chipView.center = CGPointMake(self.view.center.x, -100);
        }
    } completion:^(BOOL finished) {
        totalScore += totalPlayerDoubleWinScore;
        [self updateScore];
        totalPlayerDoubleWinScore = 0;
        playerDoubleCacheScore = self.playerDoubleView.chipView.tag;;
        [self.playerDoubleView.chipView removeFromSuperview];
        [self.winPlayerDoubleChipView removeFromSuperview];
        self.playerDoubleView.chipView = nil;
        self.winPlayerDoubleChipView = nil;
//        [self updateChipLabel];
        NSString *scoreStr = [self getScoreStrByScore:self.playerDoubleView.chipView.tag];
        self.playerDoubleViewLabel.text =  scoreStr;
    }];
}

- (void) balanceBankerDouble
{
    [UIView animateWithDuration:0.5 animations:^{
        if (self.winBankerDoubleChipView != nil) {
            totalBankerDoubleWinScore += self.winBankerDoubleChipView.tag;
            totalBankerDoubleWinScore += self.bankerDoubleView.chipView.tag;
            self.winBankerDoubleChipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
            self.bankerDoubleView.chipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
        } else {
            self.bankerDoubleView.chipView.center = CGPointMake(self.view.center.x, -100);
        }

    } completion:^(BOOL finished) {
        //更新总筹码
        totalScore += totalBankerDoubleWinScore;
        [self updateScore];
        totalBankerDoubleWinScore = 0;
        
        bankerDoubleCacheScore = self.bankerDoubleView.chipView.tag;;
        
        [self.winBankerDoubleChipView removeFromSuperview];
        [self.bankerDoubleView.chipView removeFromSuperview];
        self.bankerDoubleView.chipView = nil;
        self.winBankerDoubleChipView = nil;
//        [self updateChipLabel];
        NSString *scoreStr = [self getScoreStrByScore:self.bankerDoubleView.chipView.tag];
        self.bankerDoubleViewLabel.text =  scoreStr;
    }];
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
    
        if (self.winBankerChipView != nil) {
            totalWinScore += self.winBankerChipView.tag;
            totalWinScore += self.bankerView.chipView.tag;
            self.winBankerChipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
            self.bankerView.chipView.center = CGPointMake(self.view.center.x, self.view.frame.size.height + 100);
        }else {
            self.bankerView.chipView.center = CGPointMake(self.view.center.x, -100);
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
        self.chipSelect.hidden = NO;
        
        for (UIImageView *chipFloat in self.chipFloatingViews) {
            chipFloat.hidden = NO;
        }
        
        //更新总筹码
        totalScore += totalWinScore;
        [self updateScore];
        
        //押注筹码重置
        totalBetCacheScore = totalBetScore;
        totalBetScore = 0;
        totalWinScore = 0;
        
        playerScore = 0;
        playerCacheScore = self.playerView.chipView.tag;
        bankerScore = 0;
        bankerCacheScore = self.bankerView.chipView.tag;
        playerDoubleScore = 0;
        bankerDoubleScore = 0;
        
        sameScore = 0;
        sameCacheScore = self.sameView.chipView.tag;
        //移除筹码
        [self.playerView.chipView removeFromSuperview];
        [self.bankerView.chipView removeFromSuperview];
        [self.sameView.chipView removeFromSuperview];
        
        [self.winPlayerChipView removeFromSuperview];
        [self.winBankerChipView removeFromSuperview];
        [self.winSameChipView removeFromSuperview];
       
        
        //置空
        self.playerView.chipView = nil;
        self.bankerView.chipView = nil;
        self.sameView.chipView = nil;
        
        self.winPlayerChipView = nil;
        self.winBankerChipView = nil;
        self.winSameChipView = nil;
        
        [self updateChipLabel];

        [self.potBtn setImage:[UIImage imageNamed:@"last_pot_btn"] forState:UIControlStateNormal];
        [self.potBtn setImage:[UIImage imageNamed:@"last_pot_btn_s"] forState:UIControlStateHighlighted];
        
        if (totalScore <= 100) {
            [self showChipPresendAlert];
            totalScore += 1000;
            [self updateScore];
        }
        [[NSUserDefaults standardUserDefaults] setInteger:totalScore forKey:@"totalScore"];
        currentGameBalance = startTotalScore - totalScore;
        startTotalScore = totalScore;
        
        [self recordGameResult];
        [self drawMark];
        
        
        if (self.cardsBuilder.cards.count > 100) {
            Result *result = [self.cardsBuilder getNextResult:NO];
            if (result.resultType == ResultBankerWin) {
                self.resultTipLabel.text = @"下把出庄";
                [self.tipBtn setImage:[UIImage imageNamed:@"system_btn_banker_win"] forState:UIControlStateNormal];
            } else if (result.resultType == ResultPlayerWin) {
                self.resultTipLabel.text = @"下把出闲";
                [self.tipBtn setImage:[UIImage imageNamed:@"system_btn"] forState:UIControlStateNormal];
            } else {
                self.resultTipLabel.text = @"下把出和";
                [self.tipBtn setImage:[UIImage imageNamed:@"system_btn"] forState:UIControlStateNormal];
            }
            
            //请下注
            if (continuousWinCount >= 8) {
                [self playSoundByFile:@"win_3"];
            } else {
                [self playVoiceByFile:@"c_place_cn"];
            }
            
            self.cardsNumber.text = [NSString stringWithFormat:@"Cards:%d", self.cardsBuilder.cards.count];
        } else {
            isGameStart = YES;
            [self resetCards];
        }
        
    }];
}

- (void) resetCards
{
    self.markContainer.hidden = YES;
    self.markContainer_hd.hidden = YES;
    //清理路单
    for (UIImageView *imageView in self.markPoint1Images) {
        [imageView removeFromSuperview];
    }
    for (UIImageView *imageView in self.markPoint2Images) {
        [imageView removeFromSuperview];
    }
    for (UIImageView *imageView in self.markPoint3Images) {
        [imageView removeFromSuperview];
    }
    for (UIImageView *imageView in self.markPoint4Images) {
        [imageView removeFromSuperview];
    }
    for (UIImageView *imageView in self.markPoint5Images) {
        [imageView removeFromSuperview];
    }
    for (UIImageView *imageView in self.markPoint1Images_hd) {
        [imageView removeFromSuperview];
    }
    for (UIImageView *imageView in self.markPoint2Images_hd) {
        [imageView removeFromSuperview];
    }
    for (UIImageView *imageView in self.markPoint3Images_hd) {
        [imageView removeFromSuperview];
    }
    for (UIImageView *imageView in self.markPoint4Images_hd) {
        [imageView removeFromSuperview];
    }
    for (UIImageView *imageView in self.markPoint5Images_hd) {
        [imageView removeFromSuperview];
    }
    self.cardsBuilder = [CardsBuilder shareObject];
    self.markBuilder = [MarkBuilder shareObject];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(cutCard) userInfo:nil repeats:NO];
}

- (void) recordGameResult
{
    GameRecorderInfo *info = [[GameRecorderInfo alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:@"上午"];
    [formatter setPMSymbol:@"下午"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm a"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    info.time = dateTime;
    info.score = [NSString stringWithFormat:@"%d", currentGameBalance];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"results"];
    NSArray *results = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"results--->%@",results);
    if (results != nil && results.count > 0) {
        NSMutableArray *mutableResults = [results mutableCopy];
        [mutableResults addObject:info];
        NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:mutableResults.copy];
        [[NSUserDefaults standardUserDefaults] setObject:data1 forKey:@"results"];
    } else {
        NSMutableArray *mutableResults = [NSMutableArray array];
        [mutableResults addObject:info];
        NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:mutableResults.copy];
        [[NSUserDefaults standardUserDefaults] setObject:data1 forKey:@"results"];
    }
}

- (void) drawMark
{
    [self.markBuilder getNextMark1PointByResult:self.currentResult];
    [self.markBuilder getNextMark1PointByResultWithOutT:self.currentResult];
    [self drawAllResult1Mark:wordTSelected];
    [self drawResult2Mark];
    [self drawResult3Mark];
    [self drawResult4Mark];
    [self drawResult5Mark];
    [self updateResultCount];
    
//    if (isFirstTimeStart) {
//        isFirstTimeStart = NO;
    
        self.currentMarkContainer.hidden = NO;
//    }
}

- (void) updateResultCount
{
    NSInteger playerWinCount = [self.playerWinCountLabel.text integerValue];
    NSInteger bankerWinCount = [self.bankerWinCountLabel.text integerValue];
    NSInteger drawnGameCount = [self.drawnGameCountLabel.text integerValue];
    NSInteger bornCardCount = [self.bornCardCountLabel.text integerValue];
    NSInteger playerDoubleCount = [self.playerDoubelCountLabel.text integerValue];
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
        self.playerDoubelCountLabel.text =[NSString stringWithFormat:@"%d", playerDoubleCount];
        self.bankerDoubelCountLabel.text =[NSString stringWithFormat:@"%d", bankerDoubleCount];
        
        self.playerWinCountLabel_hd.text =[NSString stringWithFormat:@"%d", playerWinCount];
        self.bankerWinCountLabel_hd.text =[NSString stringWithFormat:@"%d", bankerWinCount];
        self.drawnGameCountLabel_hd.text =[NSString stringWithFormat:@"%d", drawnGameCount];
        self.bornCardCountLabel_hd.text =[NSString stringWithFormat:@"%d", bornCardCount];
        self.playerDoubelCountLabel_hd.text =[NSString stringWithFormat:@"%d", playerDoubleCount];
        self.bankerDoubelCountLabel_hd.text =[NSString stringWithFormat:@"%d", bankerDoubleCount];
    }
}

- (void) drawAllResult1Mark:(BOOL)isT
{
    
    NSMutableArray *results = self.markBuilder.allMark1PointsTResult;
    if (!isT) {
        results = self.markBuilder.allMark1PointsResult;
    }
    for (UIImageView *image in self.markPoint1Images) {
        if (image != nil) {
            [image removeFromSuperview];
        }
    }
    [self.markPoint1Images removeAllObjects];
    
    if (results != nil && results.count > 0) {
        for (MarkPoint *point in results) {
            UIImageView * imageView = [self drawResult1Mark:point];
            [self.markView1 addSubview:imageView];
            [self.markPoint1Images addObject:imageView];
        }
    }
    
    for (UIImageView *image in self.markPoint1Images_hd) {
        if (image != nil) {
            [image removeFromSuperview];
        }
    }
    [self.markPoint1Images_hd removeAllObjects];
    
    if (results != nil && results.count > 0) {
        for (MarkPoint *point in results) {
            UIImageView * imageView = [self drawResult1Mark:point];
            [self.markView1_hd addSubview:imageView];
            [self.markPoint1Images_hd addObject:imageView];
        }
    }
}

- (UIImageView *) drawResult1Mark:(MarkPoint *)point
{
    NSString *imageName = nil;
    if (point.result.resultType == ResultPlayerWin) {
        if (point.result.isPlayerBornCard) {
            imageName = @"player_win_fill";
        } else {
            imageName = @"player_win_empty";
        }
    } else if (point.result.resultType == ResultBankerWin) {
        if (point.result.isBankerBornCard) {
            imageName = @"banker_win_fill";
        } else {
            imageName = @"banker_win_empty";
        }
    } else {
        if (point.result.isPlayerBornCard) {
            imageName = @"drawn_game_fill";
        } else {
            imageName = @"drawn_game_empty";
        }
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.pointX.floatValue, point.pointY.floatValue, 21, 21)];
    point.isUsed = YES;
    imageView.image = [UIImage imageNamed:imageName];
    
    return imageView;
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
    [self.markPoint2Images addObject:imageView];
    [self.markView2 addSubview:imageView];
    
    UIImageView *imageView_hd = [[UIImageView alloc] initWithFrame:CGRectMake(point.pointX.floatValue, point.pointY.floatValue, 10.5, 10.5)];
    point.isUsed = YES;
    imageView_hd.image = [UIImage imageNamed:imageName];
    [self.markPoint2Images_hd addObject:imageView_hd];
    [self.markView2_hd addSubview:imageView_hd];
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
    [self.markPoint3Images addObject:imageView];
    [self.markView3 addSubview:imageView];
    
    UIImageView *imageView_hd = [[UIImageView alloc] initWithFrame:CGRectMake(point.pointX.floatValue, point.pointY.floatValue, 10.5, 10.5)];
    point.isUsed = YES;
    imageView_hd.image = [UIImage imageNamed:imageName];
    [self.markPoint3Images_hd addObject:imageView_hd];
    [self.markView3_hd addSubview:imageView_hd];

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
    [self.markPoint4Images addObject:imageView];
    [self.markView4 addSubview:imageView];
    
    UIImageView *imageView_hd = [[UIImageView alloc] initWithFrame:CGRectMake(point.pointX.floatValue, point.pointY.floatValue, 10.5, 10.5)];
    point.isUsed = YES;
    imageView_hd.image = [UIImage imageNamed:imageName];
    [self.markPoint4Images_hd addObject:imageView_hd];
    [self.markView4_hd addSubview:imageView_hd];

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
        nameLable = @"閒";
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
    [self.markPoint5Images addObject:imageView];
    [self.markView5 addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(point.pointX.floatValue, point.pointY.floatValue, 42, 42)];
    label.text = nameLable;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica" size:25];
    [self.markView5 addSubview:label];
    
    UIImageView *imageView_hd = [[UIImageView alloc] initWithFrame:CGRectMake(point.pointX.floatValue, point.pointY.floatValue, 42, 42)];
    point.isUsed = YES;
    imageView_hd.image = [UIImage imageNamed:imageName];
    [self.markPoint5Images_hd addObject:imageView_hd];
    [self.markView5_hd addSubview:imageView_hd];
    
    UILabel *label_hd = [[UILabel alloc] initWithFrame:CGRectMake(point.pointX.floatValue, point.pointY.floatValue, 42, 42)];
    label_hd.text = nameLable;
    label_hd.textColor = [UIColor whiteColor];
    label_hd.textAlignment = UITextAlignmentCenter;
    label_hd.font = [UIFont fontWithName:@"Helvetica" size:25];
    [self.markView5_hd addSubview:label_hd];
}

-(NSNumber*)add:(NSNumber *)one and:(NSNumber *)anotherNumber
{
    NSNumber *result =[NSNumber numberWithInteger:[one integerValue] + [anotherNumber integerValue]];
    result = [NSNumber numberWithInteger:result.integerValue % 10];
    return result;
}

-(IBAction)showSystemAlert:(id)sender
{
    self.markContainer.hidden = YES;
    self.markContainer_hd.hidden = YES;
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
                      cell.textLabel.textColor = [UIColor whiteColor];
//                      cell.textLabel.backgroundColor =[UIColor colorWithRed:11 green:41 blue:63 alpha:1];
//                      cell.textLabel.backgroundColor = [UIColor blackColor];
                      cell.backgroundColor = [UIColor colorWithRed:11.0/255.0 green:41.0/255.0 blue:63.0/255.0 alpha:1];
                      return cell;
                  }];
    
    // Setting custom alert height
    self.alert.height = 400;
    
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex){
        //        self.resultLabel.text = [NSString stringWithFormat:@"Selected Index\nSection: %d Row: %d", selectedIndex.section, selectedIndex.row];
        if (selectedIndex.row == 3) {
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"results"];
            NSArray *results = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            GameRecordViewController *control=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"GameRecordViewController"];
            control.gameResults = results;
            [self presentViewController:control animated:YES completion:^{
                
            }];
        }
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
    self.markContainer.hidden = YES;
    self.markContainer_hd.hidden = YES;
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

- (void)showChipNotEnoughAlert
{
    if (isGameStart) {
        return;
    }
    
    NSString *title = @"百家乐";
    NSString *message = @"抱歉。您的筹码已不足";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)onSettingBtnClicked:(id)sender
{
    if (isGameStart) {
        return;
    }
    SettingViewController *control=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SettingViewController"];
    [self presentViewController:control animated:YES completion:^{
        
    }];
    
//    [self.navigationController pushViewController:control animated:YES];
}

- (IBAction)onTableChangeClicked:(id)sender
{
    if (isGameStart) {
        return;
    }
    [self playSoundByFile:@"mouse_move"];
    NSString *title = @"赌桌限制";
    NSString *message = @"閒家、庄家：100~1万\n 和：100~1千\n 對：100~1千";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"换桌" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        isGameStart = YES;
        [self resetCards];
//        [self showTableChangeFailureAlert];
    }];

    
    [alertController addAction:action];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void) showChipPresendAlert

{
    NSString *title = @"百家乐";
    NSString *message = @"您得到了免费筹码（每小时3次）";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) showTableChangeFailureAlert
{
    NSString *title = @"换桌失败";
    NSString *message = @"现在无法换桌，请稍后再试。";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
