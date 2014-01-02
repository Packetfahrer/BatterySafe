// BatterySafe By TheJailPad
#import <UIKit/UIKit.h>
#import <SpringBoard/SBBrightnessController.h>
#import <Preferences/PSCellularDataSettingsDetail.h>

    NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:
    [NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.thejailpad.batterysafepref.plist"]];

    @interface SBUIController : NSObject { }
    +(id)sharedInstance;
    -(BOOL)isOnAC;
    @end


    @interface BluetoothManager
    -(BOOL)setEnabled:(BOOL)enabled;
    -(BOOL)setPowered:(BOOL)powered;
    +(id)sharedInstance;
    @end

    @interface SBWiFiManager
    -(id)sharedInstance;
    -(void)setWiFiEnabled:(BOOL)enabled;
    @end
     
    @interface BatterySafe : NSObject <UIAlertViewDelegate> {
    @private
    UIAlertView *_av;
    }
    @end
     
    @implementation BatterySafe

    - (void)show
    {
    _av = [[UIAlertView alloc]
    initWithTitle:@"BatterySafe"
    message:@"You're almost out of battery, you want to lower the brightness?"
    delegate:self
    cancelButtonTitle:@"No"
    otherButtonTitles: @"Yes" , nil];
    [_av show];
    }
     
    - (void)alertView:(UIAlertView *)av clickedButtonAtIndex:(NSInteger)buttonIndex
    {
	    if (buttonIndex != av.cancelButtonIndex)
	    {
		[[%c(SBBrightnessController) sharedBrightnessController] setBrightnessLevel:0.0];
		if ([[settings objectForKey:@"enabledbluetooth"] boolValue])
		{
		  [(BluetoothManager *)[objc_getClass("BluetoothManager") sharedInstance] setEnabled:NO];
                  [(BluetoothManager *)[objc_getClass("BluetoothManager") sharedInstance] setPowered:NO];
		}
		if ([[settings objectForKey:@"enabledwifi"] boolValue])
		{
   		  [[objc_getClass("SBWiFiManager") sharedInstance] setWiFiEnabled:NO];
		}
		if ([[settings objectForKey:@"enabledcellulardata"] boolValue])
		{
	   	  [(PSCellularDataSettingsDetail *)[objc_getClass("PSCellularDataSettingsDetail") sharedInstance] setEnabled:NO];
		}
	    }
    }
     
    @end

    static unsigned int warnAt=20;
    int validatealert = 0;
     
    %hook SBLowPowerAlertItem
    +(void)setBatteryLevel:(unsigned int)fp8{
    //Ont créer la variable de SBUIController pour voir si une prise est connecter
    warnAt = [[settings objectForKey:@"POURCENTAGESET"]intValue];
    SBUIController *ACconnect=[objc_getClass("SBUIController") sharedInstance];
     
    // Ont vérifie si validatealert est à zero si ont est pas trop bas et si ont est pas connecter
    if(validatealert==0&&fp8<=warnAt&&![ACconnect isOnAC]&&[[settings objectForKey:@"enabled"] boolValue]){
    BatterySafe *bsafe = [[BatterySafe alloc] init];
    [bsafe show];
    validatealert = 1;
    }
     
    // ont regarde si l'idevice est connecter a la prise éléctrique et que le niveau de batterie est supérieu au niveau d'alert
    if([ACconnect isOnAC]&&fp8>warnAt)
    {
    validatealert = 0;
    }
    }
    %end
