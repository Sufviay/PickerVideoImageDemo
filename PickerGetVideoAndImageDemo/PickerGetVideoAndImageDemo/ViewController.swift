//
//  ViewController.swift
//  PickerGetVideoAndImageDemo
//
//  Created by 岁变 on 2017/8/8.
//  Copyright © 2017年 岁变. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var picker: UIImagePickerController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func clickPicker(_ sender: Any) {
        photoShow()
    }
    
    
    func photoShow() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            if self.picker == nil {
                self.picker = UIImagePickerController()
                self.picker?.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.picker?.delegate = self
                //控制相册中显示视频和照片
                self.picker?.mediaTypes = ["public.movie", "public.image"]
                
                self.picker?.allowsEditing = false
                
            }
            self.present(picker!, animated: true, completion: nil)
        } else {
            print("读取图库失败")
        }
        
    }
    
    
     func reviewVideo(videoUrl: URL) {
        let player = AVPlayer(url: videoUrl)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        playerVC.player?.play()
        
    }

    
    
    
    
    
    // UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //判断相册中选取的是图片还是视频
        if (info.keys.contains("UIImagePickerControllerOriginalImage")) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            picker.dismiss(animated: true, completion: { 
                self.imageView.image = image
            })
            
        } else {
            let videoURL = info[UIImagePickerControllerMediaURL] as! URL
            let player = AVPlayer(url: videoURL)
            let playerVC = AVPlayerViewController()
            playerVC.player = player
            
            picker.dismiss(animated: true, completion: { 
                self.present(playerVC, animated: true, completion: {
                    playerVC.player?.play()
                })
            })
            
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

