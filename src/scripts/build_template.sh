#!/bin/bash
SHORT_SHA1=$(echo -n "$CIRCLE_SHA1" | head -c 7)
if [ $(echo "$CIRCLE_REPOSITORY_URL" | grep -q "^git@github.com") ]; then
    COMMIT_LINK=\[$SHORT_SHA1\]\(https://github.com/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/commit/$CIRCLE_SHA1\)
elif [ $(echo "$CIRCLE_REPOSITORY_URL" | grep -q "^git@bitbucket.org") ]; then
    COMMIT_LINK=\[$SHORT_SHA1\]\(https://bitbucket.org/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/commits/$CIRCLE_SHA1\)
else
    >&2 echo unknown version control system: "$CIRCLE_REPOSITORY_URL"
    fail
fi
# Note that the "\<<" in the heredoc declaration is escaped from
# CircleCI's parameters syntax.
KEYBASE_MESSAGE_TEMPLATE=$(cat <<END_HEREDOC
    CircleCI Build Notification
    "## __build_status__ $CIRCLE_PROJECT_REPONAME [#${CIRCLE_BUILD_NUM}]($CIRCLE_BUILD_URL)"
    Job: [${CIRCLE_JOB}]($CIRCLE_BUILD_URL)
    Branch: $CIRCLE_BRANCH
    Author: $CIRCLE_USERNAME
    Commit: $COMMIT_LINK
    Message: $CUSTOM_MESSAGE

END_HEREDOC
)
echo "$KEYBASE_MESSAGE_TEMPLATE" > .keybase_message