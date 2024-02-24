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
    let id = UUID()
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = createWatermelonScene()
        sceneView.allowsCameraControl = false // camera control disabled
        sceneView.showsStatistics = true // 통계 정보 표시
        
//        if watermelon.interaction == true {
            addGestureRecognizers(to: sceneView, context: context)
//        }
        
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
    }
    
    private func createWatermelonScene() -> SCNScene {
        let scene = SCNScene()
        
        let watermelonGeometry = SCNSphere(radius: 1.0)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: watermelon.imgName)
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
    
    private func createStemNode() -> SCNNode {
        let stemNode = SCNNode()

        let numberOfSegments = 50 // 원기둥의 개수를 50개로 설정
        var currentRadius = 0.08 // 시작 반지름
        let heightPerSegment = 0.03 // 각 세그먼트의 높이
        var currentPosition = 0.0 // 현재 세그먼트의 위치
        
        for i in 0..<numberOfSegments {
            let cylinder = SCNCylinder(radius: CGFloat(currentRadius), height: CGFloat(heightPerSegment))
            cylinder.firstMaterial?.diffuse.contents = UIColor.brown
            
            let cylinderNode = SCNNode(geometry: cylinder)
            cylinderNode.position = SCNVector3(0, currentPosition, 0)
            
            // 세그먼트마다 약간의 회전을 추가하여 자연스러운 구불거림 효과 생성
            let rotationAngle = Float(i) * (Float.pi / 180.0) * 5.0 // 5도 단위로 증가하는 회전 각
            cylinderNode.eulerAngles = SCNVector3(0, 0, rotationAngle * 0.1)
            
            stemNode.addChildNode(cylinderNode)
            
            // 다음 세그먼트를 위해 반지름과 위치 조정
            currentRadius *= 0.98 // 위로 갈수록 반지름을 점점 줄임
            currentPosition += heightPerSegment // 다음 세그먼트의 위치를 높이만큼 증가시킴
        }

        // 전체 줄기를 수직으로 세우기 위한 조정
        stemNode.eulerAngles = SCNVector3(-Float.pi / 2, 0, 0)
        
        return stemNode
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
