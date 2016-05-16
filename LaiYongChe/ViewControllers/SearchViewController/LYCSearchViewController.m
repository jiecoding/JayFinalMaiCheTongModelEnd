//
//  LYCSearchViewController.m
//  LaiYongChe
//search http://blog.csdn.net/swj6125/article/details/21741733
//  Created by laiyongche on 16/5/9.
//  Copyright © 2016年 laiyongche. All rights reserved.
//

#import "LYCSearchViewController.h"

#import "LYCSearchListViewModel.h"

#import "Constants.h"

#import "LYCSearchListModel.h"
@interface LYCSearchViewController ()<UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate>

{
    UISearchController *_searchController;
    
    UITableView *_tableView;
    
    NSMutableArray *_searchList;
}

@end

@implementation LYCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _searchList = [NSMutableArray array];
    
    [self createSearchController];
    
    //模拟器上测试用
    [self dataAccess:@"宝"];
}

- (void)dataAccess:(NSString *)searchString
{
    LYCSearchListViewModel *viewModel = [[LYCSearchListViewModel alloc] init];
    
    viewModel.pageSize = @"10";
    viewModel.pageNo = @"1";
    viewModel.searchStr = searchString;
    
    [viewModel handleDataWithSuccess:^(NSArray *arr) {
        DLog(@"arr searchList:%@",arr);
        [_searchList removeAllObjects];
        [_searchList addObjectsFromArray:arr];

        [self.tableView reloadData];
    } failure:^(NSError *err) {
        DLog(@"arr err:%@",err);
        
    }];
}

- (void)createSearchController
{
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(_searchController.searchBar.frame.origin.x, _searchController.searchBar.frame.origin.y, _searchController.searchBar.frame.size.width, 44.0);
    _searchController.delegate= self;
    _searchController.searchBar.delegate  = self;
    self.tableView.tableHeaderView = _searchController.searchBar;

}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    //这里不做线程延迟的话 pop的时候 searchbar会在pop后停留下..??
    _searchController.searchBar.hidden = YES;
    double delayInSeconds = 0.01;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_searchList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *flag = @"cellFlag";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
    
    if(cell == nil)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        
        LYCSearchListModel *searchListModel = [_searchList objectAtIndex:indexPath.row];
        
        if(searchListModel){
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@",searchListModel.name];
        }
    }
    return cell;
    
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [_searchController.searchBar text];
    DLog(@"searchString:%@",searchString);
//    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
//    if (self.searchList!= nil) {
//        [self.searchList removeAllObjects];
//    }
    //过滤数据
//    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格  这块不能用 _tableview
    if(searchString.length >0){
        [self dataAccess:searchString];
    }
    [self.tableView reloadData];
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
