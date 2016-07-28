//
//  SettingViewController.m
//  Baccarat
//
//  Created by chenran on 16/6/26.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingViewCell.h"
#import "SettingVoiceViewController.h"
#import "SettingGameSpeedViewController.h"
#import "SettingChangeColorViewController.h"
#import "SettingStartStyleViewController.h"
#import "SettingLangueageViewController.h"

@interface SettingViewController ()<UITabBarDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
- (IBAction)onBackClicked:(id)sender;

@end

@implementation SettingViewController
{
    NSInteger gameSpeed;
    NSInteger color;
    NSInteger style;
    NSInteger langueage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registNotification];
    [self onValueChanged];
    // Do any additional setup after loading the view.
    
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
    gameSpeed = [[NSUserDefaults standardUserDefaults] integerForKey:@"gameSpeed"];
    color = [[NSUserDefaults standardUserDefaults] integerForKey:@"color"];
    style = [[NSUserDefaults standardUserDefaults] integerForKey:@"style"];
    langueage = [[NSUserDefaults standardUserDefaults] integerForKey:@"langueage"];
    [self.tabelView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingViewCell";
    SettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[SettingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"声音和震动";
        cell.valueLabel.text = @"";
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"游戏速度";
        if (gameSpeed == 0) {
            cell.valueLabel.text = @"慢";
        } else if (gameSpeed == 1) {
            cell.valueLabel.text = @"普通";
        } else {
            cell.valueLabel.text = @"快";
        }
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"记分牌颜色";
        if (color == 0 ) {
            cell.valueLabel.text = @"闲家 蓝";
        } else {
            cell.valueLabel.text = @"闲家 红";
        }
    } else if (indexPath.row == 3) {
        cell.titleLabel.text = @"开牌方式";
        if (style == 0) {
            cell.valueLabel.text = @"自动";
        } else {
            cell.valueLabel.text = @"点击&滑动(超过最低值一千以上)";
        }
    } else if (indexPath.row == 4) {
        cell.titleLabel.text = @"布局语言";
        if (langueage == 0) {
            cell.valueLabel.text = @"汉语";
        } else {
            cell.valueLabel.text = @"英语";
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        SettingVoiceViewController *control=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SettingVoiceViewController"];
        [self presentViewController:control animated:YES completion:^{
            
        }];
    } else if (indexPath.row == 1) {
        SettingGameSpeedViewController *control=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SettingGameSpeedViewController"];
        [self presentViewController:control animated:YES completion:^{
            
        }];
    } else if (indexPath.row == 2) {
        SettingChangeColorViewController *control=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SettingChangeColorViewController"];
        [self presentViewController:control animated:YES completion:^{
            
        }];
    } else if (indexPath.row == 3) {
        SettingStartStyleViewController *control=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SettingStartStyleViewController"];
        [self presentViewController:control animated:YES completion:^{
            
        }];
    } else if (indexPath.row == 4) {
        SettingLangueageViewController *control=[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SettingLangueageViewController"];
        [self presentViewController:control animated:YES completion:^{
            
        }];

    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onBackClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
