//
//  SearchViewController.h
//  ShopTest
//
//  Created by dong on 2017/9/14.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchViewControllerDelegate <NSObject>

-(void)pushNot;

@end

@interface SearchViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *tagAry;
@property (nonatomic, strong) UINavigationController *navi;
@property (nonatomic, weak) id <SearchViewControllerDelegate>delegate;
@property (nonatomic, assign) BOOL flag;

@end
