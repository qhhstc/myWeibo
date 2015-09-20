//
//  WeiboAnnotation.h
//  MiracleWeibo
//
//  Created by 我真的不是傻逼 on 15/9/2.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "WeiboAnnotationModel.h"
@interface WeiboAnnotation : MKAnnotationView
{
    UIImageView *_userHeadImageView;
    UILabel *_textLabel;
}
@end
