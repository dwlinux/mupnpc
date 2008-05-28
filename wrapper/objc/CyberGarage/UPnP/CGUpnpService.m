//
//  CGUpnpService.m
//  CyberLink for C
//
//  Created by Satoshi Konno on 08/05/12.
//  Copyright 2008 Satoshi Konno. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <cybergarage/upnp/cservice.h>
#import <CyberGarage/UPnP/CGUpnpService.h>
#import <CyberGarage/UPnP/CGUpnpAction.h>

@implementation CGUpnpService

@synthesize cObject;

- (id) initWithCObject:(CgUpnpService *)cobj
{
	if ((self = [super init]) == nil)
		return nil;
	cObject = cobj;
	return self;
}

- (id) init
{
	[self initWithCObject:NULL];
	return self;
}

- (void) finalize
{
	[super finalize];
}

- (NSString *)serviceId
{
	if (!cObject)
		return nil;
	return [[NSString alloc] initWithUTF8String:cg_upnp_service_getserviceid(cObject)];
}

- (NSString *)serviceType
{
	if (!cObject)
		return nil;
	return [[NSString alloc] initWithUTF8String:cg_upnp_service_getservicetype(cObject)];
}

- (NSArray *)actions
{
	if (!cObject)
		return [NSArray array];
	NSMutableArray *actionArray = [NSMutableArray array];
	CgUpnpAction *cAction;
	for (cAction = cg_upnp_service_getactions(cObject); cAction; cAction = cg_upnp_action_next(cAction)) {
		CGUpnpAction *action = [[CGUpnpAction alloc] initWithCObject:cAction];
		[actionArray addObject:action];
	}
	return actionArray;
}

- (NSArray *)stateVariables
{
	if (!cObject)
		return [NSArray array];
	NSMutableArray *statVarArray = [NSMutableArray array];
	CgUpnpStateVariable *cStatVar;
	for (cStatVar = cg_upnp_service_getstatevariables(cObject); cStatVar; cStatVar = cg_upnp_statevariable_next(cStatVar)) {
		CGUpnpStateVariable *statVar = [[CGUpnpStateVariable alloc] initWithCObject:cStatVar];
		[statVarArray addObject:statVar];
	}
	return statVarArray;
}

- (CGUpnpAction *)getActionByName:(NSString *)name
{
	if (!cObject)
		return nil;
	CgUpnpAction *cAction = cg_upnp_service_getactionbyname([name UTF8String]);
	if (!cAction)
		return nil;
	return [[CGUpnpAction alloc] initWithCObject:cAction];
}

- (CGUpnpStateVariable *)getStateVariableByName:(NSString *)name
{
	if (!cObject)
		return nil;
	CgUpnpStateVariable *cStatVar = cg_upnp_service_getstatevariablebyname([name UTF8String]);
	if (!cStatVar)
		return nil;
	return [[CGUpnpStateVariable alloc] initWithCObject:cStatVar];
}

@end