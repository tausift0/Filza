# Copyright 2021 Brandon Plank / Kayla


if ! which dpkg >> /dev/null; then
	echo "Install DPKG, brew install dpkg"
	exit 1
fi
if ! which wget >> /dev/null; then
        echo "Install WGET, brew install wget"
        exit 1
fi

# Thanks CrafterPika for linux :)

if [[ "$OSTYPE" == "linux"* ]]; then
    echo "Downloading Filza from tigisoftware"
    wget https://tigisoftware.com/cydia/com.tigisoftware.filza64bit_3.8.1-22_iphoneos-arm.deb
    dpkg -x com.tigisoftware.filza64bit_3.8.1-22_iphoneos-arm.deb Filza
    mkdir Payload
    cp -r Filza/Applications/Filza.app Payload/PlankFilza.app
    rm -rf com.tigisoftware.filza64bit_3.8.1-22_iphoneos-arm.deb
    mv Payload/PlankFilza.app/dylibs Payload/PlankFilza.app/Dylibs
    mkdir Payload/PlankFilza.app/Frameworks
    echo "Patching Filza Mach-O Binary"
    wget https://brandonplank.org/downloads/zsign
    chmod +x zsign
    ./zsign -l "@executable_path/Frameworks/PlankFilza.framework/PlankFilza" Payload/PlankFilza.app/Filza
    rm -rf zsign
    rm -rf Filza
    echo "Getting Plank Filza Framework"
    unzip PlankFilza.framework.zip
    rm -rf PlankFilza.framework.zip
    cp -r PlankFilza.framework Payload/PlankFilza.app/Frameworks/
    rm -rf PlankFilza.framework
    zip -r PlankFilza.ipa Payload
    rm -rf Payload
    echo "Done :)"
    exit 1
fi
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Downloading Filza from https://tigisoftware.com/"
    wget https://tigisoftware.com/cydia/com.tigisoftware.filza64bit_3.8.1-22_iphoneos-arm.deb
    dpkg -x com.tigisoftware.filza64bit_3.8.1-22_iphoneos-arm.deb Filza
    mkdir Payload
    cp -r Filza/Applications/filza.app Payload/PlankFilza.app
    rm -rf Filza
    rm -rf com.tigisoftware.filza64bit_3.8.1-22_iphoneos-arm.deb
    mv Payload/PlankFilza.app/dylibs Payload/PlankFilza.app/Dylibs
    mkdir Payload/PlankFilza.app/Frameworks/
    echo "Patching LC"
    wget https://brandonplank.org/downloads/optool
    chmod +x optool
    ./optool install -c load -p @executable_path/Frameworks/PlankFilza.framework/PlankFilza -t Payload/PlankFilza.app/Filza
    rm -rf optool
    unzip PlankFilza.framework.zip > /dev/null 2>&1
    rm -rf PlankFilza.framework.zip > /dev/null 2>&1
    cp -r PlankFilza.framework Payload/PlankFilza.app/Frameworks/
    rm -rf PlankFilza.framework > /dev/null 2>&1
    zip -r PlankFilza.ipa Payload > /dev/null 2>&1
    rm -rf Payload > /dev/null 2>&1
    echo "You can now side load the iPA on your device ~brandon"
fi
