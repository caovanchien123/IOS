//
//  DanhSachController.swift
//  IOS
//
//  Created by x_x on 8/6/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import UIKit

class DanhSachController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrTruyen = [Story]()
    @IBOutlet weak var tabelView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTruyen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        let story = arrTruyen[indexPath.row]
        cell.img_hinh.image = story.hinh
        cell.txt_GioiThieu.text = "Giới thiệu: " + story.gioiThieu
        cell.txt_TacGia.text = "Tác giả: " + story.tacGia
        cell.txt_TenTruyen.text = "Tên truyện: " + story.ten
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadApp()
    }
    
    private func loadApp(){
        if Config.truyenDB.open() {
            Config.truyenDB.getAllTruyen(storys: &arrTruyen)
        }
        
        tabelView.delegate = self
        tabelView.dataSource = self
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("chuan bi put")
        let data = segue.destination as! UINavigationController
        let st = data.viewControllers[0] as! DocTruyenController
        guard let selectedCell = sender as? CustomTableViewCell else {
            print("can not get cell")
            return
        }
        guard let indexPath = tabelView.indexPath(for: selectedCell) else {
            print("can not get the indexpath of the selectCell")
            return
        }
        st.story = arrTruyen[indexPath.row]
    }
}
