//
//  SkuCollectionViewCell.m
//  ShopTest
//
//  Created by dong on 2017/9/18.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "SkuCollectionViewCell.h"
#import "DKNightVersion.h"
#import "UIColor+Extension.h"

@implementation SkuCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.cornerRadius = 3;
    self.btn.layer.borderColor = [UIColor colorWithHexString:@"#979797"].CGColor;
    self.btn.layer.borderWidth = 1;
    [self.btn dk_setBackgroundImage:DKImagePickerWithNames(@"black", @"redBtnBg", @"redBtnBg", @"Golden") forState:UIControlStateSelected];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];

}

-(void)setStr:(NSString *)str{
    _str = str;
    [self.btn setTitle:str forState:UIControlStateNormal];
}

-(void)setSelectedStr:(NSString *)selectedStr{
    _selectedStr = selectedStr;
    if ([selectedStr isEqualToString:@"1"]) {
        self.btn.selected = YES;
        self.btn.userInteractionEnabled = NO;
    } else {
        self.btn.selected = NO;
        self.btn.userInteractionEnabled = YES;
    }
}

@end
