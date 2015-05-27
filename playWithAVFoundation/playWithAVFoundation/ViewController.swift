//
//  ViewController.swift
//  playWithAVFoundation
//
//  Created by Vidyadhar V. Thatte on 5/16/15.
//  Copyright (c) 2015 Vidyadhar V Thatte. All rights reserved.
//

import UIKit
import AVFoundation
import CoreGraphics


var SessionRunningAndDeviceAuthorizedContext = "SessionRunningAndDeviceAuthorizedContext"
var CapturingStillImageContext = "CapturingStillImageContext"
var RecordingContext = "RecordingContext"

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var sessionQueue: dispatch_queue_t?
    var session: AVCaptureSession?
    var videoDeviceInput: AVCaptureDeviceInput?
    var movieFileOutput: AVCaptureMovieFileOutput?
    var stillImageOutput: AVCaptureStillImageOutput?
    
    
    var deviceAuthorized: Bool  = false
    var backgroundRecordId: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    var sessionRunningAndDeviceAuthorized: Bool {
        get {
            return (self.session?.running != nil && self.deviceAuthorized )
        }
    }
    
    var runtimeErrorHandlingObserver: AnyObject?
    var lockInterfaceRotation = false
    
    @IBOutlet weak var previewVeiw: AVCamPreviewView!
    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var preferencesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var session: AVCaptureSession = AVCaptureSession()
        self.session = session
        
        self.previewView.session = session
        
        self.checkDeviceAuthorizationStatus()
        
        
        
        var sessionQueue: dispatch_queue_t = dispatch_queue_create("session queue",DISPATCH_QUEUE_SERIAL)
        
        self.sessionQueue = sessionQueue
        dispatch_async(sessionQueue, {
            self.backgroundRecordId = UIBackgroundTaskInvalid
            
            var videoDevice: AVCaptureDevice! = ViewController.deviceWithMediaType(AVMediaTypeVideo, preferringPosition: AVCaptureDevicePosition.Back)
            var error: NSError? = nil
            
            
            
            var videoDeviceInput: AVCaptureDeviceInput? =  AVCaptureDeviceInput(device: videoDevice, error: &error)
            
            if (error != nil) {
                println(error)
                
            }
            
            if session.canAddInput(videoDeviceInput){
                session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
                
                dispatch_async(dispatch_get_main_queue(), {
                    // Why are we dispatching this to the main queue?
                    // Because AVCaptureVideoPreviewLayer is the backing layer for AVCamPreviewView and UIView can only be manipulated on main thread.
                    // Note: As an exception to the above rule, it is not necessary to serialize video orientation changes on the AVCaptureVideoPreviewLayer’s connection with other session manipulation.
                    
                    var orientation: AVCaptureVideoOrientation =  AVCaptureVideoOrientation(rawValue: self.interfaceOrientation.rawValue)!
                    (self.previewView.layer as! AVCaptureVideoPreviewLayer).connection.videoOrientation = orientation
                    
                })
                
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        var movieFileOutput: AVCaptureMovieFileOutput = AVCaptureMovieFileOutput()
            if session.canAddOutput(movieFileOutput){
                session.addOutput(movieFileOutput)
                
                
                var connection: AVCaptureConnection? = movieFileOutput.connectionWithMediaType(AVMediaTypeVideo)
                let stab = connection?.supportsVideoStabilization
                if (stab != nil) {
                    connection!.enablesVideoStabilizationWhenAvailable = true
                }
                
                self.movieFileOutput = movieFileOutput
                
            }
}




/*
class ScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
var session = AVCaptureSession()
var previewLayer : AVCaptureVideoPreviewLayer!
var highlightView = UIView()

var session_id = "";

override func viewDidLoad()
{
super.viewDidLoad();
//SCAN RETICLE CUSTOMIZATION
self.highlightView.autoresizingMask =
UIViewAutoresizing.FlexibleTopMargin |
UIViewAutoresizing.FlexibleBottomMargin |
UIViewAutoresizing.FlexibleLeftMargin |
UIViewAutoresizing.FlexibleRightMargin

self.highlightView.layer.borderColor = UIColor.greenColor().CGColor
self.highlightView.layer.borderWidth = 3

self.view.addSubview(self.highlightView)


let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
var error : NSError? = nil
let input : AVCaptureDeviceInput? = AVCaptureDeviceInput.deviceInputWithDevice(device, error: &error) as? AVCaptureDeviceInput

if input != nil{
session.addInput(input)
}
else{
println(error)
}

let output = AVCaptureMetadataOutput()
output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
session.addOutput(output)
output.metadataObjectTypes = output.availableMetadataObjectTypes

previewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as! AVCaptureVideoPreviewLayer
previewLayer.frame = self.view.bounds
previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
self.view.layer.addSublayer(previewLayer)
}//viewDidLoad

func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {

var highlightViewRect = CGRectZero
var barCodeObject : AVMetadataObject!
var detectionString : String!

let barCodeTypes =
[
AVMetadataObjectTypeUPCECode,
AVMetadataObjectTypeCode39Code,
AVMetadataObjectTypeCode39Mod43Code,
AVMetadataObjectTypeEAN13Code,
AVMetadataObjectTypeEAN8Code,
AVMetadataObjectTypeCode93Code,
AVMetadataObjectTypeCode128Code,
AVMetadataObjectTypePDF417Code,
AVMetadataObjectTypeQRCode,
AVMetadataObjectTypeAztecCode
]

for metadata in metadataObjects
{
for barcodeType in barCodeTypes
{
if metadata.type == barcodeType {
barCodeObject = self.previewLayer.transformedMetadataObjectForMetadataObject(metadata as! AVMetadataMachineReadableCodeObject)
//highlightViewRect = barCodeObject.bounds
detectionString = (metadata as! AVMetadataMachineReadableCodeObject).stringValue
break
} //if

} //for barCodeTypes

}//for metadataObjects

println("detection string: \(detectionString )")
//session.stopRunning()
}//

override func viewDidAppear(animated: Bool)
{
super.viewDidAppear(true)
session.stopRunning()
session.startRunning()
} //viewDidAppear*/