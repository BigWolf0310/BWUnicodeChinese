//
//  BWUnicodeExchangeChinese.m
//  UnicodeExchangeChinese
//
//  Created by syt on 2019/12/19.
//  Copyright © 2019 syt. All rights reserved.
//  参考代码：https://github.com/allencelee/LYLUnicode

#import "BWUnicodeExchangeChinese.h"
#import <objc/runtime.h>

static inline void BW_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
/**
 字符串转义
 */
@implementation NSString (BWUnicodeExchangeChinese)

- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@end

/**
 数组转义
 */
@implementation NSArray (BWUnicodeExchangeChinese)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        BW_swizzleSelector(class, @selector(description), @selector(BW_description));
        BW_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(BW_descriptionWithLocale:));
        BW_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(BW_descriptionWithLocale:indent:));
    });
}

- (NSString *)BW_description {
    return [[self BW_description] stringByReplaceUnicode];
}

- (NSString *)BW_descriptionWithLocale:(nullable id)locale {
    return [[self BW_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)BW_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self BW_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

/**
 字典转义
 */
@implementation NSDictionary (BWUnicodeExchangeChinese)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        BW_swizzleSelector(class, @selector(description), @selector(BW_description));
        BW_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(BW_descriptionWithLocale:));
        BW_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(BW_descriptionWithLocale:indent:));
    });
}

- (NSString *)BW_description {
    return [[self BW_description] stringByReplaceUnicode];
}

- (NSString *)BW_descriptionWithLocale:(nullable id)locale {
    return [[self BW_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)BW_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self BW_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

/**
 集合转义
 */
@implementation NSSet (BWUnicodeExchangeChinese)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        BW_swizzleSelector(class, @selector(description), @selector(BW_description));
        BW_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(BW_descriptionWithLocale:));
        BW_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(BW_descriptionWithLocale:indent:));
    });
}

- (NSString *)BW_description {
    return [[self BW_description] stringByReplaceUnicode];
}

- (NSString *)BW_descriptionWithLocale:(nullable id)locale {
    return [[self BW_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)BW_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self BW_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}




@end

