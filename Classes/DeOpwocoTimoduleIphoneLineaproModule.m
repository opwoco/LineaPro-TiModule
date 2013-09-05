/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "DeOpwocoTimoduleIphoneLineaproModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation DeOpwocoTimoduleIphoneLineaproModule

int beep1[]={1530,250};

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"600467d1-7f89-472a-926d-0b580df6b3f7";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"de.opwoco.timodule.iphone.lineapro";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
    
    dtdev = [DTDevices sharedDevice];
	[dtdev addDelegate:self];
    [dtdev connect];
    
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
    
    [dtdev removeDelegate:self];
    [dtdev disconnect];
    
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[dtdev dealloc];
    
    [dtdev removeDelegate:self];
    [dtdev disconnect];
    
    [super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(void)connectionState:(int)state {
    NSString *status;
    
    switch (state) {
		case CONN_DISCONNECTED:
            status = @"DISCONNECTED";
            break;
            
		case CONN_CONNECTING:
            status = @"CONNECTING";
            break;
		case CONN_CONNECTED:
            status = @"CONNECTED";
            
            [dtdev barcodeSetScanMode:1 error:nil];
            [dtdev barcodeSetScanBeep:TRUE volume:100 beepData:beep1 length:sizeof(beep1) error:nil];
            
            [dtdev msEnable:nil];
            
			break;
	}
    
    [self fireEvent:@"connectionStateChange" withObject:@{@"status": status}];
}

-(void)barcodeData:(NSString *)barcode type:(int)type {
	NSLog(@"[LINEA] Linea barcodeData");

	[self fireEvent:@"barcodeData" withObject:@{@"barcode": barcode}];
}

-(void)magneticCardData:(NSString *)track1 track2:(NSString *)track2 track3:(NSString *)track3 {
    NSLog(@"[LINEA] Linea magneticCardData");
    NSString *tracks = [NSString stringWithFormat:@"%@%@%@", track1, track2, track3];
    [self fireEvent:@"magneticCardData" withObject:tracks withSource:tracks];
}

//public properties
-(int)connected
{
    return [dtdev connstate];
}

//public functions
-(void)disconnect:(id)args
{
    [dtdev disconnect];
}

-(void)connect:(id)args
{
    [dtdev connect];
}

-(void)setBeepFreq:(id)value
{
    int beepTone[] = {[TiUtils intValue:value], 250};
    
    [dtdev barcodeSetScanBeep:TRUE volume:100 beepData:beepTone length:sizeof(beepTone) error:nil];
}


@end
