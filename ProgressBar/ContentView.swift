//
//  ContentView.swift
//  ProgressBar
//
//  Created by Sanjeev Bharti on 10/25/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var percentage: CGFloat = 0.0
    
    var body: some View {
        
        Spacer()
        VStack(spacing: 40) {
            
            batteryView.frame(height: 50)
            
            batteryView.frame(width: UIScreen.main.bounds.size.width - 100, height: 40)
            
            batteryView.frame(width: 60.0, height: 20)

            batteryView.frame(width: 40.0, height: 20)
            
            Spacer()
            
            // Footer View
            HStack {
                Button(" - ") {
                    if percentage <= 0 {
                        percentage = 0
                        return
                    } else {
                        percentage -= 0.1
                    }
                }
                
                Text("Increase")
               
                Button(" + ") {
                    if percentage >= 100 {
                        percentage = 100
                        return
                    }
                    percentage += 0.1
                }
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: DispatchWorkItem(block: {
                percentage = 0.3
            }))
        })
        .padding()
    }
    
    // Progress View
    var progressView: some View {
        RoundedRectangle(cornerRadius: 3)
            .stroke(.white, lineWidth: 2.0)
            .padding(2.0)
            .background {
                GeometryReader { geometry in
                    HStack {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(.green)
                            .frame(width: geometry.size.width * percentage)
                            .animation(.bouncy, value: percentage)
                    }
                }
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 3)
            )
    }
    
    private var batteryView: some View {
        HStack {
            GeometryReader(content: { geometry in
                
                // Tank View (It is 94% of entire view width)
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.black)
                    .frame(width: geometry.size.width * 0.94)
                    .padding(1)
                    .background {
                        progressView
                    }
                
                /* Cap View (It is 5% of entire view width,
                                   remaining 1% is horizontal space between these two controls) */
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.black)
                        .frame(width: geometry.size.width * 0.05, height: geometry.size.height * 0.4,
                               alignment: .center)
                        .offset(y: geometry.size.height/3.5) // keep Cap view vertically centered
                }
            })
        }
    }

}

#Preview {
    ContentView()
}
