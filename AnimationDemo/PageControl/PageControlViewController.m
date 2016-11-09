//
//  PageControlViewController.m
//  AnimationDemo
//
//  Created by Andrew Shen on 2016/11/7.
//  Copyright © 2016年 AndrewShen. All rights reserved.
//

#import "PageControlViewController.h"
#import "ADSPageControl.h"
#import <Masonry/Masonry.h>

@interface PageControlViewController ()
@property (nonatomic, strong)  ADSPageControl  *pageControl; // <##>
@end

@implementation PageControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configElements];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Interface Method

#pragma mark - Private Method

// 设置元素控件
- (void)configElements {
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn addTarget:self action:@selector(changeIndex) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.height.mas_equalTo(50);
    }];
    // 设置数据
    [self configData];
    
    // 设置约束
    [self configConstraints];
}

// 设置数据
- (void)configData {
    
}

// 设置约束
- (void)configConstraints {
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, 5, 20, 5));
        make.height.mas_equalTo(10);
    }];
}


#pragma mark - Event Response

- (void)changeIndex {
    NSInteger index = arc4random() % 6;
    [self.pageControl animateAtIndex:index];
}

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Init

- (ADSPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [ADSPageControl new];
    }
    return _pageControl;
}

@end
