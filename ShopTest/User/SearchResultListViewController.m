//
//  SearchResultListViewController.m
//  ShopTest
//
//  Created by dong on 2017/9/15.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "SearchResultListViewController.h"
#import "FBAPI.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "DKNightVersion.h"
#import "RowsModel.h"
#import "GoodsCollectionViewCell.h"
#import "GoodsDetailViewController.h"
#import "SearchListModel.h"

@interface SearchResultListViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *navigationBarView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, copy) NSString *currentPage;
@property (nonatomic, copy) NSString *total_rows;
@property (nonatomic, strong) NSMutableArray *modelAry;

@end

@implementation SearchResultListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.logoImageView.dk_imagePicker = DKImagePickerWithNames(@"logo-1",@"logoHong",@"logo-1",@"logoHong");
    self.navigationBarView.dk_backgroundColorPicker = DKColorPickerWithKey(naviBarViewBG);
    [self.backBtn dk_setImage:DKImagePickerWithNames(@"back", @"icon_back_red", @"back", @"icon_back_Golden") forState:UIControlStateNormal];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GoodsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GoodsCollectionViewCell"];
    
    [self setupRefresh];
}

-(void)setupRefresh{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    // 自动改变透明度
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.collectionView.mj_footer.hidden = YES;
}

-(NSMutableArray *)modelAry{
    if (!_modelAry) {
        _modelAry = [NSMutableArray array];
    }
    return _modelAry;
}

-(void)loadMore{
    [self.collectionView.mj_header endRefreshing];
    NSInteger n = [self.currentPage integerValue];
    NSDictionary *param = @{
                            @"page" : @(++n),
                            @"size" : @(16),
                            @"q" : self.searchStr
                            };
    FBRequest *request = [FBAPI postWithUrlString:@"/search/getlist" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        [self.collectionView.mj_footer endRefreshing];
        self.currentPage = result[@"data"][@"current_page"];
        self.total_rows = result[@"data"][@"total_count"];
        [self.modelAry addObjectsFromArray:[SearchListModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]]];
        [self.collectionView reloadData];
        [self checkFooterState];
    } failure:^(FBRequest *request, NSError *error) {
        
    }];
}

-(void)loadNew{
    [self.collectionView.mj_footer endRefreshing];
    self.currentPage = @"1";
    NSDictionary *param = @{
                            @"page" : self.currentPage,
                            @"size" : @(16),
                            @"q" : self.searchStr
                            };
    FBRequest *request = [FBAPI postWithUrlString:@"/search/getlist" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        NSLog(@"hurureuuf  %@", result);
        [self.collectionView.mj_header endRefreshing];
        self.currentPage = result[@"data"][@"current_page"];
        self.total_rows = result[@"data"][@"total_count"];
        self.modelAry = [SearchListModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]];
        [self.collectionView reloadData];
        [self checkFooterState];
    } failure:^(FBRequest *request, NSError *error) {
        
    }];
}

-(void)checkFooterState{
    self.collectionView.mj_footer.hidden = self.modelAry.count == 0;
    if (self.modelAry.count == [self.total_rows integerValue]) {
        self.collectionView.mj_footer.hidden = YES;
    }else{
        [self.collectionView.mj_footer endRefreshing];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelAry.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCollectionViewCell" forIndexPath:indexPath];
    SearchListModel *model = self.modelAry[indexPath.row];
    cell.searchListModel = model;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsDetailViewController *vc = [GoodsDetailViewController new];
    SearchListModel *model = self.modelAry[indexPath.row];
    vc.infoId = model._id;
    [self presentViewController:vc animated:YES completion:nil];
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(470/2, 470/2+55);
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20.0f, 20, 20.0f);
}

- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 14;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
