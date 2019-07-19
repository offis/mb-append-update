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
# \file   mem-convert.sh
# \author Patrick Uven <patrick.uven@offis.de>
# \brief  script for converting an objdump into a .mem file with
#         the format: <address> <data>
################################################################

objdump --adjust-vma=$1 -s $2 | awk --non-decimal-data '{printf "0x%x %08s\n0x%08x %08s\n0x%08x %08s\n0x%08x %08s\n", ("0x"$1)+0, $2, ("0x"$1)+4, $3, ("0x"$1)+8, $4, ("0x"$1)+12, $5}' | grep -E '0x[0-9,a-f]{8} [0-9,a-f]{8}' | awk '{printf $1 " 0x"; for (i=7;i>=1;i=i-2) printf "%s%s",substr($2,i,2),(i>1?"":"\n")}' > $2.mem
