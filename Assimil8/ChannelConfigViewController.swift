//
//  ChannelConfigViewController.swift
//  Assimil8
//
//  Created by O'Leary, Alan on 02/08/2019.
//  Copyright © 2019 Alan O'Leary. All rights reserved.
//

import Cocoa

class ChannelConfigViewController: NSViewController {

    @IBOutlet weak var closeButton: NSButton!
    @IBOutlet weak var channelNumberTextField: NSTextField!
    
    
    
    var channnelConfigProperties: ChannelConfigProperties!
    var channelNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    func setChannelConfigProperties(channelNumberIn: Int, channnelConfigPropertiesIn: ChannelConfigProperties) {
        
        channelNumber = channelNumberIn
        channnelConfigProperties = channnelConfigPropertiesIn
        
        // Now populate the fields
        channelNumberTextField.integerValue = channelNumberIn
        
    }
    
    
    @IBAction func close(_ sender: NSButton) {
        
        let application = NSApplication.shared
        application.stopModal()
        
    }
    
    
}



/*
 
 var loopMode: Bool?
 var XfadeGroup: String?
 var channelMode: String?    // ChannelMode
 var release: String?        // Release :  2.0000
 var pmSource: String?       // PMSource : 1
 var pmIndex: String?        // PMIndex : 0.32
 var pitchCV: String?        // PitchCV : 0A 0.50
 
 
 */
