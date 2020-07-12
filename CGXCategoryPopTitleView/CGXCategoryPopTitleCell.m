//
//  CGXCategoryPopTitleCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2019/5/8.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXCategoryPopTitleCell.h"

@implementation CGXCategoryPopTitleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        self.titleLabel.clipsToBounds = YES;
        self.titleLabel.layer.masksToBounds = YES;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
    }
    return self;
}
- (void)updateWithModel:(CGXCategoryPopTitleCellModel *)model
{
    self.titleLabel.backgroundColor = model.titleBgColor;
    self.titleLabel.text = model.title;
    self.titleLabel.numberOfLines = model.titleNumberOfLines;
    if (model.selected) {
        self.titleLabel.font = model.titleSelectedFont;
        self.titleLabel.textColor = model.titleSelectedColor;
    } else{
        self.titleLabel.font = model.titleFont;
        self.titleLabel.textColor = model.titleNormalColor;
    }
    self.titleLabel.layer.cornerRadius = model.cornerRadius;
    self.titleLabel.layer.borderColor = model.borderColor.CGColor;
    self.titleLabel.layer.borderWidth = model.borderWidth;
    
    
}
@end
