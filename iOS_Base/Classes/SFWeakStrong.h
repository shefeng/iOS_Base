//
//  SFWeakStrong.h
//  Pods
//
//  Created by shefeng on 2023/5/15.
//

#ifndef SFWeakStrong_h
#define SFWeakStrong_h

#ifndef    weakify
#if __has_feature( objc_arc )

#define weakify( x ) \
    _Pragma( "clang diagnostic push" ) \
    _Pragma( "clang diagnostic ignored \"-Wshadow\"" ) \
    autoreleasepool {} __weak __typeof__( x ) __weak_ ## x ## __ = x; \
    _Pragma( "clang diagnostic pop" )

#else


#define weakify( x ) \
    _Pragma( "clang diagnostic push" ) \
    _Pragma( "clang diagnostic ignored \"-Wshadow\"" ) \
    autoreleasepool {} __block __typeof__( x ) __block_ ## x ## __ = x; \
    _Pragma( "clang diagnostic pop" )

#endif
#endif

#ifndef    strongify
#if __has_feature( objc_arc )

#define strongify( x ) \
    _Pragma( "clang diagnostic push" ) \
    _Pragma( "clang diagnostic ignored \"-Wshadow\"" ) \
    try {} @finally{} __typeof__( x ) x = __weak_ ## x ## __; \
    _Pragma( "clang diagnostic pop" )

#else

#define strongify( x ) \
    _Pragma( "clang diagnostic push" ) \
    _Pragma( "clang diagnostic ignored \"-Wshadow\"" ) \
    try {} @finally{} __typeof__( x ) x = __block_ ## x ## __; \
    _Pragma( "clang diagnostic pop" )

#endif
#endif

#endif /* SFWeakStrong_h */
