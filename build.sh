#!/QOpenSys/pkgs/bin/bash

# Script library for the intERPrise build

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
# Restore the intERPrise code from git into libraries and source files
# Parameters: library, directory, text 
restore(){
  lib=$1
  dir=$2
  txt=$3
  restore.crtlib "${lib}" "${txt}"
  restore.crtsrcpf "${lib}" "${dir}" "${txt}"
}

## Delete a library 
## Parameters: library 
remove(){ 
  lib=$1 
  system -Kn "DLTLIB LIB(${lib})" 
} 
  
## Create a library 
## Parameters: library, text 
restore.crtlib(){ 
  lib=$1 
  txt=$2 
  system -Kn "CRTLIB LIB(${lib}) TEXT('${BUILD_TAG} ${txt}')" 
} 

## Create source files from all directories in the passed directory 
## Parameters: library, directory, text 
restore.crtsrcpf(){
  lib=$1
  dir=$2
  txt=$3
  
  pushd ${dir} >> /dev/null 
  for entry in */
    do
      file=${entry%%/}
      system -Kn "CRTSRCPF FILE(${lib}/${file}) RCDLEN(512) TEXT('"${txt}" ${file} Sources')" 
      restore.cpyfrmstmf ${lib} ${file} "${txt}"
    done   
  popd >> /dev/null 
} 

## Copy all files in the passed directory to the  
## sourcefile with the same name in the passed library 
## Parameters: library, directory/sourcefile, text  
restore.cpyfrmstmf(){ 
  lib=$1 
  dir=$2 
  srf=$2 
  txt=$3 
  pushd ${dir} >> /dev/null 
  for entry in * 
    do 
      if [ -f ${entry} ];then 
        atr="${entry##*.}"
        mbr="${entry%.*}"
        system -Kn "CPYFRMSTMF FROMSTMF('${PWD}/${entry}')" \
                              " TOMBR('/QSYS.LIB/${lib}.LIB/${srf}.FILE/${mbr}.MBR')" \
                              " MBROPT(*ADD)" \
                              " CVTDTA(*AUTO)" \
                              " STMFCCSID(*STMF)" \
                              " DBFCCSID(*FILE)"
        system -Kn "CHGPFM FILE(${lib}/${srf})" \
                         " MBR(${mbr})" \
                         " SRCTYPE(${atr})" \
                         " TEXT('Created by Jenkins')"
      fi 
    done
    popd >> /dev/null 
} 
