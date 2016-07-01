//
//  SettingVoiceViewController.m
//  Baccarat
//
//  Created by chenran on 16/7/2.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "SettingVoiceViewController.h"
#import "SettingVoiceViewCell.h"

@interface SettingVoiceViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SettingVoiceViewController
{
    NSInteger voiceSwitch;
    NSInteger soundSwitch;
    NSInteger shakeSwitch;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    voiceSwitch = [[NSUserDefaults standardUserDefaults] integerForKey:@"voiceSwitch"];
    soundSwitch = [[NSUserDefaults standardUserDefaults] integerForKey:@"soundSwitch"];
    shakeSwitch = [[NSUserDefaults standardUserDefaults] integerForKey:@"shakeSwitch"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingVoiceViewCell";
    SettingVoiceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[SettingVoiceViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"语音";
        if (voiceSwitch == 2) {
            [cell.valueSwitch setOn:NO];
        } else {
            [cell.valueSwitch setOn:YES];
        }
        cell.type = [NSNumber numberWithInteger:0];
    } else if (indexPath.row == 1) {
        cell.nameLabel.text = @"效果";
        if (soundSwitch == 2) {
            [cell.valueSwitch setOn:NO];
        } else {
            [cell.valueSwitch setOn:YES];
        }
        cell.type = [NSNumber numberWithInteger:1];
    } else if (indexPath.row == 2) {
        cell.nameLabel.text = @"震动";
        if (shakeSwitch == 2) {
            [cell.valueSwitch setOn:NO];
        } else {
            [cell.valueSwitch setOn:YES];
        }
        cell.type = [NSNumber numberWithInteger:2];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        
    } else if (indexPath.row == 2) {
        
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
