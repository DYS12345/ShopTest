//
//  CategoryTableViewCell.h
//  ShopTest
//
//  Created by dong on 2017/9/6.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, copy) NSString *selectedTag;

@end
