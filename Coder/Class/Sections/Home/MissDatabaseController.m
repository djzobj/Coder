//
//  MissDatabaseController.m
//  Miss
//
//  Created by 张得军 on 2018/9/30.
//  Copyright © 2018年 djz. All rights reserved.
//

#import "MissDatabaseController.h"
#import <sqlite3.h>
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>
#import <FMDBMigrationManager.h>
#import "FMDBMigrationModel.h"

@interface MissDatabaseController ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation MissDatabaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTable];
    [self addEventButton];
}

- (void)addEventButton {
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(50, 100, 80, 40);
    label.text = @"insert";
    [self.view addSubview:label];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(insertAction)];
    [label addGestureRecognizer:tap];
    label.userInteractionEnabled = YES;
    
    label = [UILabel new];
    label.frame = CGRectMake(50, 170, 80, 40);
    label.text = @"delete";
    [self.view addSubview:label];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteAction)];
    [label addGestureRecognizer:tap];
    label.userInteractionEnabled = YES;
    
    label = [UILabel new];
    label.frame = CGRectMake(50, 240, 80, 40);
    label.text = @"update";
    [self.view addSubview:label];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateAction)];
    [label addGestureRecognizer:tap];
    label.userInteractionEnabled = YES;
    
    label = [UILabel new];
    label.frame = CGRectMake(50, 310, 80, 40);
    label.text = @"query";
    [self.view addSubview:label];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(queryAction)];
    [label addGestureRecognizer:tap];
    label.userInteractionEnabled = YES;
    
    label = [UILabel new];
    label.frame = CGRectMake(50, 380, 80, 40);
    label.text = @"drop";
    [self.view addSubview:label];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dropTable)];
    [label addGestureRecognizer:tap];
    label.userInteractionEnabled = YES;

}

- (void)createTable {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:@"student.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    if ([_db open]) {
        NSString *sql = @"create table if not exists t_student(id integer primary key autoincrement, name text, age integer, sex text)";
        BOOL success = [_db executeUpdate:sql];
        if (success) {
            NSLog(@"t_student表创建成功");
        }else{
            NSLog(@"t_student表创建失败");
        }
        [_db close];
    }else{
        NSLog(@"数据库打开失败");
    }
    FMDBMigrationManager *manager = [FMDBMigrationManager managerWithDatabaseAtPath:path migrationsBundle:[NSBundle mainBundle]];
    FMDBMigrationModel *migration_1 = [[FMDBMigrationModel alloc] initWithName:@"addUserTable" andVersion:1 andExecuteUpdateArray:@[@"create table User(name text,age integer,sex text,phoneNum text)"]];
    [manager addMigration:migration_1];
    BOOL resultState=NO;
    NSError * error=nil;
    if (!manager.hasMigrationsTable) {
        resultState=[manager createMigrationsTable:&error];
    }
    //UINT64_MAX 表示升级到最高版本
    resultState=[manager migrateDatabaseToVersion:UINT64_MAX progress:nil error:&error];
    
    [_db open];
    NSString *sql = @"insert into User(name, age, sex, phoneNum) values (?, ?, ?, ?)";
    [_db executeUpdate:sql, @"张三", @(27), @"男", @"15157103462"];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        NSLog(@"%@", [NSThread currentThread]);
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    });
}

- (void)insertAction {
    [_db open];
    for (NSInteger i = 1; i < 50; i ++) {
        NSString *sql = @"insert into t_student(name, age, sex) values (?, ?, ?)";
        BOOL result = [_db executeUpdate:sql, [NSString stringWithFormat:@"%@", @(i)], @(i), @"男"];
        if (result) {
            NSLog(@"添加成功");
        }else{
            NSLog(@"添加失败");
        }
    }
    [_db close];
}

- (void)deleteAction {
    [_db open];
    BOOL result = [_db executeUpdate:@"delete from t_student"];
    if (result) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败 %d", result);
    }
    // 关闭数据库
    [_db close];
}

- (void)updateAction {
    [_db open];
    BOOL result = [_db executeUpdate:@"update t_student set age = ?, sex = ?where name = ?", @(18), @"男", @"李四"];
    if (result) {
        NSLog(@"更新成功");
    } else {
        NSLog(@"更新失败 %d", result);
    }
    result = [_db executeUpdate:@"alter table t_student add column stature real"];
    // 关闭数据库
    [_db close];
}

- (void)queryAction {
    [_db open];
    FMResultSet *resultSet= [_db executeQuery:@"select * from t_student limit 45,10"];
    if (resultSet) {
        while ([resultSet next]) {
            NSString *ID = [resultSet stringForColumn:@"id"];
            NSString *name = [resultSet stringForColumn:@"name"];
            NSLog(@"----- id == %@   name == %@", ID, name);
        }
    }
}

- (void)dropTable {
    [_db open];
    [_db executeUpdate:@"drop table if exists t_student;"];
    [_db close];
}

- (void)dealloc {
    
}

@end
