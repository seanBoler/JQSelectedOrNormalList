//
//  SelectedCellModel.m
//  TableViewSelectedCell
//
//  Created by tlkj on 17/3/28.
//  Copyright © 2017年 zhangjiaqi. All rights reserved.
//

#import "SelectedCellModel.h"

@implementation SelectedCellModel
+(instancetype)selectedKVCModel:(NSDictionary *)dict{
    SelectedCellModel *model = [[SelectedCellModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

-(void)loadDatasucessBlock:(void (^)(NSArray *))sucess faildBlock:(void (^)())faild{
    
    NSArray *load = @[@{@"title":@"山东大学"},@{@"title":@"复旦大学"},@{@"title":@"山东大学"},@{@"title":@"山东大学"},@{@"title":@"上海大学"},@{@"title":@"山东大学"},@{@"title":@"上海大学"},@{@"title":@"复旦大学"},@{@"title":@"山东大学"},@{@"title":@"复旦大学"},@{@"title":@"山东大学"},@{@"title":@"山东大学"},@{@"title":@"上海大学"},];
    
    for (NSDictionary *dic in load) {
        SelectedCellModel *model = [SelectedCellModel selectedKVCModel:dic];
        [self.array addObject:model];
    }
    if (sucess) {
        sucess(self.array.copy);
    }
    
    
}

@end
