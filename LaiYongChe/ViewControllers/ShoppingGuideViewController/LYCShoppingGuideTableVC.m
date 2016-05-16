//
//  LYCShoppingGuideTableVC.m
//  LaiYongChe
//
//  Created by laiyongche on 16/5/11.
//  Copyright © 2016年 laiyongche. All rights reserved.
//

#import "LYCShoppingGuideTableVC.h"

#import "PriceQuotationCell.h"

#import "LYCShoppingGuideViewModel.h"

#import "LYCShowpingModel.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import "Constants.h"

#import "UIImageView+WebCache.h"
@interface LYCShoppingGuideTableVC ()<MBProgressHUDDelegate>
{
    MBProgressHUD *MBProgHUD;
    NSMutableArray *_shoppingListArr;
    LYCShowpingModel *_shopigModel;
    
}
@end

@implementation LYCShoppingGuideTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _shoppingListArr = [NSMutableArray array];
    _shopigModel = [[LYCShowpingModel alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self dataAccess];
}

- (void)dataAccess
{
    LYCShoppingGuideViewModel *shoppingGuideViewModel = [[LYCShoppingGuideViewModel alloc] init];
    shoppingGuideViewModel.cityId = @"1";
    shoppingGuideViewModel.pageSize = @"10";
    shoppingGuideViewModel.carLevel = [NSString stringWithFormat:@"%d",self.carLevel];
    shoppingGuideViewModel.pageNo = [NSString stringWithFormat:@"%d",1];
    
    MBProgHUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    MBProgHUD.delegate = self;
    
    [MBProgHUD show:YES];
    [shoppingGuideViewModel handleDataWithSuccess:^(NSArray *arr) {
        //        [_priceQuotationListArr removeAllObjects];
        
        [_shoppingListArr addObjectsFromArray:arr];
        
        [MBProgHUD hide:YES];
        
        [self.tableView reloadData];
        //数组里存的是buycarlistmodel
        //        DLog(@"_priceQuotationListArr success%ld",_priceQuotationListArr.count);
    } failure:^(NSError *err) {
        DLog(@"buy _shoppingListArrERR failure %@",err);
        [MBProgHUD hide:YES];
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _shoppingListArr.count;
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
    
    _shopigModel = _shoppingListArr[indexPath.row];
    
    NSString *urlStr = _shopigModel.imagePath;
    
    
    [cell.carImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"shoppingImage"]];
    
    cell.timeLabel.text = _shopigModel.time;
    
    cell.ldescribe.text = _shopigModel.title;
    
    
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
