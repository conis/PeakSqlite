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
  SampleTodoEntity *entity = [[SampleTodoEntity alloc] initWithFMDB: self.database];
  self.datas = [entity findAllWithOrderBy: [NSString stringWithFormat: @" ORDER BY %@", [SampleTodoEntity timestamp]]];
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
  [self.database executeUpdate: [SampleTodoEntity sqlForCreateTable]];
  [self.database close];
  
  [self insertSamples];
}

//插入示例数据
-(void) insertSamples{
  for(int i = 0; i < 10; i ++){
    SampleTodoEntity *entity = [[SampleTodoEntity alloc] initWithFMDB: self.database];
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
  SampleTodoEntity *entity = [[SampleTodoEntity alloc] initWithFMDB: self.database];
  entity.todo = self.todoInput.text;
  entity.timestamp = [NSDate date];
  entity.done = NO;
  [entity insert];
  
  [self search];
}

#pragma  mark 委托
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
  NSDate *date = [PeakSqlite valueToDate: [dict objectForKey: [SampleTodoEntity timestamp]]];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle: NSDateFormatterFullStyle];
  cell.detailTextLabel.text = [dateFormatter stringFromDate:date];
  
  cell.textLabel.text = [dict objectForKey: [SampleTodoEntity todo]];
  ;
  return cell;
}
@end
