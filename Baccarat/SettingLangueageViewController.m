//
//  SettingLangueageViewController.m
//  Baccarat
//
//  Created by chenran on 16/7/22.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "SettingLangueageViewController.h"
#import "SettingGameSpeedViewCell.h"

@interface SettingLangueageViewController ()

@end

@interface SettingLangueageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
- (IBAction)onBackClicked:(id)sender;

@end

@implementation SettingLangueageViewController
{
    NSInteger langueage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    langueage = [[NSUserDefaults standardUserDefaults] integerForKey:@"langueage"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingGameSpeedViewCell";
    SettingGameSpeedViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[SettingGameSpeedViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"汉语";
        if (langueage == 0) {
            cell.labelImage.hidden = NO;
        } else {
            cell.labelImage.hidden = YES;
        }
    } else if (indexPath.row == 1) {
        cell.nameLabel.text = @"英语";
        
        if (langueage == 1) {
            cell.labelImage.hidden = NO;
        } else {
            cell.labelImage.hidden = YES;
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        langueage = 0;
    } else if (indexPath.row == 1) {
        langueage = 1;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:langueage forKey:@"langueage"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onValueChanged"
                                                        object:nil];
    [self.tabelView reloadData];
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