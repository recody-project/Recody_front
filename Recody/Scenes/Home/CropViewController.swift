//
//  CropViewController.swift
//  Recody
//
//  Created by 마경미 on 23.07.23.
//

import UIKit

protocol CropViewControllerDelegate: AnyObject {
    func cropViewControllerDidCropImage(_ image: UIImage)
}

class CropViewController: UIViewController {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cropView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2.0
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var image: UIImage!
    weak var delegate: CropViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.addTarget(self, action: #selector(cropButtonTapped), for: .touchUpInside)
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true

        view.addSubview(imageView)
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: image.size.width / image.size.height).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: image.size.height / image.size.width).isActive = true
        imageView.image = image
        
        view.addSubview(cropView)
        cropView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cropView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        cropView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        cropView.heightAnchor.constraint(equalTo: cropView.widthAnchor, multiplier: 0.4).isActive = true
        
        // 크롭 뷰를 드래그하도록 제스처 추가
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        cropView.addGestureRecognizer(panGesture)
    }
    
    @objc func cropButtonTapped() {
        // 크롭된 이미지를 생성하고 delegate를 통해 결과를 전달합니다.
        if let croppedImage = cropImage() {
            print(croppedImage)
            delegate?.cropViewControllerDidCropImage(croppedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func cropImage() -> UIImage? {
        // 이미지를 원하는 방식으로 크롭하여 반환하는 로직을 구현합니다.
        // cropView의 프레임 정보를 기반으로 크롭합니다.
        let scale = imageView.image!.size.width / imageView.frame.width
        let cropRect = CGRect(
            x: cropView.frame.origin.x * scale,
            y: cropView.frame.origin.y * scale,
            width: cropView.frame.width * scale,
            height: cropView.frame.height * scale
        )
        
        if let croppedCGImage = imageView.image?.cgImage?.cropping(to: cropRect) {
            return UIImage(cgImage: croppedCGImage)
        }
        
        return nil
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: imageView)
        var cropFrame = cropView.frame
        
        cropFrame.origin.x += translation.x
        cropFrame.origin.y += translation.y
        
        // cropView가 imageView 내부를 벗어나지 않도록 제한합니다.
        cropFrame.origin.x = max(cropFrame.origin.x, 0)
        cropFrame.origin.y = max(cropFrame.origin.y, 0)
        cropFrame.origin.x = min(cropFrame.origin.x, imageView.frame.width - cropFrame.width)
        cropFrame.origin.y = min(cropFrame.origin.y, imageView.frame.height - cropFrame.height)
        
        cropView.frame = cropFrame
        gestureRecognizer.setTranslation(.zero, in: imageView)
    }
}
