//
//  CameraView.swift
//  playWithAVFoundation
//
//  Created by Vidyadhar V. Thatte on 5/20/15.
//  Copyright (c) 2015 Vidyadhar V Thatte. All rights reserved.
//

import UIKit
import AVFoundation

class CameraView: UIView, AVCaptureMetadataOutputObjectsDelegate {
    var session = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer!
    var highlightView = UIView()
    
    func viewDidLoad()
    {
        //super.viewDidLoad();
        
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
        //previewLayer.frame = self.view.bounds
        previewLayer.frame = self.bounds
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        //self.view.layer.addSublayer(previewLayer)
        self.layer.addSublayer(previewLayer)
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
        
        //self.highlightView.frame = highlightViewRect
        //self.view.bringSubviewToFront(self.highlightView)

        detectionString = detectionString.substringFromIndex(advance(detectionString.startIndex,1));

        session.stopRunning()
    }//
    
    func viewDidAppear(animated: Bool)
    {
        //super.viewDidAppear(true)
        session.stopRunning()
        session.startRunning()
    } //viewDidAppear

}
