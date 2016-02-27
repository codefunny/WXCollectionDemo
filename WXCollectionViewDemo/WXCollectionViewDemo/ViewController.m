//
//  ViewController.m
//  WXCollectionViewDemo
//
//  Created by wenchao on 16/2/25.
//  Copyright © 2016年 wenchao. All rights reserved.
//

#import "ViewController.h"
#import "WXCollectionViewControllerBlock.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSArray* titles;
@property (nonatomic,strong) NSArray* actions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_id"];
    [self.view addSubview:self.tableView];
    
    self.titles = @[@"collection1",@"WXCollectionViewControllerBlock"];
    self.actions = @[@"CollectionViewDemo1",@"WXCollectionViewControllerBlock"];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    
    cell.textLabel.text = self.titles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString* actionClass = self.actions[indexPath.row];
//    UIViewController* controller = [[NSClassFromString(actionClass) alloc] init];
    UIViewController* controller = nil;
    if ([actionClass isEqualToString:@"WXCollectionViewControllerBlock"]) {
        controller = [WXCollectionViewControllerBlock wxCollectionController];
    } else {
        UIStoryboard* board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        controller = [board instantiateViewControllerWithIdentifier:actionClass];
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView ;
}

@end
