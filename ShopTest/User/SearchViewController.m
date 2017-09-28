//
//  SearchViewController.m
//  ShopTest
//
//  Created by dong on 2017/9/14.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchExpandedTableViewCell.h"
#import "SearchResultListViewController.h"
#import "SearchHistoryModel.h"
#import "HistoryTopTableViewCell.h"

@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchExpandedTableViewCell" bundle:nil] forCellReuseIdentifier:@"SearchExpandedTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryTopTableViewCell" bundle:nil] forCellReuseIdentifier:@"HistoryTopTableViewCell"];
    self.tableView.rowHeight = 45;
}

-(void)setTagAry:(NSMutableArray *)tagAry{
    _tagAry = tagAry;
    [self.tableView reloadData];
}

-(void)setFlag:(BOOL)flag{
    _flag = flag;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_flag) {
        return self.tagAry.count+1;
    }
    return self.tagAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_flag) {
        if (indexPath.row == 0) {
            HistoryTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryTopTableViewCell"];
            [cell.deletBtn addTarget:self action:@selector(delet) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        SearchExpandedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchExpandedTableViewCell"];
        cell.contentLabel.text = self.tagAry[indexPath.row-1];
        return cell;
    }
    SearchExpandedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchExpandedTableViewCell"];
    cell.contentLabel.text = self.tagAry[indexPath.row];
    return cell;
}

-(void)delet{
    [SearchHistoryModel clearTable];
    [self.tagAry removeAllObjects];
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_flag) {
        if (indexPath.row > 0) {
            [self dismissViewControllerAnimated:YES completion:^{
                SearchResultListViewController *vc = [SearchResultListViewController new];
                vc.searchStr = self.tagAry[indexPath.row-1];
                if ([self.delegate respondsToSelector:@selector(pushNot)]) {
                    [self.delegate pushNot];
                }
                
                BOOL flag = YES;
                for (SearchHistoryModel *model in [SearchHistoryModel findAll]) {
                    if ([vc.searchStr isEqualToString:model.keyStr]) {
                        flag = NO;
                    }
                }
                if (flag == NO) {
                    
                } else {
                    if ([SearchHistoryModel findAll].count == 10) {
                        SearchHistoryModel *model = [SearchHistoryModel findAll][0];
                        [model deleteObject];
                    }
                    SearchHistoryModel *model = [SearchHistoryModel new];
                    model.keyStr = vc.searchStr;
                    [model saveOrUpdate];
                }
                
                [self.navi pushViewController:vc animated:YES];
            }];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            SearchResultListViewController *vc = [SearchResultListViewController new];
            vc.searchStr = self.tagAry[indexPath.row];
            if ([self.delegate respondsToSelector:@selector(pushNot)]) {
                [self.delegate pushNot];
            }
            
            BOOL flag = YES;
            for (SearchHistoryModel *model in [SearchHistoryModel findAll]) {
                if ([vc.searchStr isEqualToString:model.keyStr]) {
                    flag = NO;
                }
            }
            if (flag == NO) {
                
            } else {
                if ([SearchHistoryModel findAll].count == 10) {
                    SearchHistoryModel *model = [SearchHistoryModel findAll][0];
                    [model deleteObject];
                }
                SearchHistoryModel *model = [SearchHistoryModel new];
                model.keyStr = vc.searchStr;
                [model saveOrUpdate];
            }
            
            [self.navi pushViewController:vc animated:YES];
        }];
    }
}

@end
