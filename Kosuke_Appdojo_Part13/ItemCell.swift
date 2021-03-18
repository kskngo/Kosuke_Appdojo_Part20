//
//  ItemCellTableViewCell.swift
//  Kosuke_Appdojo_Part13
//
//  Created by Kosuke Nagao on 2021/03/14.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet private var checkMarkImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    func configure(fruitsItem: FruitsItem) {
        checkMarkImageView.image = fruitsItem.isChecked ? UIImage(named: "check") : nil
        nameLabel.text = fruitsItem.name
    }
}
