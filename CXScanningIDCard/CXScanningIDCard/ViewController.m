//
//  ViewController.m
//  CXScanningIDCard
//
//  Created by 曹翔 on 2019/7/31.
//  Copyright © 2019 CX. All rights reserved.
//

#import "ViewController.h"
#import "CXScanningCardVC.h"

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic,weak)      UIButton        *scanBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份证识别";
    [self initSubViews];
}

-(void)initSubViews{
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.scanBtn = scanBtn;
    [scanBtn addTarget:self action:@selector(scanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scanBtn setTitle:@"身份证识别" forState:UIControlStateNormal];
    scanBtn.backgroundColor = [UIColor redColor];
    scanBtn.bounds = CGRectMake(0, 0, 200, 50);
    scanBtn.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    [self.view addSubview:scanBtn];
    
    
    
    
}

-(void)scanBtnClick{
    [self.navigationController pushViewController:[[CXScanningCardVC alloc] init] animated:YES];
}


@end
