//
//  SettingVoiceViewCell.m
//  Baccarat
//
//  Created by chenran on 16/7/2.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "SettingVoiceViewCell.h"

@implementation SettingVoiceViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onValueChanged:(UISwitch *)sender {
    if (self.type.integerValue == 0) {
        if (sender.isOn) {
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"voiceSwitch"];
        } else {
            [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"voiceSwitch"];
        }
        
    } else if (self.type.integerValue == 1) {
        if (sender.isOn) {
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"soundSwitch"];
        } else {
            [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"soundSwitch"];
        }
    } else {
        if (sender.isOn) {
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"shakeSwitch"];
        } else {
            [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"shakeSwitch"];
        }
    }
}
@end
