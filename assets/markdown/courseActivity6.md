## Hosting your app on the web

**IMPORTANT NOTE:** The precise steps we use here are not the prefered approach, as it causes us to make all our site content publicly browsable. For the purposes of this class, we will proceed like this regardless.

Before attempting this activity, make sure you have a **make** command available on your system. You can check that from a terminal by typing:

```dart
    make test
```

You are aiming to see the output:

```dart

    Congratulations! You have make installed, and can continue with the activity!

```

### Reminder

If you don't have `make` available and are using Windows, Activity 1 provided a link to download it - come back here once you've downloaded & installed it.

## Steps

[These instructions](https://codewithandrea.com/articles/flutter-web-github-pages/) were originally written by Andrea - they have a lot of good free & paid content available about Flutter.

Next we'll step through the parts of that guide we still need to implement:

1. Open [https://github.com](https://github.com) in a browser
2. Using the Github user interface, update the `Makefile` in our existing `repo` that we `forked` back in Activity 4, so that it contains the line:
```dart
    GITHUB_USER = {username}
```

    where {username} is the Github username you created in Activity 1



3. [Create a new __public__ repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository) or `repo`. The exact name is not too important, but for ease of following these instructions, consider using `cv_demo`
4. In a terminal run the command `make deploy OUTPUT=cv_demo`
5. In a browser, navigate to your [https://github.com/{username}/cv_demo](https://github.com/{username}/cv_demo) `repo`.
6. Navigate to the Settings [https://github.com/{username}/cv_demo/settings](https://github.com/{username}/cv_demo/settings) page, and then to the `Pages` section [https://github.com/{username}/breakthrough_demo/settings/pages](https://github.com/{username}/breakthrough_demo/settings/pages)
7. Use `Deploy from a branch` in `Source`. Choose `main` from the list of branches. Then click `Save`

Your site should now be available at [https://{username}.github.io/cv_demo](https://{username}.github.io/cv_demo) - assuming you did use the recommended `cv_demo` as the name for the second repo we created.

Once you can access that site in your browser, mark this activity complete and move on to the next one.