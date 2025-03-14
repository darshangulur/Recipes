#  Recipes App

### Summary: Include screen shots or a video of your app highlighting its features
[Demo Video](https://drive.google.com/file/d/1DEjXeiFC_dYhyCPziOpHRHacofihaAFv/view?usp=share_link)

- Lists all the recipes from the given API source
- Allows user to filter Recipes by Cuisine using the stacked buttons at the top of the screen
- Allows user to Tap on YouTube or Source links on each of the Recipe for a detailed info about the recipe
- Caches Images using `NSCache`
- The implementation follows MVVM design pattern
- Has a code coverage of 93%, that covers Network, Data Model and View Model layers.
- Potential Future Updates
    - Detail page for the Recipe with an embedded video and other meta data
    - Favorite feature to favorite a Recipe and introduce a filter button for filtering just the favorites
    - For scalability, improvise backend API to support Pagination using index and count URL Query params
    - Add Snapshot tests to the UI layer - making it easy to test,
        - Scalability for various form factors
        - Localization support
        - Different layout directions e.g. Right-to-Left for Arabic
        - Dark vs Light modes

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
The app has a minimalistic design. I prioritized on having a solid architecture design using MVVM design pattern that provides good separation of concerns between the layers. The layers follow protocol oriented architecture to provide high Scalability, Testability and Reusability. Each of the layers follow SOLID design principles. It is evident from the fact that the app has a code coverage of 100%, excluding the UI layers.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent about 12 hours overall.
- UI: 3 hours
- MVVM: 4 hours
- Unit Tests: 3 hours
- Optimizing usage of Structured Concurrency: 0.5 hours
- Deliverables prep: 1.5 hours

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
- I emphasized on having a solid architecture design, while not spending too much time on building a feature rich app. Having a good architecture helps build a lot features with less buggy code, crashes and developer errors.

### Weakest Part of the Project: What do you think is the weakest part of your project?
- UI Layer, as it is not a feature rich app and affects user retention.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
- NA
