//
//  SkuCollectionViewCell.h
//  ShopTest
//
//  Created by dong on 2017/9/18.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkuCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (copy, nonatomic) NSString *str;
@property (copy, nonatomic) NSString *selectedStr;

@end
