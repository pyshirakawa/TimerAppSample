//
//  ContentView.swift
//  Timers Sample
//
//  Created by Pablo iOS on 20/9/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = TimeControlViewModel()
    
    @State var selectedTab: Int = 1
    @State var selection: [String] = [0, 0, 0].map { "\($0)" }
    @State var showPicker: Bool = true
    @State var data: [(String, [String])] = [
        ("h", Array(0...8).map { "\($0)" }),
        ("min", Array(0...59).map { "\($0)" }),
        ("s", Array(0...59).map { "\($0)" })
    ]
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                Text("Cronómetro")
                    .bold()
                    .disabled(true)
                    .tag(0)
                Text("Temporizador")
                    .bold()
                    .tag(1)
                Text("Intervalos")
                    .bold()
                    .disabled(true)
                    .tag(2)
            }.pickerStyle(SegmentedPickerStyle())
                .padding()
            
            
            self.selectedTab == 0 ? AnyView(EmptyView()) : self.showPicker == true ?  AnyView(HorizontalTimePicker(viewModel: self.viewModel, selection: self.$selection, showPicker: self.$showPicker, data: self.$data)) : AnyView(CountDownView(viewModel: self.viewModel, showPicker: self.$showPicker))
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
