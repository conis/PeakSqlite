//
//  ViewController.m
//  PeakSqlite-Samples
//
//  Created by conis on 8/21/13.
//  Copyright (c) 2013 conis. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      [self initDatabase];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  [self search];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//查找数据
-(void) search{
  TodolistEntity *entity = [[TodolistEntity alloc] initWithFMDB: self.database];
  //根据条件查询，条件要在前面加上" AND"
  //NSString *cond = @" AND id < 8";
  NSString *orderBy = [NSString stringWithFormat: @" ORDER BY %@ DESC", [TodolistEntity fieldPrimary]];
  //self.datas = [entity findWithCondition:cond parameters:nil orderBy:nil];
  //分页查询，先根据条件查出分页数据，然后把startIndex和endIndex交给findWithCondition查询
  //PeakPagination pag = [entity paginationWithCondition:cond parameters:nil pageIndex:2 pageSize:3];
  //self.datas = [entity findWithCondition:cond parameters:nil orderBy:orderBy startIndex:pag.startIndex endIndex:pag.endIndex];
  
  self.datas = [entity findAllWithOrderBy: orderBy];
  [self.todolist reloadData];
}


//初始化数据库
-(void) initDatabase{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *path = [paths objectAtIndex:0];
  path = [path stringByAppendingString:@"/test.sqlite"];
  
  //删除现有的文件
  NSFileManager *fm = [NSFileManager defaultManager];
  [fm removeItemAtPath: path error: nil];
  
  self.database = [[FMDatabase alloc] initWithPath:path];
  self.database.traceExecution = YES;
  //建表
  [self.database open];
  [self.database executeUpdate: [TodolistEntity sqlForCreateTable]];
  [self.database close];
  
  [self insertSamples];
}

//插入示例数据
-(void) insertSamples{
  for(int i = 0; i < 10; i ++){
    TodolistEntity *entity = [[TodolistEntity alloc] initWithFMDB: self.database];
    entity.todo = [NSString stringWithFormat: @"Todo %d", i];
    entity.timestamp = [NSDate date];
    entity.done = NO;
    [entity insert];
  }
}
- (void)viewDidUnload {
  [self setTodoInput:nil];
  [self setTodolist:nil];
  [super viewDidUnload];
}

//添加新的todo
- (IBAction)createTodo:(UIButton *)sender {
  [self.todoInput resignFirstResponder];
  
  TodolistEntity *entity = [[TodolistEntity alloc] initWithFMDB: self.database];
  entity.todo = self.todoInput.text;
  entity.timestamp = [NSDate date];
  entity.done = NO;
  [entity insert];
  
  [self search];
}

#pragma  mark 委托
-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
  return YES; 
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    //删除
    NSDictionary *dict = [self.datas objectAtIndex: [indexPath row]];
    NSInteger todoId = [[dict objectForKey: [TodolistEntity fieldPrimary]] intValue];
    TodolistEntity *entity = [[TodolistEntity alloc] initWithFMDB: self.database];
    [entity deleteWithPrimary: todoId];
    [self search];
  }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.datas.count;
}


//取每一行
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  static NSString *kStaticCell = @"Cell";
  NSInteger row = [indexPath row];
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: kStaticCell];
  
  //cell不存在，创建
  if (cell == nil)
	{
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: kStaticCell];
  }
  
  NSDictionary *dict = self.datas[row];
  NSDate *date = [PeakSqlite valueToDate: [dict objectForKey: [TodolistEntity fieldTimestamp]]];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle: NSDateFormatterFullStyle];
  cell.detailTextLabel.text = [dateFormatter stringFromDate:date];
  
  cell.textLabel.text = [dict objectForKey: [TodolistEntity fieldTodo]];
  ;
  return cell;
}
@end
