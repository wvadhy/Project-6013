import Foundation
import FirebaseFirestore

class Context {
    
    static var shared: Context = Context()
    var body: String = ""
    
    init(){
        Task {
            do {
                let querySnapshot = try await Database.store.collection("users").document("\(UserData.shared.user!.uid)").getDocument()
                if(querySnapshot.exists) {
                    body =
                    """
                    for context:
                    
                    Compute is an AI powered programming study buddy mobile app which employs gamfication and personalised
                    user experiences with the help of large language models. It aims to supplement users programming and create
                    a competitive environment from which users can compete with one another and compare their stats.
                    
                    Code-Rush is a task which consists of a series of multiple choice questions
                    of a specific difficulty and for a specific programming language. These questions will ask you to select
                    the correct answer from the three choices you are given. A score is given for every correct answer given
                    by the user.
                    
                    Deep-Dive is task which consists of a series of in-depth of questions
                    of a specific difficulty and for a specific programming language. These questions task the user
                    with refactoring or creating snippets of code. These snippets are then analysed and a score is given
                    based upon its accuracy.
                    
                    Gold is earned by completing tasks like deep-dive or code-rush, the gold acquired upon completion of tasks
                    is dependent on the users rank and difficulty of the task, the higher the users rank or difficulty the more gold
                    obtained from the task.
                    
                    Points are a total accumulation of tasks completed.
                    
                    Users can obtain badges by meeting specific requirements, these range from completing specific numbers of tasks or by
                    reaching certain rank and gold goals.
                    
                    Users can climb the leaderboard by earnining more points.
                    
                    Compute consists of 5 seperate tabs. A tasks tab where all current daily tasks and categorised tasks are displayed.
                    A stats tab where users can see their progress reflected in stats and charts real time and also search up other users
                    to track their progress too. A feedback tab where feedback is given according to the users current progress in the app.
                    A leaderboard tab where the highest scoring users will be displayed. A account tab where important account information
                    and settings are stored such as enable push notifications, change password, change course.
                    
                    Do not refer to Compute as The Compute App or Compute app, just refer to it as Compute.
                    
                    My gold is \(querySnapshot.data()!["gold"] as! Int),
                    My pointsTotal is \(querySnapshot.data()!["pointsTotal"] as! Int),
                    My totalGamesPlayed is \(querySnapshot.data()!["totalGamesPlayed"] as! Int),
                    My codeRushPlayed is \(querySnapshot.data()!["codeRushPlayed"] as! Int),
                    My codeRushHighScore is \(querySnapshot.data()!["codeRushHighScore"] as! Int),
                    My codeRushCorrect is \(querySnapshot.data()!["codeRushCorrect"] as! Int),
                    My codeRushAverage is \(querySnapshot.data()!["codeRushAverage"] as! Double),
                    My codeRushTotal is \(querySnapshot.data()!["codeRushTotal"] as! Int),
                    My deepDivePlayed is \(querySnapshot.data()!["deepDivePlayed"] as! Int),
                    My deepDiveHighScore is \(querySnapshot.data()!["deepDiveHighScore"] as! Int),
                    My deepDiveCorrect is \(querySnapshot.data()!["deepDiveCorrect"] as! Int),
                    My deepDiveAverage is \(querySnapshot.data()!["deepDiveAverage"] as! Double),
                    My deepDiveTotal is \(querySnapshot.data()!["deepDiveTotal"] as! Int),
                    My codeRushAverageRuby is \(querySnapshot.data()!["codeRushAverageRuby"] as! Double),
                    My codeRushTotalRuby is \(querySnapshot.data()!["codeRushTotalRuby"] as! Int),
                    My deepDiveAverageRuby is \(querySnapshot.data()!["deepDiveAverageRuby"] as! Double),
                    My deepDiveTotalRuby is \(querySnapshot.data()!["deepDiveTotalRuby"] as! Int),
                    My codeRushAverageCpp is \(querySnapshot.data()!["codeRushAverageCpp"] as! Double),
                    My codeRushTotalCpp is \(querySnapshot.data()!["codeRushTotalCpp"] as! Int),
                    My deepDiveAverageCpp is \(querySnapshot.data()!["deepDiveAverageCpp"] as! Double),
                    My deepDiveTotalCpp is \(querySnapshot.data()!["deepDiveTotalCpp"] as! Int),
                    My codeRushAverageJava is \(querySnapshot.data()!["codeRushAverageJava"] as! Double),
                    My codeRushTotalJava is \(querySnapshot.data()!["codeRushTotalJava"] as! Int),
                    My deepDiveAverageJava is \(querySnapshot.data()!["deepDiveAverageJava"] as! Double),
                    My deepDiveTotalJava is \(querySnapshot.data()!["deepDiveTotalJava"] as! Int),
                    My codeRushAverageLua is \(querySnapshot.data()!["codeRushAverageLua"] as! Double),
                    My codeRushTotalLua is \(querySnapshot.data()!["codeRushTotalLua"] as! Int)
                    My deepDiveAverageLua is \(querySnapshot.data()!["deepDiveAverageLua"] as! Double)
                    My deepDiveTotalLua is \(querySnapshot.data()!["deepDiveTotalLua"] as! Int)
                    My codeRushAveragePython is \(querySnapshot.data()!["codeRushAveragePython"] as! Double)
                    My codeRushTotalPython is \(querySnapshot.data()!["codeRushTotalPython"] as! Int)
                    My deepDiveAveragePython is \(querySnapshot.data()!["deepDiveAveragePython"] as! Double)
                    My deepDiveTotalPython is \(querySnapshot.data()!["deepDiveTotalPython"] as! Int)
                    My codeRushAverageJs is \(querySnapshot.data()!["codeRushAverageJs"] as! Double)
                    My codeRushTotalJs is \(querySnapshot.data()!["codeRushTotalJs"] as! Int)
                    My deepDiveAverageJs is \(querySnapshot.data()!["deepDiveAverageJs"] as! Double)
                    My deepDiveTotalJs is \(querySnapshot.data()!["deepDiveTotalJs"] as! Int)
                    My pythonScore is \(querySnapshot.data()!["pythonScore"] as! Int)
                    My rubyScore is \(querySnapshot.data()!["rubyScore"] as! Int)
                    My cppScore is \(querySnapshot.data()!["cppScore"] as! Int)
                    My javaScore is \(querySnapshot.data()!["javaScore"] as! Int)
                    My jsScore is \(querySnapshot.data()!["jsScore"] as! Int)
                    My luaScore is \(querySnapshot.data()!["luaScore"] as! Int)
                    My rank is \(querySnapshot.data()!["rank"] as! Int)
                    """
                }
            } catch {
                print("Error getting document: \(error)")
            }
        }
        
    }
    
}
