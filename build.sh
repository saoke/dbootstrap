#!/usr/bin/env bash

set -e

# Base directory for this entire project
BASEDIR=$(cd $(dirname $0) && pwd)

# Source directory for unbuilt code
SRCDIR="$BASEDIR/source"

# Directory containing dojo build utilities
TOOLSDIR="$SRCDIR/util/buildscripts"

# Destination directory for built code
DISTDIR="$BASEDIR/../../../public/dist"

# Main application package build configuration
PROFILE="$BASEDIR/resource/app.profile.js"

# Configuration over. Main application start up!

if [ ! -d "$TOOLSDIR" ]; then
	echo "Can't find Dojo build tools -- did you initialise submodules? (git submodule update --init --recursive)"
	exit 1
fi

echo "Building application with $PROFILE to $DISTDIR."

echo -n "Cleaning old files..."
rm -rf "$DISTDIR"
echo " Done"

stylus -c "$SRCDIR/app/resources/app.styl"
"$TOOLSDIR/build.sh" --profile "$PROFILE" --releaseDir "$DISTDIR" optimize='' layerOptimize=''
# "$TOOLSDIR/build.sh" --profile "$PROFILE" --releaseDir "$DISTDIR" --useSourceMaps false --copyTests false

# 编译 dstore 层
DSTORE_PROFILE="$BASEDIR/resource/dstore.profile.js"
DSTORE_DISTDIR="$DISTDIR"

echo "Building dstore with $DSTORE_PROFILE to $DSTORE_DISTDIR."
"$TOOLSDIR/build.sh" --profile "$DSTORE_PROFILE" --basePath "$SRCDIR" --releaseDir "$DSTORE_DISTDIR" --release optimize='' layerOptimize=''
# "$TOOLSDIR/build.sh" --profile "$DSTORE_PROFILE" --basePath "$SRCDIR" --releaseDir "$DSTORE_DISTDIR" \
# --optimize closure --layerOptimize closure --useSourceMaps false --stripConsole warn --mini true --copyTests false

# 编译有问题， 先复制 dgrid 层
DGRID_DISTDIR="$DISTDIR"

echo "Coping dgrid with $DISTDIR to $DGRID_DISTDIR."
cp -r "$SRCDIR/dgrid" "$DGRID_DISTDIR"

cd "$BASEDIR"

# Copy & minify index.html to dist
#cat "$SRCDIR/index.html" | \
#perl -pe 's/\/\/.*$//gm;       # Strip JS comments' |
#perl -pe 's/\n/ /g;            # Replace newlines with whitespace' |
#perl -pe 's/<\!--.*?-->//g;    # Strip HTML comments' |
#perl -pe 's/isDebug: *true,//; # Remove isDebug' |
#perl -pe 's/\s+/ /g;           # Collapse whitespace' > "$DISTDIR/index.html"

echo "Build complete"
