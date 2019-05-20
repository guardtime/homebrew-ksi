#!/bin/bash

#
# Copyright 2013-2018 Guardtime, Inc.
#
# This file is part of the Guardtime client SDK.
#
# Licensed under the Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES, CONDITIONS, OR OTHER LICENSES OF ANY KIND, either
# express or implied. See the License for the specific language governing
# permissions and limitations under the License.
# "Guardtime" and "KSI" are trademarks or registered trademarks of
# Guardtime, Inc., and no license to trademarks is granted; Guardtime
# reserves and retains all trademark rights.
#

./rebuild_formulas.sh guardtime/libksi v ./Formula/libksi.rb
./rebuild_formulas.sh guardtime/ksi-tool v ./Formula/ksi-tools.rb
./rebuild_formulas.sh guardtime/logksi v ./Formula/logksi.rb
./rebuild_formulas.sh guardtime/libparamset v ./Formula/libparamset.rb
./rebuild_formulas.sh guardtime/gttlvutil v ./Formula/gttlvutil.rb
./rebuild_formulas.sh guardtime/libgtrfc3161 v ./Formula/libgtrfc3161.rb
