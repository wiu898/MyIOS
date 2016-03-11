//
//  ViewController.m
//  sqliteText
//
//  Created by 李超 on 16/3/4.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UITextField *nameField;
@property (strong, nonatomic) UITextField *ageField;
@property (strong ,nonatomic) UITextField *sexField;
@property (strong, nonatomic) UITextField *scoreField;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *ageLabel;
@property (strong ,nonatomic) UILabel *sexLabel;
@property (strong, nonatomic) UILabel *scoreLabel;
@property (strong, nonatomic) UIButton *saveButton;

@end

@implementation ViewController

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]
                      initWithFrame:CGRectMake(10, 70, 60, 50)];
        _nameLabel.text = @"姓名:";
        _nameLabel.font = [UIFont systemFontOfSize:24];
        _nameLabel.textColor = [UIColor redColor];
    }
    return _nameLabel;
}

- (UILabel *)sexLabel{
    if (_sexLabel == nil) {
        _sexLabel = [[UILabel alloc]
                     initWithFrame:CGRectMake(10, 130, 60, 50)];
        _sexLabel.text = @"性别:";
        _sexLabel.font = [UIFont systemFontOfSize:24];
        _sexLabel.textColor = [UIColor redColor];
    }
    return _sexLabel;
}

- (UILabel *)ageLabel{
    if (_ageLabel == nil) {
        _ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 190, 60, 50)];
        _ageLabel.font = [UIFont systemFontOfSize:24];
        _ageLabel.text = @"年龄:";
        _ageLabel.textColor = [UIColor redColor];
    }
    return _ageLabel;
}

- (UILabel *)scoreLabel{
    if (_scoreLabel == nil) {
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 250, 60, 50)];
        _scoreLabel.font = [UIFont systemFontOfSize:24];
        _scoreLabel.textColor = [UIColor redColor];
        _scoreLabel.text = @"分数:";
    }
    return _scoreLabel;
}

- (UITextField *)nameField{
    if (_nameField == nil) {
        _nameField = [[UITextField alloc] initWithFrame:CGRectMake(90, 70, 170, 50)];
        _nameField.backgroundColor = [UIColor whiteColor];
    }
    return _nameField;
}

- (UITextField *)sexField{
    if (_sexField == nil) {
        _sexField = [[UITextField alloc] initWithFrame:CGRectMake(90, 130, 170, 50)];
    }
    _sexField.backgroundColor = [UIColor whiteColor];
    return _sexField;
}

- (UITextField *)ageField{
    if (_ageField == nil) {
        _ageField = [[UITextField alloc] initWithFrame:CGRectMake(90, 190, 170, 50)];
        _ageField.backgroundColor = [UIColor whiteColor];
    }
    return _ageField;
}

- (UITextField *)scoreField{
    if (_scoreField == nil) {
        _scoreField = [[UITextField alloc] initWithFrame:CGRectMake(90, 250, 170, 50)];
        _scoreField.backgroundColor = [UIColor whiteColor];
    }
    return _scoreField;
}

- (UIButton *)saveButton{
    if (_saveButton == nil) {
        _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 350, 100, 40)];
        _saveButton.backgroundColor = [UIColor lightGrayColor];
        [_saveButton addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
        _saveButton.layer.cornerRadius = 0.8;
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
    }
    return _saveButton;
}

- (void)SqliteConnect{
    
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    
    NSString *database_path = [paths stringByAppendingPathComponent:@"student.sqlite"];
    
    int result = sqlite3_open(database_path.UTF8String, &db);
    
    if (result != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"open failed");
        NSLog(@"数据库打开失败");
    }else{
        NSLog(@"打开成功");
        
                //创建表
                NSString *sql = @"CREATE TABLE IF NOT EXISTS STUDENT(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, score REAL, sex TEXT);";
                result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
                if (result == SQLITE_OK) {
                    NSLog(@"创建表成功");
                }else
                {
                    NSLog(@"创建表失败");
                }
    }
    
    NSLog(@"%@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
}

- (void)saveData{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [paths objectAtIndex:0];
    
    NSString *database_path = [documents stringByAppendingPathComponent:@"student.sqlite"];
    
    NSLog(@"path = %@",database_path);
    
    int result = sqlite3_open(database_path.UTF8String, &db);
    
    if (result != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"open failed");
        NSLog(@"数据库打开失败");
    }else{
        NSLog(@"数据库打开成功");
        
        NSLog(@"%@,%@,%ld,%f",_name,_sex,_age,_score);
        
        //插入数据
        NSString *sql = [NSString stringWithFormat: @"INSERT INTO STUDENT(NAME,AGE,SCORE,SEX) VALUES(\"%@\",\"%ld\",\"%f\",\"%@\")",_name,_age,_score,_sex];
        
        result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
        
        if (result == SQLITE_OK) {
            NSLog(@"插入数据成功");
            sqlite3_close(db);
        }else{
            NSLog(@"插入数据失败");
            sqlite3_close(db);
        }
    }
    
}

- (void)query{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dataBase = [path stringByAppendingPathComponent:@"student.sqlite"];
    
    int result = sqlite3_open(dataBase.UTF8String, &db);
    
    if (result != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }else{
        NSLog(@"数据库打开成功");
        
        sqlite3_stmt *statement;
        
        //查询数据
        NSString *sql = @"SELECT * FROM STUDENT";
        
        result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &statement, NULL);
        
        if (result == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSString *nameField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
               
                _nameField.text = nameField;
                
                NSString *ageField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                _ageField.text = ageField;
                
                NSString *scoreField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                
                _scoreField.text = scoreField;
                
                NSString *sexField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                
                _sexField.text = sexField;
                
            }else{
                NSLog(@"没有查询到数据");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(db);

    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.sexLabel];
    [self.view addSubview:self.ageLabel];
    [self.view addSubview:self.scoreLabel];
    
    [self.view addSubview:self.nameField];
    [self.view addSubview:self.sexField];
    [self.view addSubview:self.ageField];
    [self.view addSubview:self.scoreField];
    
    [self.view addSubview:self.saveButton];
    
    [self query];
    
}

- (void)saveBtn:(id)sender{
    NSLog(@"进入保存方法");
    NSString *name = _nameField.text;
    NSString *sex = _sexField.text;
    NSString *age = _ageField.text;
    NSString *score = _scoreField.text;
    _name = name;
    _sex = sex;
    _score = [score doubleValue];
    _age = [age intValue];
    [self saveData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
