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
  [self testFactory];
  // Do any additional setup after loading the view, typically from a nib.
}


-(void)testFactory{

  [[MsgSendFactory creatMsgSendWithType:MsgSendTypeDefault] send];
  [[MsgSendFactory creatMsgSendWithType:MsgSendTypeMail] send];
  [[MsgSendFactory creatMsgSendWithType:MsgSendTypeSms] send];
  [[MsgSendFactory creatMsgSendWithType:MsgSendTypePush] send];


}

-(void)creatTableViewData{

  NSMutableArray *dataArray = [NSMutableArray array];
  NSArray *nameArray = @[@"小红",@"小明",@"小辉",@"jack",@"rose",@"小德"];

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
  cellModel.containerCellClass = @"TextStandCell";
  [cellDataArray addObject:cellModel];
  self.tableView.dataList = cellDataArray;

}



-(GZLStandStructureBaseView *)tableView{
  if (!_tableView) {
    _tableView = [[GZLStandStructureBaseView alloc]init];
    _tableView.separatorColor = UIColor.redColor;
    _tableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -64);
    [self.view addSubview:_tableView];
  }
  return _tableView;
}
@end
