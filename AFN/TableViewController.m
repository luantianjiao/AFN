//
//  TableViewController.m
//  AFN
//
//  Created by luan on 16/6/17.
//  Copyright © 2016年 luan. All rights reserved.
//

#import "TableViewController.h"
#import "AFNHelper.h"
#import <MJRefresh.h>

@interface TableViewController ()

@property(nonatomic,strong) NSMutableArray *items;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

#pragma mark
    self.items = [NSMutableArray array];
    
    for (int i = 1; i <= 5; i ++) {
        NSString *str = [NSString stringWithFormat:@"单元格%d",i];
        [self.items addObject:str];
    }
    //添加一个下拉刷新头部组件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
#pragma mark 如果数据是通过网络请求获得，在此处再次获取数据
        //先将之前的数据移除掉
        //        [self.items removeAllObjects];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            static int j = 6;
            for (int i = 1; i <= 5; i ++) {
                NSString *new = [NSString stringWithFormat:@"new 单元格%d",j];
                j ++;
                [self.items addObject:new];
            }
            //通知主线程更新UI界面
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
    
    //添加上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(tapFooter)];

    
    
#pragma mark AFNetworking
    NSString *url = @"";
    
    
    [AFNHelper get:url parameter:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } faliure:^(id error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark 上拉加载更多方法
- (void)tapFooter{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        static int j = 1;
        for (int i = 1; i <= 5; i ++) {
            NSString *old = [NSString stringWithFormat:@"old单元格%d",j];
            j ++;
            [self.items addObject:old];
        }
        //通知主线程更新UI界面
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    //结束刷新
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
