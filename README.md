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
