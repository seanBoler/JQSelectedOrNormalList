//
//  TableViewCell.h
//  TableViewSelectedCell
//
//  Created by tlkj on 17/3/28.
//  Copyright © 2017年 zhangjiaqi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectedCellModel;
@interface TableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIImageView *selectedImage;
@property (nonatomic,strong)SelectedCellModel *model;
@end
