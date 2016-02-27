//
//  CollectionViewFlowLayout1.m
//  WXCollectionViewDemo
//
//  Created by wenchao on 16/2/25.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import "CollectionViewFlowLayout1.h"

#define DT_SCREEN_MAIN_WIDTH [UIScreen mainScreen].bounds.size.width
#define ITEM_SIZE 100
#define ACTIVE_DISTANCE DT_SCREEN_MAIN_WIDTH
#define ZOOM_FACTOR 0.3



@implementation CollectionViewFlowLayout1

- (instancetype)init {
    self = [super init];
    
//    self.itemSize = CGSizeMake(ITEM_SIZE*2, ITEM_SIZE);
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    //self.sectionInset = UIEdgeInsetsMake(20, 0.0, 20, 0.0);
//    self.minimumLineSpacing = 50.0;
    
    return self;
}

-(void)prepareLayout {
    [super prepareLayout];
    self.itemSize = CGSizeMake(ITEM_SIZE*2, ITEM_SIZE);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //self.sectionInset = UIEdgeInsetsMake(20, 0.0, 20, 0.0);
    self.minimumLineSpacing = 50.0;
}

/**
 *  contentSize 类似于scrollview的contentsize，一般不用自己定义
 *
 *  @return
 */
//- (CGSize)collectionViewContentSize {
//    return CGSizeMake(400, 100);
//}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset: (CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //proposedContentOffset是没有对齐到网格时本来应该停下的位置
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    //对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [[super layoutAttributesForElementsInRect:rect] copy];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    NSArray* items = [[NSArray alloc] initWithArray:array copyItems:YES];
    
    NSMutableArray* mutateArray = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes* attributes in items) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            if (ABS(distance) < ACTIVE_DISTANCE ){
                CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attributes.zIndex = 1;
            }
        }
        
        [mutateArray addObject:attributes];
    }
    return mutateArray;
}

//- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
//    
//}
//- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath {
//    
//}

@end
