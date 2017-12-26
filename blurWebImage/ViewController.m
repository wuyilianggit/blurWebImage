//
//  ViewController.m
//  blurWebImage
//
//  Created by wkxx on 2017/12/26.
//  Copyright © 2017年 WYL. All rights reserved.
//

#import "ViewController.h"
#import "testTableViewCell.h"

#define KScreenWidth [UIScreen mainScreen].bounds.size.width

#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * blureImageArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _blureImageArray = [NSMutableArray array];
    _dataArray = @[@"http://cdnimg.365yf.com/album/12533761/48619892a325fafc149a.jpg",
                   @"http://cdnimg.365yf.com/album/12533753/16f0eff4ccaa4349669b.jpg",
                   @"http://cdnimg.365yf.com/album/12533746/9ca9b3841fb54dec8a55.jpg",
                   @"http://cdnimg.365yf.com/album/12605464/5511d67abb9447a76bfc.jpg",
                   @"http://cdnimg.365yf.com/album/12605457/ba4e00824a8c5cc43a53.jpg",
                   @"http://cdnimg.365yf.com/album/12605450/5159566240083e17e689.jpg",
                   @"http://cdnimg.365yf.com/album/12605441/062872cd94f1e2ef8503.jpg",
                   @"http://cdnimg.365yf.com/album/12605436/c3c6ba6a2c2b6c9dd57c.jpg",
                   @"http://cdnimg.365yf.com/album/47174218/b5e7c3fe5955d7ea0eb7.jpg",
                   @"http://cdnimg.365yf.com/album/47174215/0976131ee821d349f65f.jpg",
                   @"http://cdnimg.365yf.com/album/47174214/73238d23587ec570b2ce.jpg",
                   @"http://cdnimg.365yf.com/album/47174213/f7e28ffeb3e128d0b26a.jpg",
                   @"http://cdnimg.365yf.com/album/47174212/b1ff3cedacf6cb3089b1.jpg",
                   @"http://cdnimg.365yf.com/album/47174211/7ec2ed84f240e4701ab7.jpg"];
    [self p_setupView];
    
    NSString *path = NSHomeDirectory();//主目录
    NSLog(@"NSHomeDirectory:%@",path);
    NSString *userName = NSUserName();//与上面相同
    NSString *rootPath = NSHomeDirectoryForUser(userName);
    NSLog(@"NSHomeDirectoryForUser:%@",rootPath);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
    NSLog(@"NSDocumentDirectory:%@",documentsDirectory);
    
}

- (void)p_setupView
{
    UITableView * tab = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:tab];
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tab];
    [tab registerNib:[UINib nibWithNibName:@"testTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    tab.delegate = self;
    tab.dataSource = self;
    _tableView = tab;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    testTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ([_blureImageArray containsObject:@(indexPath.row)]) {
        [cell.bigImageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[indexPath.row]] placeholderImage:KPlaceholderImage];
    }else{
        [cell.bigImageView sd_setBlurImageWithURL:[NSURL URLWithString:_dataArray[indexPath.row]] placeholderImage:KPlaceholderImage];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScreenWidth;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_blureImageArray containsObject:@(indexPath.row)]) {
        return;
    }
    [_blureImageArray addObject:@(indexPath.row)];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
