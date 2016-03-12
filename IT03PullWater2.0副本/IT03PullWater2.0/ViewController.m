//
//  ViewController.m
//  IT03PullWater2.0
//
//  Created by Mac on 16/3/11.
//  Copyright © 2016年 Wau. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
#import "CustomView.h"
#import "CustomCell.h"
//枚举
//typedef enum : NSUInteger {
//    Left,
//    Right,
//    
//} TAB_TYPE;

typedef NS_ENUM(NSInteger, TAB_TYPE){
    
    Left =2000, //左表
    Right =2001//右表
    
};


@interface ViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    //1.1
    CGFloat _columH[2];
    UIScrollView *_bgScrollView;
    //1.3 存放下标的total
    NSMutableArray *_datas;
    NSMutableArray *_homeData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSMutableArray *data = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (NSInteger i = 0; i<30; i++) {
        Model *model = [Model new];
        
        
        model.width = arc4random()%320+320;
        model.hight = arc4random()%400+400;
        
        
        [data addObject:model];
        
    }
    
    _homeData = data;
    
    
    _datas = [NSMutableArray arrayWithObjects:[NSMutableArray array],[NSMutableArray array], nil];

    [self initView];
    [self homeData:data];
    
}

-(void)homeData:(NSArray *)data{
    
    for (NSInteger i = 0; i<data.count; i++) {
        int index = _columH[0] < _columH[1]?0:1;
        
        Model *m = data[i];
        
        CGFloat w = m.width;
        
        CGFloat h = m.hight;
        
        CGFloat temp = self.view.bounds.size.width/2 -15;
        
        h = temp/w*h;
        
        CGFloat currentH = _columH[index];
        currentH += h +10;
        
        _columH[index] = currentH;
        
        [_datas[index] addObject:@(i)];
        
    }
    
    //1.5 刷新scroll 的高度 让其滚动
    CGFloat maxH = _columH[0]>_columH[1]?_columH[0]:_columH[1];
    _bgScrollView.contentSize = CGSizeMake(0.0, maxH+100);
    
    //1.6 刷新表的高度
    
    for (NSInteger i = 0; i<2; i++) {
        UITableView *table = (UITableView *)[_bgScrollView viewWithTag:Left+i];
        [table reloadData];
        if (maxH<table.contentSize.height) {
            maxH = table.contentSize.height;
        }
    }
    
    
}
//1.4初始化UI

-(void)initView{
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    scrollView.delegate = self;
    
    scrollView.backgroundColor = [UIColor purpleColor];
    
    
    for (NSInteger i = 0; i<2; i++) {
        
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2 *i, 0, self.view.bounds.size.width/2, self.view.bounds.size.height) style:UITableViewStylePlain];
        
        table.delegate = self;
        table.dataSource = self;
        table.scrollEnabled = NO;
        table.separatorStyle = UITableViewCellSelectionStyleNone;
        if (0 == i) {
            table.tag = Left;
            table.backgroundColor = [UIColor blueColor];
            
        }else{
            
            table.tag = Right;
            table.backgroundColor = [UIColor blueColor];
            
            
            
            
        }
        [scrollView addSubview:table];
        
        
    }
    [self.view addSubview:scrollView];
    _bgScrollView = scrollView;
}


#pragma mark --table Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    NSInteger index = (tableView.tag == Left)?Left:Right;
    NSArray *array = _datas[index -2000];
    if (array.count != 0) {
        
        NSNumber *number = array[indexPath.row];
        Model *m = _homeData[number.intValue];
        if (m) {
            cell.model = m;
        }
        
    }
    
   
    
    
    return cell;
    
    
}


#pragma mark -- table datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger index = (tableView.tag == Left)?Left:Right;
    NSArray *array = _datas[index -2000];
    if (array.count != 0) {
        return array.count;
    }
    return 0;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = (tableView.tag == Left)?Left:Right;
    NSArray *array = _datas[index -2000];
    if (array.count != 0) {
        
        NSNumber *number = array[indexPath.row];
        
        Model *m = _homeData[number.intValue];
        if (m) {
            CGFloat w = m.width;
            CGFloat h = m.hight;
            
            h = self.view.bounds.size.width/2 *h/w;
            return h+50;
        }
        
        
    }
    return 0;
    
    
    
}
#pragma mark scrolldelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UITableView *leftT =(UITableView *) [scrollView viewWithTag:Left];
    UITableView *rightR =(UITableView *)[scrollView viewWithTag:Right];
    
    leftT.contentOffset = scrollView.contentOffset;
    rightR.contentOffset = scrollView.contentOffset;
    
    CGFloat w = self.view.bounds.size.width;
    CGFloat h = self.view.bounds.size.height;
    
    leftT.center = CGPointMake(w/4, leftT.contentOffset.y +h/2);
    rightR.center = CGPointMake(w/4*3, rightR.contentOffset.y +h/2);
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
