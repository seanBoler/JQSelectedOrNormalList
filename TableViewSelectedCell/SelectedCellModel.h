//
//  SelectedCellModel.h
//  TableViewSelectedCell
//
//  Created by tlkj on 17/3/28.
//  Copyright © 2017年 zhangjiaqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectedCellModel : NSObject


@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)NSMutableArray *array;

+(instancetype)selectedKVCModel:(NSDictionary *)dict;

-(void)loadDatasucessBlock:(void(^)(NSArray *modelArr))sucess faildBlock:(void(^)())faild;
@end
