//
//  datapickview.h
//  times
//
//  Created by Netcoc on 13-12-24.
//  Copyright (c) 2013年 Netcoc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatapickviewDelegate<NSObject>
//获取选中的时间
-(void)getdeta:(NSDate *)dataarray;
@end
@interface datapickview : UIView<UITableViewDataSource,UITableViewDelegate>{
    //时间控件
    UIView *dataview;
    //上面的线
    UIView *shxian;
    //下面面的线
    UIView *xxian;
    //年tableview
    UITableView *ytable;
    //月tableview
    UITableView *mtable;
    //日tableview
    UITableView *ttable;
    //小时
    UITableView *timetable;
    //分
    UITableView *tiametable;
    //上面影印
    UIView *shxianview;
    //下面影印
    UIView *xxianview;
    //年
    NSMutableArray *yeardic;
    //月
    NSMutableArray  *monthdic;
    //日
    NSMutableArray *datydic;
    //时
    NSMutableArray *whendic;
    //分
    NSMutableArray *pointsdic;
    //显示当前时间
    UILabel *thecurrenttime;
    //年份
    int yearint;
    //月份
    int monthint;
    //日分
    int dayint;
    //小时
    int hoursint;
    //分
    int pointsint;
    int newyear;
    int newmonth;
    int newday;
    int newwhen;
    int newpoints;
    //选中当前的时间
    NSMutableArray *selectarraytime;
    //确定
    UIButton *confirmbutton;
    //取消
    UIButton *cancelbutton;
}
//是否显示 时分秒
@property(nonatomic,assign)BOOL istime;
@property(nonatomic,assign)id <DatapickviewDelegate>Delegate;
//传入一个当前的时间
-(void)setdate:(NSDate *)date;
@end
