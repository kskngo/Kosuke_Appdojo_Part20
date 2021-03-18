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
        fruitsItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        cell.configure(fruitsItem: fruitsItems[indexPath.row])
        return cell
    }

    @IBAction private func exitCancel(segue: UIStoryboardSegue) {
    }

    @IBAction private func exitSave(segue: UIStoryboardSegue) {
        guard let addItemViewController = segue.source as? AddItemViewController else { return }
        guard let newItem = addItemViewController.newFruitsItem else { return }
        fruitsItems.append(newItem)
        self.tableView.reloadData()
    }
}

struct FruitsItem {
    let name: String
    let isChecked: Bool
}
