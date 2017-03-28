//
//  TableViewCell.m
//  TableViewSelectedCell
//
//  Created by tlkj on 17/3/28.
//  Copyright © 2017年 zhangjiaqi. All rights reserved.
//

#import "TableViewCell.h"
#import "SelectedCellModel.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCell];
    }
    return self;
}

- (void)creatCell{
    _selectedImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 0, 36,self.contentView.bounds.size.height)];
    [self.contentView addSubview:_selectedImage];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, self.contentView.bounds.size.width - 72, self.contentView.bounds.size.height)];
    _title.tintColor = [UIColor blackColor];
    _title.backgroundColor = [UIColor whiteColor];
    _title.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:_title];
}

-(void)setModel:(SelectedCellModel *)model{
    _model = model;
    _title.text = [NSString stringWithFormat:@"%@",model.title];
}




@end
