### Steps to Run the App

	1 Clone the Repository: Ensure you have the project files and dependencies.
	2 Open in Xcode: Open the .xcodeproj or .xcworkspace file in Xcode (iOS 16 or later).
	3 Configure Build Target: Set the build target to an iOS device or simulator running iOS 16 or later.
	4 Run the App: Click the Run button (Command + R) to launch the app in the simulator.
	5 Interact with the App:
	  - View the list of recipes from the API.
	  - Pull to refresh the list, which introduces a 3-second delay.
	  - Use the search bar to find recipes by name.
	  - Tap a recipe to navigate to its detail view.
	  - Handle errors gracefully, including malformed or empty data.

## Focus Areas
```
1 Error Handling and Resilience
	•	Prioritized robust error handling for malformed and empty data.
	•	Ensured the app gracefully displays errors and fallback states without crashing.
	•	Allowed the app to recover with retry options.

2. User Interface and Experience
	•	Focused on building an attractive and user-friendly UI.
	•	Added features like pull-to-refresh, search, and a clear navigation structure.
	•	Included dynamic handling of states such as loading, empty, and error states.

3. Scalability and Maintainability
	•	Used a ViewModel pattern to separate business logic from the UI for testability.
	•	Created reusable components like RecipeCardView and RecipeDetailView.

4. Test Coverage
	•	Implemented unit tests to verify the functionality of the ViewModel. Covered edge cases like malformed and empty data responses.
```

## Time Spent

	- Total Time: Approximately 6 hours.
	- Time Allocation:
	1 Service layer, caching, view Model: ~3 hours.
	2 User Interface Development: ~1:30 hours.
	3 Testing and Debugging: ~30`hours.
	4 Refinements and Documentation: ~1 hour.

## Trade-offs and Decisions

	1 Using Mock Data for Tests:
	    - Chose mock services for unit tests to simulate API behavior.
	    - Avoided integration tests to save time, focusing on isolated component testing.
	2 UI Simplification:
	    - Kept the UI minimal (single screen with navigation) to meet the project requirements without over-engineering.
	3 Ignoring Partial Data:
    	- Decided to disregard entire lists if malformed rather than attempting partial recovery, ensuring consistent behavior.
	4 Delayed Advanced Features:
    	- Features like pagination, caching, and favorites were excluded due to time constraints.

## Weakest Part of the Project
```
	- Error Recovery for Malformed Data:
 	- The Attempt to split the environment seem weak, I didn't want to allocate too much time to it otherwise I think it be significantly improved
	- Currently, malformed data results in the entire list being discarded. Handling partial recovery (e.g., skipping malformed entries) could improve resilience)
  - The unit is functional enough with a coverage of core functionalities but could be more thourough with a larger mock data set and more test.
  - Limited Aesthetic Customization:
	- While the UI is functional and clean, it could benefit from additional styling like animations or custom fonts to enhance appeal.
```

## Additional Information
```
	1 Constraints:
	    - Limited time required in balancing functionality and polish.
    	- Focused on meeting core requirements rather than adding advanced features.
	2 Future Improvements:
    	- Add pagination for large datasets.
	    - Implement user preferences, such as saving favorite recipes.
	    - Enhance UI with animations and transitions for a more dynamic feel.
	3 Insights:
    	- The searchable modifier and refreshable API in SwiftUI significantly simplify implementing search and refresh functionality.
	    - Separating logic into the ViewModel makes testing and debugging easier and ensures a clean UI layer.
```
