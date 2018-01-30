//
//  SetUpBudgetViewController.swift
//  My Budget
//
//  Created by MacUSER on 12.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class SetUpBudgetViewController: UIViewController {

    @IBOutlet var imcomesSlider: UISlider!
    @IBOutlet var expenseSlider: UISlider!
    @IBOutlet var savingsSlider: UISlider!
    @IBOutlet var incomeValueLabel: UILabel!
    @IBOutlet var expenseValueLabel: UILabel!
    @IBOutlet var percentageValueLabel: UILabel!
    @IBOutlet var currencyTextField: UITextField!
    
    var pickedCurrency = ""
    let currencyList = ["$","€","лв","£","¥","CHF","₽","฿"]
    
    var regularIncome  = 0
    var regularExpense = 0
    var savingsProcent = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createCurrencyPickerView(){
        let currencyPickerView = UIPickerView()
        currencyPickerView.delegate = self
        currencyTextField.inputView = currencyPickerView
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target :self, action: #selector(doneBarButtonItem))
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target :self, action: #selector(canselBarButtonItem))
        
        toolBar.setItems([doneButton, cancelButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        currencyTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func doneBarButtonItem(){
        currencyTextField.text = pickedCurrency
        usedCurrensy = pickedCurrency

        view.endEditing(true)
    }
    
    @objc func canselBarButtonItem(){
        view.endEditing(true)
    }
    
    @IBAction func incomeSliderChanged(_ sender: UISlider) {
        regularIncome = Int(sender.value)
        incomeValueLabel.text = "\(regularIncome)"
    }
    
    @IBAction func expenseSliderChanged(_ sender: UISlider) {
        regularExpense = Int(sender.value)
        expenseValueLabel.text = "\(regularExpense)"
    }
    
    @IBAction func percentageValueChanged(_ sender: UISlider) {
        savingsProcent = Int(sender.value)
        percentageValueLabel.text = "\(savingsProcent) %"
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        DBManager.singleton.updateCashFlowValues(income: regularIncome, expense: regularExpense, savings: savingsProcent, currensy: pickedCurrency)
        UserDefaults.standard.set(true, forKey: "cashFlowIsSet")
        UserDefaults.standard.set(pickedCurrency, forKey: "currency")
    }
    
    
    @IBAction func pickCurencyEditingDidBegin(_ sender: UITextField) {
        createCurrencyPickerView()
    }
    
}

extension SetUpBudgetViewController: UIPickerViewDelegate, UIPickerViewDataSource {     ///////// picker view
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  currencyList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedCurrency = currencyList[row]
    }
}

