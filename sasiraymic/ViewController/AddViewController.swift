//
//  SecondViewController.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 12/26/17.
//  Copyright © 2017 com.sasiluk. All rights reserved.
//

import UIKit
import SnapKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicked = UIImageView()
    var openCameraButton = UIButton()
    var openPhotoLibraryButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicked.backgroundColor = .gray
        
        openCameraButton.tintColor = .black
        openCameraButton.setTitleColor(.black, for: .normal)
        openCameraButton.setTitle(R.string.localizable.openCamera(), for: .normal)
        openCameraButton.addTarget(self, action: #selector(openCameraAction), for: .touchUpInside)

        
        openPhotoLibraryButton.tintColor = .black
        openPhotoLibraryButton.setTitleColor(.black, for: .normal)
        openPhotoLibraryButton.setTitle(R.string.localizable.openPhotoLibrary(), for: .normal)
        openPhotoLibraryButton.addTarget(self, action: #selector(openPhotoLibraryAction), for: .touchUpInside)
        
        
        self.view.addSubview(imagePicked)
        self.view.addSubview(openCameraButton)
        self.view.addSubview(openPhotoLibraryButton)
        
        imagePicked.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.height.equalTo(self.view.frame.size.width)
        }
        
        openCameraButton.sizeToFit()
        openCameraButton.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.imagePicked.snp.bottom).offset(Style.Spacing.X3)
        }
        
        openPhotoLibraryButton.sizeToFit()
        openPhotoLibraryButton.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.openCameraButton.snp.bottom).offset(Style.Spacing.X3)
        }
        
    }
    
    
    
    @objc func openCameraAction() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            print("no camera")
        }
    }
    
    @objc func openPhotoLibraryAction() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            print("no photo library")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIImagePickerControllerDelegate Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicked.contentMode = .scaleToFill
        imagePicked.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }


}

