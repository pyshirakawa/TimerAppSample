//
//  HorizontalTimePicker.swift
//  Timers Sample
//
//  Created by Pablo iOS on 21/9/22.
//

import SwiftUI

struct HorizontalTimePicker: View {
    
    @ObservedObject var viewModel: TimeControlViewModel

    @Binding var selection: [String]
    @Binding var showPicker: Bool
    @Binding var data: [(String, [String])]
    @State var disabledFooterButton: Bool = false
    var body: some View {
        VStack {
            
          

            HStack {
                ForEach(0..<self.data.count) { column in
                    Spacer()
                    VStack {
                        Text(self.data[column].0)
                            .frame(width: 50, height:50)
                            .padding(.vertical)
                        
                        Picker(self.data[column].0, selection: self.$selection[column]) {
                            ForEach(0..<self.data[column].1.count) { row in
                                Text(verbatim: self.data[column].1[row])
                                .tag(self.data[column].1[row])
                            }
                        }
                        .pickerStyle(.wheel)
                        .labelsHidden()
                        .frame(width: 90, height: UIScreen.main.bounds.width * 0.3)
                        .clipped()
                        
                    }
                    .clipped()
                    Spacer()
                   
                }
            }
            
            Spacer()
                        
            Button(action: {
                print(self.selection)
                if self.selection[0] == "0"{
                    self.viewModel.time = "\(self.selection[1]):\(Int(self.selection[2]) ?? 0 < 10 ? "0"+self.selection[2] : self.selection[2] )"
                    self.viewModel.countTo = (Int(self.selection[1]) ?? 0) * 60 + (Int(self.selection[2]) ?? 0)
                    self.viewModel.start(minutes: Float(self.viewModel.countTo / 60))
                }else{
                    self.viewModel.time = "\(self.selection[0]):\(self.selection[1]):\(self.selection[2])"
                    self.viewModel.countTo = ((Int(self.selection[1]) ?? 0) * 60  + (Int(self.selection[1]) ?? 0) ) * 60 + (Int(self.selection[2]) ?? 0)
                    self.viewModel.start(minutes: Float(self.viewModel.countTo / 60))
                }
                
                self.showPicker.toggle()
            }) {
                Text("Iniciar")
                    .fontWeight(.semibold)
                    .frame(width: UIScreen.main.bounds.width * 0.95, height: 50)
                    .background(Color.orange)
                    .cornerRadius(5)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 50)
            }
                        
        }
        // Fin
    }
}

extension UIPickerView {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}
