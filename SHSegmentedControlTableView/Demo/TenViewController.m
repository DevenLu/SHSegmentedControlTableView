//
//  TenViewController.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/23.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "TenViewController.h"
#import "TestOneTableView.h"

@interface TenViewController ()<SHSegTableViewDelegate>

@property (nonatomic, strong) SHSegmentedControlTableView *segTableView;

@property (nonatomic, strong) SHSegmentControl *segmentControl;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation TenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    TestOneTableView *tab1 = [[TestOneTableView alloc] init];
    tab1.num = 5;
    tab1.label = @"一";
    TestOneTableView *tab2 = [[TestOneTableView alloc] init];
    tab2.num = 5;
    tab2.label = @"二";
    TestOneTableView *tab3 = [[TestOneTableView alloc] init];
    tab3.num = 5;
    tab3.label = @"三";
    
    [self.segTableView setTableViews:@[tab1,tab2,tab3]];
    
    __weak __typeof(&*self)weakSelf = self;
    MJRefreshNormalHeader *refreshAllHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.all) {
            tab1.num = 30;
            tab2.num = 10;
            tab3.num = 20;
            weakSelf.headerView.backgroundColor = [UIColor sh_colorArc4random];
            [weakSelf.segTableView.refreshHeader endRefreshing];
        }else {
            if (weakSelf.segTableView.selectedIndex == 0) {
                tab1.num = 30;
                weakSelf.headerView.backgroundColor = [UIColor redColor];
            }else if (weakSelf.segTableView.selectedIndex == 1) {
                tab2.num = 10;
                weakSelf.headerView.backgroundColor = [UIColor greenColor];
            }else if (weakSelf.segTableView.selectedIndex == 2) {
                tab3.num = 20;
                weakSelf.headerView.backgroundColor = [UIColor blueColor];
            }
            [weakSelf.segTableView.refreshHeader endRefreshing];
        }
    }];
    [self.segTableView setRefreshHeader:refreshAllHeader];
    
    
    [self.view addSubview:self.segTableView];
}
#pragma mark -
#pragma mark   ==============SHSegTableViewDelegate==============
- (void)segTableViewDidScrollY:(CGFloat)offsetY {
    
}
- (void)segTableViewDidScroll:(UIScrollView *)tableView {
    
}
- (void)segTableViewDidScrollSub:(UIScrollView *)subTableView {
    
}
- (void)segTableViewDidScrollProgress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    if (progress == 1) {
        [self.segmentControl setSegmentSelectedIndex:targetIndex];
    }
}
#pragma mark -
#pragma mark   ==============UI-lazy==============
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _headerView.backgroundColor = [UIColor purpleColor];
    }
    return _headerView;
}
- (SHSegmentControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[SHSegmentControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) items:@[@"分栏一",@"分栏二",@"分栏三"]];
        [_segmentControl reloadViews];
        __weak __typeof(&*self)weakSelf = self;
        _segmentControl.curClick = ^(NSInteger index) {
            [weakSelf.segTableView setSegmentSelectIndex:index];
        };
    }
    return _segmentControl;
}
- (SHSegmentedControlTableView *)segTableView {
    if (!_segTableView) {
        _segTableView = [[SHSegmentedControlTableView alloc] initWithFrame:self.view.bounds];
        _segTableView.delegateCell = self;
        [_segTableView setTopView:self.headerView];
        [_segTableView setBarView:self.segmentControl];
    }
    return _segTableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
