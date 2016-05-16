//
//  LYCPriceQuotationTableVC.m
//  LaiYongChe
//
//  Created by laiyongche on 16/5/10.
//  Copyright © 2016年 laiyongche. All rights reserved.
//

#import "LYCPriceQuotationTableVC.h"

#import "Constants.h"

#import "PriceQuotationCell.h"

#import "LYCPriceQuotationViewModel.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import "LYCPriceQuotationModel.h"

#import "UIImageView+WebCache.h"


@interface LYCPriceQuotationTableVC ()<MBProgressHUDDelegate>
{
    MBProgressHUD *MBProgHUD;
    NSMutableArray *_priceQuotationListArr;
    LYCPriceQuotationModel *_priceQuotationModel;
}
@end

@implementation LYCPriceQuotationTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _priceQuotationModel = [[LYCPriceQuotationModel alloc] init];
    
    _priceQuotationListArr = [NSMutableArray array];
    
    self.view.backgroundColor = VCDefaultBgColor;

    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self dataAccess];
}

- (void)dataAccess
{
    LYCPriceQuotationViewModel *quotationViewModel = [[LYCPriceQuotationViewModel alloc] init];
    quotationViewModel.cityId = @"1";
    quotationViewModel.pageSize = @"10";
    quotationViewModel.carLevel = [NSString stringWithFormat:@"%d",self.carLevel];
    quotationViewModel.pageNo = [NSString stringWithFormat:@"%d",1];
    
    MBProgHUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    MBProgHUD.delegate = self;
    
    [MBProgHUD show:YES];
    [quotationViewModel handleDataWithSuccess:^(NSArray *arr) {
//        [_priceQuotationListArr removeAllObjects];
        
        [_priceQuotationListArr addObjectsFromArray:arr];
        
        [MBProgHUD hide:YES];
        
        [self.tableView reloadData];
        //数组里存的是buycarlistmodel
//        DLog(@"_priceQuotationListArr success%ld",_priceQuotationListArr.count);
    } failure:^(NSError *err) {
        DLog(@"buy CarViewModel failure %@",err);
        [MBProgHUD hide:YES];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _priceQuotationListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"PriceQuotationCell";
    //自定义cell类
    PriceQuotationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PriceQuotationCell" owner:self options:nil] lastObject];
    }
    
//
    _priceQuotationModel = _priceQuotationListArr[indexPath.row];

    NSString *urlStr = _priceQuotationModel.imagePath;
    
    NSLog(@"降价车的图片地址: %@",urlStr);
    
    [cell.carImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"quotationImage"]];
    
    cell.timeLabel.text = _priceQuotationModel.time;
    
    cell.ldescribe.text = _priceQuotationModel.title;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
