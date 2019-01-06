#!/QOpenSys/pkgs/bin/bash

# Script library for the intERPrise Database Services build

# Copyright (c) 2019 Remain Software
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# Contributors:
#      Wim Jongman - Original API and implementation

#
# Compile the transport build command and execute it.
# Parameters: library 
database.compile(){
  lib=$1
  system -Kn "CRTBNDCL PGM(${lib}/CRTOBJS) SRCFILE(${lib}/SRCCL) SRCMBR(CRTOBJS)"
  system -Kn "CRTCMD CMD(${lib}/CRTOBJS) PGM(${lib}/CRTOBJS) SRCFILE(${lib}/SRCCMD)"
  system -Kn "${lib}/CRTOBJS SRCLIB(${lib}) OBJLIB(${lib}) DTALIB(${lib})"
}
