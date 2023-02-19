sed -e 's/__build_status__/FAILED/' -e 's/__theme_color__/14a603/' .keybase_message > .keybase_message
export MESSAGE=`cat .keybase_message`
node /app/out/main.js