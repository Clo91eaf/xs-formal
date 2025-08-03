# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2024 Jiuyang Liu <liu@jiuyang.me>

let
  getEnv' =
    key:
    let
      val = builtins.getEnv key;
    in
    if val == "" then builtins.throw "${key} not set or '--impure' not applied" else val;
in
final: prev: {
  cds-fhs-env = final.callPackage ./cds-fhs-env.nix { inherit getEnv'; };

  jg-fpv = final.callPackage ./jg-fpv.nix { };
}
