//
//  AddItemViewController.swift
//  Kosuke_Appdojo_Part13
//
//  Created by Kosuke Nagao on 2021/03/14.
//

import UIKit

class AddItemViewController: UIViewController {
    @IBOutlet private weak var nameTextField: UITextField!
    private(set) var newFruitsItem: FruitsItem?

    @IBAction private func didTapSaveButton(_ sender: Any) {
        let name = nameTextField.text ?? ""
        if !name.isEmpty {
            newFruitsItem = FruitsItem(
                name: name,
                isChecked: false)
        }
        performSegue(withIdentifier: "SaveSegue", sender: nil)
    }
}
