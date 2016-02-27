# WXCollectionDemo

####1、基于Builder Pattern来构建一个UICollectionView

在[Limboy博客](http://limboy.me/ios/2015/02/07/builder-pattern.html)上看到一篇介绍建造者模式的应用，其中有个UICollectionController的例子，但是没有完整的代码，我这里简单的写了一个。

```
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
```