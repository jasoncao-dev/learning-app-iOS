//
//  ContentModel.swift
//  Learning App
//
//  Created by Jason Cao on 4/20/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current lesson explanation
    @Published var lessonDescription = NSAttributedString()
    
    // Current selected content and test
    @Published var currentContentSelected: Int?
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    // MARK: - Data methods:
    
    func getLocalData() {
        // Get a url to the JSON file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode JSON into an array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // Assign parsed modules to modules property
            self.modules = modules
        }
        catch {
            // TODO log error
            print("Error: Reading file throws error")
        }
        
        // Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            // Read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
            
        } catch {
            print("Error: Could not parse style data")
        }
    }
    
    // MARK: - Module navigation methods:
    func beginModule(_ moduleId: Int) {
        // Find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                // Found the matching module
                currentModuleIndex = index
                break
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex: Int) {
        // Check that the lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else {
            currentModuleIndex = 0
        }
        
        // Set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        // Advance the lesson
        currentLessonIndex += 1
        
        // Check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        } else {
            // Reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool {
        return currentLessonIndex + 1 < currentModule!.content.lessons.count
    }
    
    // MARK: Code styling
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        // Add the styling data
        if styleData != nil {
            data.append(styleData!)
        }
        
        // Add the HTML data
        data.append(Data(htmlString.utf8))
        
        // Convert to attributed string
        /*
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            resultString = attributedString
        }
        catch {
            print("Could not turn html into attributed string")
        }
         */
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        }
        
        return resultString
    }
}
