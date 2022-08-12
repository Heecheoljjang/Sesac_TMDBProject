//
//  PHPickerViewController.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/12.
//

import UIKit
import PhotosUI

class PickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func tapButton(_ sender: UIButton) {
        
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 3
        //configuration.filter = .images // 표시타입
        configuration.filter = .any(of: [.images, .livePhotos])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        self.present(picker, animated: true)
    }
    
}

extension PickerViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print(results)
    }
    
}
