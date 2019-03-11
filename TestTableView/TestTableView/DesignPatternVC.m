//
//  DesignPatternVC.m
//  TestTableView
//
//  Created by JiangNanBuYi-1012665604@qq.com on 2019/3/11.
//  Copyright © 2019 JiangNanBuYi-1012665604@qq.com. All rights reserved.
//

#import "DesignPatternVC.h"

#import "GZLStandStructureBaseView.h"
#import "TextStandCellModel.h"
#import "GZLStandStructureBaseCellModel.h"
#import "MsgSendFactory.h" //工厂模式

#import "ShopContext.h" //策略模式


@interface DesignPatternVC ()<GZLStandStructureBaseViewProtocol>

/** tableView */
@property(nonatomic,strong)GZLStandStructureBaseView  *tableView;
@end

@implementation DesignPatternVC

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;
  [self creatTableViewData];

  // Do any additional setup after loading the view, typically from a nib.
}
-(void)creatTableViewData{


  NSMutableArray *nameArray = [NSMutableArray array];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"策略模式（Strategy），它定义了算法家族，分别封装起来，让它们之间可以互相替换，此模式让算法的变化，不会影响到使用算法的客户。" withSel:NSStringFromSelector(@selector(Strategy))]];
    [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"装饰模式（Decorator），动态地给一个对象添加一些额外的职责，就增加功能来说，装饰模式比生成子类更为灵活。" withSel:NSStringFromSelector(@selector(Decorator))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"代理模式（Proxy），为其他对象提供一种代理以控制对这个对象的访问。" withSel:NSStringFromSelector(@selector(Proxy))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"工厂方法模式（Factory Method），定义一个用于创建对象的接口，让子类决定实例化哪一个类。工厂方法使一个类的实例化延迟到其子类。" withSel:NSStringFromSelector(@selector(Factory))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"原型模式（Prototype），用原型实例指定创建对象的种类，并且通过拷贝这些原型创建新的对象。" withSel:NSStringFromSelector(@selector(Prototype))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"模板方法模式（Template Method），定义一个操作中的算法的骨架，而将一些步骤延迟到子类中。模板方法使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤。" withSel:NSStringFromSelector(@selector(Template))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"外观模式（Facade），为子系统中的一组接口提供一个一致的界面，此模式定义了一个高层接口，这个接口使得这一子系统更加容易使用。" withSel:NSStringFromSelector(@selector(Facade))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"建造者模式（Builder），将一个复杂对象的构建与它的表示分离，使得同样的构建过程可以创建不同的表示。" withSel:NSStringFromSelector(@selector(Builder))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"观察者模式（Observer），定义了一种一对多的依赖关系，让多个观察者对象同时监听某一个主题对象。这个主题对象在状态发生变化时，会通知所有观察者对象，使它们能够自动更新自己。" withSel:NSStringFromSelector(@selector(Observer))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"状态模式（State），当一个对象的内在状态改变时允许改变其行为，这个对象看起来像是改变了其类。" withSel:NSStringFromSelector(@selector(State))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@" 适配器模式（Adapter），将一个类的接口转换成客户希望的另外一个接口。Adapter 模式使得原本由于接口不兼容而不能一起工作的那些类可以一起工作。" withSel:NSStringFromSelector(@selector(Adapter))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"备忘录模式（Memento），在不破坏封装性的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态。这样以后就可将该对象恢复到原先保存的状态。" withSel:NSStringFromSelector(@selector(Memento))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"组合模式（Composite），将对象组合成树形结构以表示‘部分-整体’的层次结构。组合模式使得用户对单个对象和组合对象的使用具有一致性。" withSel:NSStringFromSelector(@selector(Composite))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"迭代器模式（Iterator），提供一种方法顺序访问一个聚合对象中各个元素，而又不暴露该对象的内部表示。" withSel:NSStringFromSelector(@selector(Iterator))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"单例模式（Singleton），保证一个类仅有一个实例，并提供一个访问它的全局访问点。" withSel:NSStringFromSelector(@selector(Singleton))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"桥接模式（Bridge），将抽象部分与它的实现部分分离，使它们都可以独立地变化。" withSel:NSStringFromSelector(@selector(Bridge))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"命令模式（Command），将一个请求封装为一个对象，从而使你可用不同的请求对客户进行参数化；对请求排队或记录请求日志，以及支持可撤销的操作。" withSel:NSStringFromSelector(@selector(Command))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"职责链模式（Chain of Responsibility），使多个对象都有机会处理请求，从而避免请求的发送者和接收者之间的耦合关系。将这个对象连成一条链，并沿着这条链传递该请求，直到有一个对象处理它为止。" withSel:NSStringFromSelector(@selector(ChainOfResponsibility))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@" 中介者模式（Mediator），用一个中介对象来封装一系列的对象交互。中介者使各对象不需要显式地相互引用，从而使其耦合松散，而且可以独立地改变它们之间的交互。" withSel:NSStringFromSelector(@selector(Mediator))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"享元模式（Flyweight），运用共享技术有效地支持大量细粒度的对象。。" withSel:NSStringFromSelector(@selector(Flyweight))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"解释器模式（Interpreter），给定一个语言，定义它的文法的一种表示，并定义一个解释器，这个解释器使用该表示来解释语言中的句子。" withSel:NSStringFromSelector(@selector(Interpreter))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@" 访问者模式（Visitor），表示一个作用于某对象结构中的各元素的操作。它使你可以在不改变各元素的类的前提下定义作用于这些元素的新操作。" withSel:NSStringFromSelector(@selector(Visitor))]];
  [nameArray addObject:[TextStandCellModel creatTextStandCellModelWithTitle:@"Back To ViewController" withSel:NSStringFromSelector(@selector(Back))]];







  NSMutableArray *cellDataArray = [NSMutableArray array];
  GZLStandStructureBaseCellModel *cellModel = [[GZLStandStructureBaseCellModel alloc]init];
  cellModel.itemList = nameArray;
  cellModel.containerCellClass = @"TextStandCell";
  [cellDataArray addObject:cellModel];
  cellModel.isAutoRowheight = YES;
  self.tableView.dataList = cellDataArray;

}

-(void)gZLStandStructureBaseCellCallBcakWithParameter:(id)parameter withIndexPath:(NSIndexPath *)indexPath{
  if ([parameter isKindOfClass:TextStandCellModel.class]) {
    TextStandCellModel *model = parameter;
    if (model.sel.length > 0) {
      if ([self respondsToSelector:NSSelectorFromString(model.sel)]) {
          [self performSelector:NSSelectorFromString(model.sel) withObject:self afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
      }
    }

  }
}
-(void)Back{
  NSLog(@"%s ---方法调用",__func__);
  [self dismissViewControllerAnimated:YES completion:^{
  }];
}



-(void)Strategy{
  NSLog(@"%s ---方法调用",__func__);
  CGFloat money = 100;
  ShopContext *originalContext = [[ShopContext alloc]initWithType:ShopTypeOriginal];
  [originalContext calShopPriceWithMoney:money];

  ShopContext *disCountContext = [[ShopContext alloc]initWithType:ShopTypeDisCount];
  [disCountContext calShopPriceWithMoney:money];

  ShopContext *redictionContext = [[ShopContext alloc]initWithType:ShopTypeRediction];
  [redictionContext calShopPriceWithMoney:money];



}

-(void)Decorator{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)Proxy{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)Factory{
  NSLog(@"%s ---方法调用",__func__);

  [[MsgSendFactory creatMsgSendWithType:MsgSendTypeDefault] send];
  [[MsgSendFactory creatMsgSendWithType:MsgSendTypeMail] send];
  [[MsgSendFactory creatMsgSendWithType:MsgSendTypeSms] send];
  [[MsgSendFactory creatMsgSendWithType:MsgSendTypePush] send];

}

-(void)Prototype{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)Template{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)Facade{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)Builder{
  NSLog(@"%s ---方法调用",__func__);
}
-(void)Observer{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)State{
  NSLog(@"%s ---方法调用",__func__);
}
-(void)Adapter{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)Memento{
  NSLog(@"%s ---方法调用",__func__);
}
-(void)Composite{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)Iterator{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)Singleton{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)Bridge{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)Command{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)ChainOfResponsibility{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)Mediator{
  NSLog(@"%s ---方法调用",__func__);
}


-(void)Flyweight{
  NSLog(@"%s ---方法调用",__func__);
}
-(void)Interpreter{
  NSLog(@"%s ---方法调用",__func__);
}

-(void)Visitor{
  NSLog(@"%s ---方法调用",__func__);
}


-(GZLStandStructureBaseView *)tableView{
  if (!_tableView) {
    _tableView = [[GZLStandStructureBaseView alloc]init];
    _tableView.separatorColor = UIColor.redColor;
    _tableView.delegate = self;
    _tableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -64);
    [self.view addSubview:_tableView];
  }
  return _tableView;
}
@end

//  策略模式（Strategy），它定义了算法家族，分别封装起来，让它们之间可以互相替换，此模式让算法的变化，不会影响到使用算法的客户。
//  装饰模式（Decorator），动态地给一个对象添加一些额外的职责，就增加功能来说，装饰模式比生成子类更为灵活。
//  代理模式（Proxy），为其他对象提供一种代理以控制对这个对象的访问。
//  工厂方法模式（Factory Method），定义一个用于创建对象的接口，让子类决定实例化哪一个类。工厂方法使一个类的实例化延迟到其子类。
//  原型模式（Prototype），用原型实例指定创建对象的种类，并且通过拷贝这些原型创建新的对象。
//  模板方法模式（Template Method），定义一个操作中的算法的骨架，而将一些步骤延迟到子类中。模板方法使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤。
//  外观模式（Facade），为子系统中的一组接口提供一个一致的界面，此模式定义了一个高层接口，这个接口使得这一子系统更加容易使用。
//  建造者模式（Builder），将一个复杂对象的构建与它的表示分离，使得同样的构建过程可以创建不同的表示。
//  观察者模式（Observer），定义了一种一对多的依赖关系，让多个观察者对象同时监听某一个主题对象。这个主题对象在状态发生变化时，会通知所有观察者对象，使它们能够自动更新自己。
//  抽象工厂模式（Abstract Factory），提供一个创建一系列相关或相互依赖对象的接口，而无需指定它们具体的类。
//  状态模式（State），当一个对象的内在状态改变时允许改变其行为，这个对象看起来像是改变了其类。
//  适配器模式（Adapter），将一个类的接口转换成客户希望的另外一个接口。Adapter 模式使得原本由于接口不兼容而不能一起工作的那些类可以一起工作。
//  备忘录模式（Memento），在不破坏封装性的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态。这样以后就可将该对象恢复到原先保存的状态。
//  组合模式（Composite），将对象组合成树形结构以表示‘部分-整体’的层次结构。组合模式使得用户对单个对象和组合对象的使用具有一致性。
//  迭代器模式（Iterator），提供一种方法顺序访问一个聚合对象中各个元素，而又不暴露该对象的内部表示。
//  单例模式（Singleton），保证一个类仅有一个实例，并提供一个访问它的全局访问点。
//  桥接模式（Bridge），将抽象部分与它的实现部分分离，使它们都可以独立地变化。
//  命令模式（Command），将一个请求封装为一个对象，从而使你可用不同的请求对客户进行参数化；对请求排队或记录请求日志，以及支持可撤销的操作。
//  职责链模式（Chain of Responsibility），使多个对象都有机会处理请求，从而避免请求的发送者和接收者之间的耦合关系。将这个对象连成一条链，并沿着这条链传递该请求，直到有一个对象处理它为止。
//  中介者模式（Mediator），用一个中介对象来封装一系列的对象交互。中介者使各对象不需要显式地相互引用，从而使其耦合松散，而且可以独立地改变它们之间的交互。
//  享元模式（Flyweight），运用共享技术有效地支持大量细粒度的对象。
//  解释器模式（Interpreter），给定一个语言，定义它的文法的一种表示，并定义一个解释器，这个解释器使用该表示来解释语言中的句子。
//  访问者模式（Visitor），表示一个作用于某对象结构中的各元素的操作。它使你可以在不改变各元素的类的前提下定义作用于这些元素的新操作。
