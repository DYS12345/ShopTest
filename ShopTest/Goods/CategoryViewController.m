//
//  CategoryViewController.m
//  ShopTest
//
//  Created by dong on 2017/9/1.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "CategoryViewController.h"
#import "UIView+FSExtension.h"
#import "UIColor+Extension.h"
#import "Masonry.h"
#import "CategoryTableViewCell.h"

@interface CategoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CategoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"CategoryTableViewCell"];
    self.tableView.rowHeight = 50;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    }
    return _lineView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCell"];
    [cell.btn setTitle:self.modelAry[indexPath.row] forState:UIControlStateNormal];
    cell.selectedTag = self.selectedTag;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView reloadData];
    CategoryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(selectedTag:)]) {
        [self.delegate selectedTag:cell.btn.titleLabel.text];
    }
    for (int i = 0; i<self.modelAry.count; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        CategoryTableViewCell *cell = [tableView cellForRowAtIndexPath:index];
        cell.btn.selected = NO;
    }
    cell.btn.selected = YES;
}

@end
