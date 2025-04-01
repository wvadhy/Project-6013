import Foundation
import OpenAI

struct DeepDiveQuestion: StructuredOutput {
    
    let question: String
    let code: String
    let input: String
    let output: String
    let explanation: String
    let rules: String
    let solution: String
    
    static let example: Self = {
        .init(
            question: "Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.",
            code: """
            def twoSum(self, nums, target):
                return nums - 1 + 5 / 0
            """,
            input: "nums = [2,7,11,15], target = 9",
            output: "[0,1]",
            explanation: "Because nums[0] + nums[1] == 9, we return [0, 1].",
            rules: """
            2 <= nums.length <= 104
            -109 <= nums[i] <= 109
            Only one valid answer exists.
            """,
            solution: """
            class Solution:
                def twoSum(self, nums: List[int], target: int) -> List[int]:
                    for i in range(len(nums)):
                        for j in range(i + 1, len(nums)):
                            if nums[j] == target - nums[i]:
                                return [i, j]
                    # Return an empty list if no solution is found
                    return []
            """
        )
    }()
    
}
