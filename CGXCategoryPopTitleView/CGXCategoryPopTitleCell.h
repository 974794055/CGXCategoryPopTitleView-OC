//
//  CGXCategoryPopTitleCell.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2019/5/8.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCategoryPopTitleCellModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryPopTitleCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

- (void)updateWithModel:(CGXCategoryPopTitleCellModel *)model;
@end

NS_ASSUME_NONNULL_END
