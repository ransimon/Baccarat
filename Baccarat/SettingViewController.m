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

@interface SettingViewController ()<UITabBarDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
- (IBAction)onBackClicked:(id)sender;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"游戏速度";
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"记分牌颜色";
        cell.valueLabel.text = @"闲家 红";
    } else if (indexPath.row == 3) {
        cell.titleLabel.text = @"开牌方式";
        cell.valueLabel.text = @"点击&滑动(超过最低值一千以上)";
    } else if (indexPath.row == 4) {
        cell.titleLabel.text = @"布局语言";
        cell.valueLabel.text = @"汉语";
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
        
    } else if (indexPath.row == 2) {
        
    } else if (indexPath.row == 3) {
        
    } else if (indexPath.row == 4) {
        
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
