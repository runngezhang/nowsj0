#!/bin/bash

# Kaldi ASR baseline for the 3rd CHiME Challenge, non WSJ0 version
#
# Copyright 2015 University of Sheffield (Jon Barker, Ricard Marxer)
#                Inria (Emmanuel Vincent)
#                Mitsubishi Electric Research Labs (Shinji Watanabe)
#                University of Texas at Dallas (Seongjun Hahm)
#  Apache 2.0  (http://www.apache.org/licenses/LICENSE-2.0)

if [ $# -ne 1 ]; then
  printf "\nUSAGE: %s <CHiME3 root directory> \n\n" `basename $0`
  echo "Please specifies a CHiME3 root directory"
  echo "If you use kaldi scripts distributed in the CHiME3 data,"
  echo "It would be `pwd`/../.."
  exit 1;
fi

. ./path.sh
. ./cmd.sh 
chime3_data=$1

# You can execute run_init.sh only "once"
# This creates LMs, basic task files, basic models, 
# baseline results without speech enhancement techniques, and so on.
# Please set a main root directory of the CHiME3 data
# If you use kaldi scripts distributed in the CHiME3 data, 
# chime3_data=`pwd`/../.. 
# Otherwise, please specify it, e.g., 
# chime3_data=`pwd`/../CHiME3
local/run_init_nowsj0.sh $chime3_data

# GMM based ASR experiment
# Please set a directory of your speech enhancement method.
# run_gmm.sh can be done every time when you change a speech enhancement technique.
# The directory structure and audio files must follow the attached baseline enhancement directory
enhancement_method=enhanced
enhancement_data=$chime3_data/data/audio/16kHz/enhanced
local/run_gmm_nowsj0.sh $enhancement_method $enhancement_data

# DNN based ASR experiment
# Since it takes time to evaluate DNN, we make the GMM and DNN scripts separately.
# You may execute it after you would have promising results using GMM-based ASR experiments
local/run_dnn_nowsj0.sh $enhancement_method $enhancement_data