//
//  PaymentCodeViewController.m
//  ShopTest
//
//  Created by dong on 2017/9/5.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "PaymentCodeViewController.h"
#import "UIColor+Extension.h"
#import "GoodsViewController.h"
#import "FBAPI.h"
#import "FBConfig.h"
#import "SVProgressHUD.h"
#import "DKNightVersion.h"

@interface PaymentCodeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *qtCodeImageView;
@property (weak, nonatomic) IBOutlet UIView *successView;
@property (weak, nonatomic) IBOutlet UILabel *youhuiLabel;
@property (weak, nonatomic) IBOutlet UILabel *yunfeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *yingfukuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *payWayLabel;
@property (weak, nonatomic) IBOutlet UIView *daYinView;
@property (weak, nonatomic) IBOutlet UIView *zhengZaiDaYinView;
@property (weak, nonatomic) IBOutlet UIImageView *zhengZaiDaYinImageView;
@property (weak, nonatomic) IBOutlet UIView *daYinSuccessView;
@property (weak, nonatomic) IBOutlet UIView *printFailView;
@property (weak, nonatomic) IBOutlet UIView *rePrintView;
@property (weak, nonatomic) IBOutlet UIView *queRenZhongView;
@property (weak, nonatomic) IBOutlet UIImageView *queRenLoadingImageView;
@property (weak, nonatomic) IBOutlet UILabel *queRenTipLabel;
@property (nonatomic, assign) NSInteger payType;

@end

@implementation PaymentCodeViewController

- (IBAction)daYin:(id)sender {
    [self.zhengZaiDaYinImageView startAnimating];
    self.zhengZaiDaYinView.hidden = NO;
    NSDictionary *param = @{
                            @"rid" : self.rid
                            };
    FBRequest *request = [FBAPI postWithUrlString:@"/shopping/print_order" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        if ([result[@"success"] integerValue] == 1) {
            [self.zhengZaiDaYinImageView stopAnimating];
            self.daYinSuccessView.hidden = NO;
        } else {
            [self.zhengZaiDaYinImageView stopAnimating];
            self.printFailView.hidden = NO;
        }
    } failure:^(FBRequest *request, NSError *error) {
    }];
}

- (IBAction)rePrint:(id)sender {
    self.printFailView.hidden = YES;
    [self.zhengZaiDaYinImageView startAnimating];
    NSDictionary *param = @{
                            @"rid" : self.rid
                            };
    FBRequest *request = [FBAPI postWithUrlString:@"/shopping/print_order" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        if ([result[@"success"] integerValue] == 1) {
            [self.zhengZaiDaYinImageView stopAnimating];
            self.daYinSuccessView.hidden = NO;
        } else {
            [self.zhengZaiDaYinImageView stopAnimating];
            self.printFailView.hidden = NO;
        }
    } failure:^(FBRequest *request, NSError *error) {
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.zhengZaiDaYinView.hidden = YES;
    self.daYinSuccessView.hidden = YES;
    self.printFailView.hidden = YES;
    self.queRenZhongView.hidden = YES;
    
    NSMutableArray *imageAry2 = [NSMutableArray array];
    for (int i = 1; i<=20; i++) {
        NSString *str = [NSString stringWithFormat:@"pay%04d", i];
        UIImage *image = [UIImage imageNamed:str];
        [imageAry2 addObject:image];
    }
    self.queRenLoadingImageView.animationImages = imageAry2;
    self.queRenLoadingImageView.animationDuration = 2;
    self.queRenLoadingImageView.animationRepeatCount = 0;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"请到前台联系销售人员支付¥%@付款", self.total_money]];
    NSString *str1 = [NSString stringWithFormat:@"%@", self.total_money];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#F05958"] range:NSMakeRange(12, str1.length+1)];
    self.queRenTipLabel.attributedText = str;
    
    NSMutableArray *imageAry = [NSMutableArray array];
    for (int i = 1; i<=60; i++) {
        NSString *str = [NSString stringWithFormat:@"d%04d", i];
        UIImage *image = [UIImage imageNamed:str];
        [imageAry addObject:image];
    }
    self.zhengZaiDaYinImageView.animationImages = imageAry;
    self.zhengZaiDaYinImageView.animationDuration = 6;
    self.zhengZaiDaYinImageView.animationRepeatCount = 0;
    
    self.imageView.image = self.image;
    
    self.daYinView.dk_backgroundColorPicker = DKColorPickerWithKey(priceText);
    self.daYinView.layer.masksToBounds = YES;
    self.daYinView.layer.cornerRadius = 2;
    
    self.rePrintView.dk_backgroundColorPicker = DKColorPickerWithKey(priceText);
    self.rePrintView.layer.masksToBounds = YES;
    self.rePrintView.layer.cornerRadius = 2;
    
    self.youhuiLabel.text = [NSString stringWithFormat:@"优惠￥%@", self.coin_money];
    self.yunfeiLabel.text = [NSString stringWithFormat:@"运费￥%@", self.freight];
    self.yingfukuanLabel.text = [NSString stringWithFormat:@"应付款￥%.0f", [self.total_money floatValue] - [self.coin_money floatValue] + [self.freight floatValue]];
    
    self.yingfukuanLabel.dk_textColorPicker = DKColorPickerWithKey(priceText);
    
    self.showView.layer.masksToBounds = YES;
    self.showView.layer.cornerRadius = 5;
    
    self.successView.layer.masksToBounds = YES;
    self.successView.layer.cornerRadius = 5;
    self.successView.hidden = YES;
    
    self.qtCodeImageView.layer.borderColor = [UIColor colorWithHexString:@"#222222"].CGColor;
    self.qtCodeImageView.layer.borderWidth = 1;
    
    NSString *zhifufangshi = @"";
    if (self.payWay == 1) {
       self.payWayLabel.text = @"微信扫描二维码付款";
        zhifufangshi = @"weichat";
        self.payType = 2;
    } else if (self.payWay == 2) {
        self.payWayLabel.text = @"支付宝扫描二维码付款";
        zhifufangshi = @"alipay";
        self.payType = 2;
    } else if (self.payWay == 3) {
        self.payWayLabel.text = @"现金支付";
        zhifufangshi = @"cash";
        self.payType = 3;
    }
    
    NSDictionary *param = @{
                            @"rid" : self.rid,
                            @"payaway" : zhifufangshi,
                            @"pay_type" : @(self.payType)
                            };
    FBRequest *request1 = [FBAPI postWithUrlString:@"/shopping/payed" requestDictionary:param delegate:self];
    [request1 startRequestSuccess:^(FBRequest *request, id result) {
        if ([result[@"success"] integerValue] == 1) {
            if (self.payWay == 3) {
                //loading图出现
                self.queRenZhongView.hidden = NO;
                [self.queRenLoadingImageView startAnimating];
                return;
            }
            NSString *str = result[@"data"][@"code_url"];
            self.qtCodeImageView.image = [self qrImageForString:str imageSize:200 logoImageSize:50];
        } else {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@", result[@"message"]]];
        }
    } failure:^(FBRequest *request, NSError *error) {
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        while (TRUE) {
            [NSThread sleepForTimeInterval:2];
            [self checkOrderInfoForPayStatusWithPaymentWay:@""];
        };
    });
}

- (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];//通过kvo方式给一个字符串，生成二维码
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];//设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    CIImage *outPutImage = [filter outputImage];//拿到二维码图片
    return [self createNonInterpolatedUIImageFormCIImage:outPutImage withSize:Imagesize waterImageSize:waterImagesize];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size waterImageSize:(CGFloat)waterImagesize{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建一个DeviceGray颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    //给二维码加 logo 图
    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
    [outputImage drawInRect:CGRectMake(0,0 , size, size)];
    //logo图
    UIImage *waterimage = [UIImage imageNamed:@"code"];
    //把logo图画到生成的二维码图片上，注意尺寸不要太大（最大不超过二维码图片的%30），太大会造成扫不出来
    [waterimage drawInRect:CGRectMake((size-waterImagesize)/2.0, (size-waterImagesize)/2.0, waterImagesize, waterImagesize)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}

- (IBAction)close:(id)sender {
    GoodsViewController *vc = [GoodsViewController new];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    if (self.successView.hidden) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self presentViewController:vc animated:YES completion:nil];
    }
}

//请求订单状态以核实支付是否完成
- (void)checkOrderInfoForPayStatusWithPaymentWay:(NSString *)paymentWay
{
    FBRequest * request = [FBAPI postWithUrlString:@"/shopping/detail" requestDictionary:@{@"rid": self.rid} delegate:self];
    //延迟2秒执行以保证服务端已获取支付通知
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [request startRequestSuccess:^(FBRequest *request, id result) {
            NSDictionary * dataDic = [result objectForKey:@"data"];
            if (([[dataDic objectForKey:@"status"] isEqualToNumber:@10] | [[dataDic objectForKey:@"status"] isEqualToNumber:@16])) {
                [self.queRenLoadingImageView stopAnimating];
                self.successView.hidden = NO;
            } else {
            }
        } failure:^(FBRequest *request, NSError *error) {
            [SVProgressHUD showInfoWithStatus:[error localizedDescription]];
        }];
    });
}


@end
