//
//  ZXProductListController.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/8/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXProductListController.h"

#import "LeftSelectScroll.h"
#import "ZXDishesCell.h"


#import "ZXAddAdressController.h"

#import "OverlayView.h"
#import "ShoppingCartView.h"
#import "BadgeView.h"
#import "ShoppingCartCell.h"

#import "ZXMakeSureOrderController.h"

extern int btnH;

@interface ZXProductListController ()<LeftSelectScrollDelegate,UITableViewDataSource,UITableViewDelegate,ZFReOrderTableViewDelegate,CAAnimationDelegate>{
    LeftSelectScroll *leftScrollView;
    
    NSMutableArray *leftDataSource;
    
    //当点击的时候 不去调用滑动调节
    BOOL isScrollSetSelect;
    
    UITableView *_tableViewList;
}


@property (nonatomic,strong) ShoppingCartView *ShopCartView;

@property (nonatomic,strong) NSMutableArray *ordersArray;

@property (nonatomic,strong) NSMutableArray *dataArray;


@property (nonatomic,strong) CALayer *dotLayer;

@property (nonatomic,assign) CGFloat endPointX;

@property (nonatomic,assign) CGFloat endPointY;

@property (nonatomic,strong) UIBezierPath *path;

@property (nonatomic,assign) NSUInteger totalOrders;

@end

@implementation ZXProductListController

 //结算
- (IBAction)didClickSettlementting:(id)sender {
    ZXAddAdressController *vc = [[ZXAddAdressController alloc] init];
    vc.title = @"新增地址";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.navigationBar.shadowImage = [UIImage new];

    [self initObjects];
    
    [self creatLeftScrollView];
    
    [self createTableView];
    
    [self createShopCarView];


}

- (void)createShopCarView
{
    _ShopCartView = [[ShoppingCartView alloc] initWithFrame:CGRectMake(0, ScreenH - 46, ScreenW, 46) inView:self.view withObjects:nil];
    _ShopCartView.parentView = self.view;
    _ShopCartView.OrderList.delegate = self;
    _ShopCartView.OrderList.tableView.delegate = self;
    _ShopCartView.OrderList.tableView.dataSource = self;
    _ShopCartView.backgroundColor = RGB(239, 239, 239);
    [self.view addSubview:_ShopCartView];
    
    CGRect rect = [self.view convertRect:_ShopCartView.shoppingCartBtn.frame fromView:_ShopCartView];
    
    _endPointX = rect.origin.x + 20;
    _endPointY = rect.origin.y + 35;
}


 //初始化数据源
-(void)initObjects{
    leftDataSource = [[NSMutableArray alloc]initWithObjects:@"披萨",@"意大利面",@"饮料",@"水果",@"套餐",@"米线",@"小炒",@"汤,粥",@"小吃",@"意大利面",@"饮料",@"水果",@"披萨",@"意大利面",@"饮料",@"水果",@"套餐",@"米线",@"小炒",@"汤,粥",nil];
    
    NSDictionary *dic1 = @{@"id": @9323283,
                           @"name": @"马可波罗意面",
                           @"min_price": @12.0,
                           @"praise_num": @20,
                           @"picture":@"1.png",
                           @"month_saled":@12};
    
    NSDictionary *dic2 = @{@"id": @9323284,
                           @"name": @"鲜珍焗面",
                           @"min_price": @28.0,
                           @"praise_num": @6,
                           @"picture":@"2.png",
                           @"month_saled":@34};
    
    NSDictionary *dic3 = @{@"id": @9323285,
                           @"name": @"经典焗面",
                           @"min_price": @28.0,
                           @"praise_num": @8,
                           @"picture":@"3.png",
                           @"month_saled":@16};
    
    NSDictionary *dic4 = @{@"id": @26844943,
                           @"name": @"摩洛哥烤肉焗饭",
                           @"min_price": @32.0,
                           @"praise_num": @1,
                           @"picture":@"4.png",
                           @"month_saled":@56};
    
    NSDictionary *dic5 = @{@"id": @9323279,
                           @"name": @"莎莎鸡肉饭",
                           @"min_price": @29.0,
                           @"praise_num": @11,
                           @"picture":@"5.png",
                           @"month_saled":@11};
    
    NSDictionary *dic6 = @{@"id": @9323289,
                           @"name": @"曼哈顿海鲜巧达汤",
                           @"min_price": @22.0,
                           @"praise_num": @2,
                           @"picture":@"6.png",
                           @"month_saled":@5};
    
    NSDictionary *dic7 = @{@"id": @9323243,
                           @"name": @"意式香辣12寸传统",
                           @"min_price": @72.0,
                           @"praise_num": @0,
                           @"picture":@"7.png",
                           @"month_saled":@19};
    
    NSDictionary *dic8 = @{@"id": @9323220,
                           @"name": @"超级棒约翰9寸卷边",
                           @"min_price": @64.0,
                           @"praise_num": @28,
                           @"picture":@"8.png",
                           @"month_saled":@7};
    
    NSDictionary *dic9 = @{@"id": @9323280,
                           @"name": @"牛肉培根焗饭",
                           @"min_price": @30.0,
                           @"praise_num": @48,
                           @"picture":@"9.png",
                           @"month_saled":@0};
    
    NSDictionary *dic10 = @{@"id": @9323267,
                            @"name": @"胡椒薯格",
                            @"min_price": @16.0,
                            @"praise_num": @9,
                            @"picture":@"10.png",
                            @"month_saled":@136};
     _dataArray = [@[[dic1 mutableCopy],[dic2 mutableCopy],[dic3 mutableCopy],[dic4 mutableCopy],[dic5 mutableCopy],[dic6 mutableCopy],[dic7 mutableCopy],[dic8 mutableCopy],[dic9 mutableCopy],[dic10 mutableCopy]] mutableCopy];

}

-(void)createTableView{
    _tableViewList = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.25, leftScrollY+1, kScreenWidth * 0.75, ScreenH-leftScrollY-46)];
    _tableViewList.delegate = self;
    _tableViewList.dataSource = self;
    _tableViewList.rowHeight = 105;
    _tableViewList.backgroundColor = RGB(242, 242, 242);
    _tableViewList.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableViewList.tag = 21;//标识tableView
    [self.view addSubview:_tableViewList];
    _tableViewList.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - setter and getter

-(NSMutableArray *)ordersArray
{
    if (!_ordersArray) {
        _ordersArray = [NSMutableArray array];
    }
    return _ordersArray;
}

 //左侧列表
-(void)creatLeftScrollView{
    leftScrollView = [[LeftSelectScroll alloc]initWithFrame:CGRectMake(0, leftScrollY+1, kScreenWidth * 0.25,ScreenH-leftScrollY-46)];
    NSInteger count = leftDataSource.count;
    leftScrollView.pagingEnabled = YES;
    leftScrollView.bounces = YES;
    
    leftScrollView.contentSize = CGSizeMake(0, btnH * count);
    leftScrollView.autoresizesSubviews = NO;
    [leftScrollView setLeftSelectArray:leftDataSource];
    
    leftScrollView.leftSelectDelegate = self;
    
    leftScrollView.delegate = self;
    
    [self.view addSubview:leftScrollView];
}

#pragma mark 点击左侧切换右侧的代理方法
-(void)clickLeftSelectScrollButton:(NSInteger)indexPath{
    [leftScrollView setContentOffset:CGPointMake(0, indexPath * btnH) animated:YES];
    isScrollSetSelect = NO;
    [_tableViewList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


//// 设置section的高度
#define SECTION_HEIGHT 30.0
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 21) {
        return [self viewForHeaderView:section];
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, SECTION_HEIGHT)];
        UILabel *leftLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 3, SECTION_HEIGHT)];
        [view addSubview:leftLine];
        
        UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, SECTION_HEIGHT)];
        headerTitle.text = [NSString stringWithFormat:@"%ld号口袋",section +1];
        headerTitle.font = [UIFont systemFontOfSize:12];
        [view addSubview:headerTitle];
        
        if (section == 0) {
            
            leftLine.backgroundColor = [UIColor greenColor];
            UIButton *clear = [UIButton buttonWithType:UIButtonTypeCustom];
            clear.frame= CGRectMake(self.view.bounds.size.width - 100, 0, 100, SECTION_HEIGHT);
            [clear setTitle:@"清空购物车" forState:UIControlStateNormal];
            [clear setImage:[UIImage imageNamed:@"dele_shopCar"] forState:UIControlStateNormal];
            [clear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            clear.titleLabel.textAlignment = NSTextAlignmentCenter;
            clear.titleLabel.font = [UIFont systemFontOfSize:12];
            [clear addTarget:self action:@selector(clearShoppingCart:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:clear];
        }
        else{
            
            if (section % 3 == 0) {
                leftLine.backgroundColor = [UIColor orangeColor];
            }
            else if (section % 3 == 1)
            {
                leftLine.backgroundColor = [UIColor yellowColor];
            }
            else if (section % 3 == 2)
            {
                leftLine.backgroundColor = [UIColor redColor];
            }
            
        }
        
        //    view.backgroundColor = kUIColorFromRGB(0x9BCB3D);
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
}

-(void)clearShoppingCart:(UIButton *)sender
{
    [self.ordersArray removeAllObjects];
    
    
    _totalOrders = 0;
    _ShopCartView.badge.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)_totalOrders];
    
    
    [self setTotalMoney];
    [self setCartImage];
    [self.ShopCartView dismissAnimated:YES];
    
    for (NSMutableDictionary *dic in self.dataArray) {
        
        [dic setObject:@"0" forKey:@"orderCount"];
        
    }
    [_tableViewList reloadData];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.ShopCartView.OrderList.tableView])
    {
        return SECTION_HEIGHT;
        }
    else
        return 32;
}


//实际需要会修改
-(UIView*)viewForHeaderView:(NSInteger)parama{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,kScreenWidth * 0.75-20, 32)];
    label.backgroundColor = RGB(239, 239, 239);
    if (leftDataSource.count != 0) {
        label.text = leftDataSource[parama];
        label.font = [UIFont systemFontOfSize:14];
        ZXLog(@"%@",[NSString stringWithFormat:@"第%ld组",(long)parama]);
    }
    if (isScrollSetSelect == YES) {
        if (parama == 0) {
            [leftScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else{
            [leftScrollView setContentOffset:CGPointMake(0, (parama) * btnH) animated:YES];
        }
        [leftScrollView setSelectButtonWithIndexPathSection:parama];
    }
    return label;
}

 #pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:self.ShopCartView.OrderList.tableView])
    {
        return [self.ordersArray count];
    }
    return  leftDataSource.count ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSUInteger count = 0;
    if ([tableView isEqual:_tableViewList]) {
        count = [_dataArray count];
    }
    else if ([tableView isEqual:self.ShopCartView.OrderList.tableView])
    {
        count = [self.ordersArray[section] count];
    }
    return count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_tableViewList]) {
        ZXDishesCell *cell = [ZXDishesCell cellWithTableView:tableView];
        float price = [_dataArray[indexPath.row][@"min_price"] floatValue];
        //NSInteger nSaledNum =[_dataArray[indexPath.row][@"month_saled"] integerValue];
        //NSInteger nPraiseNum =[_dataArray[indexPath.row][@"praise_num"] integerValue];
        
        cell.name.text = _dataArray[indexPath.row][@"name"];
        cell.price.text = [NSString stringWithFormat:@"￥%.0f",price];
       // cell.month_saled.text = [NSString stringWithFormat:@"已售%ld",(long)nSaledNum];
       // cell.praise_num.text = [NSString stringWithFormat:@"%ld",(long)nPraiseNum];
      //  cell.foodImageView.image = [UIImage imageNamed:_dataArray[indexPath.row][@"picture"]];
        cell.foodId = [_dataArray[indexPath.row][@"id"] integerValue];
        cell.amount = _dataArray[indexPath.row][@"orderCount"]?[_dataArray[indexPath.row][@"orderCount"] integerValue]:0;
        __weak __typeof(&*cell)weakCell =cell;
        cell.plusBlock = ^(NSInteger nCount,BOOL animated)
        {
            NSMutableDictionary * dic = _dataArray[indexPath.row];
            [dic setObject:[NSNumber numberWithInteger:nCount] forKey:@"orderCount"];
            CGRect parentRect = [weakCell convertRect:weakCell.plus.frame toView:self.view];
            
            
             NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
            
             [self storeOrders:dict isAdded:animated withSectionIndex:0 withRowIndex:0];
            
            if (animated) {
                [self JoinCartAnimationWithRect:parentRect];
                _totalOrders ++;
            }
            else
            {
                _totalOrders --;
            }
            _ShopCartView.badge.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)_totalOrders];
            [self setCartImage];
            [self setTotalMoney];
        };
          return cell;
    }
    else if([tableView isEqual:_ShopCartView.OrderList.tableView]){
        static NSString *cellID = @"ShoppingCartCell";
        
        ShoppingCartCell *cell = (ShoppingCartCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil] lastObject];
        }
        NSMutableArray *sectionArray =[NSMutableArray array];
        sectionArray = [self.ordersArray objectAtIndex:indexPath.section];
        
        //
        cell.id = [sectionArray[indexPath.row][@"id"] integerValue];
        cell.nameLabel.text = sectionArray[indexPath.row][@"name"];
        
        float price = [sectionArray[indexPath.row][@"min_price"] floatValue];
        cell.priceLabel.text = [NSString stringWithFormat:@"￥%.0f",price] ;
        
        NSInteger count = [sectionArray[indexPath.row][@"orderCount"] integerValue];
        cell.number = count;
        cell.numberLabel.text = [NSString stringWithFormat:@"%ld",count];
        
        cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section % 3 == 0) {
            cell.dotLabel.textColor = [UIColor greenColor];
        }
        else if (indexPath.section % 3 == 1)
        {
            cell.dotLabel.textColor = [UIColor yellowColor];
        }
        else if (indexPath.section % 3 == 2)
        {
            cell.dotLabel.textColor = [UIColor redColor];
        }
        
        cell.operationBlock = ^(NSUInteger nCount,BOOL plus)
        {
            NSMutableDictionary * dic = sectionArray[indexPath.row];
            
            //更新订单列表中的数量
            [dic setObject:[NSNumber numberWithInteger:nCount] forKey:@"orderCount"];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
            
            //获取当前id的所有数量
            NSInteger nTotal = [self CountAllSections:[NSString stringWithFormat:@"%ld",[dic[@"id"] integerValue]]];
            [dict setObject:[NSNumber numberWithInteger:nTotal] forKey:@"orderCount"];
            
            [self storeOrders:dict isAdded:plus withSectionIndex:indexPath.section withRowIndex:indexPath.row];
            
            
            _totalOrders = plus ? ++_totalOrders : --_totalOrders;
            
            _ShopCartView.badge.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)_totalOrders];
            //刷新tableView
            [_tableViewList reloadData];
            [self setCartImage];
            [self setTotalMoney];
            if (_totalOrders <=0) {
                [_ShopCartView dismissAnimated:YES];
            }
            
        };
        
        return cell;
    }
    return nil;
}




-(void)storeOrders:(NSMutableDictionary *)dictionary isAdded:(BOOL)added withSectionIndex:(NSInteger)sectionID withRowIndex:(NSInteger)rowID
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    
    if (added) {
        //如果订单数组是空（无商品） 则需创建两个section (1号口袋，2号口袋（被添加）)
        if ([self.ordersArray count] <=0) {
            [self.ordersArray addObject:[NSMutableArray array]];
            [self.ordersArray addObject:[NSMutableArray array]];
        }
        //如果是从商品列表中添加，传人的sectionID为0
        //如果是从订单列表中添加，传人的sectionID是订单中实际的section
        
        for (NSMutableDictionary *dic in self.ordersArray[sectionID]) {
            if (dic[@"id"] == dict[@"id"]){
                
                NSInteger count = [self CountOthersWithoutSection:sectionID foodID:dictionary[@"id"]];
                NSInteger nCount = [dict[@"orderCount"] integerValue] - count;
                
                [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
                
                self.ShopCartView.OrderList.objects = self.ordersArray;
                [self.ShopCartView.OrderList.tableView reloadData];
                
                return;
            }
        }
        
        NSInteger count = [self CountOthersWithoutSection:sectionID foodID:dictionary[@"id"]];
        count = [dictionary[@"orderCount"] integerValue] - count;
        [dictionary setObject:[NSString stringWithFormat:@"%ld",count] forKey:@"orderCount"];
        [self.ordersArray[sectionID] addObject:dictionary];
        
        self.ShopCartView.OrderList.objects = self.ordersArray;
        [self.ShopCartView.OrderList.tableView reloadData];
    }
    else{
        //从商品列表删除，传人的section =0;优先section：0移除商品，然后再从其他section移除商品
        //从订单列表删除，就从指定的section移除相同的商品
        
        //block 代码段
        void(^block)(NSInteger,NSInteger) = ^(NSInteger section,NSInteger row){
            
            NSDictionary *dic = self.ordersArray[section][row];
            NSInteger count = [dic[@"orderCount"] integerValue];
            if (count <= 0) {
                
                [self.ordersArray[section] removeObjectAtIndex:row];
                self.ShopCartView.OrderList.objects = self.ordersArray;
                [self.ShopCartView.OrderList.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:section]]  withRowAnimation:UITableViewRowAnimationBottom];
                
                //section
                if ([self.ordersArray[section] count] <=0) {
                    [self.ordersArray removeObjectAtIndex:section];
                    [self.ShopCartView.OrderList.tableView deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationBottom];
                }
                
                [self.ShopCartView.OrderList.tableView reloadData];
                [self.ShopCartView updateFrame:self.ShopCartView.OrderList];
            }
            else{
                
            }
        };
        
        
        if (!sectionID && !rowID) {
            NSMutableDictionary *dic = self.ordersArray[sectionID][rowID];
            
            if (dic[@"id"] == dict[@"id"]) {
                NSInteger nCount = [dic[@"orderCount"] integerValue];
                //                nCount -= 1;
                [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
                block(sectionID,rowID);
                
                self.ShopCartView.OrderList.objects = self.ordersArray;
                
                [self.ShopCartView.OrderList.tableView reloadData];
            }
            else{
                //section:0 有该商品
                NSMutableArray *sectionArray = self.ordersArray[sectionID];
                NSInteger row = 0;
                for (NSMutableDictionary *dic in sectionArray)
                {
                    if (dict[@"id"] == dic[@"id"]) {
                        NSInteger nCount = [dic[@"orderCount"] integerValue];
                        nCount -= 1;
                        [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
                        block(sectionID,row);
                        
                        self.ShopCartView.OrderList.objects = self.ordersArray;
                        
                        [self.ShopCartView.OrderList.tableView reloadData];
                        
                        return;
                    }
                    row ++;
                }
                
                //section:0 没有该商品
                for (NSInteger i = sectionID + 1; i < [self.ordersArray count]; i ++) {
                    
                    sectionArray = self.ordersArray[i];
                    row = 0;
                    for (NSMutableDictionary *dic in sectionArray) {
                        if (dict[@"id"] == dic[@"id"]) {
                            NSInteger nCount = [dic[@"orderCount"] integerValue];
                            nCount -= 1;
                            [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
                            
                            if (nCount <= 0) {
                                
                                block(i,row);
                                self.ShopCartView.OrderList.objects = self.ordersArray;
                                
                                [self.ShopCartView.OrderList.tableView reloadData];
                                return;
                            }
                            
                            //刷新当前row
                            [self.ShopCartView.OrderList.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:i],nil] withRowAnimation:UITableViewRowAnimationNone];
                            
                            self.ShopCartView.OrderList.objects = self.ordersArray;
                            
                        }
                        row ++;
                    }
                }
            }
        }
        else{
            
            block(sectionID,rowID);
            
        }
    }
    
}

//计算在其他section中的指定fooid的个数
-(NSInteger)CountOthersWithoutSection:(NSInteger)sectionID foodID:(NSString *)foodID
{
    NSInteger count = 0;
    for (int i = 0; i< self.ordersArray.count; i++) {
        if (sectionID == i) {
            continue;
        }
        NSMutableArray *array = self.ordersArray[i];
        for (NSMutableDictionary *dic in array) {
            if ([dic[@"id"] integerValue] == [foodID integerValue]) {
                count += [dic[@"orderCount"] integerValue];
            }
        }
    }
    
    return count;
}

//计算所有section中指定fooid的个数
-(NSInteger)CountAllSections:(NSString *)foodID
{
    int nCount = 0;
    for (NSMutableArray *array in self.ordersArray) {
        for (NSMutableDictionary *dic in array)
        {
            if ([dic[@"id"] integerValue] == [foodID integerValue]) {
                nCount += [dic[@"orderCount"] integerValue];
            }
        }
    }
    NSMutableDictionary *dic = [self GetDictionaryFromID:[foodID integerValue]];
    
    [dic setObject:[NSNumber numberWithInt:nCount] forKey:@"orderCount"];
    return nCount;
}

-(NSMutableDictionary *)GetDictionaryFromID:(NSInteger)foodID
{
    for (NSMutableDictionary *dic in self.dataArray) {
        if ([dic[@"id"] integerValue] == foodID) {
            return dic;
        }
    }
    return nil;
}


-(void)setTotalMoney
{
    NSInteger nTotal = 0;
    for (NSMutableArray *array in self.ordersArray) {
        for (NSMutableDictionary *dic in array) {
            nTotal += [dic[@"orderCount"] integerValue] * [dic[@"min_price"] integerValue];
        }
    }
    
    [_ShopCartView setTotalMoney:nTotal];
    
}


-(void)setCartImage
{
    if (_totalOrders) {
        [_ShopCartView setCartImage:@"shopcar_on"];
    }
    else{
        [_ShopCartView setCartImage:@"shopcar"];
    }
    
}

#pragma mark -加入购物车动画
-(void) JoinCartAnimationWithRect:(CGRect)rect
{
    
    CGFloat startX = rect.origin.x;
    CGFloat startY = rect.origin.y;
    
    _path= [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startX, startY)];
    //三点曲线
    [_path addCurveToPoint:CGPointMake(_endPointX, _endPointY)
             controlPoint1:CGPointMake(startX, startY)
             controlPoint2:CGPointMake(startX - 180, startY - 200)];
    
    _dotLayer = [CALayer layer];
    UIColor *color = RGB(48, 194, 145);
    _dotLayer.backgroundColor = color.CGColor;
    _dotLayer.frame = CGRectMake(0, 0, 15, 15);
    _dotLayer.cornerRadius = (15 + 15) /4;
    [self.view.layer addSublayer:_dotLayer];
    [self groupAnimation];
    
}
#pragma mark - 组合动画
-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.5f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.8f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [_dotLayer addAnimation:groups forKey:nil];
    
    [self performSelector:@selector(removeFromLayer:) withObject:_dotLayer afterDelay:0.8f];
    
}
- (void)removeFromLayer:(CALayer *)layerAnimation{
    
    [layerAnimation removeFromSuperlayer];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ZXAddAdressController *vc = [[ZXAddAdressController alloc] init];
//    vc.title = @"新增地址";
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isScrollSetSelect = YES ;
}


@end
