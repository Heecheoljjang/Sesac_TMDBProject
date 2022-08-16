//
//  FourthViewController.swift
//  SesacTMDBProject
//
//  Created by HeecheolYoon on 2022/08/16.
//

import UIKit
import UIFramework

class FourthViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextButton.configuration = configButton()
        
    }
    
    func configButton() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        
        configuration.baseBackgroundColor = .darkGray
        configuration.baseForegroundColor = .white
        configuration.title = "영화 보기"
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .large
        
        return configuration
    }
    @IBAction func tapNextButton(_ sender: UIButton) {
        
        // iOS 13 이상, scenedelegate를 쓸 때 동작하는 코드
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene // 앱을 다시 처음부터 실행해주는 코드
        let sceneDelegate = windowScene?.delegate as? SceneDelegate // 신딜리게이트 클래스에 접근
                
        let sb = UIStoryboard(name: "NetflixView", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: NetflixViewController.reuseIdentifier) as? NetflixViewController else { return }
                
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
        
    }
    
}
