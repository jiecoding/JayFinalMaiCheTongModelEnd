//
//  LYCPriceQuotationVC.m
//  LaiYongChe
//
//  Created by laiyongche on 16/5/10.
//  Copyright © 2016年 laiyongche. All rights reserved.
//

#import "LYCPriceQuotationVC.h"
#import "WJSegmentMenuVc.h"

#import "LYCPriceQuotationTableVC.h"

#import "Constants.h"
@interface LYCPriceQuotationVC ()

@end

@implementation LYCPriceQuotationVC

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    
    self.view.backgroundColor = VCDefaultBgColor;
    
    self.title = @"降价";
    
    [self createSegmentMenuHVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
}

- (void)createSegmentMenuHVC
{
    /* 创建WJSegmentMenuVc */
    WJSegmentMenuVc *segmentMenuVc2 = [[WJSegmentMenuVc alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 60)];
    [self.view addSubview:segmentMenuVc2];
    
    /* 自定义设置(可不设置为默认值) */
    segmentMenuVc2.backgroundColor = [UIColor redColor];
    segmentMenuVc2.titleFont = [UIFont systemFontOfSize:13];
    segmentMenuVc2.unlSelectedColor = [UIColor greenColor];
    segmentMenuVc2.selectedColor = [UIColor yellowColor];
    segmentMenuVc2.MenuVcSlideType = WJSegmentMenuVcSlideTypeCaver;
    segmentMenuVc2.SlideColor = [UIColor blueColor];
    segmentMenuVc2.advanceLoadNextVc = NO;
    
    /* 创建测试数据 */
    
    LYCPriceQuotationTableVC  *priceQuotation = [[LYCPriceQuotationTableVC alloc]init];
    priceQuotation.carLevel = 1;
    
    LYCPriceQuotationTableVC  *priceQuotation2 = [[LYCPriceQuotationTableVC alloc]init];
    priceQuotation2.carLevel = 2;


    NSArray *vcArr = @[priceQuotation,priceQuotation2];
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
