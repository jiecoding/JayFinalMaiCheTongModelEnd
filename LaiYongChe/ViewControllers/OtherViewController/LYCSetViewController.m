//
//  LYCSetViewController.m
//  LaiYongChe
//
//  Created by laiyongche on 16/5/8.
//  Copyright © 2016年 laiyongche. All rights reserved.
//

#import "LYCSetViewController.h"
#import "Constants.h"

#import <CoreLocation/CoreLocation.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface LYCSetViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
{
    NSArray *_setListTitles;
    UITableView *_tableview;
    CLLocationManager *_locationManager;
    //定位到的城市地址
    NSString *_city;
    //获取缓存大小
    float _cacheSize;
}
@end

@implementation LYCSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths lastObject];
    
    _cacheSize = [self folderSizeAtPath:path];
    
    
    _tableview = [[UITableView alloc] init];
    _tableview.frame = CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT);
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableview];
    
    _setListTitles = [[NSArray alloc] initWithObjects:@"城市",@"清除缓存",@"意见反馈",@"去AppStore评个5星吧",@"访问车讯官网",@"分享买车通给朋友",nil];
    
    [self initializeLocationService];
    
   
    
}

- (void)initializeLocationService {
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        
        // 初始化定位管理器
        _locationManager = [[CLLocationManager alloc] init];
        // 设置代理
        _locationManager.delegate = self;
        // 设置定位精确度到米
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // 设置过滤器为无
        //    _locationManager.distanceFilter = kCLDistanceFilterNone;
        
        _locationManager.distanceFilter = 10.0f;
        [_locationManager requestAlwaysAuthorization];
        
        
        // 开始定位
        [_locationManager startUpdatingLocation];
        
    }
    else
    {
        DLog(@"12323132'");
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
            //获取城市 http://www.tuicool.com/articles/3URFZ3y
            _city = placemark.locality;
            if (!_city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                _city = placemark.administrativeArea;
            }
            [_tableview reloadData];

            NSLog(@"city = %@", _city);
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53.0f;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return <#expression#>
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _setListTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CELLDESTR = @"CELLDESTR";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLDESTR];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELLDESTR];
    }
    cell.textLabel.text = [_setListTitles objectAtIndex:indexPath.row];
    
    if(indexPath.row == 0){
        cell.detailTextLabel.text = _city;
    }
    if (indexPath.row == 1)
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM",_cacheSize];
    }
    
    if(indexPath.row == 2)
    {
        cell.detailTextLabel.text = @"您的意见，对我们非常重要";

    }
    
    return cell;
    
}

- (void)shareLYC
{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"hongPhone@2x.png"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 1:
            [self claerHuanCun];
            break;
        case 5:
            [self shareLYC];
            break;
            
        default:
       
            break;
    }
    
    
    
}

- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
    
}
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


- (void)claerHuanCun {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths lastObject];
    
    NSString *str = [NSString stringWithFormat:@"缓存已清除%.1fM", [self folderSizeAtPath:path]];
    DLog(@"缓存已清除%@",str);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:str delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
    for (NSString *p in files) {
        NSError *error;
        NSString *Path = [path stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
            [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
        }
    }
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
