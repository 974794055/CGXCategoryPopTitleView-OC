//
//  CGXCategoryPopTitleCellModel.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2019/5/8.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXCategoryPopTitleCellModel.h"

@implementation CGXCategoryPopTitleCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleNumberOfLines = 0;
        self.cornerRadius = 6;
        self.borderColor = [UIColor colorWithWhite:0.93 alpha:1];
        self.borderWidth = 1;
        self.selected = NO;
        self.titleNormalColor = [UIColor blackColor];
        self.titleSelectedColor = [UIColor redColor];
        self.titleFont = [UIFont systemFontOfSize:14];
        self.titleSelectedFont = [UIFont systemFontOfSize:14];
        self.titleBgColor = [UIColor whiteColor];
    }
    return self;
}
@end
