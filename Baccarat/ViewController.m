//
//  ViewController.m
//  Baccarat
//
//  Created by chenran on 16/5/22.
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
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *chip100Img;
@property (weak, nonatomic) IBOutlet UIImageView *chip500Img;
@property (weak, nonatomic) IBOutlet UIImageView *chip1000Img;
@property (weak, nonatomic) IBOutlet UIImageView *chip5000Img;
@property (weak, nonatomic) IBOutlet UIImageView *chip10000Img;
@property (weak, nonatomic) IBOutlet UIView *bottomOperationLayout;

@property (weak, nonatomic) IBOutlet ChipBoardView *playerDoubleView;
@property (weak, nonatomic) IBOutlet ChipBoardView *sameView;
@property (weak, nonatomic) IBOutlet ChipBoardView *bankerDoubleView;
@property (weak, nonatomic) IBOutlet ChipBoardView *playerView;
@property (weak, nonatomic) IBOutlet ChipBoardView *bankerView;

@property (weak, nonatomic) IBOutlet UIView *playerViewFlag;
@property (weak, nonatomic) IBOutlet UIView *bankerViewFlag;

@property (weak, nonatomic) IBOutlet UIImageView *playerCard_1;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard_2;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard_3;
@property (weak, nonatomic) IBOutlet UIImageView *bankerCard_1;
@property (weak, nonatomic) IBOutlet UIImageView *bankerCard_2;
@property (weak, nonatomic) IBOutlet UIImageView *bankerCard_3;

@property (weak, nonatomic) IBOutlet UIImageView *cardBg_1;
@property (weak, nonatomic) IBOutlet UIImageView *cardBg_2;
@property (weak, nonatomic) IBOutlet UIImageView *cardBg_3;
@property (weak, nonatomic) IBOutlet UIImageView *cardBg_4;
@property (weak, nonatomic) IBOutlet UIImageView *cardBg_5;
@property (weak, nonatomic) IBOutlet UIImageView *cardBg_6;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImage;

@property (weak, nonatomic) IBOutlet UIImageView *potBtn;
@property (weak, nonatomic) IBOutlet UIImageView *recycelBtn;

@property (weak, nonatomic) IBOutlet UIView *cutCardsContainer;
@property (weak, nonatomic) IBOutlet UIImageView *cutPointView;

@property (strong, nonatomic) UIImageView *chip100Float;
@property (strong, nonatomic) UIImageView *chip500Float;
@property (strong, nonatomic) UIImageView *chip1000Float;
@property (strong, nonatomic) UIImageView *chip5000Float;
@property (strong, nonatomic) UIImageView *chip10000Float;

@property (strong, nonatomic) UIImageView *selectChipFloat;

@property (strong, nonatomic) UIImageView *totalPlayerChipView;
@property (strong, nonatomic) UIImageView *totalBankerChipView;
@property (strong, nonatomic) UIImageView *totalPlayerDoubleChipView;
@property (strong, nonatomic) UIImageView *totalBankerDoubleChipView;
@property (strong, nonatomic) UIImageView *totalSameChipView;

@property (strong, nonatomic) UIImageView *cardsView;
@property (strong, nonatomic) UIImageView *cutCardsView;

@property (strong, nonatomic) UIImageView *cutCardsView1;
@property (strong, nonatomic) UIImageView *cutCardsView2;

@property (strong, nonatomic) UIView *burningCardContainer1;
@property (strong, nonatomic) UIView *burningCardContainer2;



@property (nonatomic, strong) CardsBuilder *cardsBuilder;
@property (nonatomic, strong) ResultBuilder *resultBuilder;

@property (nonatomic, strong) NSArray *currentGameCards;

@property (nonatomic, strong) NSArray *evaluteViews;


@property (nonatomic, strong) NSNumber *playerPoint;
@property (nonatomic, strong) NSNumber *bankerPoint;


@property (nonatomic, strong) NSNumber *animationDuration;

@property (nonatomic, strong) CABasicAnimation *anim1;
@property (nonatomic, strong) CABasicAnimation *anim2;
@property (nonatomic, strong) CABasicAnimation *anim3;
@property (nonatomic, strong) CABasicAnimation *anim4;
@property (nonatomic, strong) CABasicAnimation *anim5;
@property (nonatomic, strong) CABasicAnimation *anim6;


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
    CGFloat cutCardsView_X;
    BOOL isChanged;
    BOOL isOpenSound;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.cardsBuilder = [CardsBuilder shareObject];
    self.resultBuilder = [ResultBuilder shareObject];
    [self.resultBuilder resetResultByPoint:[NSNumber numberWithInteger:0]];
    self.evaluteViews = [[NSMutableArray alloc]init];
    cardBgX = self.cardBg_1.center.x;
    cardBgY = self.cardBg_1.center.y;
    playerCard_y = self.playerCard_1.center.y;
    bankerCard_y = self.bankerCard_1.center.y;
    animationTime = 0.6;
    totalScore = 10000;
    isOpenSound = YES;
    self.animationDuration = [NSNumber numberWithInteger:1];
    [self initEvaluteViews];
    [self initFloatingChipView];
    [self configUi];
    [self updateScore];
    self.chip100Img.highlighted = YES;
    self.selectChipFloat = _chip100Float;
    chipCenterX = self.chip100Img.center.x;
    chipCenterY = self.chip100Img.center.y;
    [self playVoiceByFile:@"WelcomeToTheTable_cn"];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(cutCard) userInfo:nil repeats:NO];//切卡
}

- (void) initFloatingChipView
{
    _chip100Float = [[UIImageView alloc] init];
    _chip100Float.frame = CGRectMake(self.chip100Img.frame.origin.x, self.chip100Img.frame.origin.y, self.chip100Img.frame.size.width, self.chip100Img.frame.size.height);
    _chip100Float.image = [UIImage imageNamed:@"chip_100"];
    UIPanGestureRecognizer *panRecognizer1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
    _chip100Float.userInteractionEnabled = YES;
    _chip100Float.tag = 100;
    [_chip100Float addGestureRecognizer:panRecognizer1];
    
    UITapGestureRecognizer *tapRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChipTapRecognizer:)];
    [_chip100Float addGestureRecognizer:tapRecognizer1];
    
    [self.view addSubview:_chip100Float];
    
    _chip500Float = [[UIImageView alloc] init];
    _chip500Float.frame = CGRectMake(self.chip500Img.frame.origin.x, self.chip500Img.frame.origin.y, self.chip500Img.frame.size.width, self.chip500Img.frame.size.height);
    _chip500Float.image = [UIImage imageNamed:@"chip_500"];
    UIPanGestureRecognizer *panRecognizer2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
    _chip500Float.userInteractionEnabled = YES;
    _chip500Float.tag = 500;
    [_chip500Float addGestureRecognizer:panRecognizer2];
    
    UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChipTapRecognizer:)];
    [_chip500Float addGestureRecognizer:tapRecognizer2];
    
    [self.view addSubview:_chip500Float];
    
    _chip1000Float = [[UIImageView alloc] init];
    _chip1000Float.frame = CGRectMake(self.chip1000Img.frame.origin.x, self.chip1000Img.frame.origin.y, self.chip1000Img.frame.size.width, self.chip1000Img.frame.size.height);
    _chip1000Float.image = [UIImage imageNamed:@"chip_1000"];
    UIPanGestureRecognizer *panRecognizer3 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
    _chip1000Float.userInteractionEnabled = YES;
    _chip1000Float.tag = 1000;
    [_chip1000Float addGestureRecognizer:panRecognizer3];
    
    UITapGestureRecognizer *tapRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChipTapRecognizer:)];
    [_chip1000Float addGestureRecognizer:tapRecognizer3];
    
    [self.view addSubview:_chip1000Float];
    
    _chip5000Float = [[UIImageView alloc] init];
    _chip5000Float.frame = CGRectMake(self.chip5000Img.frame.origin.x, self.chip5000Img.frame.origin.y, self.chip5000Img.frame.size.width, self.chip5000Img.frame.size.height);
    _chip5000Float.image = [UIImage imageNamed:@"chip_5000"];
    UIPanGestureRecognizer *panRecognizer4 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
    _chip5000Float.userInteractionEnabled = YES;
    _chip5000Float.tag = 5000;
    [_chip5000Float addGestureRecognizer:panRecognizer4];
    
    UITapGestureRecognizer *tapRecognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChipTapRecognizer:)];
    [_chip5000Float addGestureRecognizer:tapRecognizer4];
    
    [self.view addSubview:_chip5000Float];
    
    _chip10000Float = [[UIImageView alloc] init];
    _chip10000Float.frame = CGRectMake(self.chip10000Img.frame.origin.x, self.chip10000Img.frame.origin.y, self.chip10000Img.frame.size.width, self.chip10000Img.frame.size.height);
    _chip10000Float.image = [UIImage imageNamed:@"chip_10000"];
    UIPanGestureRecognizer *panRecognizer5 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
    _chip10000Float.userInteractionEnabled = YES;
    _chip10000Float.tag = 10000;
    [_chip10000Float addGestureRecognizer:panRecognizer5];
    
    UITapGestureRecognizer *tapRecognizer5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChipTapRecognizer:)];
    [_chip10000Float addGestureRecognizer:tapRecognizer5];
    
    [self.view addSubview:_chip10000Float];
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

- (void) initEvaluteViews
{
    self.evaluteViews = @[self.playerView, self.bankerView, self.playerDoubleView, self.bankerDoubleView, self.sameView];
    
}

- (void) configUi
{
    self.cutPointView.hidden = YES;
    self.potBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPotBtnClicked:)];
    [self.potBtn addGestureRecognizer:recongnizer];
    
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
    
    [self hideAllCard];
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
    
    CGFloat top = 35; // 顶端盖高度
    CGFloat bottom = 35 ; // 底端盖高度
    CGFloat left = 35;// 左端盖宽度
    CGFloat right = 35; // 右端盖宽度
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
    
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(removeBurningCardsView) userInfo:nil repeats:NO];
}

- (void) removeBurningCardsView
{
    [self.burningCardContainer1 removeFromSuperview];
    [self.burningCardContainer2 removeFromSuperview];
    [self.cutPointView removeFromSuperview];
    [self.cutCardsContainer removeFromSuperview];
    [self playVoiceByFile:@"c_place_cn"];
}

- (void) hideAllCard
{
    self.playerCard_1.hidden = YES;
    self.playerCard_2.hidden = YES;
    self.playerCard_3.hidden = YES;
    self.bankerCard_1.hidden = YES;
    self.bankerCard_2.hidden = YES;
    self.bankerCard_3.hidden = YES;
    
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
    UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;
    if ([recongizer state] == UIGestureRecognizerStateBegan) {
        isChanged = NO;
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
        self.selectChipFloat = _chip100Float;
    } else if (view.tag == 500) {
        chipCenterX = self.chip500Img.center.x;
        chipCenterY = self.chip500Img.center.y;
        self.chip100Img.highlighted = NO;
        self.chip500Img.highlighted = YES;
        self.chip1000Img.highlighted = NO;
        self.chip5000Img.highlighted = NO;
        self.chip10000Img.highlighted = NO;
        self.selectChipFloat = _chip500Float;
    } else if (view.tag == 1000) {
        chipCenterX = self.chip1000Img.center.x;
        chipCenterY = self.chip1000Img.center.y;
        self.chip100Img.highlighted = NO;
        self.chip500Img.highlighted = NO;
        self.chip1000Img.highlighted = YES;
        self.chip5000Img.highlighted = NO;
        self.chip10000Img.highlighted = NO;
        self.selectChipFloat = _chip1000Float;
    } else if (view.tag == 5000) {
        chipCenterX = self.chip5000Img.center.x;
        chipCenterY = self.chip5000Img.center.y;
        self.chip100Img.highlighted = NO;
        self.chip500Img.highlighted = NO;
        self.chip1000Img.highlighted = NO;
        self.chip5000Img.highlighted = YES;
        self.chip10000Img.highlighted = NO;
        self.selectChipFloat = _chip5000Float;
    } else if (view.tag == 10000) {
        chipCenterX = self.chip10000Img.center.x;
        chipCenterY = self.chip10000Img.center.y;
        self.chip100Img.highlighted = NO;
        self.chip500Img.highlighted = NO;
        self.chip1000Img.highlighted = NO;
        self.chip5000Img.highlighted = NO;
        self.chip10000Img.highlighted = YES;
        self.selectChipFloat = _chip10000Float;
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
    UIPanGestureRecognizer *recongizer1 = (UIPanGestureRecognizer *)sender;
    UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;
    if ([recongizer state] == UIGestureRecognizerStateBegan)
    {
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
            if (overlappingView != nil && score < totalScore) {
                recongizer.view.center = CGPointMake(overlappingView.center.x, overlappingView.center.y);
            } else {
                recongizer.view.center = CGPointMake(chipCenterX, chipCenterY);
            }
        } completion:^(BOOL finished) {
            recongizer.view.center = CGPointMake(chipCenterX, chipCenterY);
            if (overlappingView != nil) {
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
                } else {
                    [self playSoundByFile:@"ce_chipwarn"];
                }
            }
            
        }];
    };
    
    
    [recongizer dragViewWithinView:[self view]
           evaluateViewsForOverlap:views
   containedByOverlappingViewBlock:overlappingBlock
                        completion:completionBlock];
    
}

- (IBAction)onPotBtnClicked:(id)sender
{
    [self startGame];
}

- (IBAction)onChipTableViewClicked:(id)sender
{
    UITapGestureRecognizer *recongnizer = (UITapGestureRecognizer *)sender;
    ChipBoardView * boadView = (ChipBoardView *)recongnizer.view;
    NSInteger score = self.selectChipFloat.tag;
    if (score > totalScore) {
        [self playSoundByFile:@"ce_chipwarn"];
        return;
    }
    [UIView animateWithDuration:0.3f animations:^{
        self.selectChipFloat.center = CGPointMake(boadView.center.x, boadView.center.y);
    } completion:^(BOOL finished) {
        self.selectChipFloat.center = CGPointMake(chipCenterX, chipCenterY);
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
    }];
}

- (void) startGame
{
    self.bottomOperationLayout.hidden = YES;
    self.chip100Img.hidden = YES;
    self.chip500Img.hidden = YES;
    self.chip1000Img.hidden = YES;
    self.chip5000Img.hidden = YES;
    self.chip10000Img.hidden = YES;
    self.chip100Float.hidden = YES;
    self.chip500Float.hidden = YES;
    self.chip1000Float.hidden = YES;
    self.chip5000Float.hidden = YES;
    self.chip10000Float.hidden = YES;
    
    [self takeCard];
    [self dealCard];
}

- (void) takeCard
{
    NSNumber *result = [self.resultBuilder getNextResult];
    NSArray *cards = [self.cardsBuilder getCardsByResult:result];
    if (cards != nil && (cards.count == 4 || cards.count == 5 || cards.count == 6)) {
        self.currentGameCards = cards;
    }
}

- (void) dealCard
{
    if (self.currentGameCards != nil) {
        [self initAnim];
        [self.cardBg_1.layer addAnimation:self.anim1 forKey:@"anim1"];
        [self.cardBg_2.layer addAnimation:self.anim2 forKey:@"anim2"];
        [self.cardBg_3.layer addAnimation:self.anim3 forKey:@"anim3"];
        [self.cardBg_4.layer addAnimation:self.anim4 forKey:@"anim4"];
        
        if (self.currentGameCards.count >= 5) {
            [self.cardBg_5.layer addAnimation:self.anim5 forKey:@"anim5"];
        }
        if (self.currentGameCards.count >= 6) {
            [self.cardBg_6.layer addAnimation:self.anim6 forKey:@"anim6"];
        }
    }
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString *value = [anim valueForKey:@"anim"];
    if ([value isEqual:@"anim1"]) {
        Card *card = [self.currentGameCards objectAtIndex:0];
        [self playVoiceByFile:@"Players_cn"];
        self.playerCard_1.hidden = NO;
        self.playerCard_1.image = [UIImage imageNamed:card.resId];
    } else if ([value isEqual:@"anim2"]) {
        [self playVoiceByFile:@"Bankers_cn"];
        Card *card = [self.currentGameCards objectAtIndex:1];
        self.bankerCard_1.hidden = NO;
        self.bankerCard_1.image = [UIImage imageNamed:card.resId];
    }else if ([value isEqual:@"anim3"]) {
        [self playVoiceByFile:@"Players_cn"];
        Card *card = [self.currentGameCards objectAtIndex:2];
        self.playerCard_2.hidden = NO;
        self.playerCard_2.image = [UIImage imageNamed:card.resId];
    }else if ([value isEqual:@"anim4"]) {
        [self playVoiceByFile:@"Bankers_cn"];
        Card *card = [self.currentGameCards objectAtIndex:3];
        self.bankerCard_2.hidden = NO;
        self.bankerCard_2.image = [UIImage imageNamed:card.resId];
        if (self.currentGameCards.count == 4) {
            [self gameFinish];
        }
    }else if ([value isEqual:@"anim5"]) {
        [self playVoiceByFile:@"ba_1c2p_cn"];
        Card *card = [self.currentGameCards objectAtIndex:4];
        self.playerCard_3.hidden = NO;
        self.playerCard_3.image = [UIImage imageNamed:card.resId];
        if (self.currentGameCards.count == 5) {
            [self gameFinish];
        }
    }else if ([value isEqual:@"anim6"]) {
        [self playVoiceByFile:@"ba_1c2b_cn"];
        Card *card = [self.currentGameCards objectAtIndex:5];
        self.bankerCard_3.hidden = NO;
        self.bankerCard_3.image = [UIImage imageNamed:card.resId];
        if (self.currentGameCards.count == 6) {
            [self gameFinish];
        }
    }
}
- (void) gameFinish
{
    Card *card1 = [self.currentGameCards objectAtIndex:0];
    Card *card2 = [self.currentGameCards objectAtIndex:1];
    Card *card3 = [self.currentGameCards objectAtIndex:2];
    Card *card4 = [self.currentGameCards objectAtIndex:3];
    Card *card5 = nil;
    Card *card6 = nil;
    
    NSNumber *playerPoint = [self add:card1.validPoint and:card3.validPoint];
    NSNumber *bankerPoint = [self add:card2.validPoint and:card4.validPoint];
    if (self.currentGameCards.count >= 5) {
        card5 = [self.currentGameCards objectAtIndex:4];
        playerPoint = [self add:playerPoint and:card5.validPoint];
    }
    
    if (self.currentGameCards.count >= 6) {
        card6 = [self.currentGameCards objectAtIndex:5];
        bankerPoint = [self add:bankerPoint and:card6.validPoint];
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"Players_cn" forKey:@"sound"];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic repeats:NO];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:[self getVoiceNameByBumber:playerPoint] forKey:@"sound"];
    [NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic1 repeats:NO];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:@"Bankers_cn" forKey:@"sound"];
    [NSTimer scheduledTimerWithTimeInterval:3.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic2 repeats:NO];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:[self getVoiceNameByBumber:bankerPoint] forKey:@"sound"];
    [NSTimer scheduledTimerWithTimeInterval:4.5f target:self selector:@selector(playVoiceByFileDelay:) userInfo:dic3 repeats:NO];
    
    if (playerPoint.integerValue > bankerPoint.integerValue) {
        
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
        [NSTimer scheduledTimerWithTimeInterval:9.5f target:self selector:@selector(resetState) userInfo:nil repeats:NO];
    } else if (playerPoint.integerValue < bankerPoint.integerValue){
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
        [NSTimer scheduledTimerWithTimeInterval:9.5f target:self selector:@selector(resetState) userInfo:nil repeats:NO];
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
        [NSTimer scheduledTimerWithTimeInterval:9.5f target:self selector:@selector(resetState) userInfo:nil repeats:NO];
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

- (void) resetState
{
    //删除动画
    [self.playerCard_1.layer removeAllAnimations];
    [self.playerCard_2.layer removeAllAnimations];
    [self.playerCard_3.layer removeAllAnimations];
    [self.bankerCard_1.layer removeAllAnimations];
    [self.bankerCard_2.layer removeAllAnimations];
    [self.bankerCard_3.layer removeAllAnimations];
    
    //隐藏所有卡牌
    [self hideAllCard];
    
    //隐藏筹码
    self.playerView.chipView.hidden = YES;
    self.bankerView.chipView.hidden = YES;
    self.playerDoubleView.chipView.hidden = YES;
    self.bankerDoubleView.chipView.hidden = YES;
    self.sameView.chipView.hidden = YES;
    
    //显示底部
    self.bottomOperationLayout.hidden = NO;
    self.chip100Img.hidden = NO;
    self.chip500Img.hidden = NO;
    self.chip1000Img.hidden = NO;
    self.chip5000Img.hidden = NO;
    self.chip10000Img.hidden = NO;
    self.chip100Float.hidden = NO;
    self.chip500Float.hidden = NO;
    self.chip1000Float.hidden = NO;
    self.chip5000Float.hidden = NO;
    self.chip10000Float.hidden = NO;
    
    //押注筹码重置为0
    playerScore = self.playerView.chipView.tag;
    self.playerView.chipView = nil;
    bankerScore = self.bankerView.chipView.tag;
    self.bankerView.chipView = nil;
    playerDoubleScore = self.playerDoubleView.chipView.tag;
    self.playerDoubleView.chipView = nil;
    bankerDoubleScore = self.bankerDoubleView.chipView.tag;
    self.bankerDoubleView.chipView = nil;
    sameScore = self.sameView.chipView.tag;
    self.sameView.chipView = nil;
    
    //请下注
    [self playVoiceByFile:@"c_place_cn"];
    
}

-(NSNumber*)add:(NSNumber *)one and:(NSNumber *)anotherNumber
{
    NSNumber *result =[NSNumber numberWithInteger:[one integerValue] + [anotherNumber integerValue]];
    result = [NSNumber numberWithInteger:result.integerValue % 10];
    return result;
}
@end
