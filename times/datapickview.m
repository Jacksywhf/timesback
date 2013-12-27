//
//  datapickview.m
//  times
//
//  Created by Netcoc on 13-12-24.
//  Copyright (c) 2013年 Netcoc. All rights reserved.
//

#import "datapickview.h"
//命名需要大写这里我没有大写
typedef enum {
    years =1,   //年
    month,      //月
    day,        //日
    when,       //时
    points,     //分
} parameter;
@implementation datapickview
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        monthdic =          [[NSMutableArray alloc]init];
        yeardic =           [[NSMutableArray alloc]init];
        whendic =           [[NSMutableArray alloc]init];
        pointsdic =         [[NSMutableArray alloc]init];
        selectarraytime =   [[NSMutableArray alloc]init];
        datydic =           [[NSMutableArray alloc]init];
        //界面UI
        [self loadviewui];
    }
    return self;
}
#pragma mark 界面UI
-(void)loadviewui{
    //年
    for (int i=2000; i<=2099; i++) {
        NSString *string = [NSString stringWithFormat:@"%d年",i];
        [yeardic addObject:string];
    }
    //月
    for (int i =1 ; i<=12; i++) {
        NSString *strings = [NSString stringWithFormat:@"%d月",i];
        [monthdic addObject:strings];
    }
    //日
    for (int i =1 ; i<=31; i++) {
        NSString *strings = [NSString stringWithFormat:@"%d日",i];
        [datydic addObject:strings];
    }
    //时
    for (int i=0; i<=23; i++) {
        NSString *strings = [NSString stringWithFormat:@"%d点",i];
        [whendic addObject:strings];
    }
    //分
    for (int i=0; i<=59; i++) {
        NSString *strings = [NSString stringWithFormat:@"%d分",i];
        [pointsdic addObject:strings];
    }
    
    dataview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 115)];
    [self addSubview:dataview];
    
    //显示当前时间的空间
    thecurrenttime = [[UILabel alloc]initWithFrame:CGRectMake(75, 5, 150, 20)];
    thecurrenttime.text = @"";
    thecurrenttime.font = [UIFont systemFontOfSize:12.0f];
    thecurrenttime.textAlignment = NSTextAlignmentCenter;
    [dataview addSubview:thecurrenttime];
    
    //确认
    confirmbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmbutton.frame = CGRectMake(270, 5, 40, 20);
    confirmbutton.backgroundColor = [UIColor redColor];
    [confirmbutton addTarget:self action:@selector(currenttime) forControlEvents:UIControlEventTouchUpInside];
    [dataview addSubview:confirmbutton];
    
    
    //上面的半透明
    shxianview = [[UIView alloc]initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH-20, 30)];
    shxianview.backgroundColor = [UIColor whiteColor];
    shxianview.alpha = 0.5;
    shxianview.userInteractionEnabled = NO;
    [dataview addSubview:shxianview];
    
    //下面的半透明
    xxianview = [[UIView alloc]initWithFrame:CGRectMake(10, 92, SCREEN_WIDTH-20, 30)];
    xxianview.backgroundColor = [UIColor whiteColor];
    xxianview.alpha = 0.5;
    xxianview.userInteractionEnabled = NO;
    [dataview addSubview:xxianview];
    
    //上面的线
    shxian  = [[UIView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 0.5)];
    shxian.backgroundColor = [UIColor grayColor];
    [dataview addSubview:shxian];
    
    //下面的线
    xxian  = [[UIView alloc]initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 0.5)];
    xxian.backgroundColor = [UIColor grayColor];
    [dataview addSubview:xxian];
    
    //年
    ytable = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, 67, 85) style:UITableViewStylePlain];
    ytable.backgroundColor = [UIColor clearColor];
    ytable.tag = years;
    ytable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    ytable.delegate = self;
    ytable.dataSource = self;
    ytable.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    ytable.tableHeaderView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    ytable.showsHorizontalScrollIndicator =NO;
    ytable.showsVerticalScrollIndicator = NO;
    ytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [dataview addSubview:ytable];
    
    
    //月
    mtable = [[UITableView alloc]initWithFrame:CGRectMake(70-3, 30, 54, 85) style:UITableViewStylePlain];
    mtable.backgroundColor = [UIColor clearColor];
    mtable.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 62.5, 30)];
    mtable.tableHeaderView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 62.5, 30)];
    mtable.tag = month;
    mtable.dataSource = self;
    mtable.showsHorizontalScrollIndicator =NO;
    mtable.showsVerticalScrollIndicator = NO;
    mtable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mtable.delegate = self;
    
    [dataview addSubview:mtable];
    [dataview bringSubviewToFront:shxian];
    [dataview bringSubviewToFront:xxian];
    [dataview bringSubviewToFront:shxianview];
    
    //日
    ttable = [[UITableView alloc]initWithFrame:CGRectMake(70+62.5-3-8.5, 30, 62.5+3+8.5+8.5+8.5, 85) style:UITableViewStylePlain];
    ttable.backgroundColor = [UIColor clearColor];
    ttable.tag = day;
    ttable.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 62.5, 30)];
    ttable.tableHeaderView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 62.5, 30)];
    ttable.dataSource = self;
    ttable.showsHorizontalScrollIndicator =NO;
    ttable.showsVerticalScrollIndicator = NO;
    ttable.separatorStyle = UITableViewCellSeparatorStyleNone;
    ttable.delegate = self;
    [dataview addSubview:ttable];
    [dataview bringSubviewToFront:shxian];
    [dataview bringSubviewToFront:xxian];
    [dataview bringSubviewToFront:shxianview];
    [dataview bringSubviewToFront:xxianview];
}
-(void)setIstime:(BOOL)istime{
    _istime = istime;
    //真的时候显示时分秒
    if (self.istime) {
        //时
        timetable = [[UITableView alloc]initWithFrame:CGRectMake(70+62.5*2+8.5+8.5, 30, 54, 85) style:UITableViewStylePlain];
        timetable.backgroundColor = [UIColor clearColor];
        timetable.tag = when;
        timetable.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 62.5, 30)];
        timetable.tableHeaderView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 62.5, 30)];
        timetable.dataSource = self;
        timetable.showsHorizontalScrollIndicator =NO;
        timetable.showsVerticalScrollIndicator = NO;
        timetable.separatorStyle = UITableViewCellSeparatorStyleNone;
        timetable.delegate = self;
        [dataview addSubview:timetable];
        //分
        tiametable = [[UITableView alloc]initWithFrame:CGRectMake(70+62.5*3, 30, 54, 85) style:UITableViewStylePlain];
        tiametable.backgroundColor = [UIColor clearColor];
        tiametable.tag = points;
        tiametable.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 62.5, 30)];
        tiametable.tableHeaderView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 62.5, 30)];
        tiametable.dataSource = self;
        tiametable.showsHorizontalScrollIndicator =NO;
        tiametable.showsVerticalScrollIndicator = NO;
        tiametable.separatorStyle = UITableViewCellSeparatorStyleNone;
        tiametable.delegate = self;
        [dataview addSubview:tiametable];
    }else{
        dataview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 85+30);
        ytable.frame = CGRectMake(0, 30, 106, 85);
        mtable.frame = CGRectMake(106, 30, 106, 85);
        ttable.frame =CGRectMake(106*2, 30, 106, 85);
    }
    [dataview addSubview:ttable];
    [dataview bringSubviewToFront:shxian];
    [dataview bringSubviewToFront:xxian];
    [dataview bringSubviewToFront:shxianview];
    [dataview bringSubviewToFront:xxianview];
}
-(void)setdate:(NSDate *)date{
    //设置当前时间
    [self settimes:date];
}
#pragma mark 设置当前时间
-(void)settimes:(NSDate *)senddate{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm"];
    NSString * morelocationString=[dateformatter stringFromDate:senddate];
    NSArray  * array= [morelocationString componentsSeparatedByString:@"-"];
    if (self.istime) {
        thecurrenttime.text =[NSString stringWithFormat:@"%@年%@月%@日%@时%@分",[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2],[array objectAtIndex:3],[array objectAtIndex:4]];
        //选中年份的
        newyear =  [[array objectAtIndex:0]integerValue]-2000.0;
        [ytable  setContentOffset:CGPointMake(0, (newyear*30)-(ytable.contentInset.top)) animated:YES];
        //选中月份
        newmonth = [[array objectAtIndex:1]integerValue]-1.0;
        [mtable  setContentOffset:CGPointMake(0, (newmonth*30)-(mtable.contentInset.top)) animated:YES];
        //选中日
        newday = [[array objectAtIndex:2]integerValue]-1.0;
        [ttable  setContentOffset:CGPointMake(0, (newday*30)-(ttable.contentInset.top)) animated:YES];
        //选中时
        newwhen = [[array objectAtIndex:3]integerValue]-0.0;
        [timetable  setContentOffset:CGPointMake(0, (newwhen*30)-(timetable.contentInset.top)) animated:YES];
        //选中分
        newpoints = [[array objectAtIndex:4]integerValue]-0.0;
        [tiametable  setContentOffset:CGPointMake(0, (newpoints*30)-(tiametable.contentInset.top)) animated:YES];
    }else{
        thecurrenttime.text =[NSString stringWithFormat:@"%@年%@月%@日",[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2]];
        //选中年份的
        newyear =  [[array objectAtIndex:0]integerValue]-2000.0;
        [ytable  setContentOffset:CGPointMake(0, (newyear*30)-(ytable.contentInset.top)) animated:YES];
        //选中月份
        newmonth = [[array objectAtIndex:1]integerValue]-1.0;
        [mtable  setContentOffset:CGPointMake(0, (newmonth*30)-(mtable.contentInset.top)) animated:YES];
        //选中日
        newday = [[array objectAtIndex:2]integerValue]-1.0;
        [ttable  setContentOffset:CGPointMake(0, (newday*30)-(ttable.contentInset.top)) animated:YES];
    }
    yearint= newyear+2000;
    //月份
    monthint =newmonth+1;
    //日分
    dayint =newday+1;
    //小时
    hoursint=newwhen;
    //分
    pointsint =newpoints;
}
#pragma mark tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==years) { //年
        return [yeardic count];
    }else if (tableView.tag==month){ //月
        return [monthdic count];
    }else if(tableView.tag==day){ //日
        //当月份等于二月份的时候
        if(monthint==2){
            //闰年
            if (yearint%400==0){
                return 29;
                //闰年
            }else if(yearint%4==0){
                return 29;
                //平年
            }else{
                return 28;
            }
        }
        //是30天的
        if (monthint==4 || monthint==6 || monthint==9 || monthint==11) {
            return 30;
        }else{
            return 31;
        }
    }else if(tableView.tag==when){ //时
        return [whendic count];
    }else if(tableView.tag==points){//分
        return [pointsdic count];
    }else{
        return 10;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView = backView;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:11.0f];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    }
    if (tableView.tag==years) {//年
        cell.textLabel.text = [yeardic objectAtIndex:indexPath.row];
    }else if (tableView.tag==month){//月
        cell.textLabel.text = [monthdic objectAtIndex:indexPath.row];
    }else if (tableView.tag ==day){//日
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSTimeZone *defaultTimeZone = [NSTimeZone defaultTimeZone];
        NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"GMT"];
        [NSTimeZone setDefaultTimeZone:tzGMT];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [formatter setDateFormat : @"YYYY-MM-dd日"];
        NSString *strings = [NSString stringWithFormat:@"%d-%d-%@",yearint,monthint,[datydic objectAtIndex:indexPath.row]];
        NSDate *dateTime = [formatter dateFromString:strings];
        //正规化的格式设定
        [formatter setDateFormat:@"EEEE"];
        //正规化取得的系统时间并显示
        NSLog(@"%@",[formatter stringFromDate:dateTime]);
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",[datydic objectAtIndex:indexPath.row],[formatter stringFromDate:dateTime]];
    }else if (tableView.tag ==when){//时
        cell.textLabel.text = [whendic objectAtIndex:indexPath.row];
    }else if (tableView.tag ==points){//分
        cell.textLabel.text = [pointsdic objectAtIndex:indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setuitableView];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setuitableView];
}
-(void)setuitableView{
    //年
    if(ytable.tag == years){
        float f = ytable.contentOffset.y+ytable.contentInset.top;
        int i = f/30;
        [ytable  setContentOffset:CGPointMake(0, (i*30)-(ytable.contentInset.top)) animated:YES];
        if (i==0 || i==-1) {
            yearint=2000;
        }else{
            //拿到当前的年份
            yearint = i+2000;
        }
    }
    //月
    if (mtable.tag == month) {
        float f = mtable.contentOffset.y+mtable.contentInset.top;
        int i = f/30;
        [mtable  setContentOffset:CGPointMake(0, (i*30)-(mtable.contentInset.top)) animated:YES];
        if (i==0 || i==-1) {
            monthint=1;
        }else{
            //拿到当前的月份
            monthint = i+1;
        }
    }
    //日
    if (ttable.tag==day) {
        float f = ttable.contentOffset.y+ttable.contentInset.top;
        int i = f/30;
        [ttable  setContentOffset:CGPointMake(0, (i*30)-(ttable.contentInset.top)) animated:YES];
        if (i==0 || i==-1) {
            dayint =1;
        }else{
            //拿到当前的月份
            dayint = i+1;
        }
    }
    if (self.istime) {
        //时
        if (timetable.tag == when) {
            float f = timetable.contentOffset.y+timetable.contentInset.top;
            int i = f/30;
            [timetable  setContentOffset:CGPointMake(0, (i*30)-(timetable.contentInset.top)) animated:YES];
            if (i==0 || i==-1) {
                hoursint = 0;
            }else{
                hoursint = i;
            }
        }
        //分
        if (tiametable.tag == points) {
            float f = tiametable.contentOffset.y+tiametable.contentInset.top;
            int i = f/30;
            [tiametable  setContentOffset:CGPointMake(0, (i*30)-(tiametable.contentInset.top)) animated:YES];
            //拿到当前的分
            if (i==0 || i==-1) {
                pointsint =0;
            }else{
                pointsint = i;
            }
        }
    }
    if (self.istime) {
        thecurrenttime.text = [NSString stringWithFormat:@"%d年%d月%d日%d时%d分",yearint,monthint,dayint,hoursint,pointsint];
    }else{
        thecurrenttime.text = [NSString stringWithFormat:@"%d年%d月%d日",yearint,monthint,dayint];
    }
    [ttable reloadData];
}
#pragma mark 获取当前时间
-(void)currenttime{
    
    //消失的动画
    dataview.alpha = 1.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    dataview.alpha = 0.0;
    [UIView commitAnimations];
    
    //当前的时间转换成nsdate
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *defaultTimeZone = [NSTimeZone defaultTimeZone];
    NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"GMT"];
    [NSTimeZone setDefaultTimeZone:tzGMT];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDate *dateTime;
    NSString *strings;
    if (self.istime) {
        [formatter setDateFormat : @"yyyy/MM/d/ H:m"];
        strings = [NSString stringWithFormat:@"%d/%d/%d/ %d:%d",yearint,monthint,dayint,hoursint,pointsint];
        dateTime = [formatter dateFromString:strings];
    }else{
        [formatter setDateFormat : @"yyyy/MM/d"];
        strings = [NSString stringWithFormat:@"%d/%d/%d",yearint,monthint,dayint];
        dateTime = [formatter dateFromString:strings];
    }
    [self.Delegate getdeta:dateTime];
}
@end
