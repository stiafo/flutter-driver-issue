if [ "$CONFIGURATION" == "Debug-dev" ] || [ "$CONFIGURATION" == "Release-dev" ]; then
    cp Runner/dev/GoogleService-Info.plist Runner/GoogleService-Info.plist
fi
