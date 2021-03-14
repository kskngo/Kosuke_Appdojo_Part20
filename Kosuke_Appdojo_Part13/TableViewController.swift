//
//  TableViewController.swift
//  Kosuke_Appdojo_Part13
//
//  Created by Kosuke Nagao on 2021/03/12.
//

import UIKit

class TableViewController: UITableViewController {
    private var fruitsItems = [
        FruitsItem(name: "りんご", isChecked: false),
        FruitsItem(name: "みかん", isChecked: true),
        FruitsItem(name: "バナナ", isChecked: false),
        FruitsItem(name: "パイナップル", isChecked: true)
    ]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruitsItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }

        let fruitsItem = fruitsItems[indexPath.row]
        cell.checkMarkImageView.image = fruitsItem.isChecked ? UIImage(named: "check") : nil
        cell.nameLabel.text = fruitsItem.name

        return cell
    }

    @IBAction private func exitCancel(segue: UIStoryboardSegue) {
    }

    @IBAction private func exitSave(segue: UIStoryboardSegue) {
        guard let addItemViewController = segue.source as? AddItemViewController else { return }
        guard let newItemName = addItemViewController.nameTextField.text, !newItemName.isEmpty else { return }
        let newItem =  FruitsItem(name: newItemName, isChecked: false)
        fruitsItems.append(newItem)
        self.tableView.reloadData()
    }
}

struct FruitsItem {
    let name: String
    let isChecked: Bool
}
