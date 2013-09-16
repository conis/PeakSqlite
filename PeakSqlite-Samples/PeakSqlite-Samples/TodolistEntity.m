/*
  TodolistEntity.m
  todolist的实体类，基于peaksqlite-entity-maker生成。所生成的代码仅适用于PeakSqlite项目
  更多敬请访问：https://github.com/conis/peaksqlite-entity-maker
  PeakSqlite项目：https://github.com/conis/PeakSqlite

  =======================作者信息====================
  作者：Conis
  GitHub: https://github.com/conis
  博客：http://iove.net/
  E-mail: conis.yi@gmail.com
*/

#import "TodolistEntity.h"

@implementation TodolistEntity

//初始化
-(id) initWithFMDB:(FMDatabase *)database{
  self = [super initWithFMDB:database];
  if(self){
    //给表名赋值
    self.tableName = @"todolist";
    //字段列表
    self.fields = @[@"id", @"timestamp", @"done", @"todo"];
    
    self.primaryField = @"id";
    [self setDefault];
  }
  return self;
}

//设置默认数据
-(void) setDefault{
  //清除数据
  self.ID = NSNotFound;
  self.timestamp = nil;
  self.done = NO;
  self.todo = nil;
  
}

//获取所有字段存到数据库的值
-(NSArray *) parameters{
  return @[
    [PeakSqlite dateToValue: self.timestamp],
    [NSNumber numberWithBool: self.done],
    [PeakSqlite nilFilter: self.todo],
    [NSNumber numberWithInt: self.ID]
  ];
}

//插入数据
-(int)insert{
  NSString *sql = @"INSERT INTO todolist(%@) VALUES (%@)";
  NSString *insertFields = @"timestamp,done,todo";
  NSString *insertValues = @"?,?,?";

  //没有指定主键
  if(self.ID != NSNotFound){
    insertFields = [insertFields stringByAppendingString: @", id"];
    insertValues = [insertValues stringByAppendingString: @", ?"];
  }
  sql = [NSString stringWithFormat: sql, insertFields, insertValues];
  return [self insertWithSql:sql parameters: [self parameters]];
}

//更新数据
-(BOOL)update{
  NSString *sql = @"UPDATE todolist SET timestamp = ?,done = ?,todo = ? WHERE id = ?";
  [self.database open];
  BOOL result = [self.database executeUpdate:sql withArgumentsInArray: [self parameters]];
  [self.database close];
  return result;
}

//转换字典到当前实例
-(void)parseFromDictionary: (NSDictionary *) data{
  self.data = data;
  self.ID = [[data objectForKey:@"id"] intValue];
  
  self.timestamp = [PeakSqlite valueToDate: [data objectForKey:@"timestamp"]];
  self.done = [[self.data objectForKey:@"done"] boolValue];
  self.todo = [PeakSqlite valueToString: [data objectForKey:@"todo"]];
}

//==================获取字段名及表名==================
//获取所有的字段名称
+(NSArray *) fields{
  return  @[@"id", @"timestamp", @"done", @"todo"];
}

//获取表名
+(NSString*)tableName{
  return @"todolist";
}

//主键：
+(NSString*) FieldID{
  return @"id";
}


//字段名：timestamp
+(NSString*) FieldTimestamp{
  return @"timestamp";
}

//字段名：done
+(NSString*) FieldDone{
  return @"done";
}

//字段名：todo
+(NSString*) FieldTodo{
  return @"todo";
}


+(NSString *) sqlForCreateTable{
  return @"CREATE TABLE if not exists todolist(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp FLOAT, done boolean, todo TEXT)";
}
@end
