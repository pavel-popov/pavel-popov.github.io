---
title: Pushing to multiple remotes with one command
date: 2016-08-14 10:01:00 +03:00
categories:
- til
tags:
- git
---

There's a question on StackOverflow - [Able to push to all git remotes with the one command?][ques].

The solution I fell in love with is to create remote named "all" and place multiple urls there:

    [remote "all"]
    url = origin-host:path/proj.git
    url = nodester-host:path/proj.git
    url = duostack-host:path/proj.git

It works, now I'm able to push my project to all Gitlab, Github and Bitbucket with just one command - `git push all master`, for example.


[ques]: http://stackoverflow.com/questions/5785549/able-to-push-to-all-git-remotes-with-the-one-command