//
//  ViewController.m
//  JRTableView删除
//
//  Created by jerehedu on 15/6/11.
//  Copyright (c) 2015年 jerehedu. All rights reserved.
//

#import "ViewController.h"
#import "Goods.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView; //列表
    
    NSMutableArray *_goodsAry; //商品数组
    
    UIButton *_editBtn; //编辑按钮
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    titleLabel.text = @"购物车";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    //添加编辑按钮
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editBtn.frame = CGRectMake(self.view.frame.size.width-60, 25, 50, 34);
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editBtn setTitle:@"完成" forState:UIControlStateSelected];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _editBtn.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
    [self.view addSubview:_editBtn];
    [_editBtn addTarget:self action:@selector(clickEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加tableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //取数据
    NSArray *ary = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ShoppingGoodsList" ofType:@"plist"]];
    
    //把数据存到模型对象中，然后把对象存到数组中
    _goodsAry = [NSMutableArray array];
    for (int i=0; i<ary.count; i++) {
        Goods *good = [Goods goodsWithDic:ary[i]];
        [_goodsAry addObject:good];
    }
}

#pragma mark 数据源  返回有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _goodsAry.count;
}

#pragma mark 每行显示内容
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idGood = @"goods";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idGood];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idGood];
    }
    
    Goods *good = _goodsAry[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:good.icon];
    cell.textLabel.text = good.name;
    cell.detailTextLabel.text = good.details;
    cell.detailTextLabel.numberOfLines = 6;
    cell.detailTextLabel.textColor = [UIColor brownColor];
    
    return cell;
}

#pragma mark 选中行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

#pragma mark 点击编辑按钮
- (IBAction)clickEditBtn:(UIButton *)sender {
    
    //设置tableview编辑状态
    BOOL flag = !_tableView.editing;
    [_tableView setEditing:flag animated:YES];
    _editBtn.selected = flag;
}

#pragma mark 选择编辑模式，添加模式很少用,默认是删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

#pragma mark 排序 当移动了某一行时候会调用
//编辑状态下，只要实现这个方法，就能实现拖动排序
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 取出要拖动的模型数据
    Goods *goods = _goodsAry[sourceIndexPath.row];
    //删除之前行的数据
    [_goodsAry removeObject:goods];
    // 插入数据到新的位置
    [_goodsAry insertObject:goods atIndex:destinationIndexPath.row];
}

@end
