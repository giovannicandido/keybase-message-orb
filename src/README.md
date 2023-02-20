# Keybase Message Org

Send messages to keybase.io team channels.

This orb offers two jobs:

* send-message: sends a unformated message
* report: gets environment information like commit author and message and send to keybase

Both have the same options:

* team_name: the name of the team in keybase
* channel_topic: channel topic to send
* only_on_fail: if true will send the message only on fail builds
* message: the custom message to send

Not that this orb needs a context with the variables:

* KEYBASE_USERNAME: the bot username
* KEYBASE_PAPERKEY: the bot paper key to authentiation

## How to create your bot keys

To create a bot use the following:

```
keybase bot token create > /tmp/bot_token
keybase --standalone --home=/tmp/bot bot signup -u bot_name_here -t $(cat /tmp/bot_token) > paper-key
```
You can test using:

```
docker run --rm -it -e KEYBASE_USERNAME=bot_username -e KEYBASE_PAPERKEY="$(cat paper-key)" -e CHANNEL_NAME="team" -e CHANNEL_TOPIC=buildstatus -e MESSAGE="this is another test message sended from bot" ghcr.io/giovannicandio/kugelbit-message-bot
```

# Orb Source

Orbs are shipped as individual `orb.yml` files, however, to make development easier, it is possible to author an orb in _unpacked_ form, which can be _packed_ with the CircleCI CLI and published.

The default `.circleci/config.yml` file contains the configuration code needed to automatically pack, test, and deploy any changes made to the contents of the orb source in this directory.

## @orb.yml

This is the entry point for our orb "tree", which becomes our `orb.yml` file later.

Within the `@orb.yml` we generally specify 4 configuration keys

**Keys**

1. **version**
    Specify version 2.1 for orb-compatible configuration `version: 2.1`
2. **description**
    Give your orb a description. Shown within the CLI and orb registry
3. **display**
    Specify the `home_url` referencing documentation or product URL, and `source_url` linking to the orb's source repository.
4. **orbs**
    (optional) Some orbs may depend on other orbs. Import them here.

## See:
 - [Orb Author Intro](https://circleci.com/docs/2.0/orb-author-intro/#section=configuration)
 - [Reusable Configuration](https://circleci.com/docs/2.0/reusing-config)
