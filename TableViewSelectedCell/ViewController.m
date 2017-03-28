//
//  ViewController.m
//  TableViewSelectedCell
//
//  Created by tlkj on 17/3/28.
//  Copyright © 2017年 zhangjiaqi. All rights reserved.
//

#import "ViewController.h"

#import "TableViewCell.h"
#import "SelectedCellModel.h"
#import <MJRefresh/MJRefresh.h>//MJ

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *loadArray;

@property (nonatomic,strong)NSMutableArray *selectedArray;
@property (nonatomic,strong)UIButton *selectedBtn;
@end

@implementation ViewController


-(NSMutableArray *)loadArray{
    if (!_loadArray ) {
        
        SelectedCellModel *model = [[SelectedCellModel alloc]init];
        [model loadDatasucessBlock:^(NSArray *modelArr) {
            _loadArray = [NSMutableArray arrayWithArray:modelArr];
            if (!_selectedArray) {
                self.selectedArray = [NSMutableArray array];
                for (NSInteger i = 0; i <self.loadArray.count; i++) {
                    [self.selectedArray addObject:@(NO)];
                }
            }
            [self.tableView reloadData];
            
        } faildBlock:^{
            
        }];
        
    }
    return _loadArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-40) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    UIButton *buton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    buton.backgroundColor = [UIColor redColor];
    [buton setTitle:@"全选" forState:UIControlStateNormal];
    [buton setTitle:@"取消" forState:UIControlStateSelected];
    buton.tintColor = [UIColor whiteColor];
    [buton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.selectedBtn = buton;
    [self.view addSubview:self.selectedBtn];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self refeshData];//刷新

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.loadArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    SelectedCellModel *model = self.loadArray[indexPath.row];
    cell.model = model;
    if ([self.selectedArray[indexPath.row] intValue] == YES) {
        cell.selectedImage.image = [UIImage imageNamed:@"icon_20"];
    }else{
        cell.selectedImage.image = [UIImage imageNamed:@"icon_21"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.selectedArray[indexPath.row]intValue] == NO) {
        self.selectedArray[indexPath.row] = @(YES);
        if ([self isAllBtnSellected] == YES) {
            self.selectedBtn.selected = YES;
        }else{
            self.selectedBtn.selected = NO;
        }
        [self.tableView reloadData];

    }else{
        self.selectedBtn.selected = NO;
        self.selectedArray[indexPath.row] = @(NO);
        [self.tableView reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --------- 全部按钮的状态确定
-(BOOL)isAllBtnSellected{
    
    //循环去计算 选中的 个数
    int sum = 0;
    int totalCount = 0;
    
    for (int a= 0; a<self.loadArray.count; a++) {
        totalCount++;
        if ([self.selectedArray[a]intValue] == YES) {
            sum++;
        }
    }
    
    if (totalCount > 0 && sum == totalCount) {
        //说明 所有的按钮都 选中了
        return YES;
        
    }else{
        return NO;
    }
    
}

#pragma mark ------ 全选按钮
- (void)buttonAction:(UIButton *)btn{
    if (btn.selected == NO) {
        btn.selected = YES;
        //遍历模型数组,把状态全部改为YES
        for (NSInteger a = 0; a<self.loadArray.count; a++) {
            self.selectedArray[a] = @(YES);
//            SelectedCellModel *model = self.selectedArray[a];
//            model.isSelectedCell = YES;
        }
        [self.tableView reloadData];
        
    }else{
        btn.selected = NO;
        //遍历模型数组,把状态全部改为NO
        for (NSInteger a = 0; a<self.loadArray.count; a++) {
            self.selectedArray[a] = @(NO);
//            SelectedCellModel *model = self.selectedArray[a];
//            model.isSelectedCell = NO;
        }
        [self.tableView reloadData];
    }
}

#pragma mark ----刷新 ---- 加载-------------
- (void)refeshData{
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.loadArray = nil;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

@end
