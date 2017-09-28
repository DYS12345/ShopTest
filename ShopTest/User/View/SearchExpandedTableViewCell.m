//
//  SearchExpandedTableViewCell.m
//  ShopTest
//
//  Created by dong on 2017/9/15.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "SearchExpandedTableViewCell.h"

@interface SearchExpandedTableViewCell ()



@end

@implementation SearchExpandedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
