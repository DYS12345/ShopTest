//
//  ConsoleViewController.m
//  ShopTest
//
//  Created by 董永胜 on 2017/9/21.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "ConsoleViewController.h"
#import "DKNightVersion.h"
#import "SalesOrderTableViewCell.h"
#import "FBConfig.h"
#import "FBAPI.h"

@interface ConsoleViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *naviView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ConsoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImageView.dk_imagePicker = DKImagePickerWithNames(@"back",@"icon_back_red",@"back",@"icon_back_Golden");
    self.logoImageView.dk_imagePicker = DKImagePickerWithNames(@"logo-1",@"logoHong",@"logo-1",@"logoHong");
    self.naviView.dk_backgroundColorPicker = DKColorPickerWithKey(naviBarViewBG);
    
    self.tableView.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"SalesOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"SalesOrderTableViewCell"];
    
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *current_date_str = [date_formatter stringFromDate:[NSDate date]];
    NSTimeInterval  oneDay = 24*60*60*1;
    NSDate *theDate = [NSDate dateWithTimeInterval:-oneDay*30*12 sinceDate:[NSDate date]];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    
//    FBRequest *request = [FBAPI postWithUrlString:@"" requestDictionary:<#(NSDictionary *)#> delegate:<#(id)#>]
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"start_time"] = startTime;
//    params[@"end_time"] = endTime;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    params[@"token"] = [defaults objectForKey:@"token"];
//    [manager GET:[kDomainBaseUrl stringByAppendingString:@"survey/salesTrends"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSArray *rows = responseObject[@"data"];
//        self.modelAry = [SalesTrendsModel mj_objectArrayWithKeyValuesArray:rows];
//        if ([self.sDelegate respondsToSelector:@selector(getSalesTrendsModel:)]) {
//            [self.sDelegate getSalesTrendsModel:self.modelAry];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SalesOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalesOrderTableViewCell"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 0.39*SCREEN_HEIGHT;
    }
    return 0;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
