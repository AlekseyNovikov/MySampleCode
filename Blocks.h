//
//  Blocks.h
//  Innopolis
//
//  Created by Aleksey Novikov on 19/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#ifndef Innopolis_Blocks_h
#define Innopolis_Blocks_h

typedef void (^CompletionBlock)(BOOL success);
typedef void (^JsonCompletionBlock)(id json);
typedef void (^ErrorBlock)(NSError* error);
#endif
