//
//  GoodsCollectionViewCell.m
//  ShopTest
//
//  Created by dong on 2017/8/31.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "GoodsCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "DKNightVersion.h"
#import "SearchListModel.h"

@interface GoodsCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *piceLabel;

@end

@implementation GoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
    self.contentView.layer.borderWidth = 1;

    self.bgView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.titleLabel.dk_textColorPicker = DKColorPickerWithKey(GoodsTEXT);
    self.princeLabel.dk_textColorPicker = DKColorPickerWithKey(priceText);
}

-(void)setModel:(RowsModel *)model{
    [self.goodsImagView sd_setImageWithURL:[NSURL URLWithString:model.product.cover_url] placeholderImage:[UIImage imageNamed:@"Bitmap"]];
    self.goodsTitle.text = model.product.short_title;
    self.princeLabel.text = [NSString stringWithFormat:@"￥%@", model.product.sale_price];
}

-(void)setSearchListModel:(SearchListModel *)searchListModel{
    [self.goodsImagView sd_setImageWithURL:[NSURL URLWithString:searchListModel.cover_url] placeholderImage:[UIImage imageNamed:@"Bitmap"]];
    self.goodsTitle.text = searchListModel.title;
    self.princeLabel.text = [NSString stringWithFormat:@"￥%@", searchListModel.sale_price];
}

@end
