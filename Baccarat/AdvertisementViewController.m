//
//  AdvertisementViewController.m
//  Baccarat
//
//  Created by chenran on 16/7/6.
//  Copyright © 2016年 simon. All rights reserved.
//

#import "AdvertisementViewController.h"

@interface AdvertisementViewController ()
- (IBAction)onBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation AdvertisementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.indicatorView startAnimating];
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

- (IBAction)onBackClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
