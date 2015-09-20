//
//  NearbyWeiboController.h
//  MiracleWeibo
//
//  Created by 我真的不是傻逼 on 15/9/2.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "WeiboAnnotation.h"

@interface NearbyWeiboController : BaseViewController<CLLocationManagerDelegate,MKMapViewDelegate>

@end
