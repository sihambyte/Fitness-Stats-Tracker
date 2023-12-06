//  ChartView.swift
//  Fitness Stats Tracker
//
//  Created by siham on 11/30/23.
//

import SwiftUI

struct ChartView: View {
    
    let values: [Int]
    let labels: [String]
    let xAxisLabels: [String]
    
    var body: some View {
        GeometryReader { geo in
            
            HStack(alignment: .bottom) {
                ForEach(values.indices, id: \.self) { idx in
                    let max = values.max() ?? 0
                    
                    VStack {
                        Text(labels[idx])
                            .font(.caption)
                            .padding(.bottom,5)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.blue)
                            .frame(width: 25, height: CGFloat(values[idx]) / CGFloat(max) * geo.size.height * 0.6)
                        
                        Text(xAxisLabels[idx])
                            .font(.caption)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white) // Set background to white
            .overlay(
                VStack(spacing: geo.size.height / 6) {
                    ForEach(1..<6) { _ in
                        // Light horizontal grid lines
                        Rectangle()
                            .foregroundColor(Color.primary.opacity(0.2))
                            .frame(height: 1)
                    }
                }
                .frame(maxHeight: .infinity),
                alignment: .trailing
            )

            .cornerRadius(10)
            .padding(.bottom, 20)
            
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let values = [213, 343, 3, 3, 344, 435, 342, 30]
        let labels = ["213", "343", "3", "3", "344", "435", "342", "30"]
        let xAxisValues = ["May 30", "May 31", "June 1", "June 2", "June 3", "June 4", "June 5", "June 6"]
        ChartView(values: values, labels: labels, xAxisLabels: xAxisValues)
    }
}
