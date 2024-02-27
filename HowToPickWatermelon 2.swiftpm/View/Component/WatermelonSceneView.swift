//
// WatermelonSceneView.swift
//
//
//  Created by 김태현 on 2/21/24.
//

import SwiftUI
import SceneKit
import UIKit
import AVFoundation

struct WatermelonSceneView: UIViewRepresentable, Identifiable {
    let watermelon: Watermelon
    let page: Page
    let id = UUID()
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = createWatermelonScene()
        sceneView.allowsCameraControl = false
        addGestureRecognizers(to: sceneView, context: context)
    
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
    }
    
    private func createWatermelonScene() -> SCNScene {
        let scene = SCNScene()
        
        let watermelonGeometry = SCNSphere(radius: 1.0)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: watermelon.imgBodyName)
        watermelonGeometry.materials = [material]
        
        let watermelonNode = SCNNode(geometry: watermelonGeometry)
        watermelonNode.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)
        watermelonNode.eulerAngles.x += 0.6
        watermelonNode.eulerAngles.y += 0.6
        scene.rootNode.addChildNode(watermelonNode)
        
        
        let stemNode = createStemNode()
        stemNode.position = SCNVector3(0, 1, 0)
        watermelonNode.addChildNode(stemNode)
        
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 3)
        scene.rootNode.addChildNode(cameraNode)
        
        return scene
    }
    
    private func addGestureRecognizers(to view: SCNView, context: Context) {
        let coordinator = context.coordinator

        if page == .tutorialSound || watermelon.taste == .soundClear || watermelon.taste == .soundHeavy {
            let tapGesture = UITapGestureRecognizer(target: coordinator, action: #selector(coordinator.handleTap(_:)))
            view.addGestureRecognizer(tapGesture)
        }
        
        let panGesture = UIPanGestureRecognizer(target: coordinator, action: #selector(coordinator.handlePan(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(watermelon: self.watermelon)
    }
    
    private func createStemNode() -> SCNNode {
        let stemNode = SCNNode()

        
        var points = [SCNVector3]()
        let stemHeight: CGFloat = 0.1
    
        let stemCurvature: CGFloat = 0.2
    
        let numberOfPoints = 20
    

        for i in 0..<numberOfPoints {
            let x = stemCurvature * sin(CGFloat(i) * .pi / CGFloat(numberOfPoints))
            let y = stemHeight * CGFloat(i) / CGFloat(numberOfPoints)
            let z = stemCurvature * cos(CGFloat(i) * .pi / CGFloat(numberOfPoints))
            points.append(SCNVector3(x, y, z))
        }

        let xOffset: CGFloat = -0.21
    
        let yOffset: CGFloat = -0.04
    
        for i in 0..<points.count {
            points[i].x += Float(xOffset)
            points[i].y += Float(yOffset)
        }
        
        for i in 1..<points.count {
            let startPoint = points[i - 1]
            let endPoint = points[i]
            let height = CGFloat(length(simd_float3(endPoint) - simd_float3(startPoint)))
        
            let cylinder = SCNCylinder(radius: max(0.02, CGFloat(i) * 0.004), height: height)
            cylinder.firstMaterial?.diffuse.contents = UIImage(named: watermelon.imgStemName)

            let cylinderNode = SCNNode(geometry: cylinder)
            cylinderNode.position = SCNVector3((startPoint.x + endPoint.x) / 2,
                                               (startPoint.y + endPoint.y) / 2,
                                               (startPoint.z + endPoint.z) / 2)

        
        
            let worldUp = SCNVector3(0, 1, 0)
            cylinderNode.look(at: endPoint, up: worldUp, localFront: cylinderNode.worldUp)
            stemNode.addChildNode(cylinderNode)
        }

    
        stemNode.position = SCNVector3(-0.5, 0.5, 0)
        stemNode.eulerAngles.x = -Float.pi / 0.4

        return stemNode
    }
    
    class Coordinator: NSObject {
        var watermelon: Watermelon
        var audioPlayer: AVAudioPlayer?
        var initialScale: CGFloat = 0.5
        var initialPanLocation: CGPoint = .zero
        
        init(watermelon: Watermelon) {
            self.watermelon = watermelon
        }
        
        @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
            guard let sceneView = gesture.view as? SCNView else { return }
            guard let node = sceneView.scene?.rootNode.childNodes.first else { return }
            guard let cameraNode = sceneView.scene?.rootNode.childNodes.first(where: { $0.camera != nil }) else { return }

            
            switch gesture.state {
            case .began:
                initialScale = CGFloat(node.scale.x)
                
            case .changed:
                SCNTransaction.animationDuration = 0.5
                let scaleAdjustment = min(max(0, gesture.scale), 0.4)
                let newScale = Float(initialScale * scaleAdjustment)
                node.scale = SCNVector3(x: newScale, y: newScale, z: newScale)
                  
            case .ended:
                if gesture.scale > 1 {
                    node.scale = SCNVector3(x: 1, y: 1, z: 1)
                } else {
                    node.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
                    cameraNode.eulerAngles = SCNVector3(0, 0, 0)
                }
            default:
                break
            }
        }
        
        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            let feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle
            switch watermelon.taste {
            case .soundClear:
                feedbackStyle = .heavy
            default:
                feedbackStyle = .light
            }
            let feedbackGenerator = UIImpactFeedbackGenerator(style: feedbackStyle)
            feedbackGenerator.prepare()
            feedbackGenerator.impactOccurred()
        }

        
        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let sceneView = gesture.view as? SCNView else { return }
            guard let watermelonNode = sceneView.scene?.rootNode.childNodes.first else { return }
            let translation = gesture.translation(in: sceneView)
            SCNTransaction.animationDuration = 0.5
            
            if gesture.state == .began {
                initialPanLocation = gesture.location(in: sceneView)
            } else if gesture.state == .changed {
                let xRotation = Float(translation.y) / 100.0
                let yRotation = Float(translation.x) / 100.0
                
                watermelonNode.eulerAngles.x += xRotation
                watermelonNode.eulerAngles.y += yRotation
                
                gesture.setTranslation(.zero, in: sceneView)
            }
        }
    }
}
