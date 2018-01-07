#!/bin/bash

set_gpu_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

set_nvidia_card() {
  local pciid="$1"
  local fan="$2"
  local efb_file="$3"
  local xorg_template="$4"
  local mem_offset="$5"
  local cpu_offset="$6"
  local cfg="$(mktemp /tmp/xorg-XXXXXXXX.conf)"

  if [ $? -ne 0 ]; then
    echo "Temp dir creation failed."
    return
  fi

  local efb_file="$set_gpu_dir/dfp-edid.bin"
  if ! [ -f "$efb_file" ]; then
    echo "Can't find efb file at $efb_file."
    return
  fi

  local xorg_template="$set_gpu_dir/xorg.conf"
  if ! [ -f "$xorg_template" ]; then
    echo "Can't find xorg template file at $xorg_template."
    return
  fi

  sed -e s,@GPU_BUS_ID@,${pciid}, \
      -e s,@SET_EFB_FILE@,${efb_file}, \
      ${xorg_template} >> ${cfg}

  local nvscmd="$(which nvidia-settings) -a [gpu:0]/GPUFanControlState=1 -a [fan:0]/GPUTargetFanSpeed=$fan"
  if [ -n "$mem_offset" ]; then
    nvscmd="$nvscmd -a [gpu:0]/GPUMemoryTransferRateOffset[3]=$mem_offset"
  fi
  nvscmd="$nvscmd -a [gpu:0]/GPUPowerMizerMode=1"
  if [ -n "$cpu_offset" ]; then
    nvscmd="$nvscmd -a [gpu:0]/GPUGraphicsClockOffset[3]=$cpu_offset"
  fi
  nvidia-smi -pm 1
  xinit ${nvscmd} --  :0 -once -config ${cfg}
  rm -f "$cfg"
}
