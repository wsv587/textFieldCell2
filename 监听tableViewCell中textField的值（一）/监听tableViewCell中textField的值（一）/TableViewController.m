//
//  TableViewController.m
//  监听tableViewCell中textField的值（一）
//
//  Created by wangsong on 16/5/3.
//  Copyright © 2016年 alibaba. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "CustomTextField.h"

@interface TableViewController ()
/**
 *  标题
 */
@property(nonatomic, strong) NSArray *titles;
/**
 *  占位文字
 */
@property(nonatomic, strong) NSArray *placeHolders;

/**
 *  姓名
 */
@property(nonatomic, copy) NSString *name;

/**
 *  年龄
 */
@property(nonatomic, copy) NSString *age;

/**
 *  地址
 */
@property(nonatomic, copy) NSString *address;
@end

@implementation TableViewController
    static NSString * const ID = @"textFieldCell";
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSubmitButton];
    
    // 注册通知
    // 注意：此处监听的通知是：UITextFieldTextDidEndEditingNotification，textField结束编辑发送的通知，textField结束编辑时才会发送这个通知。
    // 想实时监听textField的内容的变化，你也可以注册这个通知：UITextFieldTextDidChangeNotification，textField值改变就会发送的通知。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentTextFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.contentTextField.indexPath = indexPath;

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *customCell = (TableViewCell *)cell;
    customCell.titleLabel.text = self.titles[indexPath.row];
    customCell.contentTextField.placeholder = self.placeHolders[indexPath.row];
}

#pragma mark - private method
- (void)contentTextFieldDidEndEditing:(NSNotification *)noti
{
    CustomTextField *textField = noti.object;
    if (textField.indexPath.section == 0) {
        switch (textField.indexPath.row) {
            case 0: // 名称
                self.name = textField.text;
                break;
            case 1: // 年龄
                self.age = textField.text;
                break;
            case 2: // 地址
                self.address = textField.text;
                break;
                
            default:
                break;
        }
    } else if (textField.indexPath.section == 1) {
        // 同上，请自行脑补
    } else if (textField.indexPath.section == 2) {
        // 同上，请自行脑补
    } else {
        // 同上，请自行脑补
    }
}

- (void)setupSubmitButton
{
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 60)];
    [self.view addSubview:submitButton];
    [submitButton setBackgroundColor:[UIColor redColor]];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClickButton:(UIButton *)button
{
    NSLog(@"姓名：%@,年龄：%@，地址：%@",self.name,self.age,self.address);
}

- (NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"姓名",@"年龄",@"地址"];
    }
    return _titles;
}

- (NSArray *)placeHolders
{
    if (!_placeHolders) {
        _placeHolders = @[@"请输入姓名",@"请输入年龄",@"请输入地址"];
    }
    return _placeHolders;
}

@end
