//
//  SalesOrderTableViewCell.m
//  ShopTest
//
//  Created by 董永胜 on 2017/9/21.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "SalesOrderTableViewCell.h"
#import "ChartsSwift.h"

@interface SalesOrderTableViewCell ()

@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;

@end

@implementation SalesOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
