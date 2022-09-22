//
//  CountDownView.swift
//  Timers Sample
//
//  Created by Pablo iOS on 20/9/22.
//

import SwiftUI


 
struct CountDownView: View {
    @ObservedObject var viewModel: TimeControlViewModel
    @Binding var showPicker: Bool
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    var body: some View {
        VStack {
            ZStack{
                
                Circle()
                    .stroke(Color.orange,style: StrokeStyle(lineWidth: 5,lineCap: .round))
                    .frame(width: 280,height: 280)
                Circle()
                    .trim(from: -1,to: viewModel.progress)
                    .stroke(Color.gray, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 280,height: 280)
                    .animation(.easeInOut)
                Text("\(viewModel.time)")
                    .font(.system(size: 50, weight: .medium, design: .rounded))
                
                    .padding()
                    .frame(width: width)
                    .cornerRadius(20)
                   
            
            }
            Spacer()
            
    

            HStack(spacing:50) {
                
                Button {
                    viewModel.start(minutes: viewModel.minutes)
                } label: {
                    Text("Iniciar")
                        .fontWeight(.bold)
                        .padding(10)
                        .foregroundColor(.white)
                      
                }
                .frame(width: 150,height: 50)
                .background(Color.orange)
                .cornerRadius(15)
             
                Button {
                    viewModel.reset()
                    self.showPicker.toggle()
                } label: {
                    Text("Cancelar")
                        .fontWeight(.bold)
                        .padding(10)
                        .foregroundColor(.white)
                      
                }
                .frame(width: 150,height: 50)
                .background(Color.gray)
                .cornerRadius(15)

 
            }
            .frame(width: width)
            
        }
        .padding(.top)
        .onChange(of: viewModel.minutes, perform: { newValue in
            if viewModel.isActive == false{
                viewModel.countTo = Int(viewModel.minutes * 60)
            }
        })
        .onReceive(timer) { time in
            if (viewModel.counter < viewModel.countTo) && viewModel.isActive == true {
                viewModel.counter += 1
                viewModel.updateProgress()
            }
            viewModel.updateCountdown()
        }
        
    }
}
 
struct Clock: View {
    var counter: Int
    var countTo: Int
     
    var body: some View {
        VStack {
            Text(counterToMinutes())
                .font(.system(size: 40))
            Text("counter: \(counter)")
            Text("counterTo: \(countTo)")
        }
    }
     
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
         
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}




