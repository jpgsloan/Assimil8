//
//  DragView.swift
//  Assimil8
//
//  Created by Alan O'Leary on 06/07/2019.
//  Copyright © 2019 Alan O'Leary. All rights reserved.
//

import Cocoa

import Foundation
import AppKit

public final class DragView: NSView {
    
    // highlight the drop zone when mouse drag enters the drop view
    fileprivate var highlight : Bool = false
    
    public weak var  delegate: DragViewDelegate?
    
    private var fileTypeIsOk = false
    public var acceptedFileExtensions = ["wav"]
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        
        if #available(OSX 10.13, *) {
            registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
        }else{
            registerForDraggedTypes([NSPasteboard.PasteboardType("NSFilenamesPboardType")])
        }

    }
    
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }

    public override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        

        // Drawing code here.
        NSColor.clear.set()
        __NSRectFillUsingOperation(dirtyRect, NSCompositingOperation.sourceOver)
        
        
        let bounds = self.bounds
        let size = min(bounds.size.width - 8.0, bounds.size.height - 8.0);
        let width =  max(2.0, size / 32.0)
        let frame = NSMakeRect((bounds.size.width-size)/2.0, (bounds.size.height-size)/2.0, size, size)
        
        NSBezierPath.defaultLineWidth = width
        
        // draw rounded corner square with dotted borders
        let squarePath = NSBezierPath(roundedRect: frame, xRadius: size/14.0, yRadius: size/14.0)
        let dash : [CGFloat] = [size / 10.0, size / 16.0]
        squarePath.setLineDash(dash, count: 2, phase: 2)
        squarePath.stroke()
        
    }
    
    //2
    public override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        //print("draggingEntered")
        highlight = true
        fileTypeIsOk = isExtensionAcceptable(draggingInfo: sender)
        return []
    }
    
    public override func draggingExited(_ sender: NSDraggingInfo?) {
        //print("draggingExited")
        highlight = false
        self.setNeedsDisplay(self.bounds)
    }
    
    //3
    public override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        return fileTypeIsOk ? .copy : []
    }
    
    public override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        // finished with dragging so remove any highlighting
        highlight = false
        self.setNeedsDisplay(self.bounds)
        
        return true
    }
    
    //4
    public override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        //print("performDragOperation")
        if sender.filePathURLs.count == 0 {
            return false
        }
        
        if(fileTypeIsOk) {
            if sender.filePathURLs.count == 1 {
                delegate?.dragView(self, droppedFileWithURL: sender.filePathURLs.first!)
            } else {
                delegate?.dragView(self, droppedFilesWithURLs: sender.filePathURLs)
            }
        } else {
            
        }
        
        return true
    }
    
    //5
    fileprivate func isExtensionAcceptable(draggingInfo: NSDraggingInfo) -> Bool {
        //print("isExtensionAcceptable")
        if draggingInfo.filePathURLs.count == 0 {
            return false
        }
        
        for filePathURL in draggingInfo.filePathURLs {
            let fileExtension = filePathURL.pathExtension.lowercased()
            
            if !acceptedFileExtensions.contains(fileExtension){
                return false
            }
        }
        
        return true
    }

}

public protocol DragViewDelegate: class {
    func dragView(_ dragDropView: DragView, droppedFileWithURL URL: URL)
    func dragView(_ dragDropView: DragView, droppedFilesWithURLs URLs: [URL])
}

extension DragViewDelegate {
    func dragView(_ dragDropView: DragView, droppedFileWithURL URL: URL) {
        
    }
    func dragView(_ dragDropView: DragView, droppedFilesWithURLs URLs: [URL]) {
    }
}

extension NSDraggingInfo {
    var filePathURLs: [URL] {
        var filenames : [String]?
        var urls: [URL] = []
        
        if #available(OSX 10.13, *) {
            filenames = draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType("NSFilenamesPboardType")) as? [String]
        } else {
            // Fallback on earlier versions
            filenames = draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType("NSFilenamesPboardType")) as? [String]
        }
        
        if let filenames = filenames {
            for filename in filenames {
                urls.append(URL(fileURLWithPath: filename))
            }
            return urls
        }
        
        return []
    }
}

