//
//  ViewController.m
//  Contacts_Demo
//
//  Created by SmartDoc on 15/8/12.
//  Copyright (c) 2015年 SmartDoc. All rights reserved.
//

#import "TelViewController.h"

@interface TelViewController ()

@end

@implementation TelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.phoneSegment.layer.cornerRadius = 15;
    self.phoneSegment.layer.masksToBounds = YES;
    self.phoneSegment.layer.borderWidth = 1;
    self.phoneSegment.layer.borderColor = [UIColor whiteColor].CGColor;

    [self.messageTable registerNib:[UINib nibWithNibName:@"ContactCell" bundle:nil] forCellReuseIdentifier:IDENTIFIER];
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated {
    self.phoneSegment.selectedSegmentIndex = 0;
}

- (void)loadData {
    self.dataArray = [[NSMutableArray alloc] init];
    ContactsInfo * info = [ContactsInfo shareContact];
    
    for (NSDictionary * contactDict in info.contactArray) {
        PersonContentModel * model = [[PersonContentModel alloc] init];
        model.name = contactDict[NAME]; //姓名
        model.company = contactDict[COMPANY]; //公司
        model.imageData = contactDict[HEADER_IMAGE]; //头像
        
        NSMutableString * telStr = [[NSMutableString alloc] init];
        for (NSDictionary * telDict in contactDict[NUMBER]) { //电话
            [telStr appendFormat:@"%@\n%@\n",telDict.allKeys[0],telDict[telDict.allKeys[0]]];
            model.tel =[telStr substringToIndex:telStr.length-1];
        }
        NSMutableString * emailStr = [[NSMutableString alloc] init];
        for (NSDictionary * emailDict in contactDict[EMAIL]) { //邮箱
            [emailStr appendFormat:@"%@\n%@\n",emailDict.allKeys[0],emailDict[emailDict.allKeys[0]]];
            model.email = [emailStr substringToIndex:emailStr.length-1];
        }
        [self.dataArray addObject:model];
    }
//    for (int i = 0; i < self.dataArray.count-1; i++) {
//        for (int j = 0; j < self.dataArray.count-1-i; j++) {
//            PersonContentModel * model1 = self.dataArray[j];
//            PersonContentModel * model2 = self.dataArray[j+1];
//            if ([[self firstCharactor:model1.name] compare:[self firstCharactor:model2.name]] == NSOrderedDescending) {
//                [self.dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
//            }
//        }
//    }
    self.searchArray = self.dataArray;
    [self.messageTable reloadData];
}

////获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
//- (NSString *)firstCharactor:(NSString *)aString {
//    //转成了可变字符串
//    NSMutableString *str = [NSMutableString stringWithString:aString];
//    //先转换为带声调的拼音
//    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
//    //再转换为不带声调的拼音
//    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
//    //转化为大写拼音
//    NSString *pinYin = [str capitalizedString];
//    //获取并返回首字母
//    return [pinYin substringToIndex:1];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell * cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER forIndexPath:indexPath];
        PersonContentModel * model = self.searchArray[indexPath.row];
        cell.headerImage.image = [UIImage imageWithData:model.imageData];
        cell.nameLabel.text = model.name;
        cell.companyLabel.text = model.company;
        cell.telLabel.text = model.tel;
        cell.emailLabel.text = model.email;
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonContentModel * model = self.dataArray[indexPath.row];
    NSMutableArray * array = [[NSMutableArray alloc] init];
    if (model.name.length) {
        [array addObject:model.name];
    }
    if (model.company.length) {
        [array addObject:model.company];
    }
    if (model.tel.length) {
        [array addObject:model.tel];
    }
    if (model.email.length) {
        [array addObject:model.email];
    }
    CGFloat height = [RowHeight rowHeight:array sizeWidth:WIDTH-110];
    return height+10;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText != nil) {
        searchStr = searchText;
    }
    if (searchStr != nil && searchStr.length > 0) {
        self.searchArray = [NSMutableArray array];
        for (PersonContentModel * model in self.dataArray) {
            if ([model.name rangeOfString:searchStr options:NSCaseInsensitiveSearch].length > 0) {
                [self.searchArray addObject:model];
            }
        }
    } else {
        self.searchArray = [NSMutableArray arrayWithArray:self.dataArray];
    }
    if (self.searchArray.count) {
        self.messageTable.scrollEnabled = YES;
        self.resultLabel.hidden = YES;
    } else {
        self.messageTable.scrollEnabled = NO;
        self.resultLabel.hidden = NO;
    }
    [self.messageTable reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.search.showsCancelButton = NO;
    [self.search resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.search.showsCancelButton = YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchBar:self.search textDidChange:nil];
    [self.search resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self searchBar:self.search textDidChange:nil];
    self.search.showsCancelButton = NO;
    [self.search resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
