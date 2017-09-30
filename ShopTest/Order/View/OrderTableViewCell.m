//
//  OrderTableViewCell.m
//  ShopTest
//
//  Created by 董永胜 on 2017/9/21.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "UIColor+Extension.h"
#import "OrderModel.h"
#import "OrderDetailModel.h"
#import "UIImageView+WebCache.h"
#import "DKNightVersion.h"

@interface OrderTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *dingdanhaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *xiadanshijianLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *beiZhuLabel;
@property (weak, nonatomic) IBOutlet UILabel *wuliuLabel;
@property (weak, nonatomic) IBOutlet UILabel *yunDanHaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *feiYongLabel;

@property (weak, nonatomic) IBOutlet UILabel *ridLabel;
@property (weak, nonatomic) IBOutlet UILabel *wuliugongsiLabel;
@property (weak, nonatomic) IBOutlet UILabel *maijiaBeizhuLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouhuoFangShiLabel;
@property (weak, nonatomic) IBOutlet UILabel *yunDanHaoLabell;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouhuoDiZhiLabel;
@property (weak, nonatomic) IBOutlet UILabel *zipLabel;
@property (weak, nonatomic) IBOutlet UILabel *frieghtLabel;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *skuId;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *numLabell;
@property (weak, nonatomic) IBOutlet UILabel *samplePrice;
@property (weak, nonatomic) IBOutlet UILabel *statuLabel;
@property (weak, nonatomic) IBOutlet UIView *statusBorderView;

@end

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.orderDetailView.hidden = YES;
    
    self.orderDetailView.layer.borderColor = [UIColor colorWithHexString:@"#d2d2d2"].CGColor;
    self.orderDetailView.layer.borderWidth = 1;
    
    self.statusBorderView.layer.borderColor = [UIColor colorWithHexString:@"#d2d2d2"].CGColor;
    self.statusBorderView.layer.borderWidth = 0.5;
    self.statusBorderView.layer.cornerRadius = 2;
    
    self.feiYongLabel.dk_textColorPicker = DKColorPickerWithKey(priceText);
}

-(void)setModel:(OrderModel *)model{
    _model = model;
    
    self.statusLabel.text = model.status_label;
    self.dingdanhaoLabel.text = model.rid;
    self.xiadanshijianLabel.text = model.created_at;
    self.nameLabel.text = model.name;
    self.beiZhuLabel.text = model.summary;
    self.wuliuLabel.text = model.express_name;
    self.yunDanHaoLabel.text = model.express_no;
    self.numLabel.text = model.items_count;
    self.feiYongLabel.text = [NSString stringWithFormat:@"￥%@/￥%@", model.pay_money, model.freight];
}

-(void)setOrderDetailModel:(OrderDetailModel *)orderDetailModel{
    _orderDetailModel = orderDetailModel;
    self.ridLabel.text = orderDetailModel.rid;
    self.wuliugongsiLabel.text = orderDetailModel.express_company;
    self.maijiaBeizhuLabel.text = orderDetailModel.summary;
    if ([orderDetailModel.delivery_type isEqualToString:@"1"]) {
        self.shouhuoFangShiLabel.text = @"快递";
    } else if ([orderDetailModel.delivery_type isEqualToString:@"2"]) {
        self.shouhuoFangShiLabel.text = @"自提";
    }
    self.yunDanHaoLabell.text = orderDetailModel.express_no;
    self.userNameLabel.text = orderDetailModel.userName;
    self.phoneLabel.text = orderDetailModel.phone;
    self.shouhuoDiZhiLabel.text = orderDetailModel.address;
    self.zipLabel.text = orderDetailModel.zip;
    self.frieghtLabel.text = orderDetailModel.freight;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:orderDetailModel.items[0][@"cover_url"]] placeholderImage:[UIImage imageNamed:@"Bitmap"]];
    self.skuId.text = [NSString stringWithFormat:@"%@", orderDetailModel.items[0][@"sku"]];
    self.goodsName.text = [NSString stringWithFormat:@"%@", orderDetailModel.items[0][@"name"]];
    self.numLabell.text = self.model.items_count;
    self.samplePrice.text = [NSString stringWithFormat:@"%@", orderDetailModel.items[0][@"price"]];
    self.statuLabel.text = self.model.status_label;
}

@end
