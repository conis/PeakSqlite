//
//  PeakSqlite.h
//  PeakSqlite-Samples
//
//  Created by conis on 8/21/13.
//  Copyright (c) 2013 conis. All rights reserved.
//
/*
 Entity实体的示例，供参考用，不必复制此类
*/

#import <Foundation/Foundation.h>
#import "PeakSqlite.h"

@interface SampleTodoEntity : PeakSqlite

//主键ID
@property (nonatomic) NSInteger ID;
//todo
@property (nonatomic, strong) NSString *todo;
//创建时间
@property (nonatomic, strong) NSDate *timestamp;
//状态，是否完成
@property (nonatomic) BOOL done;

//返回字段名称
+(NSString *) ID;
+(NSString *) todo;
+(NSString *) timestamp;
+(NSString *) done;
@end
