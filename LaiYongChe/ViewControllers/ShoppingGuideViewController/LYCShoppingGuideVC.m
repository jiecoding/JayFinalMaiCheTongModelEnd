//
//  LYCShoppingGuideVC.m
//  LaiYongChe
//
//  Created by laiyongche on 16/5/11.
//  Copyright © 2016年 laiyongche. All rights reserved.
//

#import "LYCShoppingGuideVC.h"
#import "Constants.h"
#import "WJSegmentMenuVc.h"
#import "LYCShoppingGuideTableVC.h"
@interface LYCShoppingGuideVC ()

@end

@implementation LYCShoppingGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新车导购";
    
    self.view.backgroundColor = VCDefaultBgColor;
    
    
    [self createWJSegmentMenuVc];
}

- (void)createWJSegmentMenuVc
{
    /* 创建WJSegmentMenuVc */
    WJSegmentMenuVc *segmentMenuVc2 = [[WJSegmentMenuVc alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 60)];
    
    [self.view addSubview:segmentMenuVc2];
    
    /* 自定义设置(可不设置为默认值) */
    segmentMenuVc2.backgroundColor = [UIColor whiteColor];
    segmentMenuVc2.titleFont = [UIFont systemFontOfSize:13];
    segmentMenuVc2.unlSelectedColor = [UIColor greenColor];
    segmentMenuVc2.selectedColor = [UIColor yellowColor];
    segmentMenuVc2.MenuVcSlideType = WJSegmentMenuVcSlideTypeSlide;
    segmentMenuVc2.SlideColor = [UIColor blueColor];
    segmentMenuVc2.advanceLoadNextVc = NO;
    
    /* 创建测试数据 */
    
    LYCShoppingGuideTableVC  *shoppingGuideTVC = [[LYCShoppingGuideTableVC alloc]init];
    shoppingGuideTVC.carLevel = 1;
    
    LYCShoppingGuideTableVC  *shoppingGuideTVC2 = [[LYCShoppingGuideTableVC alloc]init];
    shoppingGuideTVC2.carLevel = 2;
    
    
    NSArray *vcArr = @[shoppingGuideTVC,shoppingGuideTVC2];
    //对应
    NSArray *titles = @[@"11111",@"2222"];
    /* 导入数据 */
    [segmentMenuVc2 addSubVc:vcArr subTitles:titles];

    
    
    
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

@end
