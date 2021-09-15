//
//  AVCapture.swift
//  tankeiKenshutu
//
//  Created by 水代謝システム工学研究室 on 2020/07/01.
//  Copyright © 2020 水代謝システム工学研究室. All rights reserved.
//


import UIKit
import AVFoundation

protocol AVCaptureDelegate {
    func capture(image: UIImage)
}

class AVCapture:NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {

    var captureSession: AVCaptureSession!
    var delegate: AVCaptureDelegate?

    // DISMISS_COUNT に1回画像処理 （captureの実行)
    var counter = 0
//    let DISMISS_COUNT = 5
    let DISMISS_COUNT = 5

    override init()
    {
        super.init()
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        let videoDevice = AVCaptureDevice.default(for: AVMediaType.video)
        videoDevice?.activeVideoMinFrameDuration = CMTimeMake(value: 1, timescale: 30)// 1/30秒 (１秒間に30フレーム)
        let videoInput = try! AVCaptureDeviceInput.init(device: videoDevice!)
        captureSession.addInput(videoInput)

        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable as! String : Int(kCVPixelFormatType_32BGRA)]
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        // 先にセッションにOutput情報を追加
        captureSession.addOutput(videoDataOutput)
        // 内部パラメーターの配信を有効にする
        // isCameraIntrinsicMatrixDeliverySupported がtrueの場合のみ
        videoDataOutput.connections.first?.isCameraIntrinsicMatrixDeliveryEnabled = true
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
    func start_session()
    {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        let videoDevice = AVCaptureDevice.default(for: AVMediaType.video)
        videoDevice?.activeVideoMinFrameDuration = CMTimeMake(value: 1, timescale: 30)// 1/30秒 (１秒間に30フレーム)
        let videoInput = try! AVCaptureDeviceInput.init(device: videoDevice!)
        captureSession.addInput(videoInput)

        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable as! String : Int(kCVPixelFormatType_32BGRA)]
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        // 先にセッションにOutput情報を追加
        captureSession.addOutput(videoDataOutput)
        // 内部パラメーターの配信を有効にする
        // isCameraIntrinsicMatrixDeliverySupported がtrueの場合のみ
        videoDataOutput.connections.first?.isCameraIntrinsicMatrixDeliveryEnabled = true
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }

    // 新しいキャプチャの追加で呼ばれる関数
    func captureOutput(_ captureOutput: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

        if (counter % DISMISS_COUNT) == 0 {

            let image = imageFromSampleBuffer(sampleBuffer: sampleBuffer)
            delegate?.capture(image: image)

        }
        counter += 1
    }

    // SampleBufferからUIImageの作成
    func imageFromSampleBuffer(sampleBuffer :CMSampleBuffer) -> UIImage {

        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!

        // イメージバッファのロック
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))

        // 画像情報を取得
        let base = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0)!
        let bytesPerRow = UInt(CVPixelBufferGetBytesPerRow(imageBuffer))
        let width = UInt(CVPixelBufferGetWidth(imageBuffer))
        let height = UInt(CVPixelBufferGetHeight(imageBuffer))

        // ビットマップコンテキスト作成
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitsPerCompornent = 8
        let bitmapInfo = CGBitmapInfo(rawValue: (CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue) as UInt32)
        let newContext = CGContext(data: base, width: Int(width), height: Int(height), bitsPerComponent: Int(bitsPerCompornent), bytesPerRow: Int(bytesPerRow), space: colorSpace, bitmapInfo: bitmapInfo.rawValue)! as CGContext

        // イメージバッファのアンロック
        CVPixelBufferUnlockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))

        // 画像作成
        let imageRef = newContext.makeImage()!
        let image = UIImage(cgImage: imageRef, scale: 1.0, orientation: UIImage.Orientation.right)
        

        return image
    }
    
    func stopSession()
    {
        if captureSession.isRunning {
            DispatchQueue.global().async {
                self.captureSession.stopRunning()
            }
        }
    }
}
