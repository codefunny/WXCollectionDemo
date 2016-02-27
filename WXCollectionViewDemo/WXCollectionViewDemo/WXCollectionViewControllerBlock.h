//
//  WXCollectionViewControllerBlock.h
//  WXCollectionViewDemo
//
//  Created by wenchao on 16/2/27.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXCollectionViewControllerBlock;
typedef UIView*(^cellBuilderBlock)(NSNumber* );
@interface WXFlowCollectionViewBuilder : NSObject

@property(nonatomic,assign) UICollectionViewScrollDirection scrollDirection;
@property(nonatomic,assign) CGFloat    minimumInteritemSpacing;
@property(nonatomic,assign) CGFloat     minimumLineSpacing;
@property(nonatomic,assign) UIEdgeInsets   sectionInset;
@property(nonatomic,assign) CGSize     itemSize;
@property(nonatomic,copy) cellBuilderBlock   cellBuilder;

@property(nonatomic,strong) NSArray*   dataSource;

- (WXCollectionViewControllerBlock*)build;

@end

@interface WXCollectionViewControllerBlock : UICollectionViewController

+ (instancetype)wxCollectionController ;

+(instancetype)collectionViewWithBuilder:(void(^)(WXFlowCollectionViewBuilder *builder))builder ;

- (instancetype)initWithBuilder:(WXFlowCollectionViewBuilder *)builder ;

@end
