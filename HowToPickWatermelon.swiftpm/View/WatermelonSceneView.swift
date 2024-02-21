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

struct WatermelonSceneView: UIViewRepresentable {
    
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
        material.diffuse.contents = UIImage(named: "watermelonTmp0")
        watermelonGeometry.materials = [material]
        
        let watermelonNode = SCNNode(geometry: watermelonGeometry)
        watermelonNode.scale = SCNVector3(0.5, 0.5, 0.5) // initial scale
        scene.rootNode.addChildNode(watermelonNode)
        
        // 커스텀 카메라 노드 추가
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 3) // initial camera position
        scene.rootNode.addChildNode(cameraNode)
        
        return scene
    }
    
    private func addGestureRecognizers(to view: SCNView, context: Context) {
        let coordinator = context.coordinator
        
        let pinchGesture = UIPinchGestureRecognizer(target: coordinator, action: #selector(coordinator.handlePinch(_:)))
        view.addGestureRecognizer(pinchGesture)
        
        let tapGesture = UITapGestureRecognizer(target: coordinator, action: #selector(coordinator.handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        // 기존 회전 제스처 대신 Pan 제스처 추가
        let panGesture = UIPanGestureRecognizer(target: coordinator, action: #selector(coordinator.handlePan(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject {
        var audioPlayer: AVAudioPlayer?
        var initialScale: CGFloat = 0.5
        var initialPanLocation: CGPoint = .zero // 초기 팬 위치 저장
        
        @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
            guard let sceneView = gesture.view as? SCNView else { return }
            guard let node = sceneView.scene?.rootNode.childNodes.first else { return }
            guard let cameraNode = sceneView.scene?.rootNode.childNodes.first(where: { $0.camera != nil }) else { return }

            
            switch gesture.state {
            case .began:
                initialScale = CGFloat(node.scale.x)
                
            case .changed:
                let scaleAdjustment = min(max(0, gesture.scale), 0.4)
                let newScale = Float(initialScale * scaleAdjustment)
                node.scale = SCNVector3(x: newScale, y: newScale, z: newScale)
                  
            case .ended:
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                SCNTransaction.commit()
                
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
            print("탭 제스처 감지됨")
            guard let path = Bundle.main.path(forResource: "tap29", ofType: "mp3") else { return }
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("사운드 재생 중 오류 발생: \(error)")
            }
        }
        
        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let sceneView = gesture.view as? SCNView else { return }
            guard let watermelonNode = sceneView.scene?.rootNode.childNodes.first else { return }
            let translation = gesture.translation(in: sceneView)
            SCNTransaction.animationDuration = 0.5
            
            if gesture.state == .began {
                initialPanLocation = gesture.location(in: sceneView) // 초기 위치 저장
            } else if gesture.state == .changed {
                // 팬 이동량에 따라 노드 회전
                let xRotation = Float(translation.y) / 100.0 // 상하 드래그 -> x축 회전
                let yRotation = Float(translation.x) / 100.0 // 좌우 드래그 -> y축 회전
                
                // 현재 노드의 회전값에 더해줍니다.
                watermelonNode.eulerAngles.x += xRotation
                watermelonNode.eulerAngles.y += yRotation // 드래그 방향과 회전 방향 조정
                
                // 제스처의 translation을 리셋하여 연속적인 회전을 가능하게 합니다.
                gesture.setTranslation(.zero, in: sceneView)
            }
        }
    }
}
