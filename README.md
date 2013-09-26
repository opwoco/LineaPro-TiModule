Linea Pro Titanium Module
=========================

Used SDK: ver 1.77 *(27. Februar 2013)*


USAGE
-----
To enable your app to support the Linea Pro or Infinea Tab Devices, you have to extend your Info.plist.  

This can be done in the tiapp.xml

	<ios>
        <plist>
            <dict>
               <key>UISupportedExternalAccessoryProtocols</key>
                <array>
                    <string>com.datecs.linea.pro.msr</string>
                    <string>com.datecs.linea.pro.bar</string>
                </array>
            </dict>
        </plist>
    </ios>

This step is required, otherwise your app won't be able to get a successful connection to your device

Also be sure to add the module itself to your tiapp.xml.

After that you can access the module like any other:

	var Linea = require('de.opwoco.timodule.iphone.lineapro');
	
Methods
-------

### connect()
Connects to the device. This is just required to call if you used disconnect() before.  
The module connects automatically on launch.

### disconnect()
Disconnect the current scan device.

### getBatteryLevel()
Returns a string telling how much the battery of the connected device is currently charged in percent.

### setScanMode(*mode*)
Set the scan mode (default is MODE_SINGLE_SCAN)

The modes are defined via the following attributes of the module:

- MODE_SINGLE_SCAN
	- The scan will be terminated after successful barcode recognition (default)
- MODE_MULTI_SCAN
	- Scanning will continue unless either scan button is releasd, or stop scan function is called
- MODE_MOTION_DETECT
	- For as long as scan button is pressed or stop scan is not called the engine will operate in low power scan mode trying to detect objects entering the area, then will turn on the lights and try to read the barcode. Supported only on Code engine.
- MODE_SINGLE_SCAN_RELEASE
	- Pressing the button/start scan will enter aim mode, while a barcode scan will actually be performed upon button release/stop scan.
- MODE_MULTI_SCAN_NO_DUPLICATES
	- Same as multi scan mode, but allowing no duplicate barcodes to be scanned
	
**Example**

```
Linea.setScanMode(Linea.MODE_MULTI_SCAN);
```

Events
------
### connectionStateChange
- status - *string*
	- CONNECTED / CONNECTING / DISCONNECTED

### scannedBarcode
- barcode - *string*
- barcodeType - *string*

### magneticCardSwiped - *broken*
- track1 - *string*
- track2 - *string*
- track3 - *string*
