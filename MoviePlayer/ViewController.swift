//
//  ViewController.swift
//  MoviePlayer
//
//  Created by Hansub Yoo on 2020/07/23.
//  Copyright © 2020 Hansub Yoo. All rights reserved.
//

import UIKit
import AVKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var extenalVideoView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        // 비디오 파일명을 사용하여 비디오가 저장된 앱 내부의 파일 경로를 받아옴
        let filePath: String? = Bundle.main.path(forResource: "고기짬뽕라면 1인분 만들기 (feat.맛남의광장) ㅣ 백종원의 쿠킹로그", ofType: "mp4")
        // 앱 내부의 파일명을 URL형식으로 변경
        let url = URL(fileURLWithPath: filePath!)
        
        self.playVideo(url: url)
    }
    
    @IBAction func btnPlayExternalMovie(_ sender: UIButton) {
        let webViewConfiguration = WKWebViewConfiguration()
        webViewConfiguration.allowsInlineMediaPlayback = true
        let wkWebView = WKWebView(frame: self.extenalVideoView.frame, configuration: webViewConfiguration)
        self.view.addSubview(wkWebView)
        let myURL = URL(string: "https://www.youtube.com/watch?v=2sUjx8PE_vg")
        let youtubeRequest = URLRequest(url: myURL!)
        wkWebView.load(youtubeRequest)
    }
    
    private func playVideo(url: URL) {
        // AVPlayerController의 인스턴스 생성
        let playerController = AVPlayerViewController()
        
        // 비디오 URL로 초기화된 AVPlayer의 인스턴스 생성
        let player = AVPlayer(url: url as URL)
        // AVPlayerViewController의 player 속성에 위에서 생성한 AVPlayer 인스턴스를 할당
        playerController.player = player
        
        self.present(playerController, animated: true) {
            player.play()
        }
    }
    
}

/**
 유튜브 링크로 실행하는 것은 실행되지 않아 검색하던 중
 https://stackoverflow.com/questions/34709880/play-a-video-from-youtube-in-a-avplayerviewcontroller-in-swift
 에서 찾았다. AVPlayer에서는 동영상 파일을 재생할 뿐이다. youtube는 동영상 파일을 노출시키지 않기 때문에 실행이 불가능하다. 그래서, 웹뷰로 실행시켜야한다.
 */
