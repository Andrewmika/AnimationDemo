//
//  DashboardViewController.m
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/11.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import "DashboardViewController.h"
#import "DashboardView.h"

@interface DashboardViewController ()
@property (nonatomic, strong)  DashboardView  *dashboard; // <##>
@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dashboard = [[DashboardView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.dashboard.center = self.view.center;
    [self.view addSubview:self.dashboard];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(0, 0, 50, 50);
    button.center = CGPointMake(self.dashboard.center.x, self.dashboard.center.y + 150);
    [button addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickAction {
    [self.dashboard animatePointWithAngle:arc4random() % 11 * 0.1 * M_PI];
}

@end
