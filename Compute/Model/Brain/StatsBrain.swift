import Foundation
import Charts

class StatsBrain {
    
    static var shared: StatsBrain = StatsBrain()
    
    var correct: Int = 15
    var total: Int = 20
    
    init(){
        Task {
            let tempCorrect = await CodeRushBrain.shared.getTotalCorrect()
            let tempTotal = await CodeRushBrain.shared.getTotal()
            
            correct = Int(tempCorrect)!
            total = Int(tempTotal)!
        }
    }
        
    func createLineChart() -> LineChartView {
        
        var chartEntries: [ChartDataEntry] = [ChartDataEntry]()
        
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
    
    func createPieChart() -> PieChartView {
        
        var entries: [ChartDataEntry] = [ChartDataEntry]()
        
        let pieChart = PieChartView()
        
        pieChart.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        
        entries.append(ChartDataEntry(x: Double(correct), y: Double(correct)))
        entries.append(ChartDataEntry(x: Double(total) - Double(correct),
                                      y: Double(total) - Double(correct)))
        
        let set = PieChartDataSet(entries: entries)
        set.colors = [.mainColour, .accent]
        let data = PieChartData(dataSet: set)
        
        pieChart.legendRenderer.legend?.enabled = false
        data.setDrawValues(false)
        
        pieChart.data = data
        
        return pieChart
    }
    
    func createBarChart() -> BarChartView {
        
        var barEntries: [BarChartDataEntry] = [BarChartDataEntry]()
        
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
