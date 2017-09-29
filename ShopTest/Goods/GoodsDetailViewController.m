//
//  GoodsDetailViewController.m
//  ShopTest
//
//  Created by dong on 2017/9/1.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "OderInfoViewController.h"
#import "FBAPI.h"
#import "GoodsDetailModel.h"
#import "UIColor+Extension.h"
#import "FBConfig.h"
#import "UIImageView+WebCache.h"
#import "UIView+FSExtension.h"
#import "DKNightVersion.h"
#import "SVProgressHUD.h"

@interface GoodsDetailViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;
@property (weak, nonatomic) IBOutlet UILabel *goodsDescreb;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (nonatomic, strong) GoodsDetailModel *model;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property (weak, nonatomic) IBOutlet UIView *goodsDetailView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsDetailViewBottom;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.priceLabel.dk_textColorPicker = DKColorPickerWithKey(priceText);
    self.buyBtn.dk_backgroundColorPicker = DKColorPickerWithKey(priceText);
    
//    self.closeBtn.layer.masksToBounds = YES;
//    self.closeBtn.layer.cornerRadius = 3;
//    self.closeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.closeBtn.layer.borderWidth = 1;
    
    self.rateLabel.layer.masksToBounds = YES;
    self.rateLabel.layer.cornerRadius = 1;
    self.rateLabel.layer.borderWidth = 1;
    self.rateLabel.layer.borderColor = [UIColor colorWithHexString:@"#ffffff"].CGColor;
    
    NSDictionary *param = @{
                            @"id" : self.infoId
                            };
    FBRequest *request = [FBAPI postWithUrlString:@"/product/view" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        NSLog(@"sadsadsadsad %@", result);
        self.model = [GoodsDetailModel mj_objectWithKeyValues:result[@"data"]];
        
        self.goodsTitle.text = self.model.short_title;
        self.goodsDescreb.text = self.model.advantage;
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@", self.model.sale_price];
        
        NSArray *ary;
        if (self.model.pad_asset.count == 0) {
            ary = self.model.asset;
        } else {
            ary = self.model.pad_asset;
        }
        for (int i = 0; i<ary.count; i++) {
            UIImageView *imageview=[[UIImageView alloc]init];
            [imageview sd_setImageWithURL:[NSURL URLWithString:ary[i]] placeholderImage:[UIImage imageNamed:@"Bitmap"]];
            imageview.contentMode = UIViewContentModeScaleAspectFit;
            imageview.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
             [self.scrollView addSubview:imageview];
        }
        
        UITapGestureRecognizer * privateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView:)];
        privateLetterTap.numberOfTouchesRequired = 1; //手指数
        privateLetterTap.numberOfTapsRequired = 1; //tap次数
        [self.scrollView addGestureRecognizer:privateLetterTap];
        
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*ary.count, SCREEN_HEIGHT);
        [self.scrollView flashScrollIndicators];
        if (ary.count == 0) {
            self.pageLabel.text = [NSString stringWithFormat:@"%@/%lu", @"0", (unsigned long)ary.count];
            self.leftBtn.userInteractionEnabled = NO;
            self.rightBtn.userInteractionEnabled = NO;
        } else {
            self.pageLabel.text = [NSString stringWithFormat:@"%@/%lu", @"1", (unsigned long)ary.count];
            self.leftBtn.userInteractionEnabled = YES;
            self.rightBtn.userInteractionEnabled = YES;
        }
    } failure:^(FBRequest *request, NSError *error) {
        
    }];
    
    self.scrollView.delegate = self;
}

- (void)tapAvatarView: (UITapGestureRecognizer *)gesture{
    NSInteger n = 1;
    if (self.goodsDetailViewBottom.constant == 0) {
        n = -125;
    } else {
        n = 0;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.goodsDetailViewBottom.constant = n;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buy:(id)sender {
    if ([self.model.skus_count integerValue] == 0) {
        [SVProgressHUD showInfoWithStatus:@"商品信息不全，无法购买"];
        return;
    }
    
    OderInfoViewController *vc = [OderInfoViewController new];
    vc.image = [self fullScreenshots];
    vc.model = self.model;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)left:(id)sender {
    CGFloat x = self.scrollView.contentOffset.x;
    if (x == 0) {
        return;
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.contentOffset = CGPointMake(x-SCREEN_WIDTH, self.scrollView.contentOffset.y);
        }];
    }
}

- (IBAction)right:(id)sender {
    CGFloat x = self.scrollView.contentOffset.x;
    if (x == (self.model.asset.count-1)*SCREEN_WIDTH) {
        return;
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.contentOffset = CGPointMake(x+SCREEN_WIDTH, self.scrollView.contentOffset.y);
        }];
    }
}

-(UIImage*)fullScreenshots{
    
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return viewImage;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    self.pageLabel.text = [NSString stringWithFormat:@"%.0f/%lu", x/SCREEN_WIDTH+1, (unsigned long)self.model.asset.count];
}

@end
