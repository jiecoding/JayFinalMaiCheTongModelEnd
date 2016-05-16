//
//  LYCBottomSliderController.m
//  BuyCarLYC
//
//  Created by laiyongche on 16/4/28.
//  Copyright © 2016年 LYC. All rights reserved.
//

#import "LYCBottomSliderController.h"
#import "LYCTabBarController.h"
#import "UIView+SHCZExt.h"
#import "ZYWSideView.h"
#import "Constants.h"

#import "LYCSearchViewController.h"
#import "LYCPriceQuotationVC.h"
#import "LYCShoppingGuideVC.h"
#import "LYCComparisonVC.h"

@interface LYCBottomSliderController ()<ZYWSideViewDelegate>
{
    //是否点击展开了侧滑菜单
    BOOL _isTap;
    LYCTabBarController *_MVC;
}
@property UISwipeGestureRecognizer *leftRecognizer;
@property UISwipeGestureRecognizer *rightRecognizer;

@end
@implementation LYCBottomSliderController
 
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad
{
    
    self.view.backgroundColor = [UIColor clearColor];
    _isTap = NO;

    [self addSubViews];
    [self addRecognizer];
    
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0f green:233/255.0f blue:235/255.0f alpha:1];
    
}

//添加子视图
-(void)addSubViews{
    
    //在self.view上创建一个透明的View  作为leftView
    ZYWSideView *sliderLeftView=[[ZYWSideView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width*0.35,self.view.bounds.size.height)];
    
    sliderLeftView.delegate = self;
    //添加
    [self.view addSubview:sliderLeftView];
    
    [self addTabbarController];

}

- (void)didSideViewLeftBtnEvent:(NSInteger)btnTag
{
    
    LYCSearchViewController *searchVC = [[LYCSearchViewController alloc] init];
    LYCPriceQuotationVC *priceQVC = [[LYCPriceQuotationVC alloc] init];
    LYCShoppingGuideVC *lycShoppingVC = [[LYCShoppingGuideVC alloc] init];
    LYCComparisonVC *comparisonVC = [[LYCComparisonVC alloc] init];
    
    
    //b页面变返回要在a页面这样写
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
//    backButtonItem.title = @"返回";
    backButtonItem.title = @"";

    self.navigationItem.backBarButtonItem = backButtonItem;
    
    
    switch (btnTag) {
        case 100:
            // 里面实现对应得button 点击方法
            DLog(@"搜索车系");
            [self.navigationController  pushViewController:searchVC animated:YES];
            
            break;
        case 101:
            [self.navigationController pushViewController:priceQVC animated:YES];
            DLog(@"降价行情");
            break;

        case 102:
            [self.navigationController pushViewController:lycShoppingVC animated:YES];
            DLog(@"新车导购");
            break;

        case 103:
            [self.navigationController pushViewController:comparisonVC animated:YES];
            DLog(@"车型对比");
            break;

        case 104:
            DLog(@"预约试驾");
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.laiyongche.com"]];

            break;
        default:
            break;
    }
}

//添加主控制器（tabbarcontroller）的View

-(void)addTabbarController{
    
    _MVC = [[LYCTabBarController alloc] init];
    
    //  添加子控制器 - 保证响应者链条的正确传递
    [self addChildViewController:_MVC];
    
    //  将 MVC 的视图，添加到 self.view 上
    [self.view addSubview:_MVC.view];
    
    _MVC.view.frame = self.view.bounds;
    
    //待优化 [
    UILabel *label = [[UILabel alloc] init];
    CGFloat ff = self.view.frame.size.height / 4 ;
    label.frame = CGRectMake(0, 0, 0, ff);
    //待优化 ]
    //添加左上角点击展开按钮
    _tapShowLeftVCbtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    _tapShowLeftVCbtn.frame =CGRectMake(0,label.center.y -60, 100, 100);
    
    [_tapShowLeftVCbtn addTarget:self action:@selector(didTapEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [_tapShowLeftVCbtn setImage:[UIImage imageNamed:@"sliderTapBtnBg"] forState:UIControlStateNormal];
    
    [_MVC.view addSubview:_tapShowLeftVCbtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSliderTapBtn)name:@"showSliderTapBtn"object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideSliderTapBtn)name:@"hideSliderTapBtn"object:nil];

    
}

- (void)showSliderTapBtn
{
    _tapShowLeftVCbtn.alpha = 1;
}

- (void)hideSliderTapBtn
{
    _tapShowLeftVCbtn.alpha = 0;
}


- (void)didTapEvent:(UIButton *)btn
{
    _isTap = !_isTap;
    if (_isTap) {
        [UIView animateWithDuration:0.5 animations:^{
            _MVC.view.frame = CGRectMake(self.view.frame.size.width*0.35, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            [self.view removeGestureRecognizer:_rightRecognizer];
            [self.view addGestureRecognizer:_leftRecognizer];
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            _MVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            [self.view removeGestureRecognizer:_leftRecognizer];
            [self.view addGestureRecognizer:_rightRecognizer];
            
        }];
        
    }
}

//添加手势
-(void)addRecognizer{
    //  向左
    _leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didPanEvent:)];
    _leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:_leftRecognizer];
    
    _rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightPanEvent:)];
    _rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:_rightRecognizer];

     _isTap = NO;
}


//实现拖拽
-(void)didPanEvent:(UIPanGestureRecognizer *)recognizer{
    [UIView animateWithDuration:0.3 animations:^{
        _MVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [self.view removeGestureRecognizer:_leftRecognizer];
        [self.view addGestureRecognizer:_rightRecognizer];
    }];
    
    _isTap = YES;
}
-(void)rightPanEvent:(UIPanGestureRecognizer *)recognizer{
    [UIView animateWithDuration:0.3 animations:^{
        _MVC.view.frame = CGRectMake(self.view.frame.size.width*0.35, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [self.view removeGestureRecognizer:_rightRecognizer];
        [self.view addGestureRecognizer:_leftRecognizer];

    }];
    _isTap = YES;

}


@end
