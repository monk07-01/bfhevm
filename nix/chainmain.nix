{ pkgs ? import ./default.nix { }, sources ? import ./sources.nix }:
(import sources.bfhevm { }).bfhevmd

