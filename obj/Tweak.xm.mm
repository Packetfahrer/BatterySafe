#line 1 "Tweak.xm"

#import <UIKit/UIKit.h>
#import <SpringBoard/SBBrightnessController.h>
     
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
     
#include <logos/logos.h>
#include <substrate.h>
@class SBBrightnessController; @class SBLowPowerAlertItem; 
static void (*_logos_meta_orig$_ungrouped$SBLowPowerAlertItem$setBatteryLevel$)(Class, SEL, unsigned int); static void _logos_meta_method$_ungrouped$SBLowPowerAlertItem$setBatteryLevel$(Class, SEL, unsigned int); 
static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$SBBrightnessController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBBrightnessController"); } return _klass; }
#line 31 "Tweak.xm"
    @implementation BatterySafe


    - (void)show {
    _av = [[UIAlertView alloc]
    initWithTitle:@"BatterySafe"
    message:@"You're almost out of battery, you want to lower the brightness?"
    delegate:self
    cancelButtonTitle:@"No"
    otherButtonTitles: @"Yes" , nil];
    [_av show];
    }
     

    - (void)alertView:(UIAlertView *)av clickedButtonAtIndex:(NSInteger)buttonIndex {
	    if (buttonIndex != av.cancelButtonIndex)
	    {
		[[_logos_static_class_lookup$SBBrightnessController() sharedBrightnessController] setBrightnessLevel:0.0];
		if ([[settings objectForKey:@"enabledbluetooth"] boolValue])
		{
		  [(BluetoothManager *)[objc_getClass("BluetoothManager") sharedInstance] setEnabled:NO];
                  [(BluetoothManager *)[objc_getClass("BluetoothManager") sharedInstance] setPowered:NO];
		}
		if ([[settings objectForKey:@"enabledwifi"] boolValue])
		{
   		  [[objc_getClass("SBWiFiManager") sharedInstance] setWiFiEnabled:NO];
		}
		if ([[settings objectForKey:@"enabledlocalisation"] boolValue])
		{
	   	  
		}
		if ([[settings objectForKey:@"enabled3glte"] boolValue])
		{
	   	  
		}
	    }
    }
     
    @end

    static unsigned int warnAt=20;
    int validatealert = 0;
     
    
    static void _logos_meta_method$_ungrouped$SBLowPowerAlertItem$setBatteryLevel$(Class self, SEL _cmd, unsigned int fp8){
    
    warnAt = [[settings objectForKey:@"POURCENTAGESET"]intValue];
    SBUIController *ACconnect=[objc_getClass("SBUIController") sharedInstance];
     
    
    if(validatealert==0&&fp8<=warnAt&&![ACconnect isOnAC]&&[[settings objectForKey:@"enabled"] boolValue]){
    BatterySafe *bsafe = [[BatterySafe alloc] init];
    [bsafe show];
    validatealert = 1;
    }
     
    
    if([ACconnect isOnAC]&&fp8>warnAt)
    {
    validatealert = 0;
    }
    }
    
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBLowPowerAlertItem = objc_getClass("SBLowPowerAlertItem"); Class _logos_metaclass$_ungrouped$SBLowPowerAlertItem = object_getClass(_logos_class$_ungrouped$SBLowPowerAlertItem); MSHookMessageEx(_logos_metaclass$_ungrouped$SBLowPowerAlertItem, @selector(setBatteryLevel:), (IMP)&_logos_meta_method$_ungrouped$SBLowPowerAlertItem$setBatteryLevel$, (IMP*)&_logos_meta_orig$_ungrouped$SBLowPowerAlertItem$setBatteryLevel$);} }
#line 94 "Tweak.xm"
