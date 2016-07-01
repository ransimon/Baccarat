//
//  GameRecordViewController.m
//  Baccarat
//
//  Created by chenran on 16/6/30.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "GameRecordViewController.h"
#import "GameRecordCellTableViewCell.h"
#import "GameRecorderInfo.h"


@interface GameRecordViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)onBackBtnClicked:(id)sender;

@end

@implementation GameRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.gameResults == nil) {
        return 0;
    } else {
        return self.gameResults.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GameRecordCellTableViewCell";
    GameRecordCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[GameRecordCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    GameRecorderInfo *info = [self.gameResults objectAtIndex:indexPath.row];
    cell.scoreLabel.text = [NSString stringWithFormat:@"%@.0", info.score];
    cell.timeLabel.text = info.time;
    cell.numberLabel.text = [NSString stringWithFormat:@"%d", self.gameResults.count - indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onBackBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
