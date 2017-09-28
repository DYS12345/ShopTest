//
//  CategoryTableViewCell.m
//  ShopTest
//
//  Created by dong on 2017/9/6.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "CategoryTableViewCell.h"
#import "DKNightVersion.h"

@implementation CategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setSelectedTag:(NSString *)selectedTag{
    _selectedTag = selectedTag;
    [self.btn dk_setTitleColorPicker:DKColorPickerWithKey(btnNormal) forState:UIControlStateNormal];
    [self.btn dk_setTitleColorPicker:DKColorPickerWithKey(btnSelected) forState:UIControlStateSelected];
    if ([self.btn.titleLabel.text isEqualToString:@"全部"]) {
        if ([selectedTag isEqualToString:@""]) {
            self.btn.selected = YES;
        } else {
            self.btn.selected = NO;
        }
        return;
    }
    if ([selectedTag isEqualToString:self.btn.titleLabel.text]) {
        self.btn.selected = YES;
    } else {
        self.btn.selected = NO;
    }
}

@end
