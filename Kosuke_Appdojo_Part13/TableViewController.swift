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

    private static let fruitsItemsKey = "fruitsItemsKey"

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFruitsItems()
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
        saveFruitsItems()
    }

    override func tableView(
        _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fruitsItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            saveFruitsItems()
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
                guard let fruitsItem = fruitsItem else { return }

                self?.fruitsItems[indexPath.row] = fruitsItem
                self?.tableView.reloadRows(at: [indexPath], with: .automatic)
                self?.addItemMode = nil
                self?.saveFruitsItems()
            }
        )
        performSegue(withIdentifier: "Edit", sender: nil)
    }

    @IBAction private func add(_ sender: Any) {
        addItemMode = .add(
            completion: { [weak self] fruitsItem in
                guard let fruitsItem = fruitsItem else { return }

                self?.fruitsItems.append(fruitsItem)
                self?.tableView.reloadData()
                self?.addItemMode = nil
                self?.saveFruitsItems()
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

    private func saveFruitsItems() {
        let saveData = fruitsItems.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(saveData as [Any], forKey: Self.fruitsItemsKey)
    }

    private func loadFruitsItems() {
        guard let items = UserDefaults.standard.array(forKey: Self.fruitsItemsKey) as? [Data] else { return }
        fruitsItems = items.compactMap { try? JSONDecoder().decode(FruitsItem.self, from: $0) }
    }
}

struct FruitsItem: Codable {
    var name: String
    var isChecked: Bool
}
