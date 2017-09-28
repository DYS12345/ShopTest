//
//  KuaiDiViewController.m
//  ShopTest
//
//  Created by dong on 2017/9/5.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "KuaiDiViewController.h"
#import "UIImageView+WebCache.h"
#import "THNChooseCityViewController.h"
#import "SVProgressHUD.h"
#import "PayWayViewController.h"
#import "DKNightVersion.h"
#import "UIView+FSExtension.h"

@interface KuaiDiViewController () <UITextFieldDelegate>
{
    NSString *_provinceId;
    NSString *_cityId;
    NSString *_countyId;
    NSString *_townId;
    
    NSString *_provinceName;
    NSString *_cityName;
    NSString *_countyName;
    NSString *_townName;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *youXiangTF;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTF;
@property (weak, nonatomic) IBOutlet UILabel *yunFeiLabel;
@property (weak, nonatomic) IBOutlet UIButton *anyTime;
@property (weak, nonatomic) IBOutlet UIButton *oneToSevenBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixSevenBtn;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *summaryTF;
@property (copy, nonatomic) NSString *freight;

@end

static NSString *const EditAddressURL = @"/delivery_address/save";

@implementation KuaiDiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.priceLabel.dk_textColorPicker = DKColorPickerWithKey(priceText);
    self.buyBtn.dk_backgroundColorPicker = DKColorPickerWithKey(priceText);
    
    self.imageView.image = self.image;
    
    self.showView.layer.masksToBounds = YES;
    self.showView.layer.cornerRadius = 5;
    
    self.buyBtn.layer.masksToBounds = YES;
    self.buyBtn.layer.cornerRadius = 3;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.model.cover_url]];
    self.goodsTitleLabel.text = self.model.short_title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", self.model.sale_price];
    self.colorLabel.text = self.color;
    
    self.anyTime.selected = YES;
    self.anyTime.userInteractionEnabled = NO;
    
    self.detailAddressTF.delegate = self;
}

- (IBAction)otherClose:(id)sender {
    if (self.nameTF.isFirstResponder | self.phoneTF.isFirstResponder | self.youXiangTF.isFirstResponder | self.detailAddressTF.isFirstResponder | self.summaryTF.isFirstResponder) {
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)anyTime:(UIButton*)sender {
    sender.selected = YES;
    self.oneToSevenBtn.selected = NO;
    self.oneToSevenBtn.userInteractionEnabled = YES;
    self.sixSevenBtn.selected = NO;
    self.sixSevenBtn.userInteractionEnabled = YES;
    sender.userInteractionEnabled = NO;
}

- (IBAction)oneToSeven:(UIButton*)sender {
    sender.selected = YES;
    self.anyTime.selected = NO;
    self.anyTime.userInteractionEnabled = YES;
    self.sixSevenBtn.selected = NO;
    self.sixSevenBtn.userInteractionEnabled = YES;
    sender.userInteractionEnabled = NO;
}

- (IBAction)sixSeven:(UIButton*)sender {
    sender.selected = YES;
    self.anyTime.selected = NO;
    self.anyTime.userInteractionEnabled = YES;
    self.oneToSevenBtn.selected = NO;
    self.oneToSevenBtn.userInteractionEnabled = YES;
    sender.userInteractionEnabled = NO;
}

- (IBAction)selectAddrees:(UIButton*)sender {
    [self.view endEditing:true];
    __weak __typeof(self)weakSelf = self;
    THNChooseCityViewController *chooseCityVC = [[THNChooseCityViewController alloc] init];
    
    chooseCityVC.modalPresentationStyle = UIModalPresentationPopover;
    chooseCityVC.popoverPresentationController.sourceView = self.view;
    chooseCityVC.popoverPresentationController.sourceRect = CGRectMake(self.view.centerX+50, self.view.centerY-30, sender.width, sender.height);
    chooseCityVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    chooseCityVC.preferredContentSize = CGSizeMake(300, 330);
    
    chooseCityVC.getChooseAddressId = ^(NSString *provinceId, NSString *cityId, NSString *countyId, NSString *streetId) {
        _provinceId = provinceId;
        _cityId = cityId;
        _countyId = countyId;
        _townId = streetId;
    };
    chooseCityVC.getChooseAddressName = ^(NSString *provinceName, NSString *cityName, NSString *countyName, NSString *streetName) {
        weakSelf.addressTF.text = [NSString stringWithFormat:@"%@ %@ %@ %@", provinceName, cityName, countyName, streetName];
        _provinceName = provinceName;
        _cityName = cityName;
        _countyName = countyName;
        _townName = streetName;
    };
    
    [self presentViewController:chooseCityVC animated:YES completion:nil];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.nameTF.text.length < 2) {
        [SVProgressHUD showInfoWithStatus:@"收货人姓名至少2个字符"];
        return;
    }
    
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写联系方式"];
        return;
    }
    
    if (self.addressTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请选择所在地区"];
        return;
    }
    
    if (self.detailAddressTF.text.length == 5) {
        [SVProgressHUD showInfoWithStatus:@"请填写详细地址"];
        return;
    }
    
    if (self.detailAddressTF.text.length < 5) {
        [SVProgressHUD showInfoWithStatus:@"详细地址描述信息不得少于5个字符"];
        return;
    }
    
    if (self.phoneTF.text.length != 11) {
        [SVProgressHUD showInfoWithStatus:@"内地手机号码为11位数字"];
        return;
    }
    
    if (self.youXiangTF.text.length > 6) {
        [SVProgressHUD showInfoWithStatus:@"邮编为6位数字"];
        return;
    }
    
    [self requestDataForCommitAddress];
}

//请求提交收货地址信息
- (void)requestDataForCommitAddress
{
    NSDictionary * params = @{@"province_id": _provinceId,
                              @"rid": self.rid,
                              @"city_id" : _cityId,
                              @"county_id" : _countyId,
                              @"town_id" : _townId
                              };
    FBRequest * request1 = [FBAPI postWithUrlString:@"/shopping/fetch_freight" requestDictionary:params delegate:self];
    [request1 startRequestSuccess:^(FBRequest *request, id result) {
        self.yunFeiLabel.text = [NSString stringWithFormat:@"运费：%@元", result[@"data"][@"freight"]];
        self.freight = result[@"data"][@"freight"];
    } failure:^(FBRequest *request, NSError *error) {
        
    }];
}

- (IBAction)buy:(id)sender {
    if (self.nameTF.text.length < 2) {
        [SVProgressHUD showInfoWithStatus:@"收货人姓名至少2个字符"];
        return;
    }
    
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写联系方式"];
        return;
    }
    
    if (self.addressTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请选择所在地区"];
        return;
    }
    
    if (self.detailAddressTF.text.length == 5) {
        [SVProgressHUD showInfoWithStatus:@"请填写详细地址"];
        return;
    }
    
    if (self.detailAddressTF.text.length < 5) {
        [SVProgressHUD showInfoWithStatus:@"详细地址描述信息不得少于5个字符"];
        return;
    }
    
    if (self.phoneTF.text.length != 11) {
        [SVProgressHUD showInfoWithStatus:@"内地手机号码为11位数字"];
        return;
    }
    
    if (self.youXiangTF.text.length > 6) {
        [SVProgressHUD showInfoWithStatus:@"邮编为6位数字"];
        return;
    }
    NSDictionary *addbookDict = @{
                                  @"name" : self.nameTF.text,
                                  @"phone" : self.phoneTF.text,
                                  @"zip" : self.youXiangTF.text,
                                  @"province_id" : _provinceId,
                                  @"city_id" : _cityId,
                                  @"county_id" : _countyId,
                                  @"town_id" : _townId,
                                  @"province" : _provinceName,
                                  @"city" : _cityName,
                                  @"county" : _countyName,
                                  @"town" : _townName
                                  };
    NSString *addbookStr = [self convertToJsonData:addbookDict];
    NSDictionary *param = @{
                            @"rrid" : self.rid,
                            @"is_nowbuy" : @(1),
                            @"addbook" : addbookStr,
                            @"summary" : self.summaryTF.text,
                            @"delivery_type" : @(1),
                            @"app_type" : @(2),
                            @"from_site" : @(11)
                            };
    FBRequest *request1 = [FBAPI postWithUrlString:@"/shopping/confirm" requestDictionary:param delegate:self];
    [request1 startRequestSuccess:^(FBRequest *request, id result) {
        PayWayViewController *vc = [PayWayViewController new];
        vc.rid = result[@"data"][@"rid"];
        vc.image = self.image;
        vc.coin_money = result[@"data"][@"coin_money"];
        vc.freight = result[@"data"][@"freight"];
        vc.total_money = result[@"data"][@"total_money"];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:vc animated:YES completion:nil];
    } failure:^(FBRequest *request, NSError *error) {
    }];
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

@end
