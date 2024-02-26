//
//  WatermelonSceneView.swift
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
        sceneView.allowsCameraControl = false // camera control disabled

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
        watermelonNode.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0) // initial scale
        watermelonNode.eulerAngles.x += 0.6
        watermelonNode.eulerAngles.y += 0.6
        scene.rootNode.addChildNode(watermelonNode)
        
        // 수박 줄기 추가
        let stemNode = createStemNode()
        stemNode.position = SCNVector3(0, 1, 0) // 수박 위에 위치시킵니다.
        watermelonNode.addChildNode(stemNode) // 수박 노드에 줄기 노드를 자식으로 추가합니다.
        
        // 커스텀 카메라 노드 추가
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 3) // initial camera position
        scene.rootNode.addChildNode(cameraNode)
        
        return scene
    }
    
    private func addGestureRecognizers(to view: SCNView, context: Context) {
        let coordinator = context.coordinator
        
//        let pinchGesture = UIPinchGestureRecognizer(target: coordinator, action: #selector(coordinator.handlePinch(_:)))
//        view.addGestureRecognizer(pinchGesture)
        
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

        // 줄기의 곡선을 정의하는 포인트들을 생성합니다.
        var points = [SCNVector3]()
        let stemHeight: CGFloat = 0.1 // 줄기의 높이
        let stemCurvature: CGFloat = 0.2 // 줄기의 곡률
        let numberOfPoints = 20 // 줄기를 구성하는 포인트의 수

        for i in 0..<numberOfPoints {
            let x = stemCurvature * sin(CGFloat(i) * .pi / CGFloat(numberOfPoints))
            let y = stemHeight * CGFloat(i) / CGFloat(numberOfPoints)
            let z = stemCurvature * cos(CGFloat(i) * .pi / CGFloat(numberOfPoints))
            points.append(SCNVector3(x, y, z))
        }

        let xOffset: CGFloat = -0.21 // 왼쪽으로 이동할 거리
        let yOffset: CGFloat = -0.04 // 왼쪽으로 이동할 거리
        for i in 0..<points.count {
            points[i].x += Float(xOffset)
            points[i].y += Float(yOffset)
        }
        
        // 포인트들을 사용하여 줄기의 곡선을 따라 SCNCylinder들을 배치합니다.
        for i in 1..<points.count {
            let startPoint = points[i - 1]
            let endPoint = points[i]
            let height = CGFloat(length(simd_float3(endPoint) - simd_float3(startPoint))) // GLKVector3Distance 대체
            let cylinder = SCNCylinder(radius: max(0.02, CGFloat(i) * 0.004), height: height)
            cylinder.firstMaterial?.diffuse.contents = UIImage(named: watermelon.imgStemName)

            let cylinderNode = SCNNode(geometry: cylinder)
            cylinderNode.position = SCNVector3((startPoint.x + endPoint.x) / 2,
                                               (startPoint.y + endPoint.y) / 2,
                                               (startPoint.z + endPoint.z) / 2)

            // 줄기 세그먼트의 방향을 계산하여 회전시킵니다.
            // worldUp 벡터를 기본 Y 축 방향인 (0, 1, 0)으로 설정합니다.
            let worldUp = SCNVector3(0, 1, 0)
            cylinderNode.look(at: endPoint, up: worldUp, localFront: cylinderNode.worldUp)
            stemNode.addChildNode(cylinderNode)
        }

        // 전체 줄기를 적절히 조정하여 수박 위에 위치시킵니다.
        stemNode.position = SCNVector3(-0.5, 0.5, 0) // 'x' 값을 조정하여 왼쪽으로 이동
        stemNode.eulerAngles.x = -Float.pi / 0.4 // 필요한 경우 조정

        return stemNode
    }
    
    class Coordinator: NSObject {
        var watermelon: Watermelon
        var audioPlayer: AVAudioPlayer?
        var initialScale: CGFloat = 0.5
        var initialPanLocation: CGPoint = .zero // 초기 팬 위치 저장
        
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
                if gesture.scale > 1 { // 줌 인
                    node.scale = SCNVector3(x: 1, y: 1, z: 1) // 확대된 상태
                } else { // 줌 아웃
                    node.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5) // 원래 스케일
                    cameraNode.eulerAngles = SCNVector3(0, 0, 0) // 카메라 각도 약간 위를 향하도록 조정
                }
            default:
                break
            }
        }
        
        @objc func handleTap(_ gesture: UITapGestureRecognizer) {

//            guard let url = Bundle.main.url(forResource: "testSoundTrain", withExtension: "mp3") else { return }
//            
//            do {
//                audioPlayer = try AVAudioPlayer(contentsOf: url)
//                audioPlayer?.play()
//            } catch (let err) {
//                print(err.localizedDescription)
//            }
            print("Current watermelon taste: \(watermelon.taste)")
            
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
