//
//  ViewController.swift
//  sampleMiniGuidebook
//
//  Created by kensuke yoshida on 2017/06/19.
//  Copyright © 2017年 kensuke yoshida. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,
    UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    
    //classの直下に置くと、プロパティとなる（複数のメソッドを使用するから）
    //var proArray = ["Ayala", "Moalboal"]
    //プロパティリストから読み込んだdataを格納する配列
    //[String] ->　中身がString型のデータが入ってくる配列
    var placeList:[String] = []
    

    
     //選択された名前
    var selectName = "" //!は整数が入っているの略　イコール　　var selectedIndex = -1


    //TODO：二枚目の画面を作成し、タップされたエリア名を二枚目の画面で表示してください(ラベル使用)
    //ヒントはエリア名をそのまま二枚目の画面に渡してください
    //(数字ではなく、文字)
    //移動にはナビゲーションコントロラーを使ってください
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //プロパティリストファイルパスを取得
        let filePath = Bundle.main.path(forResource:"placelist", ofType: "plist")

        
        //プロパティリストからdataを取得（ディクショナリー型）
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        //TableViewで扱いやすい配列（エリア名の入っている配列）を作成
        //高速列挙(for文)で値を取得
        for(key, data) in dic!{
//            print("KEY=\(key)")
//            print("DATA\(data)")
            
            placeList.append(key as! String)
        }
        
        
        //printで配列の中身を確認(念のため)
        print(placeList)
        
        
        
    }

    //②行数を決定　＊ここでは列数は表示しない
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.count
    }
    
    //③リストに表示する文字列を決定し、表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //文字を表示するセルの取得(セルの再利用)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //表示したい文字の設定
        //cell.textLabel?.text = "\(indexPath.row)"
        cell.textLabel?.text = placeList[indexPath.row]
        
        //アクセサリをつける
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        
        //文字を設定したセルを返す
        return cell
        
    }
    
    
    //セルをタップしたとき、セグエを指定して画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //表示されているエリア名メンバ変数に格納
        selectName = placeList[indexPath.row]
        
        //セグエを指定して画面移動
        performSegue(withIdentifier: "showDetail", sender: nil)
        
        
    }
    
    //次の画面へ移動するときにプロパティに選択したエリア名を渡す
    //セグエを使って別な画面に移動するときに発動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //次の画面をインスタンス化(as:ダウンキャスト型変換)
        //移動先の画面のインスタンスを作成
        let dvc = segue.destination as! myDetailView
        
        
        //移動先の画面のプロパティにエリア名を指定
        //dvc.myLabel.text = selectName 考え方はいいが、インスタンス化されるタイミングがもっと後なのでエラーになってしまう
        
        dvc.areaName = selectName
        
        
        //次の画面のプロパティに選択された行番号を指定
        //dvc.sIndex = selectedIndex
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

