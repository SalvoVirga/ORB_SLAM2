# Build examples
add_executable(rgbd_tum RGB-D/rgbd_tum.cc)
target_link_libraries(rgbd_tum orb_slam2)

add_executable(stereo_kitti Stereo/stereo_kitti.cc)
target_link_libraries(stereo_kitti orb_slam2 g2o)

add_executable(stereo_euroc Stereo/stereo_euroc.cc)
target_link_libraries(stereo_euroc orb_slam2 g2o)

add_executable(mono_tum Monocular/mono_tum.cc)
target_link_libraries(mono_tum orb_slam2 g2o)

add_executable(mono_kitti Monocular/mono_kitti.cc)
target_link_libraries(mono_kitti orb_slam2 g2o)

add_executable(mono_euroc Monocular/mono_euroc.cc)
target_link_libraries(mono_euroc orb_slam2 g2o)
