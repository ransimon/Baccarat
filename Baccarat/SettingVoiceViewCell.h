//
//  SettingVoiceViewCell.h
//  Baccarat
//
//  Created by chenran on 16/7/2.
//  Copyright © 2016年 simon. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SettingVoiceViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *valueSwitch;
@property (strong, nonatomic) NSNumber *type;

- (IBAction)onValueChanged:(UISwitch *)sender;

@end
