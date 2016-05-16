//
//  ViewController.m
//  CityDemo
//
//  Created by 李海瑞 on 16/4/18.
//  Copyright © 2016年 李海瑞. All rights reserved.
//

#import "FilterViewController.h"
#import "CityTableViewCell.h"
#define CityCellStr  @"CityTableViewCell"

@interface FilterViewController ()<DateCollectionViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *CityTbleview;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self.CityTbleview registerNib:[UINib nibWithNibName:CityCellStr bundle:nil] forCellReuseIdentifier:CityCellStr];
    
    self.view.backgroundColor = [UIColor greenColor];
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CityCellStr];
    cell.index=indexPath;
    cell.delegate=self;
    [cell.Citycollectionview reloadData];
      return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}
-(void)didSelectedTableview:(NSIndexPath *)index withcollecttion:(NSIndexPath *)collectionindex
{
    NSLog(@"----%ld ---%ld",index.section,collectionindex.row);


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
