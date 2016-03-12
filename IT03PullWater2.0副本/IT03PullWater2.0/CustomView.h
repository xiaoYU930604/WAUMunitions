//
//  CustomView.h
//  IT03PulWater1.0
//
//  Created by Mac on 16/3/10.
//  Copyright © 2016年 Wau. All rights reserved.
//


typedef void(^block)(id);

#import <UIKit/UIKit.h>
#import "Model.h"
@interface CustomView : UIView
@property(nonatomic,strong)Model *model;
-(instancetype)initWithFrame:(CGRect)frame completion:(block)newBlock;

@end
