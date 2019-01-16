//
//  ViewController.m
//  mariadb-connector-c
//
//  Created by Zach Wang on 2019/1/16.
//  Copyright © 2019 WildFox. All rights reserved.
//

#import "ViewController.h"
#import "mysql.h"

#define CONNECTION_HOST "127.0.0.1"
#define CONNECTION_USER "zach"
#define CONNECTION_PASS "dragon"
#define CONNECTION_DB   "live"
@interface ViewController ()
@property (nonatomic) MYSQL *connection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.connection = mysql_init(NULL);
        MYSQL *connection = mysql_real_connect(self.connection, CONNECTION_HOST, CONNECTION_USER, CONNECTION_PASS, CONNECTION_DB, 8889, NULL, 0);
        
        if (connection) {
            [self buildTableList];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^ {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect to MySQL" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            });
        }
    });
}

- (void)buildTableList {
    NSString *SQL = @"SHOW TABLES;";
    int status = mysql_real_query(self.connection, [SQL UTF8String], [SQL length]);
    
    if (status == 0) {
        MYSQL_RES *result = mysql_store_result(self.connection);
        
        if (result == NULL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to list tables." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            });
        } else {
            MYSQL_ROW row;
            
            NSMutableArray *tables = [[NSMutableArray alloc] init];
            while ((row = mysql_fetch_row(result))) {
                char *charData = row[0];
                NSString *stringData = [[NSString alloc] initWithCString:charData encoding:NSUTF8StringEncoding];
                [tables addObject:stringData];
            }
            
            mysql_free_result(result);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@", tables);
            });
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to list tables." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
        });
    }
}

@end
