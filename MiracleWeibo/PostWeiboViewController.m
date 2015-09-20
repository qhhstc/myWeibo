//
//  PostWeiboViewController.m
//  MiracleWeibo
//
//  Created by 我真的不是傻逼 on 15/8/30.
//  Copyright (c) 2015年 no.4. All rights reserved.
//
#import "PostWeiboViewController.h"
#import "DataService.h"
#import "ThemeButton.h"
#import "ZoomImageView.h"
#import "MMDrawerController.h"
#import "NearbyViewController.h"
@interface PostWeiboViewController ()
{
    UITextView *_textView;
    UIView *_editorBar;
    ZoomImageView *_image;
    CLLocationManager *_locationManager;
}
@end

@implementation PostWeiboViewController

- (void)willZoomIn:(ZoomImageView *)zoom{
    [_textView resignFirstResponder];
}

- (void)willZoomOut:(ZoomImageView *)zoom{
    [_textView becomeFirstResponder];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_textView becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self createBar];
    // Do any additional setup after loading the view.
}

- (void)createBar{
    ThemeButton *cancel = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    cancel.normalImgName = @"/button_icon_close.png";
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancel];
    
    ThemeButton *send = [[ThemeButton alloc] initWithFrame:CGRectMake(kWidth-50, 20, 44, 44)];
    send.normalImgName = @"/button_icon_ok.png";
    [send addTarget:self action:@selector(sendWeibo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:send];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 0)];
    _textView.font = [UIFont systemFontOfSize:17];
    _textView.backgroundColor = [UIColor lightGrayColor];
    _textView.editable = YES;
    _textView.layer.cornerRadius = 10;
    _textView.layer.borderWidth = 2;
    _textView.layer.borderColor = [UIColor blackColor].CGColor;

    [self.view addSubview:_textView];
    
    //2 编辑工具栏
    _editorBar = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight, kWidth, 55)];
    _editorBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_editorBar];
    //3.创建多个编辑按钮
    NSArray *imgs = @[
                      @"/compose_toolbar_1.png",
                      @"/compose_toolbar_4.png",
                      @"/compose_toolbar_3.png",
                      @"/compose_toolbar_5.png",
                      @"/compose_toolbar_6.png"
                      ];
    for (int i=0; i<imgs.count; i++) {
        NSString *imgName = imgs[i];
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(15+(kWidth/5)*i, 20, 40, 33)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10+i;
        button.normalImgName = imgName;
        [_editorBar addSubview:button];
    }
    _addressText = [[ThemeLabel alloc] initWithFrame:CGRectMake(5, _textView.bottom-40, 70, 30)];
    _addressText.text = @"请选择地址";
    [_textView addSubview:_addressText];
}

- (void)buttonAction:(UIButton*)button{
    if (button.tag == 10) {
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"拍照", nil];
        [action showInView:self.view];
    }
    if (button.tag == 13) {
        [self location];
    }
}
//开始更新地理信息
- (void)location{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        //当前版本
        if ([UIDevice currentDevice].systemVersion.floatValue >8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}

#pragma -mark 获取地理信息
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [_locationManager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"%f,%f",coordinate.longitude,coordinate.latitude);
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        CLPlacemark *place = [placemarks lastObject];
//        NSLog(@"%@",place.name);
//    }];
    
    NSString *coordinateStr = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:coordinateStr forKey:@"coordinate"];
    [params setObject:TokenValue forKey:Token];
    [DataService requestWeiboURL:geo_address method:@"GET" params:params datas:nil withBlock:^(id result) {
        NSArray *geos = [result objectForKey:@"geos"];
        if (geos.count > 0) {
            NSDictionary *geo = [geos lastObject];
            NSString *address = [geo objectForKey:@"address"];
            NSLog(@"%@",address);
        }
    }];
    NSMutableDictionary *nearbyParams = [[NSMutableDictionary alloc] init];
    NSNumber *lon = [NSNumber numberWithFloat:coordinate.longitude];
    NSNumber *lat = [NSNumber numberWithFloat:coordinate.latitude];
    [nearbyParams setObject:lon.stringValue forKey:@"long"];
    [nearbyParams setObject:lat.stringValue forKey:@"lat"];
    [nearbyParams setObject:TokenValue forKey:Token];
    [DataService requestWeiboURL:nearbyPois method:@"GET" params:nearbyParams datas:nil withBlock:^(id result) {
        NSLog(@"%@",result);
        NSArray *a = [result objectForKey:@"pois"];
        NearbyViewController *vc = [[NearbyViewController alloc] init];
        vc.array = a;
        vc.b = ^(NSString *str){
            self.addressText.text = str;
        };
        [self.navigationController pushViewController:vc animated:YES];
    }];
}
//相机键
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        UIImagePickerController *vc= [[ UIImagePickerController alloc] init];
        vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    if (buttonIndex == 1) {
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        }
        else {
            NSLog(@"不可用");
        }
    }
}
//选取完照片 显示
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (_zoomImageView == nil) {
        _zoomImageView = [[ZoomImageView alloc] initWithFrame:CGRectMake(10, _textView.bottom+10, 80, 80)];
        _zoomImageView.delegate = self;
        [self.view addSubview:_zoomImageView];
    }
    _zoomImageView.image = img;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//监控键盘 调整试图高度
- (void)keyboardWillShow:(NSNotification *)notification{
    NSValue *bounsValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    
    CGRect frame = [bounsValue CGRectValue];
    //2 键盘高度
    CGFloat height = frame.size.height;
    
    //3 调整视图的高度
    _textView.height = kHeight-_editorBar.height-height-64-_zoomImageView.height;
    _editorBar.top = _textView.bottom+_zoomImageView.height-10;
    if (_zoomImageView) {
        _zoomImageView.top = _textView.bottom +10;
    }
    _addressText.frame = CGRectMake(5, _textView.bottom-40, 150, 30);
    _addressText.textColor = [UIColor colorWithRed:.29 green:.84 blue:.92 alpha:1];
}
//取消编辑 关闭侧边
- (void)cancel{
    //通过UIWindow找到  MMDRawer
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if ([window.rootViewController isKindOfClass:[MMDrawerController class]]) {
        MMDrawerController *mmDrawer = (MMDrawerController *)window.rootViewController;
        
        [mmDrawer closeDrawerAnimated:YES completion:NULL];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendWeibo{
    NSString *text = _textView.text;
    NSString *error = nil;
    if (text.length == 0) {
        error = @"微博内容为空";
    }
    else if(text.length > 140) {
        error = @"微博内容大于140字符";
    }
    if (error != nil) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    else {
        UIAlertView *post = [[UIAlertView alloc] initWithTitle:@" 提示"message:@"确定发送" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [post show];
    }
    [_textView resignFirstResponder];
}
//发送状态栏
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        AFHTTPRequestOperation *op = [DataService sendWeiboContent:_textView.text image:_zoomImageView.image completion:^(id result) {
            [self showStatusTip:@"发送成功" show:NO operation:nil];
        }];
        [self showStatusTip:@"正在发送" show:YES operation:op];
        [self cancel];
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
