//
//  CGXCategoryPopTitleView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2019/5/8.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXCategoryPopTitleView.h"

@interface CGXCategoryPopTitleView()<UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray<CGXCategoryPopTitleCellModel *> *dataArray;

@property (nonatomic,copy) CGXCategoryPopTitleViewSelectBlock selectBlock;
@property (nonatomic,copy) CGXCategoryPopTitleViewShowCellBlock showCellBlcok;
@end
@implementation CGXCategoryPopTitleView
static CGXCategoryPopTitleView *__onetimeClass;
+(CGXCategoryPopTitleView *)sharedSingleton
{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        __onetimeClass = [[CGXCategoryPopTitleView alloc]init];
    });
    
    return __onetimeClass;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissPopView)];
        myTap.delegate = self;
        [self addGestureRecognizer:myTap];
        
        self.topSpace = [[UIApplication sharedApplication] statusBarFrame].size.height+44.0;
        self.isAdaptive = YES;
        self.insets =UIEdgeInsetsMake(10, 10, 10, 10);
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        self.row = 4;
        self.rowHeight = 40;
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.alertView];
        self.alertView.frame =CGRectMake(0, self.topSpace, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-self.topSpace);
        [self initCollectionView];
    }
    return self;
}

-(NSMutableArray<CGXCategoryPopTitleCellModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)initCollectionView
{
    UICollectionViewFlowLayout*flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.alertView.frame), CGRectGetHeight(self.alertView.frame)) collectionViewLayout:flowLayout];
    
    collectionView.delegate=self;
    collectionView.dataSource=self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator=NO;
    collectionView.backgroundColor =[UIColor whiteColor];
    [collectionView registerClass:[CGXCategoryPopTitleCell class] forCellWithReuseIdentifier:NSStringFromClass([CGXCategoryPopTitleCell class])];
    //给collectionView注册头分区的Id
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionElementKindSectionHeader class])];
    //给collection注册脚分区的id
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionElementKindSectionFooter class])];
    [self.alertView addSubview:collectionView];
    if (@available(iOS 11.0, *)) {
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.collectionView = collectionView;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.alertView.frame =CGRectMake(0, self.topSpace, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-self.topSpace);
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.alertView.frame), CGRectGetHeight(self.alertView.frame));
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    [layout invalidateLayout];
    self.collectionView.frame = self.alertView.bounds;
    if (!CGSizeEqualToSize(self.bounds.size, [self intrinsicContentSize])) {
        [self invalidateIntrinsicContentSize];
    }
    CGFloat height = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    if (height != 0 && height != self.alertView.bounds.size.height) {
        
        if (self.isAdaptive) {
            if (height <= self.alertView.bounds.size.height) {
                CGRect frame = self.alertView.frame;
                frame.size.height = height;
                self.alertView.frame = frame;
                self.collectionView.frame = self.alertView.bounds;
            }
        }
    }
}
- (CGSize)intrinsicContentSize
{
    return self.collectionView.collectionViewLayout.collectionViewContentSize;
}
#pragma mark UICollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark - 返回每个分区的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.insets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minimumInteritemSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.bounds.size.width, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.bounds.size.width, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat space = self.insets.left+self.insets.right;
    float cellWidth = (CGRectGetWidth(collectionView.frame)-space-(self.row -1)*self.minimumInteritemSpacing)/self.row;
    NSAssert(self.row > 0, @"每行至少一个item");
    return CGSizeMake(cellWidth, self.rowHeight);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionElementKindSectionHeader class]) forIndexPath:indexPath];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionElementKindSectionFooter class]) forIndexPath:indexPath];
        view.backgroundColor = [UIColor whiteColor];;
        return view;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXCategoryPopTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXCategoryPopTitleCell class]) forIndexPath:indexPath]; 
    CGXCategoryPopTitleCellModel *model = self.dataArray[indexPath.row];
    [cell updateWithModel:model];
    if (self.showCellBlcok) {
        self.showCellBlcok(cell);
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     CGXCategoryPopTitleCellModel *model = self.dataArray[indexPath.row];
    
    if (self.selectBlock) {
        self.selectBlock(model);
    }
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch
{
    if ([touch.view isKindOfClass:[CGXCategoryPopTitleView class]]) {
        return YES;
    }
    return NO;
}
-(void)showUpdateCellShowBlock:(CGXCategoryPopTitleViewShowCellBlock)showCellBlcok
{
    self.showCellBlcok = showCellBlcok;
}
-(void)showPopViewArray:(NSMutableArray<CGXCategoryPopTitleCellModel *>*)dataArray  SelectBlock:(CGXCategoryPopTitleViewSelectBlock)selectBlock
{
     [self showPopView];
    self.selectBlock = selectBlock;
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    [self.collectionView reloadData];
    
   
}
#pragma mark - Public
- (void)showPopView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView animateWithDuration:0.5  animations:^{
        self.frame = rect;
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];
}

- (void)dismissPopView
{
    CGRect rect = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView animateWithDuration:0.5  animations:^{
        self.frame = rect;
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
