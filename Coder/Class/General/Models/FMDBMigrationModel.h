//
//  FMDBMigrationModel.h
//  Miss
//
//  Created by 张得军 on 2019/4/16.
//  Copyright © 2019 djz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDBMigrationManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMDBMigrationModel : NSObject <FMDBMigrating>

- (instancetype)initWithName:(NSString *)name andVersion:(uint64_t)version andExecuteUpdateArray:(NSArray *)updateArray;//自定义方法

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) uint64_t version;
- (BOOL)migrateDatabase:(FMDatabase *)database error:(out NSError *__autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END
