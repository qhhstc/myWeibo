//
//  DataService.m
//  XLWeibo
//
//  Created by 天才邱海晖 on 15/8/12.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "DataService.h"
@implementation DataService

+ (AFHTTPRequestOperation *)requestWeiboURL:(NSString *)url
                 method:(NSString *)method
                 params:(NSDictionary *)params
                  datas:(NSDictionary *)datas
              withBlock:(blocktype) block{
    NSString *fullString = [perURL stringByAppendingString:url];
    NSURL *purl = [NSURL URLWithString:perURL];
    NSArray *allkeys = [params allKeys];
    NSMutableString *paramString = [[NSMutableString alloc] init];
    for (int i = 0; i <allkeys.count; i++) {
        NSString *pre = allkeys[i];
        NSString *last = [params valueForKey:pre];
        [paramString appendFormat:@"%@=%@",pre,last];
        if (i < allkeys.count - 1) {
            [paramString appendFormat:@"&"];
        }
    }
    NSString *separate = purl.query ?@"&" :@"?";
    NSURL *fullUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",fullString,separate,paramString]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    if ([method  isEqual: @"GET"]) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:fullUrl];
        request.timeoutInterval = 60;
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            block(result);
        }];
    }
    if ([method isEqual:@"POST"]) {
        if (datas) {
            AFHTTPRequestOperation *operation = [manager POST:fullString parameters:params constructingBodyWithBlock:^(id <AFMultipartFormData> formData){
                for (NSString *name in datas) {
                    NSData *data = [datas objectForKey:name];
                    [formData appendPartWithFileData:data name:name fileName:@"lk.png" mimeType:@"image/jpeg"];
                }
            }success:^(AFHTTPRequestOperation *operation,id response){
                NSLog(@"%@",response);
            }failure:^(AFHTTPRequestOperation *operation,NSError *error){
                NSLog(@"%@",error);
            }];
            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                NSLog(@"%f",totalBytesWritten/(double)totalBytesExpectedToWrite);
            }];
            return operation;
        }
        else{
            AFHTTPRequestOperation *operation = [manager POST:fullString parameters:params success:^(AFHTTPRequestOperation *operation,id response){
                NSLog(@"%@",response);
            }failure:^(AFHTTPRequestOperation *response,NSError *error){
                NSLog(@"%@",error);
            }];
            return operation;
        }
    }
    return nil;
}

+ (void)getHomeWeibo{
    NSDictionary *dic = @{Token:TokenValue};

    [DataService requestWeiboURL:getHomeList method:@"GET" params:dic datas:nil withBlock:^(id result){
        
    }];
}

+ (AFHTTPRequestOperation *)sendWeiboContent:(NSString *)content image:(UIImage *)img completion:(blocktype)block{
    NSDictionary *dic = @{@"status":content,Token:TokenValue};
    if (img == nil) {
        AFHTTPRequestOperation *op = [DataService requestWeiboURL:postWeibo method:@"POST" params:dic datas:nil withBlock:^(id result){
            NSLog(@"发送成功");
            NSLog(@"%@",result);
        }];
        return op;
    }
    else {
        NSData *data = UIImageJPEGRepresentation(img, 1);
        if (data.length > 2*1024*1024) {
            data = UIImageJPEGRepresentation(img, .5);
        }
        NSDictionary *datas = @{@"pic":data};
        AFHTTPRequestOperation *op = [DataService requestWeiboURL:postWeiboIMage method:@"POST" params:dic datas:datas withBlock:^(id result){
            NSLog(@"发送图片成功");
        }];
        return op;
    }
}

@end
