#!/bin/sh

#./launch_warpx.sh <mpi-ranks> <omp-threads> <fast-mem-size-in-mb> <num-of-migration-threads> <migration-interval-seconds> <warpx_cmd> <problem>

./launch_warpx.sh 2 8 40 8 1 /home/jiaolin/warpx_pmdk_test/warpx_build/warpx_3d /home/jiaolin/warpx_pmdk_test/warpx_problems/laser-driven-acceleration/test_3d_64x64x512

mkdir /home/jiaolin/warpx_pmdk_test/results_nimble
chowrn -R jiaolin /home/jiaolin/warpx_pmdk_test/results_nimble

result_dir="/home/jiaolin/warpx_pmdk_test/results_nimble"
warpx_exe="/home/jiaolin/warpx_pmdk_test/warpx_build/warpx_3d"
problem_dir="/home/jiaolin/warpx_pmdk_test/warpx_problems/laser-driven-acceleration"


problem="test_3d_64x64x512_steps_200"
fastmemsize="40"
mkdir $result_dir/$problem
./launch_warpx.sh 2 8 $fastmemsize 8 1 $warpx_exe "$problem_dir/$problem" > $result_dir/$problem/appoutput.txt


problem="test_3d_128x128x1024_steps_200"
fastmemsize="310"
mkdir $result_dir/$problem
./launch_warpx.sh 2 8 $fastmemsize 8 1 $warpx_exe "$problem_dir/$problem" > $result_dir/$problem/appoutput.txt


problem="test_3d_256x256x2048_steps_200"
fastmemsize="2500"
mkdir $result_dir/$problem
./launch_warpx.sh 2 8 $fastmemsize 8 1 $warpx_exe "$problem_dir/$problem" > $result_dir/$problem/appoutput.txt


problem="test_3d_512x512x4096_steps_200"
fastmemsize="20000"
mkdir $result_dir/$problem
./launch_warpx.sh 2 8 $fastmemsize 8 1 $warpx_exe "$problem_dir/$problem" > $result_dir/$problem/appoutput.txt


problem="test_3d_864x864x7200" # 10 steps
fastmemsize="100000"
mkdir $result_dir/$problem
./launch_warpx.sh 2 8 $fastmemsize 8 1 $warpx_exe "$problem_dir/$problem" > $result_dir/$problem/appoutput.txt


problem="test_3d_960x960x7680_steps_10" # 10 steps
fastmemsize="135000"
mkdir $result_dir/$problem
./launch_warpx.sh 2 8 $fastmemsize 8 1 $warpx_exe "$problem_dir/$problem" > $result_dir/$problem/appoutput.txt

chowrn -R jiaolin:jiaolin /home/jiaolin/warpx_pmdk_test/results_nimble

echo "--- Finished ---"
