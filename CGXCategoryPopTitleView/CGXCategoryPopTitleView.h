//
//  CGXCategoryPopTitleView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2019/5/8.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCategoryPopTitleCell.h"
#import "CGXCategoryPopTitleCellModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^CGXCategoryPopTitleViewSelectBlock)(CGXCategoryPopTitleCellModel *model);
typedef void(^CGXCategoryPopTitleViewShowCellBlock)(CGXCategoryPopTitleCell *cell);
@interface CGXCategoryPopTitleView : UIView

+(CGXCategoryPopTitleView *)sharedSingleton;

@property (nonatomic , assign) CGFloat topSpace;//顶部透明距离 默认导航条高度
@property (nonatomic , assign) BOOL isAdaptive;//自适应高度
@property (nonatomic , assign) NSInteger minimumLineSpacing;//默认是10
@property (nonatomic , assign) NSInteger minimumInteritemSpacing;//默认是10
@property (nonatomic) UIEdgeInsets insets;//默认是10
@property (nonatomic , assign) NSInteger row;//默认4个
@property (nonatomic , assign) CGFloat rowHeight;//默认40
/**
 显示方法 结束时返回的是正在使用中的频道集合
 */
-(void)showPopViewArray:(NSMutableArray<CGXCategoryPopTitleCellModel *>*)dataArray  SelectBlock:(CGXCategoryPopTitleViewSelectBlock)selectBlock;
/**
 自定义设置显示
 */
-(void)showUpdateCellShowBlock:(CGXCategoryPopTitleViewShowCellBlock)showCellBlcok;

- (void)dismissPopView;

@end

NS_ASSUME_NONNULL_END
