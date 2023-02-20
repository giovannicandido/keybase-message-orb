sed -e 's/__build_status__/SUCCESS/g' -e 's/__theme_color__/14a603/g' -i .keybase_message
export MESSAGE=`cat .keybase_message`
echo "sending message: "
echo ${MESSAGE}
node /app/out/main.js