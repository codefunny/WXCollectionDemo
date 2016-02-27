//
//  WXCollectionViewControllerBlock.m
//  WXCollectionViewDemo
//
//  Created by wenchao on 16/2/27.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import "WXCollectionViewControllerBlock.h"

static NSString* const  kCollectionCell = @"collectionCell";
@implementation WXFlowCollectionViewBuilder

- (WXCollectionViewControllerBlock*)build {
    WXCollectionViewControllerBlock* collection = [[WXCollectionViewControllerBlock alloc] initWithBuilder:self];
    
    return collection ;
}

@end

@interface WXCollectionViewControllerBlock ()

@property (nonatomic,strong) NSArray*   dataSource;
@property (nonatomic,copy) cellBuilderBlock   cellBuild;

@end

@implementation WXCollectionViewControllerBlock

+ (instancetype)wxCollectionController {
    WXCollectionViewControllerBlock* collectionController = [WXCollectionViewControllerBlock collectionViewWithBuilder:^(WXFlowCollectionViewBuilder *builder) {
        builder.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        builder.minimumInteritemSpacing = 10;
        builder.minimumLineSpacing = 10;
        builder.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        CGSize itemSize = CGSizeMake(100, 200);
        builder.itemSize = itemSize;
        builder.dataSource = @[@1,@2,@3,@4,@5,@6, @7,@8, @9, @10];
        builder.cellBuilder = ^UIView *(NSNumber *number){
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, itemSize.width, itemSize.height)];
            view.backgroundColor = [UIColor blueColor];
            UILabel* label = [UILabel new];
            label.text = [NSString stringWithFormat:@"%@",number];
            [label sizeToFit];
            [view addSubview:label];
            return view;
        };

    }];
    
    return collectionController;
}

+(instancetype)collectionViewWithBuilder:(void(^)(WXFlowCollectionViewBuilder *builder))builder{
    
    WXFlowCollectionViewBuilder* wxBuilder = [WXFlowCollectionViewBuilder new];
    builder(wxBuilder);
    
    return [wxBuilder build];
}

- (instancetype)initWithBuilder:(WXFlowCollectionViewBuilder *)builder {
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = builder.scrollDirection;
    layout.minimumLineSpacing = builder.minimumLineSpacing;
    layout.minimumInteritemSpacing = builder.minimumInteritemSpacing;
    layout.itemSize = builder.itemSize;
    layout.sectionInset = builder.sectionInset;
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        _dataSource = builder.dataSource ;
        _cellBuild = builder.cellBuilder;
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionCell];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCell forIndexPath:indexPath];
    UIView* view = self.cellBuild(self.dataSource[indexPath.row]);
    [cell.contentView addSubview:view];
    return cell;
}

@end
