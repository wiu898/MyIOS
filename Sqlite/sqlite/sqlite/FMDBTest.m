//
//  FMDBTest.m
//  sqlite
//
//  Created by 李超 on 16/3/10.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "FMDBTest.h"
#import <FMDB.h>

@interface FMDBTest()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation FMDBTest

-(void) viewDidLoad{

    [super viewDidLoad];
    
    //1.获取数据库文件路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"student.sqlite"];
    
    //2.获取数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
    //3.打开数据库
    if ([db open]) {
        NSLog(@"打开数据库成功");
        //4.创建表
        NSString *sql = @"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL,age integer NOT NULL)";
        
        BOOL result = [db executeUpdate:sql];
        if (result) {
            NSLog(@"创表成功");
        }else{
            NSLog(@"创表失败");
        }
    }
    self.db = db;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self delete];
    [self insert];
    [self query];
}

//插入数据

- (void)insert{

    for (int i = 0; i < 10; i++) {
        NSString *name = [NSString stringWithFormat:@"jack-%d",arc4random_uniform(100)];
        [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES(?,?);",name,@(arc4random_uniform(40))];
    }
}

//删除数据
- (void)delete{

    [self.db executeUpdate:@"DROP TABLE IF EXISTS t_student"];
}

//查询
- (void)query{

    //1.执行查询语句
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_student"];
    
    //2.遍历查询结果
    while ([resultSet next]) {
        int ID = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet stringForColumn:@"age"];
        int age = [resultSet intForColumn:@"age"];
        NSLog(@"%d %@ %D", ID, name, age);
    }
}

@end
