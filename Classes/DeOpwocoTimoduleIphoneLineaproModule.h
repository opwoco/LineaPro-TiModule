/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"
#import "DTDevices.h"

@interface DeOpwocoTimoduleIphoneLineaproModule : TiModule 
{
    DTDevices *dtdev;
}

-(void)barcodeData:(NSString *)barcode type:(int)type;
-(void)magneticCardData:(NSString *)track1 track2:(NSString *)track2 track3:(NSString *)track3;

@end
