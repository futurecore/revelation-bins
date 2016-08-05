#!/bin/bash

echo $PWD
REVELATION=${HOME}/revelation/

function test_binaries {
    # Single-core ASM tests.
    for FILE in $REVELATION/revelation/test/asm/*.elf ;
    do
        echo
        echo $1 --max-insts 1000 $FILE
        $1 --max-insts 1000 $FILE ;
    done
    # Single-core C tests.
    for FILE in $REVELATION/revelation/test/c/*.elf ;
    do
        echo
        echo $1 $FILE
        $1 $FILE ;
    done
    # Multicore tests.
    for FILE in $REVELATION/revelation/test/multicore/*.elf ;
    do
        echo
        echo $1 -r 1 -c 2 $FILE
        $1 -r 1 -c 2 $FILE;
    done
    # Single-core benchmarks.
    echo
    echo $1 $REVELATION/benchmarks/single-core/fib_large.elf
    $1 $REVELATION/benchmarks/single-core/fib_large.elf
    # Zigzag.
    echo
    echo $1 -r 2 -c 2 $REVELATION/revelation/test/zigzag/zigzag4.elf
    $1 -r 2 -c 2 $REVELATION/revelation/test/zigzag/zigzag4.elf
}


test_binaries ./pydgin-revelation-jit
test_binaries ./pydgin-revelation-nojit
