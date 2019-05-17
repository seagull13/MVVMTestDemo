//
//  ViewController.m
//  TestTableView
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/2/27.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import "ViewController.h"
#import "GZLStandStructureBaseView.h"
#import "TextStandCellModel.h"
#import "GZLStandStructureBaseCellModel.h"
#import "MsgSendFactory.h"
@interface ViewController ()

/** tableView */
@property(nonatomic,strong)GZLStandStructureBaseView  *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableViewData];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 69, [UIScreen mainScreen].bounds.size.width - 200, 30)];
    [btn setTitle:@"设计模式" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)btnClick{
    [self presentViewController:[[NSClassFromString(@"DesignPatternVC") alloc]init] animated:YES completion:^{

    }];

//    [self presentViewController:[[NSClassFromString(@"MVVMSimpleVC") alloc]init] animated:YES completion:^{
//
//    }];
}



-(void)creatTableViewData{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *nameArray = @[@"小红",@"小明",@"小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红小红",@"jack",@"rose",@"小德"];
    
    for (int i = 0; i < 1000; i++) {
        TextStandCellModel *textModel = [[TextStandCellModel alloc]init];
        textModel.name = nameArray[i%6];
        textModel.height = 1.5 + arc4random_uniform(100) /200.0;
        textModel.weight = 60 + arc4random_uniform(200) /10.0;
        [dataArray addObject:textModel];
    }
    
    
    NSMutableArray *cellDataArray = [NSMutableArray array];
    GZLStandStructureBaseCellModel *cellModel = [[GZLStandStructureBaseCellModel alloc]init];
    cellModel.itemList = dataArray;
    cellModel.isAutoRowheight = YES;
    cellModel.containerCellClass = @"TextExampleCell";
    [cellDataArray addObject:cellModel];
    self.tableView.dataList = cellDataArray;
    
}



-(GZLStandStructureBaseView *)tableView{
    if (!_tableView) {
        _tableView = [[GZLStandStructureBaseView alloc]init];
        _tableView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -100);
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
@end

