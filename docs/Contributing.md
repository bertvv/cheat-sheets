# Contributing to a Github project

How to create a pull request that causes no pain to the maintainer.

## Setting up your local development environment

1. Fork the Github repo
2. Clone it on your development machine
3. Add upstream repository as a remote


Consider the master branch to be "property" of the upstream project. **Never** work on the master branch directly, but create a branch, e.g.:

```
git checkout -b feature/add-widgets
git checkout -b bugfix/gh-45
```

Working on the master branch directly will cause merge conflicts, and a messy history when you fetch new code from upstream and integrate it with your own code.

## Working locally

1. Every time you start working on the code, it's important to be sure you have the latest from upstream:

    ```
    git pull upstream master
    ```

2. Rebase your local branch onto the master branch:

    ```
    git rebase master
    ```

3. Resolve any conflicts and commit
4. Do your own work, commit
5. Push to your own fork

    ```
    git push
    ```

## Sending the pull-request

## Resources

- <https://help.github.com/articles/about-pull-request-merges/>

