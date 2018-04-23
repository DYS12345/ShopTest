//
//  GoodsViewController.m
//  ShopTest
//
//  Created by dong on 2017/8/30.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "GoodsViewController.h"
#import "FBAPI.h"
#import "RowsModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "GoodsCollectionViewCell.h"
#import "QRCodeScanViewController.h"
#import "CategoryViewController.h"
#import "UIView+FSExtension.h"
#import "GoodsDetailViewController.h"
#import "UserModel.h"
#import "DKNightVersion.h"
#import "ThemeViewController.h"
#import "UserViewController.h"
#import "SearchViewController.h"
#import "SearchResultListViewController.h"
#import "SearchHistoryModel.h"
#import "SVProgressHUD.h"
#import "ValidationViewController.h"
#import "FBConfig.h"
#import "DongApplication.h"
#import "GoodsDetailModel.h"
#import "ShowPoictureStaticViewController.h"
#import "ShowPictureViewController.h"

@interface GoodsViewController () <UICollectionViewDelegate, UICollectionViewDataSource, CategoryViewControllerDelegate, UITextFieldDelegate, SearchViewControllerDelegate, UserViewControllerDelegate>

@property (nonatomic, copy) NSString *currentPage;
@property (nonatomic, copy) NSString *total_rows;
@property (nonatomic, strong) NSMutableArray *modelAry;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *tagsAry;
@property (nonatomic, copy) NSString *selectedTag;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIButton *canBtn;
@property (weak, nonatomic) IBOutlet UIImageView *logoImagView;
@property (weak, nonatomic) IBOutlet UIButton *userBtn;
@property (weak, nonatomic) IBOutlet UIView *naviBarView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;
@property (weak, nonatomic) IBOutlet UIButton *themeBtn;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (strong, nonatomic) SearchViewController *searchVC;
@property (strong, nonatomic) NSArray *imageModelAry;
@property (nonatomic, strong) NSMutableArray *imageUrlAry;
@property (nonatomic, strong) NSMutableArray *idOAry;
@property (nonatomic, assign) BOOL flag;

@end

@implementation GoodsViewController

-(NSMutableArray *)idOAry{
    if (!_idOAry) {
        _idOAry = [NSMutableArray array];
    }
    return _idOAry;
}

-(NSMutableArray *)tagsAry{
    if (!_tagsAry) {
        _tagsAry = [NSMutableArray array];
    }
    return _tagsAry;
}

-(NSMutableArray *)imageUrlAry{
    if (!_imageUrlAry) {
        _imageUrlAry = [NSMutableArray array];
    }
    return _imageUrlAry;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

-(SearchViewController *)searchVC{
    if (!_searchVC) {
        _searchVC = [SearchViewController new];
        self.searchVC.preferredContentSize = CGSizeMake(350/2+30, 100);
        _searchVC.delegate = self;
    }
    return _searchVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.flag = YES;
    
    self.menuImageView.dk_imagePicker = DKImagePickerWithNames(@"classification",@"classificationHong",@"classification",@"classificationJin");
    [self.canBtn dk_setImage:DKImagePickerWithNames(@"Combined Shape",@"Combined ShapeHong",@"Combined Shape",@"Combined ShapeJin") forState:UIControlStateNormal];
    [self.themeBtn dk_setImage:DKImagePickerWithNames(@"Search",@"SearchRed",@"Search",@"SearchGolden") forState:UIControlStateNormal];
    self.logoImagView.dk_imagePicker = DKImagePickerWithNames(@"logo-1",@"logoHong",@"logo-1",@"logoHong");
    self.userImageView.dk_imagePicker = DKImagePickerWithNames(@"PersonalCenter",@"gerenHong",@"PersonalCenter",@"gerenJin");
    self.naviBarView.dk_backgroundColorPicker = DKColorPickerWithKey(naviBarViewBG);
    self.searchView.dk_backgroundColorPicker = DKColorPickerWithKey(searchViewBG);
    
    self.menuBtn.userInteractionEnabled = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GoodsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GoodsCollectionViewCell"];
    
    UserModel *userModel = [[UserModel findAll] lastObject];
    NSDictionary *param = @{
                            @"id" : userModel.storage_id
                            };
    NSLog(@"sadasdas  %@", userModel.storage_id);
    FBRequest *request = [FBAPI postWithUrlString:@"/scene_scene/view" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        NSLog(@"sadasdas  %@", result);
        self.menuBtn.userInteractionEnabled = YES;
        [self.tagsAry removeAllObjects];
        [self.tagsAry addObjectsFromArray:result[@"data"][@"product_tags"]];
        [self.tagsAry insertObject:@"全部" atIndex:0];
        self.selectedTag = self.tagsAry[0];
        [self setupRefresh];
    } failure:^(FBRequest *request, NSError *error) {
    }];
    
    self.searchTF.delegate = self;
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    self.searchVC.flag = NO;
    NSString *str = [NSString stringWithFormat:@"%@%@", textField.text, string];
    NSDictionary *param = @{
                            @"q" : str,
                            @"size" : @(4)
                            };
    FBRequest *request = [FBAPI postWithUrlString:@"/search/expanded" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        NSArray *strAry = result[@"data"][@"data"][@"swords"];
        self.searchVC.preferredContentSize = CGSizeMake(350/2+30, strAry.count*45);
        self.searchVC.tagAry = (NSMutableArray*)strAry;
    } failure:^(FBRequest *request, NSError *error) {
        
    }];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入搜索内容"];
        return YES;
    }
    [textField resignFirstResponder];
    [self.searchVC dismissViewControllerAnimated:YES completion:^{
        SearchResultListViewController *vc = [SearchResultListViewController new];
        vc.searchStr = textField.text;
        textField.text = @"";
        
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
        
        [self.navigationController pushViewController:vc animated:YES];
    }];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.searchVC.flag = YES;
    UIView *sender = self.searchView;
    self.searchVC.navi = self.navigationController;
    self.searchVC.modalPresentationStyle = UIModalPresentationPopover;
    self.searchVC.popoverPresentationController.sourceView = self.view;
    self.searchVC.popoverPresentationController.sourceRect = CGRectMake(sender.x-3, sender.y+3, sender.width, sender.height);
    self.searchVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    
    NSArray *ary = [SearchHistoryModel findAll];
    NSMutableArray *mAry = [NSMutableArray array];
    for (SearchHistoryModel *model in ary) {
        [mAry addObject:model.keyStr];
    }
    self.searchVC.preferredContentSize = CGSizeMake(350/2+30, (ary.count+1)*45);
    self.searchVC.tagAry = mAry;
    
    [self presentViewController:self.searchVC animated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    UserModel *usermodel = [[UserModel findAll] lastObject];
    if ([usermodel.theme isEqualToString:@"normal"]) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

-(NSMutableArray *)modelAry{
    if (!_modelAry) {
        _modelAry = [NSMutableArray array];
    }
    return _modelAry;
}

-(void)setupRefresh{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    // 自动改变透明度
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.collectionView.mj_footer.hidden = YES;
}

-(void)loadMore{
    [self.collectionView.mj_header endRefreshing];
    NSInteger n = [self.currentPage integerValue];
    if ([self.selectedTag isEqualToString:@"全部"]) {
        self.selectedTag = @"";
    }
    UserModel *userModel = [[UserModel findAll] lastObject];
    NSDictionary *param = @{
                            @"page" : @(++n),
                            @"size" : @(16),
                            @"sort" : @(1),
                            @"scene_id" :userModel.storage_id,
                            @"tag" : self.selectedTag
                            };
    FBRequest *request = [FBAPI postWithUrlString:@"/scene_scene/product_list" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        [self.collectionView.mj_footer endRefreshing];
        self.currentPage = result[@"data"][@"current_page"];
        self.total_rows = result[@"data"][@"total_rows"];
        [self.modelAry addObjectsFromArray:[RowsModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]]];
        [self.collectionView reloadData];
        [self checkFooterState];
    } failure:^(FBRequest *request, NSError *error) {
        
    }];
}

-(void)loadNew{
    [self.collectionView.mj_footer endRefreshing];
    self.currentPage = @"1";
    if ([self.selectedTag isEqualToString:@"全部"]) {
        self.selectedTag = @"";
    }
    UserModel *userModel = [[UserModel findAll] lastObject];
    NSLog(@"dasdasdsa %@", [UserModel findAll]);
    NSDictionary *param = @{
                            @"page" : self.currentPage,
                            @"size" : @(16),
                            @"sort" : @(1),
                            @"scene_id" :userModel.storage_id,
                            @"tag" : self.selectedTag
                            };
    FBRequest *request = [FBAPI postWithUrlString:@"/scene_scene/product_list" requestDictionary:param delegate:self];
    [request startRequestSuccess:^(FBRequest *request, id result) {
        NSLog(@"sdasdsadsa %@", result);
        [self.collectionView.mj_header endRefreshing];
        self.currentPage = result[@"data"][@"current_page"];
        self.total_rows = result[@"data"][@"total_rows"];
        self.modelAry = [RowsModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]];
        [self.collectionView reloadData];
        [self checkFooterState];
        
        if (self.flag) {
            self.flag = NO;
            
            NSDictionary *param1 = @{
                                     @"page" : @(1),
                                     @"size" : @([self.total_rows integerValue]),
                                     @"sort" : @(1),
                                     @"scene_id" :userModel.storage_id,
                                     @"tag" : @""
                                     };
            FBRequest *request1 = [FBAPI postWithUrlString:@"/scene_scene/product_list" requestDictionary:param1 delegate:self];
            [request1 startRequestSuccess:^(FBRequest *request, id result) {
                self.imageModelAry = [RowsModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]];
                for (int i = 0; i<self.imageModelAry.count; i++) {
                    RowsModel *model = self.imageModelAry[i];
                    NSDictionary *param2 = @{
                                             @"id" : model.product_id
                                             };
                    FBRequest *request2 = [FBAPI postWithUrlString:@"/product/view" requestDictionary:param2 delegate:self];
                    [request2 startRequestSuccess:^(FBRequest *request, id result) {
                        GoodsDetailModel *detailModel = [GoodsDetailModel mj_objectWithKeyValues:result[@"data"]];
                        NSArray *ary;
                        if (detailModel.pad_asset.count == 0) {
                            ary = detailModel.asset;
                        } else {
                            ary = detailModel.pad_asset;
                        }
                        NSMutableArray *idAry = [NSMutableArray array];
                        NSString *idStr = model.product_id;
                        for (int i = 0; i<ary.count; i++) {
                            [idAry addObject:idStr];
                        }
                        [self.idOAry addObjectsFromArray:idAry];
                        [self.imageUrlAry addObjectsFromArray:ary];
                        ((DongApplication*)[DongApplication sharedApplication]).imageUrlAry = [NSArray arrayWithArray:self.imageUrlAry];
                        ((DongApplication*)[DongApplication sharedApplication]).idOAry = [NSArray arrayWithArray:self.idOAry];
                        
                        
                        UISwipeGestureRecognizer * recognizer;
                        recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom)];
                        [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
                        [self.collectionView addGestureRecognizer:recognizer];
                    } failure:^(FBRequest *request, NSError *error) {
                        
                    }];
                }
            } failure:^(FBRequest *request, NSError *error) {
                
            }];
        }
        
        
    } failure:^(FBRequest *request, NSError *error) {
        
    }];
}

-(void)handleSwipeFrom{
    [((DongApplication*)[DongApplication sharedApplication]) resetIdleTimer:1000000000];
    ShowPictureViewController *vc = [ShowPictureViewController new];
    ((UIApplication*)[UIApplication sharedApplication]).keyWindow.rootViewController = vc;
}

-(void)pushNot{
    self.searchTF.text = @"";
    [self.searchTF resignFirstResponder];
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
    RowsModel *model = self.modelAry[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsDetailViewController *vc = [GoodsDetailViewController new];
    RowsModel *model = self.modelAry[indexPath.row];
    vc.infoId = model.product._id;
    [self presentViewController:vc animated:YES completion:nil];
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(470/2*SCREEN_WIDTH/1024.0, (470/2+55)*SCREEN_WIDTH/1024.0);
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

- (IBAction)scan:(id)sender {
    QRCodeScanViewController *vc = [QRCodeScanViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)menu:(UIButton*)sender {
    CategoryViewController *vc = [[CategoryViewController alloc] init];
    vc.delegate = self;
    vc.modalPresentationStyle = UIModalPresentationPopover;
    vc.popoverPresentationController.sourceView = self.view;
    vc.popoverPresentationController.sourceRect = CGRectMake(sender.x+4, sender.y, sender.width, sender.height);
    vc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    vc.preferredContentSize = CGSizeMake(150, (self.tagsAry.count)*50);
    vc.modelAry = self.tagsAry;
    BOOL flag = YES;
    for (int i = 0; i<self.modelAry.count-1; i++) {
        RowsModel *model = self.modelAry[i];
        RowsModel *modelNext = self.modelAry[i+1];
        if (![model.tag isEqualToString:modelNext.tag]) {
            flag = NO;
        }
    }
    if (flag) {
        RowsModel *model = self.modelAry[0];
        vc.selectedTag = model.tag;
    } else {
        vc.selectedTag = @"";
    }
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)selectedTag:(NSString *)tag{
    self.selectedTag = tag;
    [self setupRefresh];
}

- (IBAction)user:(UIButton*)sender {
    UserViewController *vc = [[UserViewController alloc] init];
    vc.delegate = self;
    vc.navi = self.navigationController;
    vc.goodsVc = self;
    vc.modalPresentationStyle = UIModalPresentationPopover;
    vc.popoverPresentationController.sourceView = self.view;
    vc.popoverPresentationController.sourceRect = CGRectMake(sender.x-3, sender.y, sender.width, sender.height);
    vc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    vc.preferredContentSize = CGSizeMake(350/2, 440/2);
    [self presentViewController:vc animated:YES completion:nil];
}

-(UIImage*)fullScreenshots{
    
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return viewImage;
}

-(void)orderDismiss{
    ValidationViewController *vc = [ValidationViewController new];
    vc.c = 2;
    vc.image = [self fullScreenshots];
    vc.navi = self.navigationController;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:^{
    }];
}

-(void)consoleDismiss{
    ValidationViewController *vc = [ValidationViewController new];
    vc.c = 1;
    vc.image = [self fullScreenshots];
    vc.navi = self.navigationController;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:^{
    }];
}

//改成搜索
- (IBAction)theme:(UIButton*)sender {
    
}

@end
