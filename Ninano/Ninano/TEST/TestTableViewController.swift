//
//  TestTableViewController.swift
//  Ninano
//
//  Created by KYUBO A. SHIM on 2022/07/25.
//

import UIKit

class TestTableViewController: UITableViewController {

    private var likeViewModel = LikeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func alertMinus(_ sender: UIBarButtonItem) {
        print("zfgsdgf")
        
    }
    
    
    @IBAction func alertPLUS(_ sender: UIButton) {
        print("TlqkfRJ")
        let alertController = UIAlertController(title: "Add List Item", message: "Add an item that you need to do.", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?[0], let text = textField.text, let textFieldSecond = alertController.textFields?[1], let textSecond = textFieldSecond.text  else {
                // execute code if textField doesn't exist
                return
            }

            self?.likeViewModel.insertLike(LikeModel(nameLike: textSecond, isLiked: false, url: text))
            self?.tableView.reloadData()
        }

        alertController.addTextField { textField in
            textField.placeholder = "url"
        }

        alertController.addTextField { textField in
            textField.placeholder = "name"
        }

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        present(alertController, animated: true)
    }
    
    
    
    
    
//    @IBAction func alertPlus(_ sender: UIBarButtonItem) {
//        print("TlqkfRJ")
//        let alertController = UIAlertController(title: "Add List Item", message: "Add an item that you need to do.", preferredStyle: .alert)
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//
//        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
//            guard let textField = alertController.textFields?[0], let text = textField.text, let textFieldSecond = alertController.textFields?[1], let textSecond = textFieldSecond.text  else {
//                // execute code if textField doesn't exist
//                return
//            }
//
//            self?.likeViewModel.insertLike(LikeModel(nameLike: textSecond, isLiked: false, url: text))
//            self?.tableView.reloadData()
//        }
//
//        alertController.addTextField { textField in
//            textField.placeholder = "url"
//        }
//
//        alertController.addTextField { textField in
//            textField.placeholder = "name"
//        }
//
//        alertController.addAction(cancelAction)
//        alertController.addAction(okAction)
//
//        present(alertController, animated: true)
//    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return likeViewModel.getLike().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TestCellID", for: indexPath) as? TestTableViewCell else {return UITableViewCell.init()}
        cell.urlLabel.text = likeViewModel.getLike()[indexPath.row].url
        cell.nameLabel.text = likeViewModel.getLike()[indexPath.row].nameLike
        cell.isLikedLabel.text = likeViewModel.getLike()[indexPath.row].isLiked ? "♥" : "♡"
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

//     Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }

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
