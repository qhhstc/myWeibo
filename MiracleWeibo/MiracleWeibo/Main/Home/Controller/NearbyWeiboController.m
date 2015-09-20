//
//  NearbyWeiboController.m
//  MiracleWeibo
//
//  Created by 我真的不是傻逼 on 15/9/2.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "NearbyWeiboController.h"
#import "DataService.h"
@interface NearbyWeiboController ()
{
    CLLocationManager *_manager;
    MKMapView *_mapView;
    NSMutableArray *_mapArray;
}
@end

@implementation NearbyWeiboController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近的微博";
    [self createMap];

    [self location];
    // Do any additional setup after loading the view.
}

- (void)location{
    _manager = [[CLLocationManager alloc] init];
    if ([UIDevice currentDevice].systemVersion.floatValue > 8.0) {
        [_manager requestWhenInUseAuthorization];
    }
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    _manager.delegate = self;
    [_manager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [manager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    [self getWeiboWith:lon lat:lat];
    
    
    CLLocationCoordinate2D center = coordinate;
    MKCoordinateSpan span = {0.2,0.2};
    MKCoordinateRegion region = {center,span};
    _mapView.region = region;
}

- (void)getWeiboWith:(NSString *)lon lat:(NSString *)lat{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:TokenValue forKey:Token];
    [DataService requestWeiboURL:nearbyWeibo method:@"GET" params:params datas:nil withBlock:^(id result) {
        NSLog(@"%@",result);
        _mapArray = [[NSMutableArray alloc] init];
        NSArray *a = [result objectForKey:@"statuses"];
        for (NSDictionary *weibo in a) {
            GettedWeibo *weiboModel = [[GettedWeibo alloc] initWithDataDic:weibo];
            WeiboAnnotationModel *model = [[WeiboAnnotationModel alloc] init];
            model.weibo = weiboModel;
            NSArray *geo = [weiboModel.geo objectForKey:@"coordinates"];
            CGFloat lat = [geo[0] floatValue];
            CGFloat lon = [geo[1] floatValue];
            [model setCoordinate:CLLocationCoordinate2DMake(lat, lon)];
            [_mapArray addObject:model];
        }
        [_mapView addAnnotations:_mapArray];
    }];
}

#pragma -mark 地图
- (void)createMap{
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
}
#pragma -mark 微博标注视图（自定义)
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    WeiboAnnotation *pinView = (WeiboAnnotation *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
    if (pinView == nil) {
        pinView = [[WeiboAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
    }
    pinView.annotation = annotation;
    return pinView;
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
