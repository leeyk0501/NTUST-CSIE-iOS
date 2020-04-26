//
//  TableViewController.swift
//  Hw02
//
//  Created by B10615013 on 2020/3/27.
//  Copyright © 2020 B10615013. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    var insertOrDelete = 0
    var names = ["Cache", "Dust2", "Inferno", "Mirage", "Nuke", "Office", "Overpass", "Train"]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_1to2" {
            let vc = segue.destination as? secondViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                vc!.receiveStr = names[selectedRow]
            }
        }
    }
    
    @IBAction func clickLeftBtn(_ sender: UIButton) {
        if leftBtn.title(for: .normal) == "新增" && insertOrDelete == 0 {
            // Insert mode
            insertOrDelete = 1
            tableView.isEditing = true
            
            leftBtn.setTitle("返回", for: .normal)
        }
        else if leftBtn.title(for: .normal) == "返回"{
            //Return default mode
            insertOrDelete = 0
            tableView.isEditing = false
            leftBtn.setTitle("新增", for: .normal)
        }
    }
    @IBAction func clickRightBtn(_ sender: UIButton) {
        if rightBtn.title(for: .normal) == "刪除" && insertOrDelete == 0 {
            //Delete mode
            insertOrDelete = 2
            tableView.isEditing = true
            rightBtn.setTitle("返回", for: .normal)
        }
        else if rightBtn.title(for: .normal) == "返回"{
            //Return default mode
            insertOrDelete = 0
            tableView.isEditing = false
            rightBtn.setTitle("刪除", for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftBtn.setTitle("新增", for: .normal)
        rightBtn.setTitle("刪除", for: .normal)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = names[indexPath.row]
        cell.imageView?.image = UIImage(named: names[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if (insertOrDelete == 1) {
            return .insert
        } else if (insertOrDelete == 2) {
            return .delete
        } else {
            return .none
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            names.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            tableView.beginUpdates()
            if let name = tableView.cellForRow(at: indexPath)?.textLabel?.text {
                names.insert(name, at: indexPath.row)
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            tableView.endUpdates()
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
