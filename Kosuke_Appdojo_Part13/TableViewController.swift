//
//  TableViewController.swift
//  Kosuke_Appdojo_Part13
//
//  Created by Kosuke Nagao on 2021/03/12.
//

import UIKit

class TableViewController: UITableViewController {

    private var addItemMode: AddItemViewController.Mode?

    private enum Segue: String {
        case add = "Add"
        case edit = "Edit"
    }

    private var fruitsItems: [FruitsItem] = []

    private let repository = FruitsItemsRepository()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let fruitsItems = repository.load() {
            self.fruitsItems = fruitsItems
        }
    }

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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fruitsItems[indexPath.row].isChecked.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        repository.save(fruitsItems: fruitsItems)
    }

    override func tableView(
        _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fruitsItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            repository.save(fruitsItems: fruitsItems)
        }
    }

    @IBAction private func exitCancel(segue: UIStoryboardSegue) {
    }

    @IBAction private func exitAdd(segue: UIStoryboardSegue) {
    }

    @IBAction private func exitEdit(segue: UIStoryboardSegue) {
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        addItemMode = .edit(
            target: fruitsItems[indexPath.row],
            completion: { [weak self] fruitsItem in
                guard let strongSelf = self else { return }
                guard let fruitsItem = fruitsItem else { return }

                strongSelf.fruitsItems[indexPath.row] = fruitsItem
                strongSelf.tableView.reloadRows(at: [indexPath], with: .automatic)
                strongSelf.addItemMode = nil
                strongSelf.repository.save(fruitsItems: strongSelf.fruitsItems)
            }
        )
        performSegue(withIdentifier: "Edit", sender: nil)
    }

    @IBAction private func add(_ sender: Any) {
        addItemMode = .add(
            completion: { [weak self] fruitsItem in
                guard let strongSelf = self else { return }
                guard let fruitsItem = fruitsItem else { return }

                strongSelf.fruitsItems.append(fruitsItem)
                strongSelf.tableView.reloadData()
                strongSelf.addItemMode = nil
                strongSelf.repository.save(fruitsItems: strongSelf.fruitsItems)
        })

        performSegue(withIdentifier: "Add", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController else { return }
        guard let addItemViewController =
                navigationController.topViewController as? AddItemViewController else { return }
        guard let identifier = segue.identifier else { return }
        guard let segue = Segue(rawValue: identifier) else { return }

        switch segue {
        case .edit, .add:
            addItemViewController.mode = addItemMode
        }
    }
}

struct FruitsItem: Codable {
    var name: String
    var isChecked: Bool
}
