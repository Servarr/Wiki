# Why?

  - Because UI components are cached by the browser, changes involving these components can end up using old versions cached locally instead of new. Because of the rapid pace of development and the high amount of UI churn, this is an occasional problem.

# How?

  - Chrome: [Clear cache and cookies](https://support.google.com/accounts/answer/32050)
  - Firefox: [How to clear the Firefox cache](https://support.mozilla.org/en-US/kb/how-clear-firefox-cache)
  - Safari: [Manage cookies and website data using Safari](https://support.apple.com/en-in/guide/safari/sfri11471/mac)

# Prove

  - Proving this issue is the cause of your problem is very easy, just open Radarr in a Chrome Incognito Window or a Firefox Private Window. If it works there, this is your problem.

# Tools

  - In Firefox, you can go to History, right click on the correct entry and choose *Forget About This Site*.

![Firefox Forget About This Site](Clear-Cache-Cookies-and-Local-Storage1.png "Firefox Forget About This Site")

  - The [Clear Cache](https://chrome.google.com/webstore/detail/clear-cache/cppjkneekbjaeellbfkmgnhonkkjfpdn) extension for Chrome can be used to quickly clear your cookies, cache and local storage. Use the example image below to configure it correctly.

![Clear Cache Example Settings](Clear-Cache-Cookies-and-Local-Storage2.png "Clear Cache Example Settings")
