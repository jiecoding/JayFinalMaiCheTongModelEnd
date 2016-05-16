//
//  LYCComparisonVC.m
//  LaiYongChe
//
//  Created by laiyongche on 16/5/11.
//  Copyright © 2016年 laiyongche. All rights reserved.
//

#import "LYCComparisonVC.h"
#import "Constants.h"
#import "UIView+WLFrame.h"
#import "LYCFriendsHelpCarVC.h"

@interface LYCComparisonVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LYCComparisonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"车型对比";
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = VCDefaultBgColor;
    [self addViews];
}

- (void)addViews
{
    UIButton *addComparisonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addComparisonBtn setBackgroundImage:[UIImage imageNamed:@"Comparison_Btn"] forState:UIControlStateNormal];
    [addComparisonBtn setTitle:@"添加对比" forState:UIControlStateNormal];
    addComparisonBtn.frame = CGRectMake(0, 64,self.view.width, 60);
    [addComparisonBtn addTarget:self action:@selector(pushFriendsHelpVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addComparisonBtn];
    
    UITableView *_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, addComparisonBtn.bottom + 10, self.view.width, self.view.height - addComparisonBtn.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
}

- (void)pushFriendsHelpVC
{
    LYCFriendsHelpCarVC *friendHelpVC =[[LYCFriendsHelpCarVC alloc] init];
    
    [self.navigationController pushViewController:friendHelpVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *CELLDI = @"CELLDI";
    
    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:CELLDI];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLDI];
    }
    cell.textLabel.text = @"测试 车型对比";
    return cell;
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
