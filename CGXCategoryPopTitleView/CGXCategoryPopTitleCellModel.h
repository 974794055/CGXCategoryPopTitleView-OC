//
//  CGXCategoryPopTitleCellModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2019/5/8.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryPopTitleCellModel : NSObject

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, assign) NSInteger titleNumberOfLines;

@property (nonatomic, strong) UIColor *titleNormalColor;

@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIFont *titleSelectedFont;

@property (nonatomic, strong) UIColor *titleBgColor;


@end

NS_ASSUME_NONNULL_END
