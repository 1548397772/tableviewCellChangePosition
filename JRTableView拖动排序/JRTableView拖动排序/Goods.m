//
//  Goods.m
//  购物车表格删除
//
//  Created by jerei on 15-1-7.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "Goods.h"

@implementation Goods

-(id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.icon = [dic objectForKey:@"icon"];
        self.name = [dic objectForKey:@"name"];
        self.details = [dic objectForKey:@"details"];
    }
    return self;
}

+(id)goodsWithDic:(NSDictionary *)dic
{
    Goods *good = [[Goods alloc] initWithDic:dic];
    return good;
}

@end
