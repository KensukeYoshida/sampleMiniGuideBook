//
//  myDetailView.swift
//  sampleMiniGuidebook
//
//  Created by kensuke yoshida on 2017/06/19.
//  Copyright © 2017年 kensuke yoshida. All rights reserved.
//

import UIKit
import MapKit

class myDetailView: UIViewController {

    @IBOutlet weak var myTextView: UITextView!

    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myMapView: MKMapView!
    
    var areaName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //プロパティリストファイルパスを取得
        let filePath = Bundle.main.path(forResource:"placelist", ofType: "plist")
        
        
        //プロパティリストからdataを取得（ディクショナリー型）
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        //指定されたエリア名をキーにして、画面に必要な情報を取得
        let detailInfo:NSDictionary = dic?[areaName] as! NSDictionary
        
        
        //このカッコの中はdouble型にしないといけない
        let lati: Double = Double(detailInfo["latitude"] as! String)!
        
        let long: Double = Double(detailInfo["longitude"] as! String)!
        
         let coordinate = CLLocationCoordinate2DMake(lati, long)
        
        //縮尺を設定
        let span = MKCoordinateSpanMake(0.5, 0.5)
        
        //範囲オブジェクト作成
        let region = MKCoordinateRegionMake(coordinate, span)
        
        //MapViewに範囲オブジェクトを設定
        myMapView.setRegion(region, animated: true)
        
        //アヤラにピンを立てる
        //ピンを生成
        let myPin = MKPointAnnotation()
        
        //ピンの座標を設定
        myPin.coordinate = coordinate
        
        //mapViewにピンを追加
        myMapView.addAnnotation(myPin)


    
        myImageView.image = UIImage(named:detailInfo["image"] as! String)
        myTextView.text = (detailInfo["description"] as! String)
        
        myMapView.showAnnotations(myMapView.annotations, animated: true)
        
        




        
        print(detailInfo["image"] as! String)
        print(detailInfo["description"] as! String)
        print(detailInfo["latitude"] as! String)
        print(detailInfo["longitude"] as! String)
        
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
