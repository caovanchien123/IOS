//
//  YeuThichController.swift
//  IOS
//
//  Created by x_x on 8/7/20.
//  Copyright © 2020 x_x. All rights reserved.
//

import UIKit

class DSYTCTController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum NavigationDirection {
        case cuatoi
        case yeuthich
    }
    var navigrationDirection:NavigationDirection = .yeuthich
    
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
    
    @IBAction func xoa(_ sender: UIButton) {
        let index = tabelView.indexPathForView(view: sender)!.row;
        if navigrationDirection == .cuatoi{
            if Config.truyenDB.open() {
                Config.truyenDB.delete(story: arrTruyen[index])
                arrTruyen.remove(at: index)
                tabelView.deleteRows(at: [tabelView.indexPathForView(view: sender) as! IndexPath], with: .fade)
            }
        }else if navigrationDirection == .yeuthich {
            if Config.yeuThich.open() {
                Config.yeuThich.delete(dadoc: ID(idTruyen: arrTruyen[index].ID_Story, idUser: Config.user!.ID!))
                arrTruyen.remove(at: index)
                tabelView.deleteRows(at: [tabelView.indexPathForView(view: sender) as! IndexPath], with: .fade)
            }
        }
        Toast("Đã xoá thành công").show(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if navigrationDirection == .cuatoi {
            if Config.truyenDB.open() {
                Config.truyenDB.getAllTruyenTG(storys: &arrTruyen)
            }
        }else if navigrationDirection == .yeuthich {
            if Config.yeuThich.open() {
                Config.yeuThich.readMealList(story: &arrTruyen)
            }
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
