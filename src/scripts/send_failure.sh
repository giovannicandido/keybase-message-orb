sed -i 's/__build_status__/FAILED/' -i 's/__theme_color__/14a603/' .keybase_message
export MESSAGE=`cat .keybase_message`
echo "sending message: "
echo ${MESSAGE}
node /app/out/main.js