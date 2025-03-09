import Foundation
import Charts

struct StatsBrain {
    
    var entries = [ChartDataEntry]()
    var barEntries = [BarChartDataEntry]()
    var chartEntries = [ChartDataEntry]()
    
    mutating func createLineChart() -> LineChartView {
        
        let lineChart = LineChartView()
        
        lineChart.frame = CGRect(x: 0, y: 0, width: 338, height: 147)
            
        for i in 1...10 {
            chartEntries.append(ChartDataEntry(x: Double(i), y: Double(i)))
        }
        
        let set = LineChartDataSet(entries: chartEntries)
        set.colors = [UIColor.mainColour, UIColor.accent]
        let data = LineChartData(dataSet: set)
        
        lineChart.legendRenderer.legend?.enabled = false
        data.setDrawValues(false)
        
        lineChart.data = data
        
        return lineChart
    }
    
    mutating func createPieChart() -> PieChartView {
        
        let pieChart = PieChartView()
        
        pieChart.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        
        entries.append(ChartDataEntry(x: Double(CodeRushBrain.shared.totalCorrect), y: Double(CodeRushBrain.shared.totalCorrect)))
        entries.append(ChartDataEntry(x: Double(CodeRushBrain.shared.totalCorrect) - Double(CodeRushBrain.shared.totalCorrect),
                                      y: Double(CodeRushBrain.shared.totalCorrect) - Double(CodeRushBrain.shared.totalCorrect)))
        
        let set = PieChartDataSet(entries: entries)
        set.colors = [.mainColour, .accent]
        let data = PieChartData(dataSet: set)
        
        pieChart.legendRenderer.legend?.enabled = false
        data.setDrawValues(false)
        
        pieChart.data = data
        
        return pieChart
    }
    
    mutating func createBarChart() -> BarChartView {
        
        let barChart = BarChartView()
        
        barChart.frame = CGRect(x: 0, y: 0, width: 348, height: 232)
        
        for i in 1...10 {
            barEntries.append(BarChartDataEntry(x: Double(i), y: Double(i)))
        }
        
        let setTwo = BarChartDataSet(entries: barEntries)
        setTwo.colors = [.mainColour, .accent]
        let dataTwo = BarChartData(dataSet: setTwo)
        
        barChart.data = dataTwo
        
        return barChart
    }
    
}
