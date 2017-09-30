//
//  OrderViewController.m
//  ShopTest
//
//  Created by dong on 2017/9/19.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "OrderViewController.h"
#import "DKNightVersion.h"
#import "AllOrderViewController.h"
#import "OrderZiTiViewController.h"
#import "KuaiDiOrderViewController.h"
#import "UIColor+Extension.h"
#import "FBConfig.h"
#import "UIView+FSExtension.h"
#import "OrderTopTableViewCell.h"
#import "OrderTableViewCell.h"
#import "FBAPI.h"
#import "UserModel.h"
#import "MJExtension.h"
#import "OrderModel.h"
#import "OrderDetailModel.h"
#import "MJRefresh.h"
#import "DKNightVersion.h"

@interface OrderViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIView *naviView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIButton *allOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *zitiBtn;
@property (weak, nonatomic) IBOutlet UIButton *kuaiDiBtn;
@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, assign) NSInteger selectedN;
@property (nonatomic, strong) NSArray *btnAry;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modelAry;
@property (nonatomic, strong) NSMutableArray *orderDetailModelAry;
@property (nonatomic, strong) NSMutableArray *modelAryl; //中间变量
@property (nonatomic, strong) NSMutableArray *orderDetailModelAryl; //中间变量
@property (nonatomic, copy) NSString *currentPage;
@property (nonatomic, copy) NSString *total_rows;

@end

@implementation OrderViewController

-(NSMutableArray *)modelAry{
    if (!_modelAry) {
        _modelAry = [NSMutableArray array];
    }
    return _modelAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImageView.dk_imagePicker = DKImagePickerWithNames(@"back",@"icon_back_red",@"back",@"icon_back_Golden");
    self.logoImageView.dk_imagePicker = DKImagePickerWithNames(@"logo-1",@"logoHong",@"logo-1",@"logoHong");
    self.naviView.dk_backgroundColorPicker = DKColorPickerWithKey(naviBarViewBG);
    
    [self.allOrderBtn dk_setTitleColorPicker:DKColorPickerWithKey(priceText) forState:UIControlStateDisabled];
    [self.allOrderBtn setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    [self.zitiBtn dk_setTitleColorPicker:DKColorPickerWithKey(priceText) forState:UIControlStateDisabled];
    [self.zitiBtn setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    [self.kuaiDiBtn dk_setTitleColorPicker:DKColorPickerWithKey(priceText) forState:UIControlStateDisabled];
    [self.kuaiDiBtn setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    self.btnAry = @[self.allOrderBtn, self.zitiBtn, self.kuaiDiBtn];
    self.allOrderBtn.enabled = NO;
    self.selectedButton = self.allOrderBtn;
 
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderTopTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderTopTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderZiTiTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderZiTiTableViewCell"];
    
    self.tableView.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
    
    [self setupRefresh];
    
    UserModel *usermodel = [[UserModel findAll] lastObject];
    self.currentPage = @"1";
    NSDictionary *param = @{
                            @"page" : self.currentPage,
                            @"size" : @(10),
                            @"status" : @(0),
                            @"storage_id" : usermodel.storage_id
                            };
    FBRequest *request = [FBAPI postWithUrlString:@"/shopping/orders" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        NSLog(@"uiuwefbhb %@", result);
        self.modelAry = [OrderModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]];
        self.modelAryl = [NSMutableArray arrayWithArray:self.modelAry];
        
        self.currentPage = result[@"data"][@"current_page"];
        self.total_rows = result[@"data"][@"total_rows"];
        
        [self.tableView reloadData];
        [self checkFooterState];
        
        for (int i = 0; i<self.modelAry.count; i++) {
            OrderModel *orderModel = self.modelAry[i];
            NSDictionary *param1 = @{
                                     @"rid" : orderModel.rid,
                                     @"storage_id" : usermodel.storage_id
                                     };
            FBRequest *request1 = [FBAPI postWithUrlString:@"/shopping/detail" requestDictionary:param1 delegate:self];
            [request1 startRequestSuccess:^(FBRequest *request, id result) {
                OrderDetailModel *orderDetailModel = [OrderDetailModel mj_objectWithKeyValues:result[@"data"]];
                [self.orderDetailModelAry addObject:orderDetailModel];
                self.orderDetailModelAryl = [NSMutableArray arrayWithArray:self.orderDetailModelAry];
            } failure:^(FBRequest *request, NSError *error) {
                
            }];
        }
        
    } failure:^(FBRequest *request, NSError *error) {
    }];
}

-(void)checkFooterState{
    self.tableView.mj_footer.hidden = self.modelAryl.count == 0;
    if (self.modelAryl.count == [self.total_rows integerValue]) {
        self.tableView.mj_footer.hidden = YES;
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
}

-(void)setupRefresh{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.mj_footer.hidden = YES;
}

-(void)loadMore{
    NSInteger n = [self.currentPage integerValue];
    UserModel *userModel = [[UserModel findAll] lastObject];
    NSDictionary *param = @{
                            @"page" : @(++n),
                            @"size" : @(10),
                            @"status" : @(0),
                            @"storage_id" : userModel.storage_id
                            };
    FBRequest *request = [FBAPI postWithUrlString:@"/shopping/orders" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        NSArray *ary = [OrderModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]];
        [self.modelAry addObjectsFromArray:ary];
        self.modelAryl = [NSMutableArray arrayWithArray:self.modelAry];
        self.currentPage = result[@"data"][@"current_page"];
        self.total_rows = result[@"data"][@"total_rows"];
        
        [self.tableView reloadData];
        [self checkFooterState];
        
        [self.orderDetailModelAry removeAllObjects];
        for (int i = 0; i<self.modelAry.count; i++) {
            OrderModel *orderModel = self.modelAry[i];
            NSDictionary *param1 = @{
                                     @"rid" : orderModel.rid,
                                     @"storage_id" : userModel.storage_id
                                     };
            FBRequest *request1 = [FBAPI postWithUrlString:@"/shopping/detail" requestDictionary:param1 delegate:self];
            [request1 startRequestSuccess:^(FBRequest *request, id result) {
                OrderDetailModel *orderDetailModel = [OrderDetailModel mj_objectWithKeyValues:result[@"data"]];
                [self.orderDetailModelAry addObject:orderDetailModel];
                self.orderDetailModelAryl = [NSMutableArray arrayWithArray:self.orderDetailModelAry];
            } failure:^(FBRequest *request, NSError *error) {
                
            }];
        }
        
    } failure:^(FBRequest *request, NSError *error) {
    }];
}

-(NSMutableArray *)orderDetailModelAry{
    if (!_orderDetailModelAry) {
        _orderDetailModelAry = [NSMutableArray array];
    }
    return _orderDetailModelAry;
}

- (IBAction)quanbuDingdan:(UIButton*)button {
    for (UIButton *btn in self.btnAry) {
        btn.backgroundColor = [UIColor clearColor];
    }
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    button.backgroundColor = [UIColor whiteColor];
    
    self.orderDetailModelAryl = [NSMutableArray arrayWithArray:self.orderDetailModelAry];
    self.modelAryl = [NSMutableArray arrayWithArray:self.modelAry];
    [self.tableView reloadData];
}

- (IBAction)zitiDingDan:(UIButton*)button {
    self.orderDetailModelAryl = [NSMutableArray arrayWithArray:self.orderDetailModelAry];
    self.modelAryl = [NSMutableArray arrayWithArray:self.modelAry];
    
    for (UIButton *btn in self.btnAry) {
        btn.backgroundColor = [UIColor clearColor];
    }
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    button.backgroundColor = [UIColor whiteColor];
    
    for (OrderModel *model in self.modelAry) {
        if ([model.delivery_type isEqualToString:@"1"]) {
            [self.modelAryl removeObject:model];
        }
    }
    for (OrderDetailModel *model in self.orderDetailModelAry) {
        if ([model.delivery_type isEqualToString:@"1"]) {
            [self.orderDetailModelAryl removeObject:model];
        }
    }
    [self.tableView reloadData];
}

- (IBAction)kuaiDiDingDan:(UIButton*)button {
    self.orderDetailModelAryl = [NSMutableArray arrayWithArray:self.orderDetailModelAry];
    self.modelAryl = [NSMutableArray arrayWithArray:self.modelAry];
    
    for (UIButton *btn in self.btnAry) {
        btn.backgroundColor = [UIColor clearColor];
    }
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    button.backgroundColor = [UIColor whiteColor];
    
    for (OrderModel *model in self.modelAry) {
        if ([model.delivery_type isEqualToString:@"2"]) {
            [self.modelAryl removeObject:model];
        }
    }
    for (OrderDetailModel *model in self.orderDetailModelAry) {
        if ([model.delivery_type isEqualToString:@"2"]) {
            [self.orderDetailModelAryl removeObject:model];
        }
    }
    [self.tableView reloadData];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelAryl.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        OrderTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTopTableViewCell"];
        return cell;
    }
    
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell"];
    cell.pullClickBtn.tag = indexPath.row;
    cell.model = self.modelAryl[indexPath.row-1];
    if (self.orderDetailModelAryl.count == self.modelAryl.count) {
        cell.orderDetailModel = self.orderDetailModelAryl[indexPath.row-1];
    }
    [cell.pullClickBtn addTarget:self action:@selector(pullClick:) forControlEvents:UIControlEventTouchUpInside];
    if (cell.pullBtn.selected) {
        cell.pullLabel.text = @"收起";
        cell.orderDetailView.hidden = NO;
    } else {
        cell.pullLabel.text = @"详情";
        cell.orderDetailView.hidden = YES;
    }
    return cell;
}

-(void)pullClick:(UIButton*)sender{
    for (int i = 1; i<self.modelAryl.count+1; i++) {
        OrderTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (i == sender.tag) {
            continue;
        }
        cell.pullClickBtn.selected = NO;
        cell.pullBtn.selected = NO;
    }
    sender.selected = !sender.selected;
    OrderTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    cell.pullBtn.selected = !cell.pullBtn.selected;
    if (sender.selected) {
        self.selectedN = sender.tag;
    } else {
        self.selectedN = 0;
    }
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 40;
    }
    if (self.selectedN != 0) {
        if (indexPath.row == self.selectedN) {
            return 710/2+50;
        }
    }
    return 50;
}

@end
