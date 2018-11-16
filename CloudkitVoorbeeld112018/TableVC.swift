//
//  TableVC.swift
//  CloudkitVoorbeeld112018
//
//  Created by Toine Schnabel on 12/11/2018.
//  Copyright © 2018 Toine Schnabel. All rights reserved.
//

import UIKit
import CloudKit

class TableVC: UITableViewController, UITextFieldDelegate,NotifyUserProtocol {
    @IBOutlet var naamTabel: UITableView!
    
    var database : Model?

    override func viewDidLoad() {
        super.viewDidLoad()
        if (database == nil) {database = Model()}
        database!.addNaamRecord(voorNaam: "toine", achterNaam: "Schnabel")
        database!.addNaamRecord(voorNaam: "Jacqueline", achterNaam: "Hendriks")

        print (database!.copyDB)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
//        voorNaam.endEditing(true)
//        commentsField.endEditing(true)
    }
        
    @IBAction func addNewName(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Errand", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addTextField(configurationHandler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            self.database?.addNaamRecord(voorNaam: alertController.textFields!.first!.text!, achterNaam: alertController.textFields!.last!.text!)
            self.naamTabel.reloadData()
        }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return database!.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! naamTableViewCell
        cell.achternaam.text = database!.copyDBSorted[indexPath.row].achterNaam
        cell.voornaam.text = database!.copyDBSorted[indexPath.row].voorNaam
        // Configure the cell...
        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            database?.deleteNaamRecord(forRow: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
    func notifyUser(_ title: String, message: String)
    {
        print ("in notifyUser")
//        let alert = UIAlertController(title: title,
//                                      message: message,
//                                      preferredStyle: .alert)
//        
//        let cancelAction = UIAlertAction(title: "OK",
//                                         style: .cancel, handler: nil)
//        
//        alert.addAction(cancelAction)
//        self.present(alert, animated: true,
//                     completion: nil)
    }
}
