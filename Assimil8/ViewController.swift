//
//  ViewController.swift
//  Assimil8
//
//  Created by Alan O'Leary on 06/07/2019.
//  Copyright © 2019 Alan O'Leary. All rights reserved.
//

import Cocoa
import AVFoundation
import Yams

class ViewController: NSViewController {
    
    
    @IBOutlet weak var projectNameField: NSTextField!
    
    @IBOutlet weak var projectNumberField: NSTextField!
    
    
    @IBOutlet weak var deleteButton1: NSButton!
    @IBOutlet weak var deleteButton2: NSButton!
    @IBOutlet weak var deleteButton3: NSButton!
    @IBOutlet weak var deleteButton4: NSButton!
    @IBOutlet weak var deleteButton5: NSButton!
    @IBOutlet weak var deleteButton6: NSButton!
    @IBOutlet weak var deleteButton7: NSButton!
    @IBOutlet weak var deleteButton8: NSButton!
    
    @IBOutlet weak var selectButton1: NSButtonCell!
    @IBOutlet weak var selectButton2: NSButton!
    @IBOutlet weak var selectButton3: NSButton!
    @IBOutlet weak var selectButton4: NSButton!
    @IBOutlet weak var selectButton5: NSButton!
    @IBOutlet weak var selectButton6: NSButton!
    @IBOutlet weak var selectButton7: NSButton!
    @IBOutlet weak var selectButton8: NSButton!
    
    @IBOutlet weak var imageView1: NSButtonCell!
    @IBOutlet weak var imageView2: NSButtonCell!
    @IBOutlet weak var imageView3: NSButtonCell!
    @IBOutlet weak var imageView4: NSButtonCell!
    @IBOutlet weak var imageView5: NSButtonCell!
    @IBOutlet weak var imageView6: NSButtonCell!
    @IBOutlet weak var imageView7: NSButtonCell!
    @IBOutlet weak var imageView8: NSButtonCell!
    
    @IBOutlet weak var dropTarget1: DragView!
    @IBOutlet weak var dropTarget2: DragView!
    @IBOutlet weak var dropTarget3: DragView!
    @IBOutlet weak var dropTarget4: DragView!
    @IBOutlet weak var dropTarget5: DragView!
    @IBOutlet weak var dropTarget6: DragView!
    @IBOutlet weak var dropTarget7: DragView!
    @IBOutlet weak var dropTarget8: DragView!
    
    @IBOutlet weak var zoneButton1: NSButton!
    @IBOutlet weak var zoneButton2: NSButton!
    @IBOutlet weak var zoneButton4: NSButton!
    @IBOutlet weak var zoneButton3: NSButton!
    @IBOutlet weak var zoneButton5: NSButton!
    @IBOutlet weak var zoneButton6: NSButton!
    @IBOutlet weak var zoneButton7: NSButton!
    @IBOutlet weak var zoneButton8: NSButton!
    
    
    @IBOutlet weak var channel1ConfigButton: NSButton!
    @IBOutlet weak var channel2ConfigButton: NSButton!
    @IBOutlet weak var channel3ConfigButton: NSButton!
    @IBOutlet weak var channel4ConfigButton: NSButton!
    @IBOutlet weak var channel5ConfigButton: NSButton!
    @IBOutlet weak var channel6ConfigButton: NSButton!
    @IBOutlet weak var channel7ConfigButton: NSButton!
    @IBOutlet weak var channel8ConfigButton: NSButton!
    
    
    @IBOutlet weak var openPresetButton: NSButton!
    
    var preset: Preset = Preset()
    var projectProperties: ProjectProperties!
    //var avPlayer:AVAudioPlayer = AVAudioPlayer();

    
    var audioPlayer = AVAudioPlayer()
    
    
    let zoneTitle = "[Zones]"
    let defaultTitle = "<Select/Drop .wav File>"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.wantsLayer = true
        //let image = NSImage(named:NSImage.Name(rawValue: "Assimil8orPanel"))
        //// print("image size \(image!.size.width):\(image!.size.height)")
        //self.view.layer!.contents = image

        
        //dropTarget1.acceptedFileExtensions = ["wav"]
        dropTarget1.delegate = self
        dropTarget2.delegate = self
        dropTarget3.delegate = self
        dropTarget4.delegate = self
        dropTarget5.delegate = self
        dropTarget6.delegate = self
        dropTarget7.delegate = self
        dropTarget8.delegate = self
        
        // Do any additional setup after loading the view.
        
        projectProperties = ProjectProperties()
        
        imageView1.isEnabled = false
        imageView2.isEnabled = false
        imageView3.isEnabled = false
        imageView4.isEnabled = false
        imageView5.isEnabled = false
        imageView6.isEnabled = false
        imageView7.isEnabled = false
        imageView8.isEnabled = false
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func openPreset(_ sender: NSButton) {
        
        // Select open preset and validate
        // That all .wavs are still in
        // the project folder
        // Note: EXTRA settings will be lost
        
        // Might want to YAML Parse here
        // to preserve settings
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a .txt file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = false;
        dialog.canCreateDirectories    = false;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["yml"];
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            
            if let path = result?.path {
                let success = preset.parseFromFile(filePath: path)
                print (success)
                if (!success) {
                    let alert = NSAlert()
                    alert.alertStyle = .informational
                    alert.messageText = "Failed to parse YAML preset file."
                    alert.runModal()
                }
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    @IBAction func closeApplication(_ sender: NSButton) {
        // Show Down Application
        
        let alert = NSAlert()
        alert.messageText = "Close Assimil8, Are you sure?"
        //alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        let answer = alert.runModal()
        
        if answer == NSApplication.ModalResponse.alertFirstButtonReturn {
            exit(0)
        }
    }
    
    func openChannelConfigEditor(channelNumber: Int) {
        
        var ccp = projectProperties.channelConfigPropertyMap[channelNumber]
        if(ccp === nil) {
            ccp = ChannelConfigProperties()
            projectProperties.channelConfigPropertyMap.updateValue(ccp!, forKey: channelNumber)
        }
        
        // Now have valid ccp
        
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        
        let channelConfigController = storyboard.instantiateController(withIdentifier: "Channel Config Controller") as! NSWindowController
        
        let channelConfigWindow = channelConfigController.window
        
        
        let channelConfigViewController = channelConfigWindow!.contentViewController as! ChannelConfigViewController
        
        channelConfigViewController.setChannelConfigProperties(channelNumberIn: channelNumber, channnelConfigPropertiesIn: ccp!)
        
        //zoneWindowViewController.setZoneChannelProperties(zoneChannelPropertiesIn: czp)
        
        //zoneWindowViewController.audioPlayer = audioPlayer
        
        let application = NSApplication.shared
        
        // Run the window MODAL !!
        
        application.runModal(for: channelConfigWindow!)
        channelConfigWindow!.close()
    
        
    }
    
    
    @IBAction func channel1ConfigButton(_ sender: NSButton) {
        openChannelConfigEditor(channelNumber: 1)
    }
    
    @IBAction func channel2ConfigButton(_ sender: NSButton) {
        openChannelConfigEditor(channelNumber: 2)
    }
    
    @IBAction func channel3ConfigButton(_ sender: NSButton) {
        openChannelConfigEditor(channelNumber: 3)
    }
    
    @IBAction func channel4ConfigButton(_ sender: NSButton) {
        openChannelConfigEditor(channelNumber: 4)
    }
    
    @IBAction func channel5ConfigButton(_ sender: NSButton) {
        openChannelConfigEditor(channelNumber: 5)
    }
    
    @IBAction func channel6ConfigButton(_ sender: NSButton) {
        openChannelConfigEditor(channelNumber: 6)
    }
    
    @IBAction func channel7ConfigButton(_ sender: NSButton) {
        openChannelConfigEditor(channelNumber: 7)
    }
    
    @IBAction func channel8ConfigButton(_ sender: NSButton) {
        openChannelConfigEditor(channelNumber: 8)
    }
    
    
    @IBAction func deleteChannel1(_ sender: NSButton) {
        if(confirmDelete() == true) {
            deleteChannel(channelNumber: 1, zoneMode: false)
        }
    }
   
    @IBAction func deleteChannel2(_ sender: NSButton) {
        if(confirmDelete() == true) {
            deleteChannel(channelNumber: 2, zoneMode: false)
        }
    }
    
    @IBAction func deleteChannel3(_ sender: NSButton) {
        if(confirmDelete() == true) {
            deleteChannel(channelNumber: 3, zoneMode: false)
        }
    }
    
    @IBAction func deleteChannel4(_ sender: NSButton) {
        if(confirmDelete() == true) {
            deleteChannel(channelNumber: 4, zoneMode: false)
        }
    }
    
    @IBAction func deleteChannel5(_ sender: NSButton) {
        if(confirmDelete() == true) {
            deleteChannel(channelNumber: 5, zoneMode: false)
        }
    }
    
    @IBAction func deleteChannel6(_ sender: NSButton) {
        if(confirmDelete() == true) {
            deleteChannel(channelNumber: 6, zoneMode: false)
        }
    }
    
    @IBAction func deleteChannel7(_ sender: NSButton) {
        if(confirmDelete() == true) {
            deleteChannel(channelNumber: 7, zoneMode: false)
        }
    }
    
    @IBAction func deleteChannel8(_ sender: NSButton) {
        if(confirmDelete() == true) {
            deleteChannel(channelNumber: 8, zoneMode: false)
        }
    }
    
    func confirmDelete() -> Bool {
        
        let alert = NSAlert()
        alert.messageText = "Delete Channel Settings, Are you sure?"
        //alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        let answer = alert.runModal()
        
        if answer == NSApplication.ModalResponse.alertFirstButtonReturn {
            return true
        }
        
        return false
    }
    
    
    func deleteChannel(channelNumber: Int, zoneMode: Bool) {
        // make sure this is ok then reset sample

        switch(channelNumber){
        case 1: do {
            imageView1.isEnabled = false
            projectProperties.channel1File = nil
            
            if(zoneMode == true){
                imageView1.title = zoneTitle
            }else{
                imageView1.title = defaultTitle
                projectProperties.channel1ZoneProperties = nil
            }
            }
        case 2: do {
            imageView2.isEnabled = false
            projectProperties.channel2File = nil
            
            if(zoneMode == true){
                imageView2.title = zoneTitle
            }else{
                imageView2.title = defaultTitle
                projectProperties.channel2ZoneProperties = nil
            }
            }
        case 3: do {
            imageView3.isEnabled = false
            projectProperties.channel3File = nil
            
            if(zoneMode == true){
                imageView3.title = zoneTitle
            }else{
                imageView3.title = defaultTitle
                projectProperties.channel3ZoneProperties = nil
            }
        }
        case 4: do {
            imageView4.isEnabled = false
            projectProperties.channel4File = nil
            
            if(zoneMode == true){
            imageView4.title = zoneTitle
            }else{
            imageView4.title = defaultTitle
            projectProperties.channel4ZoneProperties = nil
            }
        }
        case 5: do {
            imageView5.isEnabled = false
            projectProperties.channel5File = nil
            
            if(zoneMode == true){
                imageView5.title = zoneTitle
            }else{
                imageView5.title = defaultTitle
                projectProperties.channel5ZoneProperties = nil
            }
            }
        case 6: do {
            imageView6.isEnabled = false
            projectProperties.channel6File = nil
            
            if(zoneMode == true){
                imageView6.title = zoneTitle
            }else{
                imageView6.title = defaultTitle
                projectProperties.channel6ZoneProperties = nil
            }
            }
        case 7: do {
            imageView7.isEnabled = false
            projectProperties.channel7File = nil
            
            if(zoneMode == true){
                imageView7.title = zoneTitle
            }else{
                imageView7.title = defaultTitle
                projectProperties.channel7ZoneProperties = nil
            }
            }
        case 8: do {
            imageView8.isEnabled = false
            projectProperties.channel8File = nil
            
            if(zoneMode == true){
                imageView8.title = zoneTitle
            }else{
                imageView8.title = defaultTitle
                projectProperties.channel8ZoneProperties = nil
            }
            }
        default: do {
            }
        }
        
        
    }
    
    func channelSampleExist(channel: Int) -> Bool {
        
        switch(channel){
        case 1: return projectProperties.channel1File != nil
        case 2: return projectProperties.channel2File != nil
        case 3: return projectProperties.channel3File != nil
        case 4: return projectProperties.channel4File != nil
        case 5: return projectProperties.channel5File != nil
        case 6: return projectProperties.channel6File != nil
        case 7: return projectProperties.channel7File != nil
        case 8: return projectProperties.channel8File != nil
        default: return false
        }
        
    }
    
    
    func shouldEditZone() -> Bool {
        
        // check if there is already a sample
        
        let alert = NSAlert()
        alert.messageText = "Convert to Zones?"
        //alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        let answer = alert.runModal()
        
        if answer == NSApplication.ModalResponse.alertFirstButtonReturn {
            return true
        }
        
        return false
    }

    @IBAction func zoneEdit1(_ sender: NSButton) {
        
        if(channelSampleExist(channel: 1) == true){
            // channel sample exists - confirm if want to convert into Zones
            if(shouldEditZone() == false){
                return
            }
        }
    
        var czp = projectProperties.channel1ZoneProperties
        if(czp === nil) {
            czp = ZoneChannelProperties()
            projectProperties.channel1ZoneProperties = czp
            if(channelSampleExist(channel: 1) == true){
                var zp = czp?.zone1Properties
                if(zp === nil){
                    zp = ZoneProperties()
                    czp?.zone1Properties = zp
                }
                zp?.zoneFile = projectProperties.channel1File
                
            }
        }
        
        launchZoneEditor(channelNumber: 1, czp:&czp!)
        deleteChannel(channelNumber: 1, zoneMode: true)
        
    }
    
    @IBAction func zoneEdit2(_ sender: NSButton) {
        if(channelSampleExist(channel: 2) == true){
            // channel sample exists - confirm if want to convert into Zones
            if(shouldEditZone() == false){
                return
            }
        }
        
        var czp = projectProperties.channel2ZoneProperties
        if(czp === nil) {
            czp = ZoneChannelProperties()
            projectProperties.channel2ZoneProperties = czp
            if(channelSampleExist(channel: 2) == true){
                var zp = czp?.zone1Properties
                if(zp === nil){
                    zp = ZoneProperties()
                    czp?.zone1Properties = zp
                }
                zp?.zoneFile = projectProperties.channel2File

            }
        }
        
        launchZoneEditor(channelNumber: 2, czp:&czp!)
        deleteChannel(channelNumber: 2, zoneMode: true)
    }
    
    @IBAction func zoneEdit3(_ sender: NSButton) {
        if(channelSampleExist(channel: 3) == true){
            // channel sample exists - confirm if want to convert into Zones
            if(shouldEditZone() == false){
                return
            }
        }
        
        var czp = projectProperties.channel3ZoneProperties
        if(czp === nil) {
            czp = ZoneChannelProperties()
            projectProperties.channel3ZoneProperties = czp
            if(channelSampleExist(channel: 3) == true){
                var zp = czp?.zone1Properties
                if(zp === nil){
                    zp = ZoneProperties()
                    czp?.zone1Properties = zp
                }
                zp?.zoneFile = projectProperties.channel3File

            }
        }
        
        
        
        launchZoneEditor(channelNumber: 3, czp:&czp!)
        deleteChannel(channelNumber: 3, zoneMode: true)
    }
    
    @IBAction func zoneEdit4(_ sender: NSButton) {
        if(channelSampleExist(channel: 4) == true){
            // channel sample exists - confirm if want to convert into Zones
            if(shouldEditZone() == false){
                return
            }
        }
        
       
        
        var czp = projectProperties.channel4ZoneProperties
        if(czp === nil) {
            czp = ZoneChannelProperties()
            projectProperties.channel4ZoneProperties = czp
            if(channelSampleExist(channel: 4) == true){
                var zp = czp?.zone1Properties
                if(zp === nil){
                    zp = ZoneProperties()
                    czp?.zone1Properties = zp
                }
                zp?.zoneFile = projectProperties.channel4File


            }
        }
        
        launchZoneEditor(channelNumber: 4, czp:&czp!)
        deleteChannel(channelNumber: 4, zoneMode: true)
    }
    
    @IBAction func zoneEdit5(_ sender: NSButton) {
        if(channelSampleExist(channel: 5) == true){
            // channel sample exists - confirm if want to convert into Zones
            if(shouldEditZone() == false){
                return
            }
        }
        
        
        var czp = projectProperties.channel5ZoneProperties
        if(czp === nil) {
            czp = ZoneChannelProperties()
            projectProperties.channel5ZoneProperties = czp
            if(channelSampleExist(channel: 5) == true){
                var zp = czp?.zone1Properties
                if(zp === nil){
                    zp = ZoneProperties()
                    czp?.zone1Properties = zp
                }
                zp?.zoneFile = projectProperties.channel5File
                
            }
        }
        
        launchZoneEditor(channelNumber: 5, czp:&czp!)
        deleteChannel(channelNumber: 5, zoneMode: true)
    }
    
    @IBAction func zoneEdit6(_ sender: NSButton) {
        if(channelSampleExist(channel: 6) == true){
            // channel sample exists - confirm if want to convert into Zones
            if(shouldEditZone() == false){
                return
            }
        }
        
        
        
        var czp = projectProperties.channel6ZoneProperties
        if(czp === nil) {
            czp = ZoneChannelProperties()
            projectProperties.channel6ZoneProperties = czp
            if(channelSampleExist(channel: 6) == true){
                var zp = czp?.zone1Properties
                if(zp === nil){
                    zp = ZoneProperties()
                    czp?.zone1Properties = zp
                }
                zp?.zoneFile = projectProperties.channel6File
 
            }
        }
        
        launchZoneEditor(channelNumber: 6, czp:&czp!)
        deleteChannel(channelNumber: 6, zoneMode: true)
    }
    
    @IBAction func zoneEdit7(_ sender: Any) {
        if(channelSampleExist(channel: 7) == true){
            // channel sample exists - confirm if want to convert into Zones
            if(shouldEditZone() == false){
                return
            }
        }
        
        
        
        var czp = projectProperties.channel7ZoneProperties
        if(czp === nil) {
            czp = ZoneChannelProperties()
            projectProperties.channel7ZoneProperties = czp
            if(channelSampleExist(channel: 7) == true){
                var zp = czp?.zone1Properties
                if(zp === nil){
                    zp = ZoneProperties()
                    czp?.zone1Properties = zp
                }
                zp?.zoneFile = projectProperties.channel7File
            }
        }
        
        launchZoneEditor(channelNumber: 7, czp:&czp!)
        deleteChannel(channelNumber: 7, zoneMode: true)
    }
    
    @IBAction func zoneEdit8(_ sender: Any) {
        if(channelSampleExist(channel: 8) == true){
            // channel sample exists - confirm if want to convert into Zones
            if(shouldEditZone() == false){
                return
            }
        }
        
        var czp = projectProperties.channel8ZoneProperties
        if(czp === nil) {
            czp = ZoneChannelProperties()
            projectProperties.channel8ZoneProperties = czp
            if(channelSampleExist(channel: 8) == true){
                var zp = czp?.zone1Properties
                if(zp === nil){
                    zp = ZoneProperties()
                    czp?.zone1Properties = zp
                }
                zp?.zoneFile = projectProperties.channel8File
                
            }
        }
    
        
        launchZoneEditor(channelNumber: 8, czp:&czp!)
        deleteChannel(channelNumber: 8, zoneMode: true)
    }
    
    func launchZoneEditor(channelNumber: Int, czp: inout ZoneChannelProperties) {
        
        // 1
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        
        let zoneWindowController = storyboard.instantiateController(withIdentifier: "Zone Window Controller") as! NSWindowController
        
        let zoneWindow = zoneWindowController.window
        
        let zoneWindowViewController = zoneWindow!.contentViewController as! ZoneViewController
        
        zoneWindowViewController.setZoneChannelProperties(zoneChannelPropertiesIn: czp)
        
        zoneWindowViewController.audioPlayer = audioPlayer
        
        let application = NSApplication.shared
        
        // Run the window MODAL !!
        
        dropTarget1.delegate = nil
        dropTarget2.delegate = nil
        dropTarget3.delegate = nil
        dropTarget4.delegate = nil
        dropTarget5.delegate = nil
        dropTarget6.delegate = nil
        dropTarget7.delegate = nil
        dropTarget8.delegate = nil
        
        application.runModal(for: zoneWindow!)
        zoneWindow!.close()
        
        dropTarget1.delegate = self
        dropTarget2.delegate = self
        dropTarget3.delegate = self
        dropTarget4.delegate = self
        dropTarget5.delegate = self
        dropTarget6.delegate = self
        dropTarget7.delegate = self
        dropTarget8.delegate = self
    }
    
    
    @IBAction func playChannel(_ sender: NSButton) {
        playChannelNumber(channelNumber: 1)
    }
    
    @IBAction func playChannel2(_ sender: NSButton) {
        playChannelNumber(channelNumber: 2)
    }
    
    @IBAction func playChannel3(_ sender: NSButton) {
        playChannelNumber(channelNumber: 3)
    }
    
    @IBAction func playChannel4(_ sender: NSButton) {
        playChannelNumber(channelNumber: 4)
    }
    
    @IBAction func playChannel5(_ sender: NSButton) {
        playChannelNumber(channelNumber: 5)
    }
    
    @IBAction func playChannel6(_ sender: NSButton) {
        playChannelNumber(channelNumber: 6)
    }
    
    @IBAction func playChannel7(_ sender: NSButton) {
        playChannelNumber(channelNumber: 7)
    }
    
    @IBAction func playChannel8(_ sender: NSButton) {
        playChannelNumber(channelNumber: 8)
    }
    
    func playChannelNumber(channelNumber: Int) {
        print("Play Channel: ", channelNumber)
        
        var fileURL: URL?
        
        switch(channelNumber) {
            case 1: fileURL = projectProperties.channel1File
            case 2: fileURL = projectProperties.channel2File
            case 3: fileURL = projectProperties.channel3File
            case 4: fileURL = projectProperties.channel4File
            case 5: fileURL = projectProperties.channel5File
            case 6: fileURL = projectProperties.channel6File
            case 7: fileURL = projectProperties.channel7File
            case 8: fileURL = projectProperties.channel8File
            default: return
        }
        
        if(fileURL == nil){
            print("FileURL is nil")
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
    
    
    //////////////////////// EXPORT CODE
    
    @IBAction func exportButtonClick(_ sender: Any) {
        print("Export")
        
        let projectFolder = getProjectFolder()
        if (projectFolder == nil) {
            return
        }
        
        // CHECK IF PROJECT NUMBER ALREADY EXISTS
        let myInt = projectNumberField.integerValue
        let projectFileName = getProjectFileNameFromNumber(projectFolder: projectFolder!, projectInt: myInt)
        
        if(projectFileExists(projectFileURL: projectFileName)){
            
            let alert = NSAlert()
            alert.alertStyle = .warning
            alert.messageText = "Project Number Already Exists"
            alert.addButton(withTitle: "OK")
            alert.runModal()
            
            return;
        }
        
        // have a project number to use
        moveProjectFiles(projectFolderURL: projectFolder!)
        writeProject(projectFileNameURL: projectFileName, projectNumber: myInt)
    }
    
    func moveChannelZoneFiles(zcp: ZoneChannelProperties, projectFolderURL: URL) {
        
        let z1p = zcp.zone1Properties
        if(z1p != nil) {
            moveZoneFiles(zp: z1p!, projectFolderURL: projectFolderURL)
        }
        let z2p = zcp.zone2Properties
        if(z2p != nil) {
            moveZoneFiles(zp: z2p!, projectFolderURL: projectFolderURL)
        }
        let z3p = zcp.zone3Properties
        if(z3p != nil) {
            moveZoneFiles(zp: z3p!, projectFolderURL: projectFolderURL)
        }
        let z4p = zcp.zone4Properties
        if(z4p != nil) {
            moveZoneFiles(zp: z4p!, projectFolderURL: projectFolderURL)
        }
        let z5p = zcp.zone5Properties
        if(z5p != nil) {
            moveZoneFiles(zp: z5p!, projectFolderURL: projectFolderURL)
        }
        let z6p = zcp.zone6Properties
        if(z6p != nil) {
            moveZoneFiles(zp: z6p!, projectFolderURL: projectFolderURL)
        }
        let z7p = zcp.zone7Properties
        if(z7p != nil) {
            moveZoneFiles(zp: z7p!, projectFolderURL: projectFolderURL)
        }
        let z8p = zcp.zone8Properties
        if(z8p != nil) {
            moveZoneFiles(zp: z8p!, projectFolderURL: projectFolderURL)
        }
    }
    
    func moveZoneFiles(zp: ZoneProperties, projectFolderURL: URL) {
        do {
            let fileName = FileManager.default.displayName(atPath: (zp.zoneFile!.path))
            let destinationFileName = projectFolderURL.appendingPathComponent(fileName)
            try FileManager.default.copyItem(at: (zp.zoneFile!), to: destinationFileName)
        }
        catch (let error){
            print(error.localizedDescription)
        }
    }

    
    func moveProjectFiles(projectFolderURL: URL){
        
        do {
            if((projectProperties.channel1File) != nil){
                let fileName = FileManager.default.displayName(atPath: projectProperties.channel1File!.path)
                let destinationFileName = projectFolderURL.appendingPathComponent(fileName)
                print("Copy from:" +  projectProperties.channel1File!.absoluteString +  " to: " + destinationFileName.absoluteString)
                try FileManager.default.copyItem(at: projectProperties.channel1File!, to: destinationFileName)
            }
            
            let c1zp = projectProperties.channel1ZoneProperties
            if(c1zp != nil) {
                //writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c1zp!)
                moveChannelZoneFiles(zcp: c1zp!, projectFolderURL: projectFolderURL)
            }
            
            if((projectProperties.channel2File) != nil){
                let fileName = FileManager.default.displayName(atPath: projectProperties.channel2File!.path)
                let destinationFileName = projectFolderURL.appendingPathComponent(fileName)
                print("Copy from:" +  projectProperties.channel2File!.absoluteString +  " to: " + destinationFileName.absoluteString)
                try FileManager.default.copyItem(at: projectProperties.channel2File!, to: destinationFileName)
            }
            
            
            let c2zp = projectProperties.channel2ZoneProperties
            if(c2zp != nil) {
                //writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c1zp!)
                moveChannelZoneFiles(zcp: c2zp!, projectFolderURL: projectFolderURL)
            }
            
            
            if((projectProperties.channel3File) != nil){
                let fileName = FileManager.default.displayName(atPath: projectProperties.channel3File!.path)
                let destinationFileName = projectFolderURL.appendingPathComponent(fileName)
                print("Copy from:" +  projectProperties.channel3File!.absoluteString +  " to: " + destinationFileName.absoluteString)
                try FileManager.default.copyItem(at: projectProperties.channel3File!, to: destinationFileName)
            }
            
            let c3zp = projectProperties.channel3ZoneProperties
            if(c3zp != nil) {
                //writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c1zp!)
                moveChannelZoneFiles(zcp: c3zp!, projectFolderURL: projectFolderURL)
            }
            
            if((projectProperties.channel4File) != nil){
                let fileName = FileManager.default.displayName(atPath: projectProperties.channel4File!.path)
                let destinationFileName = projectFolderURL.appendingPathComponent(fileName)
                print("Copy from:" +  projectProperties.channel4File!.absoluteString +  " to: " + destinationFileName.absoluteString)
                try FileManager.default.copyItem(at: projectProperties.channel4File!, to: destinationFileName)
            }
            
            let c4zp = projectProperties.channel4ZoneProperties
            if(c4zp != nil) {
                //writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c1zp!)
                moveChannelZoneFiles(zcp: c4zp!, projectFolderURL: projectFolderURL)
            }
            
            if((projectProperties.channel5File) != nil){
                let fileName = FileManager.default.displayName(atPath: projectProperties.channel5File!.path)
                let destinationFileName = projectFolderURL.appendingPathComponent(fileName)
                print("Copy from:" +  projectProperties.channel5File!.absoluteString +  " to: " + destinationFileName.absoluteString)
                try FileManager.default.copyItem(at: projectProperties.channel5File!, to: destinationFileName)
            }
            
            let c5zp = projectProperties.channel5ZoneProperties
            if(c5zp != nil) {
                //writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c1zp!)
                moveChannelZoneFiles(zcp: c5zp!, projectFolderURL: projectFolderURL)
            }
            
            if((projectProperties.channel6File) != nil){
                let fileName = FileManager.default.displayName(atPath: projectProperties.channel6File!.path)
                let destinationFileName = projectFolderURL.appendingPathComponent(fileName)
                print("Copy from:" +  projectProperties.channel6File!.absoluteString +  " to: " + destinationFileName.absoluteString)
                try FileManager.default.copyItem(at: projectProperties.channel6File!, to: destinationFileName)
            }
            
            let c6zp = projectProperties.channel6ZoneProperties
            if(c6zp != nil) {
                //writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c1zp!)
                moveChannelZoneFiles(zcp: c6zp!, projectFolderURL: projectFolderURL)
            }
            
            if((projectProperties.channel7File) != nil){
                let fileName = FileManager.default.displayName(atPath: projectProperties.channel7File!.path)
                let destinationFileName = projectFolderURL.appendingPathComponent(fileName)
                print("Copy from:" +  projectProperties.channel7File!.absoluteString +  " to: " + destinationFileName.absoluteString)
                try FileManager.default.copyItem(at: projectProperties.channel7File!, to: destinationFileName)
            }
            
            let c7zp = projectProperties.channel7ZoneProperties
            if(c7zp != nil) {
                //writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c1zp!)
                moveChannelZoneFiles(zcp: c7zp!, projectFolderURL: projectFolderURL)
            }
            
            if((projectProperties.channel8File) != nil){
                let fileName = FileManager.default.displayName(atPath: projectProperties.channel8File!.path)
                let destinationFileName = projectFolderURL.appendingPathComponent(fileName)
                print("Copy from:" +  projectProperties.channel8File!.absoluteString +  " to: " + destinationFileName.absoluteString)
                try FileManager.default.copyItem(at: projectProperties.channel8File!, to: destinationFileName)
            }
            
            let c8zp = projectProperties.channel8ZoneProperties
            if(c8zp != nil) {
                //writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c1zp!)
                moveChannelZoneFiles(zcp: c8zp!, projectFolderURL: projectFolderURL)
            }
        }
        catch (let error){
            print(error.localizedDescription)
        }
    
    }
    
    func writeChannelElement(projectFileStr: inout String, channelFile: URL, channelNumber: Int){
        
        projectFileStr.append("\n")
        projectFileStr.append("  ")
        projectFileStr.append("Channel ")
        projectFileStr.append(String(channelNumber))
        projectFileStr.append(" :")
        projectFileStr.append("\n")
        projectFileStr.append("    ")
        projectFileStr.append("PlayMode : 1")
        projectFileStr.append("\n")
        projectFileStr.append("    ")
        projectFileStr.append("PitchCV : 0A 0.50")
        projectFileStr.append("\n")
        projectFileStr.append("    ")
        projectFileStr.append("Zone 1 :")
        projectFileStr.append("\n")
        projectFileStr.append("      ")
        projectFileStr.append("Sample : ")
        projectFileStr.append(FileManager.default.displayName(atPath: channelFile.path))
        //projectFileStr.append("\n")
        
    }
    
    func writeChannelZonesElement(projectFileStr: inout String, zcp: ZoneChannelProperties, channelNumber: Int) {
        
        projectFileStr.append("\n")
        projectFileStr.append("  ")
        projectFileStr.append("Channel ")
        projectFileStr.append(String(channelNumber))
        projectFileStr.append(" : ")
        projectFileStr.append("\n")
        projectFileStr.append("    ")
        projectFileStr.append("ZonesCV : ")
        projectFileStr.append(zcp.zonesCV!)
        
        let z1p = zcp.zone1Properties
        if(z1p != nil) {
            writeZoneElement(projectFileStr:&projectFileStr, zp:z1p!, zoneCount: 1)
        }
        
        let z2p = zcp.zone2Properties
        if(z2p != nil) {
            writeZoneElement(projectFileStr:&projectFileStr, zp:z2p!, zoneCount: 2)
        }
        
        let z3p = zcp.zone3Properties
        if(z3p != nil) {
            writeZoneElement(projectFileStr:&projectFileStr, zp:z3p!, zoneCount: 3)
        }
        
        let z4p = zcp.zone4Properties
        if(z4p != nil) {
            writeZoneElement(projectFileStr:&projectFileStr, zp:z4p!, zoneCount: 4)
        }
        
        let z5p = zcp.zone5Properties
        if(z5p != nil) {
            writeZoneElement(projectFileStr:&projectFileStr, zp:z5p!, zoneCount: 5)
        }
        
        let z6p = zcp.zone6Properties
        if(z6p != nil) {
            writeZoneElement(projectFileStr:&projectFileStr, zp:z6p!, zoneCount: 6)
        }
        
        let z7p = zcp.zone7Properties
        if(z7p != nil) {
            writeZoneElement(projectFileStr:&projectFileStr, zp:z7p!, zoneCount: 7)
        }
        
        let z8p = zcp.zone8Properties
        if(z8p != nil) {
            writeZoneElement(projectFileStr:&projectFileStr, zp:z8p!, zoneCount: 8)
        }
    }
    
    func writeZoneElement(projectFileStr: inout String, zp: ZoneProperties, zoneCount: Int) {
        
        projectFileStr.append("\n")
        projectFileStr.append("    ")
        projectFileStr.append("Zone ")
        projectFileStr.append(String(zoneCount))
        projectFileStr.append(" :")
        projectFileStr.append("\n")
        projectFileStr.append("      ")
        projectFileStr.append("Sample : ")
        projectFileStr.append(FileManager.default.displayName(atPath: (zp.zoneFile!.path)))
        projectFileStr.append("\n")
        projectFileStr.append("      ")
        projectFileStr.append("MinVoltage : ")
        projectFileStr.append(String.localizedStringWithFormat("%.2f", zp.zoneMinVoltage!))
        //projectFileStr.append((zp.zoneMinVoltage!.description))
        
    }
    
    
    func writeProject(projectFileNameURL: URL, projectNumber: Int){
        
        var projectFileStr = "Preset "
        projectFileStr.append(String(projectNumber))
        projectFileStr.append(" :")
        projectFileStr.append("\n")
        projectFileStr.append("  ")
        projectFileStr.append("Name : ")
        projectFileStr.append(projectNameField.stringValue)
        if let presetStr = preset.yamlString()
        {
            projectFileStr.append(presetStr);
        }
        
        // projectFileStr.append("\n");
        // Now loop through each channel
        
//        let c1zp = projectProperties.channel1ZoneProperties
//        if(c1zp != nil) {
//            writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c1zp!, channelNumber: 1)
//        } else if((projectProperties.channel1File) != nil){
//            writeChannelElement(projectFileStr: &projectFileStr, channelFile: projectProperties.channel1File!, channelNumber: 1)
//        }
//
//        let c2zp = projectProperties.channel2ZoneProperties
//        if(c2zp != nil) {
//            writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c2zp!, channelNumber: 2)
//        } else if((projectProperties.channel2File) != nil){
//            writeChannelElement(projectFileStr: &projectFileStr, channelFile: projectProperties.channel2File!, channelNumber: 2)
//        }
//
//        let c3zp = projectProperties.channel3ZoneProperties
//        if(c3zp != nil) {
//            writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c3zp!, channelNumber: 3)
//        } else if((projectProperties.channel3File) != nil){
//            writeChannelElement(projectFileStr: &projectFileStr, channelFile: projectProperties.channel3File!, channelNumber: 3)
//        }
//
//        let c4zp = projectProperties.channel4ZoneProperties
//        if(c4zp != nil) {
//            writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c4zp!, channelNumber: 4)
//        } else if((projectProperties.channel4File) != nil){
//            writeChannelElement(projectFileStr: &projectFileStr, channelFile: projectProperties.channel4File!, channelNumber: 4)
//        }
//
//        let c5zp = projectProperties.channel5ZoneProperties
//        if(c5zp != nil) {
//            writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c5zp!, channelNumber: 5)
//        } else if((projectProperties.channel5File) != nil){
//            writeChannelElement(projectFileStr: &projectFileStr, channelFile: projectProperties.channel5File!, channelNumber: 5)
//        }
//
//        let c6zp = projectProperties.channel6ZoneProperties
//        if(c6zp != nil) {
//            writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c6zp!, channelNumber: 6)
//        } else if((projectProperties.channel6File) != nil){
//            writeChannelElement(projectFileStr: &projectFileStr, channelFile: projectProperties.channel6File!, channelNumber: 6)
//        }
//
//        let c7zp = projectProperties.channel7ZoneProperties
//        if(c7zp != nil) {
//            writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c7zp!, channelNumber: 7)
//        } else if((projectProperties.channel7File) != nil){
//            writeChannelElement(projectFileStr: &projectFileStr, channelFile: projectProperties.channel7File!, channelNumber: 7)
//        }
//
//        let c8zp = projectProperties.channel8ZoneProperties
//        if(c8zp != nil) {
//            writeChannelZonesElement(projectFileStr:&projectFileStr, zcp:c8zp!, channelNumber: 8)
//        } else if((projectProperties.channel8File) != nil){
//            writeChannelElement(projectFileStr: &projectFileStr, channelFile: projectProperties.channel8File!, channelNumber: 8)
//        }
//
        // Now write the file to disk!
        do {
            try projectFileStr.write(to: projectFileNameURL, atomically: false, encoding: .utf8)
        }
        catch {
            print(error.localizedDescription)
        }

    }
    
    func getProjectFileNameFromNumber(projectFolder: URL, projectInt: Int) -> URL {
        var projectName = "prst"
        let str = NSString(format:"%03d", projectInt)
        projectName+=str as String
        projectName+=".yml"
        
        return projectFolder.appendingPathComponent(projectName)
    }
    
    func projectFileExists(projectFileURL: URL) -> Bool {
        return FileManager.default.fileExists(atPath: projectFileURL.path)
    }
    
    func getProjectFolder() -> URL? {
        // Now export the current settings
        let dialog = NSOpenPanel();
        dialog.title                   = "Select Project Folder";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseFiles          = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = true;
        dialog.allowsMultipleSelection = false;
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                print("Selected :" + result!.absoluteString)
                return result
            }
        }
        
        return nil
    }
    
    /////////////////////////////////// END EXPORT

    
    /////////////////////////////////// IMPORT FILES
    //@IBAction func browseFile(sender: AnyObject) {
    @IBAction func Click(_ sender: NSButton) {
        selectChannelFile(channelNumber: 1)
    }
    
    
    @IBAction func selectChannel2(_ sender: NSButton) {
        selectChannelFile(channelNumber: 2)
    }
    
    
    @IBAction func selectChannel3(_ sender: NSButton) {
        selectChannelFile(channelNumber: 3)
    }
    
    
    @IBAction func selectChannel4(_ sender: NSButton) {
        selectChannelFile(channelNumber: 4)
    }
    
    @IBAction func selectChannel5(_ sender: NSButton) {
        selectChannelFile(channelNumber: 5)
    }
    
    
    @IBAction func selectChannel6(_ sender: NSButton) {
        selectChannelFile(channelNumber: 6)
    }
    
    
    @IBAction func selectChannel7(_ sender: NSButton) {
        selectChannelFile(channelNumber: 7)
    }
    
    
    @IBAction func selectChannel8(_ sender: NSButton) {
        selectChannelFile(channelNumber: 8)
    }
    
    private func selectChannelFile(channelNumber: Int) {
        
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
                setFile(channelNumber: channelNumber, fileURL: result!)
            }
        } else {
            // User clicked on "Cancel"
        }
    }
    
    func confirmReplaceZoneMode() -> Bool {
        
        let alert = NSAlert()
        alert.messageText = "Replace Zones?"
        //alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        let answer = alert.runModal()
        
        if answer == NSApplication.ModalResponse.alertFirstButtonReturn {
            return false
        }
        
        return true
        
    }
    
    func setChannelProperties(imageView: NSButtonCell, displayFileName: String) {
        if(imageView.title == zoneTitle) {
            // Zones have been set already, confirm with user before overwriting.
            if (confirmReplaceZoneMode() == true){
                return;
            }
        }
        
        imageView.isEnabled = true
        imageView.alternateTitle = displayFileName
        imageView.title = displayFileName
        imageView.image = NSImage(named: "activity.png")
        imageView.imagePosition = NSControl.ImagePosition.imageLeading
    }
    
    public func setFile(channelNumber: Int, fileURL: URL){
        let displayFileName = FileManager.default.displayName(atPath: fileURL.path)
        
        switch(channelNumber) {
        case 1: do {
            setChannelProperties(imageView: imageView1, displayFileName: displayFileName)
            preset.contents.channel1?.zone1?.sample = fileURL.lastPathComponent
        }
        case 2: do {
            setChannelProperties(imageView: imageView2, displayFileName: displayFileName)
            preset.contents.channel2?.zone1?.sample = fileURL.lastPathComponent
        }
        case 3: do {
            setChannelProperties(imageView: imageView3, displayFileName: displayFileName)
            preset.contents.channel3?.zone1?.sample = fileURL.lastPathComponent
        }
        case 4: do {
            setChannelProperties(imageView: imageView4, displayFileName: displayFileName)
            preset.contents.channel4?.zone1?.sample = fileURL.lastPathComponent
        }
        case 5: do {
            setChannelProperties(imageView: imageView5, displayFileName: displayFileName)
            preset.contents.channel5?.zone1?.sample = fileURL.lastPathComponent
        }
        case 6: do {
            setChannelProperties(imageView: imageView6, displayFileName: displayFileName)
            preset.contents.channel6?.zone1?.sample = fileURL.lastPathComponent
        }
        case 7: do {
            setChannelProperties(imageView: imageView7, displayFileName: displayFileName)
            preset.contents.channel7?.zone1?.sample = fileURL.lastPathComponent
        }
        case 8: do {
            setChannelProperties(imageView: imageView8, displayFileName: displayFileName)
            preset.contents.channel8?.zone1?.sample = fileURL.lastPathComponent
        }
        default:
            do {}
        }
    }
}

extension ViewController: DragViewDelegate {
    
    func dragView(_ dragDropView: DragView, droppedFileWithURL URL: URL) {
        
        switch(dragDropView){
            case dropTarget1: setFile(channelNumber: 1, fileURL: URL)
            case dropTarget2: setFile(channelNumber: 2, fileURL: URL)
            case dropTarget3: setFile(channelNumber: 3, fileURL: URL)
            case dropTarget4: setFile(channelNumber: 4, fileURL: URL)
            case dropTarget5: setFile(channelNumber: 5, fileURL: URL)
            case dropTarget6: setFile(channelNumber: 6, fileURL: URL)
            case dropTarget7: setFile(channelNumber: 7, fileURL: URL)
            case dropTarget8: setFile(channelNumber: 8, fileURL: URL)
            default: do {
                // do nothing
            }
        }
    }
    
    func dragView(_ dragDropView: DragView, droppedFilesWithURLs URLs: [URL]) {
        
        switch(dragDropView){
            case dropTarget1: do{
                setMultipleFilesFromChannel(channelNumber: 1, files: URLs)
            }
            case dropTarget2: do {
                setMultipleFilesFromChannel(channelNumber: 2, files: URLs)
            }
            case dropTarget3: do {
                setMultipleFilesFromChannel(channelNumber: 3, files: URLs)
            }
            case dropTarget4: do {
                setMultipleFilesFromChannel(channelNumber: 4, files: URLs)
            }
            case dropTarget5: do {
                setMultipleFilesFromChannel(channelNumber: 5, files: URLs)
            }
            case dropTarget6: do {
                setMultipleFilesFromChannel(channelNumber: 6, files: URLs)
            }
            case dropTarget7: do {
                setMultipleFilesFromChannel(channelNumber: 7, files: URLs)
            }
            case dropTarget8: do {
                setMultipleFilesFromChannel(channelNumber: 8, files: URLs)
            }
            default: do {
                // do nothing
            }
        }
        
    }
    
    func setMultipleFilesFromChannel(channelNumber: Int, files URLs: [URL]){
        
        var channel = channelNumber
        
        for URL in URLs {
            setFile(channelNumber: channel, fileURL: URL)
            if(channel == 8){
                return
            }
            channel+=1
        }
    }
}


class ProjectProperties {
    
    var projectName: String?
    var projectFolder: URL?
    var projectFileName: URL?
    
    var channel1File: URL?
    var channel2File: URL?
    var channel3File: URL?
    var channel4File: URL?
    var channel5File: URL?
    var channel6File: URL?
    var channel7File: URL?
    var channel8File: URL?
    
    var channel1ZoneProperties: ZoneChannelProperties?
    var channel2ZoneProperties: ZoneChannelProperties?
    var channel3ZoneProperties: ZoneChannelProperties?
    var channel4ZoneProperties: ZoneChannelProperties?
    var channel5ZoneProperties: ZoneChannelProperties?
    var channel6ZoneProperties: ZoneChannelProperties?
    var channel7ZoneProperties: ZoneChannelProperties?
    var channel8ZoneProperties: ZoneChannelProperties?
    
    var channelConfigPropertyMap = [Int: ChannelConfigProperties]()
    //var channel1ConfigProperties: ChannelConfigProperties?
}

class ChannelConfigProperties {
    var loopMode: Bool?
    var XfadeGroup: String?
    var channelMode: String?    // ChannelMode
    var release: String?        // Release :  2.0000
    var pmSource: String?       // PMSource : 1
    var pmIndex: String?        // PMIndex : 0.32
    var pitchCV: String?        // PitchCV : 0A 0.50
}

class ZoneChannelProperties {
    var zonesCV: String?
    var zone1Properties: ZoneProperties?
    var zone2Properties: ZoneProperties?
    var zone3Properties: ZoneProperties?
    var zone4Properties: ZoneProperties?
    var zone5Properties: ZoneProperties?
    var zone6Properties: ZoneProperties?
    var zone7Properties: ZoneProperties?
    var zone8Properties: ZoneProperties?
}

class ZoneProperties {
    var zoneFile: URL?
    var zoneMinVoltage: Float?
}
