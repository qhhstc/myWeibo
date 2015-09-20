//
//  WeiboAnnotation.h
//  MiracleWeibo
//
//  Created by 我真的不是傻逼 on 15/9/2.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "GettedWeibo.h"
@interface WeiboAnnotationModel : NSObject<MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) GettedWeibo *weibo;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
