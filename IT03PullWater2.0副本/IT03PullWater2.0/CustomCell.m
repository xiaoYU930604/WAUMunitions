//
//  CustomCell.m
//  IT03PullWater2.0
//
//  Created by Mac on 16/3/11.
//  Copyright © 2016年 Wau. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell(){
    
    UIImageView *_pView;
    UIView *_Bview;
    
}

@end

@implementation CustomCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        [self initView];
        
    }
    return self;
    
    
}

-(void)initView{
    
    
    self.backgroundColor = [UIColor grayColor];
    
    UIImageView *productImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    productImage.backgroundColor = [UIColor redColor];
    [self addSubview:productImage];
    
    UIView *bottom = [[UIView alloc]initWithFrame:CGRectZero];
    
    bottom.backgroundColor = [UIColor purpleColor];
    
    [self addSubview:bottom];
    
    _pView = productImage;
    _Bview = bottom;
    
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    Model *m = self.model;
    
    if (m) {
        
        CGFloat temp = [UIScreen mainScreen].bounds.size.width/2-15;
        
        CGFloat w = m.width;
        CGFloat h = m.hight;
        
        h = temp/w*h;
        
        _pView.frame = CGRectMake(10, 10, temp, h);
        
        
        _Bview.frame = CGRectMake(10, _pView.frame.size.height+10, temp, 30);
        
        
    }
    
    
}








- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
