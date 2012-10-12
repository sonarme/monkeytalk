//
//  FMDElement.h
//  Demo
//
//  Created by Kyle Balogh on 1/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FMDElement : NSObject {
    NSString *atomicNumber;
    NSString *elementName;
    NSString *elementSymbol;
}

@property (nonatomic, retain) NSString *atomicNumber;
@property (nonatomic, retain) NSString *elementName;
@property (nonatomic, retain) NSString *elementSymbol;

@end
