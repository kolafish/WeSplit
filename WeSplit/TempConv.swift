//
//  TempConv.swift
//  WeSplit
//
//  Created by Kola Fish on 2024/6/27.
//

import SwiftUI

struct TempConv: View {
    @State private var temp = 25.0
    @FocusState private var amountIsFocused: Bool
    @State private var inputT = "摄氏度"
    @State private var outputT = "摄氏度"



    let tipPercentages = ["摄氏度", "华氏度", "开氏度"]
    var totalPerPerson: Double {
        var cT = temp
        var outT = cT
        switch inputT {
        case  "华氏度":
            cT = (temp - 32.0) *  5 / 9
        case  "开氏度":
            cT = temp - 273.15
        default:
            cT = temp
        }
        switch outputT {
        case  "华氏度":
            outT = cT *  9 / 5 + 32
        case  "开氏度":
            outT = cT + 273.15
        default:
            outT = cT
        }
        return outT
    }

    
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section("输入温度")  {
                    TextField("温度", value: $temp, format: .number )
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                Section("输入温度单位") {
                    Picker("Tip percentage", selection: $inputT) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("输出温度单位") {
                    Picker("Tip percentage", selection: $outputT) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("输出温度")  {
                    Text(totalPerPerson, format:.number)
                }
                
            }
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    TempConv()
}
