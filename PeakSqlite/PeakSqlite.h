//
//  PeakSqliteEntity.h
//
//  Created by conis on 8/21/13.
//  Copyright (c) 2013 conis. All rights reserved.
//

/*
 操作数据库的基本类
*/

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

//定义结构
typedef struct{
  CGFloat pageSize;
  CGFloat pageIndex;
  CGFloat pageCount;
  CGFloat recordCount;
  CGFloat startIndex;
  CGFloat endIndex;
}PeakPagination;

@interface PeakSqlite : NSObject

@property (nonatomic, strong) FMDatabase *database;
//查询出来的一条数据
@property (nonatomic, strong) NSDictionary *data;
//表名
@property(nonatomic, strong) NSString *tableName;
//字段列表
@property(nonatomic, strong) NSArray *fields;
//主键
@property (nonatomic) NSInteger primaryId;

//主键名称
@property(nonatomic, strong) NSString *primaryField;

//初始化
-(id) initWithFMDB: (FMDatabase *) database;
//从字典中转换数据到当前实例
-(void)parseFromDictionary: (NSDictionary *) data;
//计算根据Sql计算分页信息
-(PeakPagination) paginationWithSql: (NSString *) sql parameters:(NSArray *)params pageIndex: (NSInteger) aIndex pageSize: (NSInteger) aSize;
//根据条件对当前表进行分页计算
-(PeakPagination) paginationWithCondition: (NSString *) cond parameters: (NSArray *) params pageIndex: (NSInteger) aIndex pageSize: (NSInteger) aSize;

//======================增删改====================
//插入当前实例，并返回最后插入的ID
-(NSInteger) insert;
//插入数据，并返回最后插入的ID
-(NSInteger) insertWithSql:(NSString *)sql parameters:(NSArray *)params;
//更新数据
-(BOOL) update;
//保存当前实例
-(BOOL) save;
//根据主键删除
-(BOOL) deleteWithPrimary:(NSInteger)primaryId;
//根据条件删除某个表的数据
-(BOOL) deleteWithCondition:(NSString *)condition parameters:(NSArray *)params;
-(BOOL) executeWithSql:(NSString *)sql parameters:(NSArray *)params;
//======================计算与统计==================
//根据Sql来计算总记录数
-(NSInteger)countWithSql:(NSString *)sql parameters:(NSArray *)params;
//根据条件计算当前表
-(NSInteger) countWithCondition:(NSString *)cond parameters:(NSArray *)params;
//根据条件统计当前表的某一个字段
-(CGFloat) sumWithCondition: (NSString *) cond field: (NSString *) field parameters:(NSArray *)params;
//根据sql统计，要求sql的第一列必需是sum(field)
-(CGFloat) sumWithSql: (NSString *) sql parameters:(NSArray *)params;

//======================查询==================
//获取第一行第一列的数据
-(id) scalarWithSql:(NSString *)sql parameters:(NSArray *)params;
//获取一条记录
-(BOOL) findOneWithCondition:(NSString *)cond parameters:(NSArray *)params orderBy:(NSString *)orderBy;
//根据主键，获取一条记录
-(BOOL)findOneWithPrimaryId:(NSInteger) primaryId;
//从FMResultSet中读取数据，子类继承
//-(BOOL) findOneWithFMResultSet:(FMResultSet *)rs;
//根据Sql搜索，并返回结果集
-(NSArray *) findWithSql:(NSString *)sql parameters:(NSArray *)params;
//根据条件查询当前表
-(NSArray *) findWithCondition: (NSString *) cond parameters:(NSArray *)params orderBy:(NSString *)orderBy;
//根据条件查询，可以进行分页
-(NSArray *) findWithCondition: (NSString *) cond parameters:(NSArray *)params orderBy:(NSString *)orderBy startIndex: (NSInteger) start endIndex: (NSInteger) end;
//获取当前表的所有数据
-(NSArray *) findAllWithOrderBy: (NSString *) orderBy;
//查询所有数据，并可以分页
-(NSArray *) findAllWithOrderBy: (NSString *) orderBy startIndex: (NSInteger) start endIndex: (NSInteger) end;
//检查表是否存在
-(BOOL) existsWithTableName: (NSString *) tableName;
//检测某个表的某个字段是否存在
-(BOOL) existsWithTableName:(NSString *)tableName fieldName: (NSString *) field;
-(void) alterWithField: (NSString *) fieldName dataType: (NSString *) dataType;
//==================类方法============
+(NSString *) tableName;
+(NSArray *) fields;
+(NSString *) fieldPrimary;
//将nil转换为NSNull null，主要针对指针类型
+(id) nilFilter: (id) value;
//是否为数据库中的空值
+(BOOL) isDBNull:(id)value;
+(id) dateToValue: (NSDate *) date;
+(NSString *) sqlForCreateTable;

//将数据库中的值转换为各种类型
+(BOOL) valueToBool:(id)value;
+(BOOL) valueToBool:(id)value defaultValue:(BOOL)def;
+(NSInteger) valueToInt: (id) value;
+(NSInteger) valueToInt: (id) value defaultValue: (NSInteger) def;
+(NSString *) valueToString: (id) value;
+(NSString *) valueToString: (id) value defaultValue: (NSString *) def;
+(CGFloat) valueToFloat: (id) value;
+(CGFloat) valueToFloat: (id) value defaultValue: (CGFloat) def;
+(NSDate*) valueToDate:(id)value;
+(NSDate*) valueToDate:(id)value defaultValue: (NSDate*) def;
@end
