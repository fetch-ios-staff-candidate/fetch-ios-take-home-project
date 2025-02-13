### Summary: Include screen shots or a video of your app highlighting its features

https://github.com/user-attachments/assets/d4912053-061d-45cd-a6cc-9316a32df35d

---
### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

###### My biggest priorities no matter what project I am working on is to ensure that the codebase is clean, maintablable, and easy to understand at all times. I focused on the following aspects:

1. **Readability:** I followed consistent naming conventions for variables, functions, and classes. I am a huge believer that great code is self-documenting, meaning that anyone reading it can easily understand the purpose of each part without requiring extensive comments or explanations.

2. **Modularization:** I broke the code into smaller, reusable components and methods. By focusing on modularity, I made sure that each component could be tested independently and reused elsewhere in the app if it ever needed to be, which promotes scalability and reduces redundancy. I realize for a small app like this, that modularization might be considered overkill and "pre-optimized", but for larger apps, this is 100% a necessity to keep build times minimized as much as possible.

3. **Separation of Concerns:** I used principles like *Single Responsibility* and *Separation of Concerns* to ensure that each component or class had a clear and focused role. This reduces unnecessary complexity and makes it easier to test and maintain the codebase over time.

4. **Maintainability:** In a perfect world, developers would stay at the same company forever. However, we know that is not the case which makes maintainability a huge deal. The code is structured in a way that future developers (including myself) can easily update and extend the app without worrying about inadvertently breaking other parts of the system. This was achieved by following best practices for architecture (MVVM) and keeping dependencies manageable.

###### Being also heavy product and design-minded, I prioritized creating a user interface (UI) that is both visually appealing and intuitive to use. I focused on the following key areas to achieve this:

1. **User Experience Focus:** I always like to put myself in the shoes of the end user to ensure the app feels natural and effortless to navigate. The end goal is always to make it feel intuitive. 

2. **Visual Design:** The color palette and typography were all inspired by the Fetch app. The goal was to make the design clean, cohesive, and visually engaging. I focused on using design patterns and UI elements that are familiar and easy to understand for most users. 

3. **Design System:** If you look at the *DesignSystem* module, you will see that I started to stub out what a resuable and scalable design system might look like for this app. You will see use of *TextStyle's* and *ButtonStyle's* to allow engineering teams to quickly apply styles to common elements such as *Text's* and *Button's*. The beauty about using this is, if the app ever needs a redesign, then all that needs updated are the modularized styles. Doing this also allows easily supporting both light and dark mode themes.

---
### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

###### In total, I put in just a little over 9 hours for this project. Here was the breakdown:

1. Understanding the requirements and creating a list of subtasks that needed achieved to get me to the finish line. This allowed me to easily manage the project and see what else needed done: **1 hour**

2. Writing all of the code (not including tests): **6 hours**

3. Writing tests for the code: **0.5 hours**

4. Writing this README: **1.5 hours**


---
### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

###### Complexity vs. Built-in APIs

**Trade-off:** Manually managing image caching increases code complexity compared to using several 3rd party libraries that do image caching really well.

**Decision:** Avoided 3rd party libraries to meet the requirements.

###### Memory vs. Storage Efficiency:

**Trade-off:** Storing images in memory (using NSCache inside `ImageCache`) improves performance but increases memory usage. However, storing them on disk reduces memory consumption but increases retrieval time.
	
**Decision:** Used both memory (for fast access) and disk caching (for persistence) to balance speed and efficiency.

###### Storage Size vs Persistence

**Trade-off:** Images stored on disk persist between app launches, but they may consume significant storage over time which some users tend to find frustrating. (We have this issue here at Marco Polo 😀)

**Decision:** Implemented a file-based caching system but did not implement cache-clearing (when it gets above a certain threshold) as an automatic process.

---
### Weakest Part of the Project: What do you think is the weakest part of your project?

###### Overall, I'm really happy with how this project turned out and was structured. But to me, the weakest part would be the image caching mechanism. There are so many improvements that could be made to it with enough time but due to the nature of the project, I thought it would be more beneficial to work on the rest of the app instead. Here are some of the issues I see with the current image cache mechanism in place:

1. **No Expiration or Invalidation Mechanism**: Cached images never expire which means old or stale images could persist indefinitely, leading to outdated images. With enough time, it would be nice to implement a time-based eviction system such as storing a timestamp with each image and delete files older than a set duration
	
2. **Storage Growth Over Time**: The disk cache will continuously grow as new images are saved, potentially consuming a lot of space. In return, this could lead to performance issues and frustrated customers (as mentioned above) wondering why the app is using so much storage. With enough time, it would be nice to introduce a size-based limit and delete the least recently used files when cache size exceeds a threshold.
	
3. **No Logging or Event Tracking Infrastrucutre:** Prouction ready apps have logging and event tracking all over the place (logging failures, logging which network requests that are being made by a certain user, etc...) which allows to gain extremely valuable insights on if the app is performing as expected and allows to track down issues when they arise. This is something I intentially left out due to time but something I would never leave out in a real production ready app. 


---
### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

1. I had a really hard time spelling Recipe! My brain always wanted to do Recipie! 😅
2. All joking aside, I really enjoyed working on this project. The requirements were clear and I was not confused at any time on what you might be looking for. I have a huge respect for companies who prefer take home projects vs a single in-person LeetCode interview as the take home projects mimic real world scenarios and not algorithm trivia and allow the developer to showcase their true skillets without a tough time constraint.
