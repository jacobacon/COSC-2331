#!/bin/bash

nasm -f elf $1
ld -m elf_i386 
