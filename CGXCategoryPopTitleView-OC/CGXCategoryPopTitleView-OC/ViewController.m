//
//  ViewController.m
//  CGXCategoryPopTitleView-OC
//
//  Created by MacMini-1 on 2019/7/2.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "ViewController.h"
#import "CGXCategoryPopTitleView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"弹出" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)rightItemClicked
{
     NSMutableArray *arr1 = [[NSMutableArray alloc] initWithObjects:@"要闻",@"河北",@"财经",@"娱乐",@"体育",@"社会",@"NBA",@"视频",@"汽车",@"图片",@"科技",@"军事",@"国际",@"数码",@"星座",@"电影",@"时尚",@"文化",@"游戏",@"教育",@"动漫",@"政务",@"纪录片",@"房产",@"佛学",@"股票",@"理财",@"有声",@"家居",@"电竞",@"美容",@"电视剧",@"搏击",@"健康",@"摄影",@"生活",@"旅游",@"韩流",@"探索",@"综艺",@"美食",@"育儿",@"红烧全部", @"麻辣龙虾", @"美味便宜好货", @"胡萝卜", @"清甜生活", @"母婴", @"美味香蕉", @"时尚", @"麻辣干锅", @"剁椒鱼头", @"鸳鸯火锅", nil];
    
    NSMutableArray *dataArr= [NSMutableArray array];
    for (int i = 0; i<arr1.count; i++) {
        CGXCategoryPopTitleCellModel *model = [[CGXCategoryPopTitleCellModel alloc] init];
        model.title = arr1[i];
        [dataArr addObject:model];
    }
    CGXCategoryPopTitleView *popView = [CGXCategoryPopTitleView sharedSingleton];
    popView.isAdaptive = NO;
    popView.rowHeight = 40;
    popView.topSpace = [[UIApplication sharedApplication] statusBarFrame].size.height+44.0;;
    popView.row = 3;
    popView.insets = UIEdgeInsetsMake(10, 10, 10, 10);
    popView.minimumInteritemSpacing = 10;
    popView.minimumLineSpacing = 10;
    [popView showPopViewArray:dataArr SelectBlock:^(CGXCategoryPopTitleCellModel * _Nonnull model) {
        NSLog(@"channels--%@" , model.title);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [popView dismissPopView];
        });
    }];
    [popView showUpdateCellShowBlock:^(CGXCategoryPopTitleCell * _Nonnull cell) {
       NSLog(@"cell--%@" , cell);
        cell.titleLabel.backgroundColor = [UIColor whiteColor];
    }];
    
}

@end
