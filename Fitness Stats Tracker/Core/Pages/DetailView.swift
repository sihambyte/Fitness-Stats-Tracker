//
//  DetailView.swift
//  Fitness Stats Tracker
//
//  Created by siham on 11/30/23.
//

import SwiftUI

struct DetailView: View {
    
    var activity: Activity
    var repository: HKRepository
    @ObservedObject var viewModel: DetailViewModel
    
    
    init(activity: Activity, repository: HKRepository) {
        self.activity = activity
        self.repository = repository
        
        viewModel = DetailViewModel(activity: activity, repository: repository)
    }
    
    var body: some View {
        ChartView(values: viewModel.stats.map {viewModel.value(from: $0.stat).value }, labels: viewModel.stats.map {viewModel.value(from: $0.stat).desc }, xAxisLabels: viewModel.stats.map { DetailViewModel.dateFormatter.string(from: $0.date)})
        
        List(viewModel.stats) { stat in
            VStack(alignment: .leading) {
                Text(viewModel.value(from: stat.stat).desc)
                Text(stat.date, style: .date).opacity(0.5)
            }
        }
        .navigationBarTitle("\(activity.name) \(activity.image)", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(activity: Activity(id: "Steps", name: "Steps", image: "👣", goal: 2000), repository: HKRepository())
    }
}
