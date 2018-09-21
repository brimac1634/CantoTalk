//
//  CameraController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 5/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import AVFoundation
import CoreML
import Vision
import RealmSwift

class CameraController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    let mainRealm = try! Realm(configuration: Realm.Configuration(fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"), readOnly: true))
    
    let cameraView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cameraDisplay: CameraDisplay = {
        let view = CameraDisplay()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var entries: Results<Entries>?
    var entryArray: [Entries]?

    private var requests = [VNRequest]()
    private lazy var cameraLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    
    private lazy var captureSession: AVCaptureSession = {
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.photo
        guard
            let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
            let input = try? AVCaptureDeviceInput(device: backCamera)
            else { return session }
        session.addInput(input)
        return session
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entries = mainRealm.objects(Entries.self)
        setupViews()
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "MyQueue"))
        self.captureSession.addOutput(videoOutput)
        self.captureSession.startRunning()
        setupVision()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupDisplay()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.captureSession.stopRunning()
    }
    
    //MARK: - View Setup Methods
    
    func setupViews() {
        view.addSubview(cameraView)
        cameraView.layer.addSublayer(self.cameraLayer)
        
        
        
        NSLayoutConstraint.activate([
            cameraView.topAnchor.constraint(equalTo: view.topAnchor),
            cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            
            ])

    }
    
    func setupDisplay() {
        view.addSubview(cameraDisplay)
        
        NSLayoutConstraint.activate([
            cameraDisplay.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cameraDisplay.leadingAnchor.constraint(equalTo: cameraView.safeAreaLayoutGuide.leadingAnchor),
            cameraDisplay.trailingAnchor.constraint(equalTo: cameraView.safeAreaLayoutGuide.trailingAnchor),
            cameraDisplay.bottomAnchor.constraint(equalTo: cameraView.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        cameraDisplay.circleView.animate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.cameraLayer.frame = self.cameraView.bounds
        self.cameraLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    }
    
    //MARK: - Camera and CoreML configuration
    
    func setupVision() {
        guard let visionModel = try? VNCoreMLModel(for: Inceptionv3().model)
            else { fatalError("Can't load VisionML model") }
        let classificationRequest = VNCoreMLRequest(model: visionModel, completionHandler: handleClassifications)
        classificationRequest.imageCropAndScaleOption = VNImageCropAndScaleOption.scaleFill
        self.requests = [classificationRequest]
    }
    
    func handleClassifications(request: VNRequest, error: Error?) {
        entryArray = []
        guard let observations = request.results as? [VNClassificationObservation] else { print("no results: \(error!)"); return }
        guard let firstResult = observations.first?.identifier else {return}
        let individualWords = firstResult.components(separatedBy: ", ")
        guard let entryList = entries else {return}
        
        DispatchQueue.main.async {
            //once new model is created, remove the individualWords var and make the resulted word match exactly with database
            for word in individualWords {
                if let entry = entryList.filter("englishWord = %@", word).sorted(byKeyPath: "englishWord").first {
                    self.cameraDisplay.selectedEntry = entry
                    self.pauseAnimation()
                    
                } else {
                    self.cameraDisplay.selectedEntry = nil
                    self.resumeAnimation()
                }
            }

            

            
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        var requestOptions:[VNImageOption : Any] = [:]
        if let cameraIntrinsicData = CMGetAttachment(sampleBuffer, key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil) {
            requestOptions = [.cameraIntrinsics:cameraIntrinsicData]
        }
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: CGImagePropertyOrientation(rawValue: 1)!, options: requestOptions)
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
    }
    
    func pauseAnimation() {
        let circle = cameraDisplay.circleView
        let layer = circle.layer
        circle.pauseLayer(layer: layer)
        
    }
    
    func resumeAnimation() {
        let circle = cameraDisplay.circleView
        let layer = circle.layer
        circle.resumeLayer(layer: layer)
    }
    
}
