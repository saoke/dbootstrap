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

# Cache directory
CACHEDIR="$BASEDIR/.build-cache"

# Build lock file
LOCKFILE="$BASEDIR/.build.lock"

# Configuration over. Main application start up!

if [ ! -d "$TOOLSDIR" ]; then
	echo "Can't find Dojo build tools -- did you initialise submodules? (git submodule update --init --recursive)"
	exit 1
fi

# Check if build is already running
if [ -f "$LOCKFILE" ]; then
    echo "Build is already running. If this is an error, remove $LOCKFILE"
    exit 1
fi

# Create lock file
touch "$LOCKFILE"

# Cleanup function
cleanup() {
    rm -f "$LOCKFILE"
}

# Register cleanup function
trap cleanup EXIT

echo "Building application with $PROFILE to $DISTDIR."

# Create cache directory if it doesn't exist
mkdir -p "$CACHEDIR"

# Function to check if files have changed
check_changes() {
    local dir=$1
    local cache_file="$CACHEDIR/$(basename $dir).cache"
    
    if [ ! -f "$cache_file" ]; then
        return 1
    fi
    
    find "$dir" -type f -name "*.js" -o -name "*.styl" | while read file; do
        if [ "$(md5sum $file | cut -d' ' -f1)" != "$(grep $file $cache_file | cut -d' ' -f1)" ]; then
            return 1
        fi
    done
    
    return 0
}

# Function to update cache
update_cache() {
    local dir=$1
    local cache_file="$CACHEDIR/$(basename $dir).cache"
    
    find "$dir" -type f -name "*.js" -o -name "*.styl" | while read file; do
        echo "$file $(md5sum $file | cut -d' ' -f1)" >> "$cache_file"
    done
}

# Check if we need to rebuild
# if check_changes "$SRCDIR"; then
#     echo "No changes detected, skipping build"
#     exit 0
# fi

echo "Forcing build regardless of changes detected."

echo -n "Cleaning old files..."
rm -rf "$DISTDIR"
mkdir -p "$DISTDIR"
echo " Done"

# Function to compile a single Stylus file
compile_stylus() {
    local file=$1
    local cache_file="$CACHEDIR/$(basename $file).cache"
    
    # Check if file has changed
    if [ -f "$cache_file" ] && [ "$(md5sum $file | cut -d' ' -f1)" = "$(cat $cache_file)" ]; then
        echo "  Skipping $file (unchanged)"
        return
    fi
    
    echo "  Compiling $file"
    stylus -c -u nib "$file"
    
    # Update cache
    md5sum "$file" | cut -d' ' -f1 > "$cache_file"
}

# Compile Stylus files in parallel
echo "Compiling Stylus files..."
cd "$SRCDIR/dgrid"
for file in css/*.styl; do
    compile_stylus "$file" &
done
wait

cd "$BASEDIR"
compile_stylus "$SRCDIR/app/resources/app.styl"
echo "Done"

# Build the application with optimized settings
echo "Building application..."
"$TOOLSDIR/build.sh" \
    --profile "$PROFILE" \
    --releaseDir "$DISTDIR" \
    --useSourceMaps "false" \
    --optimize "shrinksafe" \
    --layerOptimize "shrinksafe" \
    --stripConsole "normal" \
    --cssOptimize "comments" \
    --mini "true" \
    --failOnError "true" \
    --parallel "true" \
    --jobs "4" \
    --copyTests "false" \
    --copyDemos "false" \
    --copyReadme "false" \
    --copyLicense "false" \
    $@

# Update cache after successful build
update_cache "$SRCDIR"

# Check if dgrid was built
if [ ! -d "$DISTDIR/dgrid" ]; then
    echo "Warning: dgrid directory was not created in $DISTDIR"
    # 手动复制dgrid文件到输出目录
    echo "Copying dgrid files to $DISTDIR/dgrid..."
    mkdir -p "$DISTDIR/dgrid"
    cp -r "$SRCDIR/dgrid"/* "$DISTDIR/dgrid/"
    echo "Done copying dgrid files."
fi


cd "$BASEDIR"

# Copy & minify index.html to dist
#cat "$SRCDIR/index.html" | \
#perl -pe 's/\/\/.*$//gm;       # Strip JS comments' |
#perl -pe 's/\n/ /g;            # Replace newlines with whitespace' |
#perl -pe 's/<\!--.*?-->//g;    # Strip HTML comments' |
#perl -pe 's/isDebug: *true,//; # Remove isDebug' |
#perl -pe 's/\s+/ /g;           # Collapse whitespace' > "$DISTDIR/index.html"

echo "Build complete"
