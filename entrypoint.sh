#!/bin/bash
set -ex

if [ "x$INPUT_INSTALL_DEPS" != 'x' ]; then
  apt-get update
  source ${INPUT_INSTALL_DEPS}
  apt-get clean -y
fi

echo $INPUT_CMAKE_OPTIONS

CTEST_OPTIONS="-DCTEST_CONFIGURATION_TYPE:STRING="
if [ "x$INPUT_CTEST_CONFIGURATION_TYPE" == 'x' ]; then
	INPUT_CTEST_CONFIGURATION_TYPE="Debug"
fi
CTEST_OPTIONS+=${INPUT_CTEST_CONFIGURATION_TYPE}

if [ "x$INPUT_CTEST_TOOLCHAIN_FILE" != 'x' ]; then
	CTEST_OPTIONS+=" -DCTEST_TOOLCHAIN_FILE:STRING="${INPUT_CTEST_TOOLCHAIN_FILE}
fi

if [ "x$INPUT_CTEST_BINARY_DIRECTORY" != 'x' ]; then
	CTEST_OPTIONS+=" -DCTEST_BINARY_DIRECTORY:STRING="${INPUT_CTEST_BINARY_DIRECTORY}
fi

if [ "x$INPUT_CTEST_ANALYZER" != 'x' ]; then
	CTEST_OPTIONS+=" -DCTEST_ANALYZER:STRING="${INPUT_CTEST_ANALYZER}
fi

if [ "x$INPUT_CTEST_RUN_TESTS" != 'x' ]; then
	CTEST_OPTIONS+=" -DCTEST_RUN_TESTS:BOOL="${INPUT_CTEST_RUN_TESTS}
fi

if [ "x$INPUT_CMAKE_OPTIONS" != 'x' ]; then
	CTEST_OPTIONS+=" -D"${INPUT_CMAKE_OPTIONS}
fi

if [ "x$INPUT_SSH_KEY" != 'x' ]; then
    eval $(ssh-agent)
    ssh-add - <<< "$INPUT_SSH_KEY"
fi

ctest -VV -S build.cmake ${CTEST_OPTIONS}

