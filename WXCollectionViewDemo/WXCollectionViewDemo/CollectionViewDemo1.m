//
//  CollectionViewDemo1.m
//  WXCollectionViewDemo
//
//  Created by wenchao on 16/2/25.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import "CollectionViewDemo1.h"
#import "CollectionViewFlowLayout1.h"

@interface CollectionViewDemo1 ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)UICollectionView* collectionView;

@end

@implementation CollectionViewDemo1


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collection_cell"];
    [self.view addSubview:self.collectionView];
    
//    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection_cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blueColor];
    UILabel* label = [UILabel new];
    label.text = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    [cell.contentView addSubview:label];
    
    return cell;
}

#pragma mark -
- (UICollectionView*)collectionView {
    if (!_collectionView) {
        CollectionViewFlowLayout1* layout = [[CollectionViewFlowLayout1 alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 200) collectionViewLayout:layout];
        //_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor cyanColor];
    }
    
    return _collectionView;
}

@end
