//
//  Preset.swift
//  Assimil8
//
//

import Foundation
import Yams

public class Preset {
    public var contents: Contents = Contents()
    public var presetNumber: String = "Preset 1"
    
    init() {
    }
    
    public func yamlString() -> String? {
        let encoder = YAMLEncoder()
        do {
            let contentsString = try encoder.encode(contents)
            // wrap in final Preset key
            let presetString = presetNumber + " :\n"
            return presetString + contentsString
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public func parseFromFile(filePath: String) -> Bool {
        do {
            let yaml = try String(contentsOfFile: filePath)
            
            // First extract Preset number and strip from yaml
            let splitStringArray = yaml.split(separator: "\n", maxSplits: 1).map(String.init)
            if splitStringArray.count < 2 {
                return false
            }
            
            presetNumber = splitStringArray[0]
            
            let decoder = YAMLDecoder()
            contents = try decoder.decode(Contents.self, from: splitStringArray[1])
            print (contents.name)
            return true
        } catch {
            return false
        }
    }
    
    public struct Contents: Codable {
        var name: String = "Project Name"
        var channel1: Channel?
        var channel2: Channel?
        var channel3: Channel?
        var channel4: Channel?
        var channel5: Channel?
        var channel6: Channel?
        var channel7: Channel?
        var channel8: Channel?
        
        private enum CodingKeys : String, CodingKey {
            case name = "Name"
            case channel1 = "Channel 1"
            case channel2 = "Channel 2"
            case channel3 = "Channel 3"
            case channel4 = "Channel 4"
            case channel5 = "Channel 5"
            case channel6 = "Channel 6"
            case channel7 = "Channel 7"
            case channel8 = "Channel 8"
        }
    }
    
    public struct Channel: Codable {
        var playMode: String? // = "1"
        var pitchCV: String? // = "0A 0.50"
        var pitch: String?
        var loopMode: String?
        var zonesCV: String?
        var zonesRT: String?
        var linFM: String?
        var zone1: Zone?
        var zone2: Zone?
        var zone3: Zone?
        var zone4: Zone?
        var zone5: Zone?
        var zone6: Zone?
        var zone7: Zone?
        var zone8: Zone?
        
        private enum CodingKeys : String, CodingKey {
            case playMode = "PlayMode"
            case pitchCV = "PitchCV"
            case pitch = "Pitch"
            case loopMode = "LoopMode"
            case zonesCV = "ZonesCV"
            case zonesRT = "ZonesRT"
            case linFM = "LinFM"
            case zone1 = "Zone 1"
            case zone2 = "Zone 2"
            case zone3 = "Zone 3"
            case zone4 = "Zone 4"
            case zone5 = "Zone 5"
            case zone6 = "Zone 6"
            case zone7 = "Zone 7"
            case zone8 = "Zone 8"
        }
    }
    
    public struct Zone: Codable {
        var sample: String?
        var sampleEnd: String?
        var loopLength: String?
        
        private enum CodingKeys : String, CodingKey {
            case sample = "Sample"
            case sampleEnd = "SampleEnd"
            case loopLength = "LoopLength"
        }
    }
    
    //public createChannel()
}
