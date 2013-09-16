/*
  todolist的实体类，基于peaksqlite-entity-maker生成。所生成的代码仅适用于PeakSqlite项目
  更多敬请访问：https://github.com/conis/peaksqlite-entity-maker
  PeakSqlite项目：https://github.com/conis/PeakSqlite

  =======================作者信息====================
  作者：Conis
  GitHub: https://github.com/conis
  博客：http://iove.net/
  E-mail: conis.yi@gmail.com
*/

#import <Foundation/Foundation.h>
#import "PeakSqlite.h"

@interface TodolistEntity : PeakSqlite

//属性
@property (nonatomic) NSInteger ID;


@property (nonatomic, strong) NSDate  *timestamp;

@property (nonatomic) BOOL done;

@property (nonatomic, strong) NSString  *todo;


//类方法
+(NSString *) FieldID;

+(NSString *) FieldTimestamp;

+(NSString *) FieldDone;

+(NSString *) FieldTodo;

@end
