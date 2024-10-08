#!/bin/bash
#
# env vars:
# - WWW_DIR: path to "pywallet-web" git clone
# - for signing the version announcement file:
#   - PYWALLET_SIGNING_ADDRESS (required)
#   - PYWALLET_SIGNING_WALLET (required)
#

set -e

PROJECT_ROOT="$(dirname "$(readlink -e "$0")")/.."
CONTRIB="$PROJECT_ROOT/contrib"

cd "$PROJECT_ROOT"

. "$CONTRIB"/build_tools_util.sh


echo -n "Remember to run add_cosigner to add any additional sigs.  Continue (y/n)? "
read answer
if [ "$answer" != "y" ]; then
    echo "exit"
    exit 1
fi


if [ -z "$WWW_DIR" ] ; then
    WWW_DIR=/opt/pywallet-web
fi

if [ -z "$PYWALLET_SIGNING_WALLET" ] || [ -z "$PYWALLET_SIGNING_ADDRESS" ]; then
    echo "You need to set env vars PYWALLET_SIGNING_WALLET and PYWALLET_SIGNING_ADDRESS!"
    exit 1
fi

VERSION=$("$CONTRIB"/print_pywallet_version.py)
info "VERSION: $VERSION"

set -x

info "updating www repo"
./contrib/make_download "$WWW_DIR"
info "signing the version announcement file"
sig=$(./run_pywallet -o signmessage $PYWALLET_SIGNING_ADDRESS $VERSION -w $PYWALLET_SIGNING_WALLET)
echo "{ \"version\":\"$VERSION\", \"signatures\":{ \"$PYWALLET_SIGNING_ADDRESS\":\"$sig\"}}" > "$WWW_DIR"/version

# push changes to website repo
pushd "$WWW_DIR"
git diff
git commit -a -m "version $VERSION"
git push
popd


info "release_www.sh finished successfully."
info "now you should run WWW_DIR/publish.sh to sign the website commit and upload signature"
