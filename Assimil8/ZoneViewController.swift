//
//  ZoneViewController.swift
//  Assimil8
//
//  Created by Alan O'Leary on 13/07/2019.
//  Copyright © 2019 Alan O'Leary. All rights reserved.
//

import Cocoa
import AVFoundation

class ZoneViewController: NSViewController {

    @IBOutlet weak var dropTarget1: DragView!
    @IBOutlet weak var dropTarget2: DragView!
    @IBOutlet weak var dropTarget3: DragView!
    @IBOutlet weak var dropTarget4: DragView!
    @IBOutlet weak var dropTarget5: DragView!
    @IBOutlet weak var dropTarget6: DragView!
    @IBOutlet weak var dropTarget7: DragView!
    @IBOutlet weak var dropTarget8: DragView!
    
    @IBOutlet weak var zone1From: NSTextField!
    @IBOutlet weak var zone1To: NSTextField!
    @IBOutlet weak var zone2From: NSTextField!
    @IBOutlet weak var zone2To: NSTextField!
    @IBOutlet weak var zone3From: NSTextField!
    @IBOutlet weak var zone3To: NSTextField!
    @IBOutlet weak var zone4From: NSTextField!
    @IBOutlet weak var zone4To: NSTextField!
    @IBOutlet weak var zone5From: NSTextField!
    @IBOutlet weak var zone5To: NSTextField!
    @IBOutlet weak var zone6From: NSTextField!
    @IBOutlet weak var zone6To: NSTextField!
    @IBOutlet weak var zone7From: NSTextField!
    @IBOutlet weak var zone7To: NSTextField!
    @IBOutlet weak var zone8From: NSTextField!
    @IBOutlet weak var zone8To: NSTextField!
    
    
    @IBOutlet weak var zone1Button: NSButton!
    @IBOutlet weak var zone2Button: NSButton!
    @IBOutlet weak var zone3Button: NSButton!
    @IBOutlet weak var zone4Button: NSButton!
    @IBOutlet weak var zone5Button: NSButton!
    @IBOutlet weak var zone6Button: NSButton!
    @IBOutlet weak var zone7Button: NSButton!
    @IBOutlet weak var zone8Button: NSButton!
    
    @IBOutlet weak var deleteZone1Button: NSButton!
    @IBOutlet weak var deleteZone2Button: NSButton!
    @IBOutlet weak var deleteZone3Button: NSButton!
    @IBOutlet weak var deleteZone4Button: NSButton!
    @IBOutlet weak var deleteZone5Button: NSButton!
    @IBOutlet weak var deleteZone6Button: NSButton!
    @IBOutlet weak var deleteZone7Button: NSButton!
    @IBOutlet weak var deleteZone8Button: NSButton!
    
    @IBOutlet weak var selectZone1WavButton: NSButton!
    @IBOutlet weak var selectZone2WavButton: NSButton!
    @IBOutlet weak var selectZone3WavButton: NSButton!
    @IBOutlet weak var selectZone4WavButton: NSButton!
    @IBOutlet weak var selectZone5WavButton: NSButton!
    @IBOutlet weak var selectZone6WavButton: NSButton!
    @IBOutlet weak var selectZone7WavButton: NSButton!
    @IBOutlet weak var selectZone8WavButton: NSButton!
    
    
    
    
    @IBOutlet weak var fixCVRangeButton: NSButton!
    
    @IBOutlet weak var zoneCVNumber: NSPopUpButton!
    @IBOutlet weak var zoneCVGroup: NSPopUpButton!
    
    var zoneChannelProperties: ZoneChannelProperties!
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        dropTarget1.delegate = self
        dropTarget2.delegate = self
        dropTarget3.delegate = self
        dropTarget4.delegate = self
        dropTarget5.delegate = self
        dropTarget6.delegate = self
        dropTarget7.delegate = self
        dropTarget8.delegate = self
        
        zone1From.isEnabled = false
        zone2From.isEnabled = false
        zone3From.isEnabled = false
        zone4From.isEnabled = false
        zone5From.isEnabled = false
        zone6From.isEnabled = false
        zone7From.isEnabled = false
        zone8From.isEnabled = false
        
        zone1To.isEnabled = false
        zone2To.isEnabled = false
        zone3To.isEnabled = false
        zone4To.isEnabled = false
        zone5To.isEnabled = false
        zone6To.isEnabled = false
        zone7To.isEnabled = false
        zone8To.isEnabled = false
        
        zone1Button.isEnabled = false
        zone2Button.isEnabled = false
        zone3Button.isEnabled = false
        zone4Button.isEnabled = false
        zone5Button.isEnabled = false
        zone6Button.isEnabled = false
        zone7Button.isEnabled = false
        zone8Button.isEnabled = false
        
        deleteZone1Button.isEnabled = false
        deleteZone2Button.isEnabled = false
        deleteZone3Button.isEnabled = false
        deleteZone4Button.isEnabled = false
        deleteZone5Button.isEnabled = false
        deleteZone6Button.isEnabled = false
        deleteZone7Button.isEnabled = false
        deleteZone8Button.isEnabled = false
        
        zone1Button.isEnabled = false
        zone2Button.isEnabled = false
        zone3Button.isEnabled = false
        zone4Button.isEnabled = false
        zone5Button.isEnabled = false
        zone6Button.isEnabled = false
        zone7Button.isEnabled = false
        zone8Button.isEnabled = false
        
    }
    
    public func setZoneChannelProperties(zoneChannelPropertiesIn: ZoneChannelProperties) {
        
        zoneChannelProperties = zoneChannelPropertiesIn
        
        var zoneCV = zoneChannelProperties.zonesCV
        if(zoneCV == nil){
            zoneCV = "1A"
        }
        
        let numChar = zoneCV?.remove(at: String.Index.init(encodedOffset: 0))
        let groupChar = zoneCV?.remove(at: String.Index.init(encodedOffset: 0))
        
    
        zoneCVNumber.selectItem(withTitle: String(numChar!))
        zoneCVGroup.selectItem(withTitle: String(groupChar!))
        
        if(zoneChannelProperties.zone1Properties != nil){
            loadZoneData(zoneProperties: zoneChannelProperties.zone1Properties!, channel: 1)
        }
        
        if(zoneChannelProperties.zone2Properties != nil){
            loadZoneData(zoneProperties: zoneChannelProperties.zone2Properties!, channel: 2)
        }
        
        if(zoneChannelProperties.zone3Properties != nil){
            loadZoneData(zoneProperties: zoneChannelProperties.zone3Properties!, channel: 3)
        }
        
        if(zoneChannelProperties.zone4Properties != nil){
            loadZoneData(zoneProperties: zoneChannelProperties.zone4Properties!, channel: 4)
        }
        
        if(zoneChannelProperties.zone5Properties != nil){
            loadZoneData(zoneProperties: zoneChannelProperties.zone5Properties!, channel: 5)
        }
        
        if(zoneChannelProperties.zone6Properties != nil){
            loadZoneData(zoneProperties: zoneChannelProperties.zone6Properties!, channel: 6)
        }
        
        if(zoneChannelProperties.zone7Properties != nil){
            loadZoneData(zoneProperties: zoneChannelProperties.zone7Properties!, channel: 7)
        }
        
        if(zoneChannelProperties.zone8Properties != nil){
            loadZoneData(zoneProperties: zoneChannelProperties.zone8Properties!, channel: 8)
        }
        
        
        
    }
    
    private func loadZoneData(zoneProperties: ZoneProperties, channel: Int) {

        setZoneFile(zoneNumber: channel, fileURL: zoneProperties.zoneFile!)
 
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    /**
        Range is +5.0 to -5.0 spread evenly
        |+5 |+4 |+3 |+2 |+1 |+0-|-1 |-2 |-3 |-4 |-5 |
        9 Buckets bookended by +/- 5
 
        1: z1: +5 -5
        2: z1: +5 0 z2: 0 -5
        3: z1: +5 0 z2: 0 -2.5 z3: -2.5 to -5
        z4: -3.75
    **/
    @IBAction func fixCVRange(_ sender: NSButton) {
        
        let channelCount = countChannelZones()
        var channelIncrement = 1  // Note: index from 1

        let maxFrom = Float(5.0)
        let minTo = Float(-5.0)
        
        let increment = Float( (Float(10.0) / Float(channelCount)) * -1)
        
        //let strides = Float(10/channelCount)
        
        var cvSteps = [Float]()
        
        for cv in stride(from:maxFrom, to:minTo, by:increment) {
            //print("Stride:" + String(cv) + "\n")
            cvSteps.append(cv)
        }
        
        if((zoneChannelProperties.zone1Properties) != nil){
            
            let zoneFromFloat = cvSteps[channelIncrement-1]
            
            zone1From.floatValue = zoneFromFloat
            
            // check if this is the last zone or if there is more
            if(channelIncrement==channelCount){
                // last one - sent the end range
                zone1To.floatValue = minTo
                zoneChannelProperties.zone1Properties?.zoneMinVoltage = minTo
            }else{
                // get the next range
                let zoneToFloat = cvSteps[channelIncrement]
                zone1To.floatValue = zoneToFloat
                zoneChannelProperties.zone1Properties?.zoneMinVoltage = zoneToFloat
            }
            
            channelIncrement+=1
        }
        
        if((zoneChannelProperties.zone2Properties) != nil){
            
            let zoneFromFloat = cvSteps[channelIncrement-1]
            
            zone2From.floatValue = zoneFromFloat
            
            // check if this is the last zone or if there is more
            if(channelIncrement==channelCount){
                // last one - sent the end range
                zone2To.floatValue = minTo
                zoneChannelProperties.zone2Properties?.zoneMinVoltage = minTo
            }else{
                // get the next range
                let zoneToFloat = cvSteps[channelIncrement]
                zone2To.floatValue = zoneToFloat
                zoneChannelProperties.zone2Properties?.zoneMinVoltage = zoneToFloat
            }
            
            channelIncrement+=1
        }
        
        if((zoneChannelProperties.zone3Properties) != nil){
            
            let zoneFromFloat = cvSteps[channelIncrement-1]
            
            zone3From.floatValue = zoneFromFloat
            
            // check if this is the last zone or if there is more
            if(channelIncrement==channelCount){
                // last one - sent the end range
                zone3To.floatValue = minTo
                zoneChannelProperties.zone3Properties?.zoneMinVoltage = minTo
            }else{
                // get the next range
                let zoneToFloat = cvSteps[channelIncrement]
                zone3To.floatValue = zoneToFloat
                zoneChannelProperties.zone3Properties?.zoneMinVoltage = zoneToFloat
            }
            
            channelIncrement+=1
        }
        
        if((zoneChannelProperties.zone4Properties) != nil){
            
            let zoneFromFloat = cvSteps[channelIncrement-1]
            
            zone4From.floatValue = zoneFromFloat
            
            // check if this is the last zone or if there is more
            if(channelIncrement==channelCount){
                // last one - sent the end range
                zone4To.floatValue = minTo
                zoneChannelProperties.zone4Properties?.zoneMinVoltage = minTo
            }else{
                // get the next range
                let zoneToFloat = cvSteps[channelIncrement]
                zone4To.floatValue = zoneToFloat
                zoneChannelProperties.zone4Properties?.zoneMinVoltage = zoneToFloat
            }
            
            channelIncrement+=1
        }
        
        
        if((zoneChannelProperties.zone5Properties) != nil){
            
            let zoneFromFloat = cvSteps[channelIncrement-1]
            
            zone5From.floatValue = zoneFromFloat
            
            // check if this is the last zone or if there is more
            if(channelIncrement==channelCount){
                // last one - sent the end range
                zone5To.floatValue = minTo
                zoneChannelProperties.zone5Properties?.zoneMinVoltage = minTo
            }else{
                // get the next range
                let zoneToFloat = cvSteps[channelIncrement]
                zone5To.floatValue = zoneToFloat
                zoneChannelProperties.zone5Properties?.zoneMinVoltage = zoneToFloat
            }
            
            channelIncrement+=1
        }
        
        if((zoneChannelProperties.zone6Properties) != nil){
            
            let zoneFromFloat = cvSteps[channelIncrement-1]
            
            zone6From.floatValue = zoneFromFloat
            
            // check if this is the last zone or if there is more
            if(channelIncrement==channelCount){
                // last one - sent the end range
                zone6To.floatValue = minTo
                zoneChannelProperties.zone6Properties?.zoneMinVoltage = minTo
            }else{
                // get the next range
                let zoneToFloat = cvSteps[channelIncrement]
                zone6To.floatValue = zoneToFloat
                zoneChannelProperties.zone6Properties?.zoneMinVoltage = zoneToFloat
            }
            
            channelIncrement+=1
        }
        
        
        if((zoneChannelProperties.zone7Properties) != nil){
            
            let zoneFromFloat = cvSteps[channelIncrement-1]
            
            zone7From.floatValue = zoneFromFloat
            
            // check if this is the last zone or if there is more
            if(channelIncrement==channelCount){
                // last one - sent the end range
                zone7To.floatValue = minTo
                zoneChannelProperties.zone7Properties?.zoneMinVoltage = minTo
            }else{
                // get the next range
                let zoneToFloat = cvSteps[channelIncrement]
                zone7To.floatValue = zoneToFloat
                zoneChannelProperties.zone7Properties?.zoneMinVoltage = zoneToFloat
            }
            
            channelIncrement+=1
        }
        
        if((zoneChannelProperties.zone8Properties) != nil){
            
            let zoneFromFloat = cvSteps[channelIncrement-1]
            
            zone8From.floatValue = zoneFromFloat
            
            // check if this is the last zone or if there is more
            if(channelIncrement==channelCount){
                // last one - sent the end range
                zone8To.floatValue = minTo
                zoneChannelProperties.zone8Properties?.zoneMinVoltage = minTo
            }else{
                // get the next range
                let zoneToFloat = cvSteps[channelIncrement]
                zone8To.floatValue = zoneToFloat
                zoneChannelProperties.zone8Properties?.zoneMinVoltage = zoneToFloat
            }
            
            channelIncrement+=1
        }
        
        
        
 
        
    }
    
    func countChannelZones() -> Int {
        
        var counter = 0
        
        if((zoneChannelProperties.zone1Properties) != nil){
            counter+=1
        }
        
        if((zoneChannelProperties.zone2Properties) != nil){
            counter+=1
        }
        
        if((zoneChannelProperties.zone3Properties) != nil){
            counter+=1
        }
        
        if((zoneChannelProperties.zone4Properties) != nil){
            counter+=1
        }
        
        if((zoneChannelProperties.zone5Properties) != nil){
            counter+=1
        }
        
        if((zoneChannelProperties.zone6Properties) != nil){
            counter+=1
        }
        
        if((zoneChannelProperties.zone7Properties) != nil){
           counter+=1
        }
        
        if((zoneChannelProperties.zone8Properties) != nil){
            counter+=1
        }
        
        return counter
    }
    
    
    @IBAction func dismissZoneWindow(_ sender: NSButton) {
        
        // save the data
        saveZoneData()
        
        let application = NSApplication.shared
        application.stopModal()
    }
    
    private func saveZoneData(){
        
        // selecting file will set the zone file properties but this
        // persists the voltage cv etc.
        let selectedNumberItem = zoneCVNumber.selectedItem
        let selectedGroupItem = zoneCVGroup
        var zonesCV = ""
        zonesCV.append(selectedNumberItem!.title)
        zonesCV.append(selectedGroupItem!.title)
        
        zoneChannelProperties.zonesCV = zonesCV
        
        
        if((zoneChannelProperties.zone1Properties) != nil){
            zoneChannelProperties.zone1Properties?.zoneMinVoltage = zone1To.floatValue
        }
     
        if((zoneChannelProperties.zone2Properties) != nil){
            zoneChannelProperties.zone2Properties?.zoneMinVoltage = zone2To.floatValue
        }
        
        if((zoneChannelProperties.zone3Properties) != nil){
            zoneChannelProperties.zone3Properties?.zoneMinVoltage = zone3To.floatValue
        }
        
        if((zoneChannelProperties.zone4Properties) != nil){
            zoneChannelProperties.zone4Properties?.zoneMinVoltage = zone4To.floatValue
        }
        
        if((zoneChannelProperties.zone5Properties) != nil){
            zoneChannelProperties.zone5Properties?.zoneMinVoltage = zone5To.floatValue
        }
        
        if((zoneChannelProperties.zone6Properties) != nil){
            zoneChannelProperties.zone6Properties?.zoneMinVoltage = zone6To.floatValue
        }
        
        if((zoneChannelProperties.zone7Properties) != nil){
            zoneChannelProperties.zone7Properties?.zoneMinVoltage = zone7To.floatValue
        }
        
        if((zoneChannelProperties.zone8Properties) != nil){
            zoneChannelProperties.zone8Properties?.zoneMinVoltage = zone8To.floatValue
        }
    
    }
    
    // ----------------------------------------------------
    //
    // ----------------------------------------------------
    
    @IBAction func zone1ToFieldUpdated(_ sender: NSTextField) {
        zone2From.floatValue = zone1To.floatValue
    }
    
    @IBAction func zone2ToFieldUpdated(_ sender: NSTextField) {
        zone3From.floatValue = zone2To.floatValue
    }
    
    @IBAction func zone3ToFieldUpdated(_ sender: NSTextField) {
        zone4From.floatValue = zone3To.floatValue
    }
    
    @IBAction func zone4ToFieldUpdated(_ sender: NSTextField) {
        zone5From.floatValue = zone5To.floatValue
    }
    
    @IBAction func zone5ToFieldUpdated(_ sender: NSTextField) {
         zone6From.floatValue = zone5To.floatValue
    }
    
    @IBAction func zone6ToFieldUpdated(_ sender: NSTextField) {
         zone7From.floatValue = zone6To.floatValue
    }
    
    @IBAction func zone7ToFieldUpdated(_ sender: NSTextField) {
    }
    
    // ----------------------------------------------------
    //
    // ----------------------------------------------------
  
    @IBAction func zone2FromFieldUpdated(_ sender: NSTextField) {
    }
    
    @IBAction func zone3FromFieldUpdated(_ sender: NSTextField) {
    }
    
    @IBAction func zone4FromFieldUpdated(_ sender: NSTextField) {
    }
    
    @IBAction func zone5FromFieldUpdated(_ sender: NSTextField) {
    }
    
    @IBAction func zone6FromFieldUpdated(_ sender: NSTextField) {
    }
    
    @IBAction func zone7FromFieldUpdated(_ sender: NSTextField) {
    }
    
    @IBAction func zone8FromFieldUpdated(_ sender: NSTextField) {
    }
    
    // ----------------------------------------------------
    //
    // ----------------------------------------------------
    
    @IBAction func zone1ButtonAction(_ sender: NSButton) {
        playZoneNumber(zoneNumber: 1)
    }
    
    @IBAction func zone2ButtonAction(_ sender: NSButton) {
        playZoneNumber(zoneNumber: 2)
    }
    
    @IBAction func zone3ButtonAction(_ sender: NSButton) {
        playZoneNumber(zoneNumber: 3)
    }
    
    @IBAction func zone4ButtonAction(_ sender: NSButton) {
        playZoneNumber(zoneNumber: 4)
    }
    
    @IBAction func zone5ButtonAction(_ sender: NSButton) {
        playZoneNumber(zoneNumber: 5)
    }
    
    @IBAction func zone6ButtonAction(_ sender: NSButton) {
        playZoneNumber(zoneNumber: 6)
    }
    
    @IBAction func zone7ButtonAction(_ sender: NSButton) {
        playZoneNumber(zoneNumber: 7)
    }
    
    @IBAction func zone8ButtonAction(_ sender: NSButton) {
        playZoneNumber(zoneNumber: 8)
    }
    
    func playZoneNumber(zoneNumber: Int) {
        //print("Play Zone: ", zoneNumber)
        
        var fileURL: URL?
        
        switch(zoneNumber) {
        case 1: fileURL = zoneChannelProperties.zone1Properties?.zoneFile
        case 2: fileURL = zoneChannelProperties.zone2Properties?.zoneFile
        case 3: fileURL = zoneChannelProperties.zone3Properties?.zoneFile
        case 4: fileURL = zoneChannelProperties.zone4Properties?.zoneFile
        case 5: fileURL = zoneChannelProperties.zone5Properties?.zoneFile
        case 6: fileURL = zoneChannelProperties.zone6Properties?.zoneFile
        case 7: fileURL = zoneChannelProperties.zone7Properties?.zoneFile
        case 8: fileURL = zoneChannelProperties.zone8Properties?.zoneFile
        default: return
        }
        
        if(fileURL == nil){
            //print("FileURL is nil")
            return
        }
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: fileURL!)
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    // ----------------------------------------------------
    //
    // ----------------------------------------------------
    
    @IBAction func deleteZone1Button(_ sender: NSButton) {
        deleteZone(zoneNumber: 1)
    }
    
    @IBAction func deleteZone2Button(_ sender: NSButton) {
        deleteZone(zoneNumber: 2)
    }
    
    @IBAction func deleteZone3Button(_ sender: NSButton) {
        deleteZone(zoneNumber: 3)
    }
    
    @IBAction func deleteZone4Button(_ sender: NSButton) {
        deleteZone(zoneNumber: 4)
    }
    
    @IBAction func deleteZone5Button(_ sender: NSButton) {
        deleteZone(zoneNumber: 5)
    }
    
    @IBAction func deleteZone6Button(_ sender: NSButton) {
        deleteZone(zoneNumber: 6)
    }
    
    @IBAction func deleteZone7Button(_ sender: NSButton) {
        deleteZone(zoneNumber: 7)
    }
    
    @IBAction func deleteZone8Button(_ sender: NSButton) {
        deleteZone(zoneNumber: 8)
    }
    
    func deleteZone(zoneNumber: Int){
        // make sure this is ok then reset sample
        
        let alert = NSAlert()
        alert.messageText = "Delete Channel Sample, Are you sure?"
        //alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        let answer = alert.runModal()
        
        if answer == NSApplication.ModalResponse.alertFirstButtonReturn {
            switch(zoneNumber){
            case 1: do {
                zone1Button.isEnabled = false
                deleteZone1Button.isEnabled = false
                zone1From.isEnabled = false
                zone1To.isEnabled = false
                zone1Button.title = "<Select/Drop .wav File"
                }
            case 2: do {
                zone2Button.isEnabled = false
                deleteZone2Button.isEnabled = false
                zone2From.isEnabled = false
                zone2To.isEnabled = false
                zone2Button.title = "<Select/Drop .wav File"
               }
            case 3: do {
                zone3Button.isEnabled = false
                deleteZone3Button.isEnabled = false
                zone3From.isEnabled = false
                zone3To.isEnabled = false
                zone3Button.title = "<Select/Drop .wav File"
               }
            case 4: do {
                zone4Button.isEnabled = false
                deleteZone4Button.isEnabled = false
                zone4From.isEnabled = false
                zone4To.isEnabled = false
                zone4Button.title = "<Select/Drop .wav File"
                }
            case 5: do {
                zone5Button.isEnabled = false
                deleteZone5Button.isEnabled = false
                zone5From.isEnabled = false
                zone5To.isEnabled = false
                zone5Button.title = "<Select/Drop .wav File"
                }
            case 6: do {
                zone6Button.isEnabled = false
                deleteZone6Button.isEnabled = false
                zone6From.isEnabled = false
                zone6To.isEnabled = false
                zone6Button.title = "<Select/Drop .wav File"
                }
            case 7: do {
                zone7Button.isEnabled = false
                deleteZone7Button.isEnabled = false
                zone7From.isEnabled = false
                zone7To.isEnabled = false
                zone7Button.title = "<Select/Drop .wav File"
                }
            case 8: do {
                zone8Button.isEnabled = false
                deleteZone8Button.isEnabled = false
                zone8From.isEnabled = false
                zone8To.isEnabled = false
                zone8Button.title = "<Select/Drop .wav File"
                }
            default: do {
                }
            }
        }
        
    }
    
    // ----------------------------------------------------
    //
    // ----------------------------------------------------
    
    func enableCVRange(zoneNumber: Int) {
        // trick is to know which is previous slot
        switch(zoneNumber){
        case 1: do {
            if(zone1From.isEnabled==false){
                zone1From.isEnabled = true
                zone1To.isEnabled = true
                zone1From.floatValue = 5.00
                zone1To.floatValue = -5.00
            }
            }
        case 2: do {
            if(zone2From.isEnabled==false){
                zone2From.isEnabled = true
                zone2To.isEnabled = true
                zone2From.floatValue = 5.00
                zone2To.floatValue = -5.00
            }
            }
        case 3: do {
            if(zone3From.isEnabled==false){
                zone3From.isEnabled = true
                zone3To.isEnabled = true
                zone3From.floatValue = 5.00
                zone3To.floatValue = -5.00
            }
            }
        case 4: do {
            if(zone4From.isEnabled==false){
                zone4From.isEnabled = true
                zone4To.isEnabled = true
                zone4From.floatValue = 5.00
                zone4To.floatValue = -5.00
            }
            }
        case 5: do {
            if(zone5From.isEnabled==false){
                zone5From.isEnabled = true
                zone5To.isEnabled = true
                zone5From.floatValue = 5.00
                zone5To.floatValue = -5.00
            }
            }
        case 6: do {
            if(zone6From.isEnabled==false){
                zone6From.isEnabled = true
                zone6To.isEnabled = true
                zone6From.floatValue = 5.00
                zone6To.floatValue = -5.00
            }
            }
        case 7: do {
            if(zone7From.isEnabled==false){
                zone7From.isEnabled = true
                zone7To.isEnabled = true
                zone7From.floatValue = 5.00
                zone7To.floatValue = -5.00
            }
            }
        case 8: do {
            if(zone8From.isEnabled==false){
                zone8From.isEnabled = true
                zone8To.isEnabled = true
                zone8From.floatValue = 5.00
                zone8To.floatValue = -5.00
            }
            }
            
        default: do {}
        }
        
    }
    
    func disableCVRange(){
        
    }
    
    
    // ----------------------------------------------------
    //
    // ----------------------------------------------------
    
    @IBAction func selectZone1Button(_ sender: NSButton) {
        selectZoneFile(zoneNumber: 1)
    }
    
    @IBAction func selectZone2Button(_ sender: NSButton) {
        selectZoneFile(zoneNumber: 2)
    }
    
    @IBAction func selectZone3Button(_ sender: NSButton) {
        selectZoneFile(zoneNumber: 3)
    }
    
    @IBAction func selectZone4Button(_ sender: NSButton) {
        selectZoneFile(zoneNumber: 4)
    }
    
    @IBAction func selectZone5Button(_ sender: NSButton) {
        selectZoneFile(zoneNumber: 5)
    }
    
    @IBAction func selectZone6Button(_ sender: NSButton) {
        selectZoneFile(zoneNumber: 6)
    }
    
    @IBAction func selectZone7Button(_ sender: NSButton) {
        selectZoneFile(zoneNumber: 7)
    }
    
    @IBAction func selectZone8Button(_ sender: NSButton) {
        selectZoneFile(zoneNumber: 8)
    }
    
    private func selectZoneFile(zoneNumber: Int) {
        
        let dialog = NSOpenPanel();
        dialog.title                   = "Choose a .txt file";
        
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = false;
        dialog.canCreateDirectories    = false;
        dialog.allowsMultipleSelection = true;
        dialog.allowedFileTypes        = ["wav"];
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                print("Selected :" + result!.absoluteString)
                setZoneFile(zoneNumber: zoneNumber, fileURL: result!)
            }
        } else {
            // User clicked on "Cancel"
        }
    }
 
    // ----------------------------------------------------
    //
    // ----------------------------------------------------
    
    public func setZoneFile(zoneNumber: Int, fileURL: URL){
        let displayFileName = FileManager.default.displayName(atPath: fileURL.path)
        
        switch(zoneNumber) {
        case 1: do {
            
            zone1Button.isEnabled = true
            deleteZone1Button.isEnabled = true
            enableCVRange(zoneNumber: 1)
            zone1Button.alternateTitle = displayFileName
            zone1Button.title = displayFileName
            zone1Button.image = NSImage(named: "activity.png")
            zone1Button.imagePosition = NSControl.ImagePosition.imageLeading
            
            var zp = zoneChannelProperties.zone1Properties
            if (zp === nil) {
                zp = ZoneProperties()
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone1From.floatValue
                zoneChannelProperties.zone1Properties = zp
            }else {
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone1From.floatValue
            }
            }
        case 2: do {
            zone2Button.isEnabled = true
            deleteZone2Button.isEnabled = true
            enableCVRange(zoneNumber: 2)
            zone2Button.alternateTitle = displayFileName
            zone2Button.title = displayFileName
            zone2Button.image = NSImage(named: "activity.png")
            zone2Button.imagePosition = NSControl.ImagePosition.imageLeading
            
            var zp = zoneChannelProperties.zone2Properties
            if (zp === nil) {
                zp = ZoneProperties()
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone2From.floatValue
                zoneChannelProperties.zone2Properties = zp
            }else {
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone2From.floatValue
            }
            }
        case 3: do {
            zone3Button.isEnabled = true
            deleteZone3Button.isEnabled = true
            enableCVRange(zoneNumber: 3)
            zone3Button.alternateTitle = displayFileName
            zone3Button.title = displayFileName
            zone3Button.image = NSImage(named: "activity.png")
            zone3Button.imagePosition = NSControl.ImagePosition.imageLeading
            
            var zp = zoneChannelProperties.zone3Properties
            if (zp === nil) {
                zp = ZoneProperties()
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone3From.floatValue
                zoneChannelProperties.zone3Properties = zp
            }else {
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone3From.floatValue
            }
            }
        case 4: do {
            zone4Button.isEnabled = true
            deleteZone4Button.isEnabled = true
            enableCVRange(zoneNumber: 4)
            zone4Button.alternateTitle = displayFileName
            zone4Button.title = displayFileName
            zone4Button.image = NSImage(named: "activity.png")
            zone4Button.imagePosition = NSControl.ImagePosition.imageLeading
            
            var zp = zoneChannelProperties.zone4Properties
            if (zp === nil) {
                zp = ZoneProperties()
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone4From.floatValue
                zoneChannelProperties.zone4Properties = zp
            }else {
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone4From.floatValue
            }
            }
        case 5: do {
            zone5Button.isEnabled = true
            deleteZone5Button.isEnabled = true
            enableCVRange(zoneNumber: 5)
            zone5Button.alternateTitle = displayFileName
            zone5Button.title = displayFileName
            zone5Button.image = NSImage(named: "activity.png")
            zone5Button.imagePosition = NSControl.ImagePosition.imageLeading
            
            var zp = zoneChannelProperties.zone5Properties
            if (zp === nil) {
                zp = ZoneProperties()
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone5From.floatValue
                zoneChannelProperties.zone5Properties = zp
            }else {
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone5From.floatValue
            }
            }
        case 6: do {
            zone6Button.isEnabled = true
            deleteZone6Button.isEnabled = true
            enableCVRange(zoneNumber: 6)
            zone6Button.alternateTitle = displayFileName
            zone6Button.title = displayFileName
            zone6Button.image = NSImage(named: "activity.png")
            zone6Button.imagePosition = NSControl.ImagePosition.imageLeading
            
            var zp = zoneChannelProperties.zone6Properties
            if (zp === nil) {
                zp = ZoneProperties()
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone6From.floatValue
                zoneChannelProperties.zone6Properties = zp
            }else {
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone6From.floatValue
            }
            }
        case 7: do {
            zone7Button.isEnabled = true
            deleteZone7Button.isEnabled = true
            enableCVRange(zoneNumber: 7)
            zone7Button.alternateTitle = displayFileName
            zone7Button.title = displayFileName
            zone7Button.image = NSImage(named: "activity.png")
            zone7Button.imagePosition = NSControl.ImagePosition.imageLeading
            
            var zp = zoneChannelProperties.zone7Properties
            if (zp === nil) {
                zp = ZoneProperties()
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone7From.floatValue
                zoneChannelProperties.zone7Properties = zp
            }else {
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone7From.floatValue
            }
            }
        case 8: do {
            zone8Button.isEnabled = true
            deleteZone8Button.isEnabled = true
            enableCVRange(zoneNumber: 8)
            zone8Button.alternateTitle = displayFileName
            zone8Button.title = displayFileName
            zone8Button.image = NSImage(named: "activity.png")
            zone8Button.imagePosition = NSControl.ImagePosition.imageLeading
            
            var zp = zoneChannelProperties.zone8Properties
            if (zp === nil) {
                zp = ZoneProperties()
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone8From.floatValue
                zoneChannelProperties.zone8Properties = zp
            }else {
                zp!.zoneFile = fileURL
                zp!.zoneMinVoltage = zone8From.floatValue
            }
            }
        default:
            print("default")
        }
    }

}


extension ZoneViewController: DragViewDelegate {
    
    func dragView(_ dragDropView: DragView, droppedFileWithURL URL: URL) {
        
        switch(dragDropView){
        case dropTarget1: setZoneFile(zoneNumber: 1, fileURL: URL)
        case dropTarget2: setZoneFile(zoneNumber: 2, fileURL: URL)
        case dropTarget3: setZoneFile(zoneNumber: 3, fileURL: URL)
        case dropTarget4: setZoneFile(zoneNumber: 4, fileURL: URL)
        case dropTarget5: setZoneFile(zoneNumber: 5, fileURL: URL)
        case dropTarget6: setZoneFile(zoneNumber: 6, fileURL: URL)
        case dropTarget7: setZoneFile(zoneNumber: 7, fileURL: URL)
        case dropTarget8: setZoneFile(zoneNumber: 8, fileURL: URL)
        default: do {
            // do nothing
            }
        }
    }
    
    func dragView(_ dragDropView: DragView, droppedFilesWithURLs URLs: [URL]) {
        
        switch(dragDropView){
        case dropTarget1: do{
            setMultipleFilesFromZone(zoneNumber: 1, files: URLs)
            }
        case dropTarget2: do {
            setMultipleFilesFromZone(zoneNumber: 2, files: URLs)
            }
        case dropTarget3: do {
            setMultipleFilesFromZone(zoneNumber: 3, files: URLs)
            }
        case dropTarget4: do {
            setMultipleFilesFromZone(zoneNumber: 4, files: URLs)
            }
        case dropTarget5: do {
            setMultipleFilesFromZone(zoneNumber: 5, files: URLs)
            }
        case dropTarget6: do {
            setMultipleFilesFromZone(zoneNumber: 6, files: URLs)
            }
        case dropTarget7: do {
            setMultipleFilesFromZone(zoneNumber: 7, files: URLs)
            }
        case dropTarget8: do {
            setMultipleFilesFromZone(zoneNumber: 8, files: URLs)
            }
        default: do {
            // do nothing
            }
        }
        
    }
    
    func setMultipleFilesFromZone(zoneNumber: Int, files URLs: [URL]){
        
        var zone = zoneNumber
        
        for URL in URLs {
            setZoneFile(zoneNumber: zone, fileURL: URL)
            if(zone == 8){
                return
            }
            zone+=1
        }
    }
}
