#!/bin/bash

################################################################
# Copyright (c) 2019 OFFIS Institute for Information Technology
#                          Oldenburg, Germany
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#################################################################

#################################################################
# \file   pause_write_reset.sh
# \author Patrick Uven <patrick.uven@offis.de>
# \brief  script for pausing the MicroBlaze, writing a .mem file
#         into the MicorBlaze data and instruction BRAM, unpausing
#         a resetting the MicroBlaze again.
################################################################

devmem 0x40000000 32 0x00000006

cat $1 | awk -e '{ system("devmem " $1 " 32 " $2) }'

devmem 0x40000000 32 0x00000000
devmem 0x40000000 32 0x00000004
