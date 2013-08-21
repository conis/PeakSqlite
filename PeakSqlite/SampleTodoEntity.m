//
//  PeakSqlite.m
//  PeakSqlite-Samples
//
//  Created by conis on 8/21/13.
//  Copyright (c) 2013 conis. All rights reserved.
//


#import "SampleTodoEntity.h"

@implementation SampleTodoEntity

-(id) initWithFMDB:(FMDatabase *)database{
  self = [super initWithFMDB:database];
  if(self){
    //给表名赋值
    self.tableName = @"todolist";
    //字段列表
    self.fields = @[@"id", @"todo", @"timestamp", @"done"];
    //主键的ID
    //self.primaryField = @"id";
  }
  return self;
}

//设置默认数据
-(void) setDefault{
  //清除数据
  self.ID = NSNotFound;
  self.todo = nil;
  self.timestamp = nil;
}

//获取所有字段存到数据库的值
-(NSArray *) parameters{
  return @[[PeakSqlite nilFilter:self.todo],
           [PeakSqlite dateToValue: self.timestamp],
           [NSNumber numberWithBool: self.done],
           [NSNumber numberWithInt: self.ID]];
}

//插入数据
-(int)insert{
  NSString *sql = @"INSERT INTO diary(%@) VALUES (%@)";
  NSString *insertFields = @"todo, timestamp, done";
  NSString *insertValues = @"?,?,?";
  //没有指定ID
  if(self.ID != NSNotFound){
    insertFields = [insertFields stringByAppendingString: @", id"];
    insertValues = [insertValues stringByAppendingString: @", ?"];
  }
  sql = [NSString stringWithFormat: sql, insertFields, insertValues];
  return [self insertWithSql:sql parameters: [self parameters]];
}

//更新数据
-(BOOL)update{
  NSString *sql = @"UPDATE todolist SET todo = ?, timestamp = ?, done = ? WHERE id = ?";
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
  self.done = [[data objectForKey:@"done"] doubleValue];
  self.todo  = [PeakSqlite valueToString: [data objectForKey:@"todo"]];
}

//获取一条数据
-(BOOL) findOneWithCondition:(NSString *)cond parameters:(NSArray *)params orderBy:(NSString *)orderBy{
  BOOL result = [super findOneWithCondition:cond parameters:params orderBy:orderBy];
  //将数据填充到属性
  if(result){
    [self parseFromDictionary: self.data];
  }else{
    //没有找到数据，还原为初始值
    [self setDefault];
  }
  return result;
}

//==================获取字段名及表名==================
//获取所有的字段名称
+(NSArray *) fields{
  return @[@"id", @"todo", @"timestamp", @"done"];
}

//获取表名
+(NSString*)tableName{
  return @"todolist";
}

//字段名：id
+(NSString*)ID{
  return @"id";
}

//字段名： timestamp
+(NSString*)timestamp{
  return @"timestamp";
}

//字段名：todo
+(NSString*)todo{
  return @"todo";
}

//字段名：done
+(NSString*)done{
  return @"done";
}
@end
