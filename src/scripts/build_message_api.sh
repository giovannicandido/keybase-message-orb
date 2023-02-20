#!/bin/bash
echo "The env username is is: ${KB_USERNAME}"
echo "The env paperkey is is: ${KB_PAPERKEY}"
SHORT_SHA1=$(echo -n "$CIRCLE_SHA1" | head -c 7)
if [ "$(echo $CIRCLE_REPOSITORY_URL | grep ^git@github.com)" ]; then
    COMMIT_LINK=[$SHORT_SHA1]\(https://github.com/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/commit/$CIRCLE_SHA1\)
elif [ "$(echo $CIRCLE_REPOSITORY_URL | grep ^git@bitbucket.org)" ]; then
    COMMIT_LINK=[$SHORT_SHA1]\(https://bitbucket.org/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/commits/$CIRCLE_SHA1\)
else
    >&2 echo unknown version control system: "$CIRCLE_REPOSITORY_URL"
    fail
fi

KEYBASE_MESSAGE_TEMPLATE=$(cat <<END_HEREDOC
    CircleCI Build Notification
    "## __build_status__ "$CIRCLE_PROJECT_REPONAME" [#${CIRCLE_BUILD_NUM}]("$CIRCLE_BUILD_URL")"
    Job: [${CIRCLE_JOB}]("$CIRCLE_BUILD_URL")
    Branch: "$CIRCLE_BRANCH"
    Author: "$CIRCLE_USERNAME"
    Commit: "$COMMIT_LINK"
    Message: "$CUSTOM_MESSAGE"

END_HEREDOC
)

KEYBASE_MESSAGE_API=$(cat <<END_HEREDOC
    {
        "method": "send",
        "params": {
           "options": "options": {"channel": {"name": "${CHANNEL_NAME}", "members_type": "team", "topic_type": "chat", "public": false, "topic_name": "${CHANNEL_TOPI}"},
           "message": {"body": "${KEYBASE_MESSAGE_TEMPLATE}"}}
        }
    }        
END_HEREDOC
)

echo "$KEYBASE_MESSAGE_TEMPLATE" > .keybase_message
echo "$KEYBASE_MESSAGE_TEMPLATE" > message.json